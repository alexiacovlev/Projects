using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;


using ITHit.WebDAV.Server;
using ITHit.WebDAV.Server.Class1;
using ITHit.WebDAV.Server.Class2;
using ITHit.WebDAV.Server.Quota;
using ITHit.WebDAV.Server.Search;

namespace DMS.WebDav.Module
{
    /// <summary>
    /// Represents folder in webdav repository.
    /// </summary>
    public class DavFolder : DavHierarchyItem, IFolder, IQuota, ISearch
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="DavFolder"/> class.
        /// </summary>
        /// <param name="context">Instance of <see cref="DavContext"/> class.</param>
        /// <param name="itemId">Id of this folder.</param>
        /// <param name="parentId">Id of parent folder.</param>
        /// <param name="name">Name of this folder.</param>
        /// <param name="path">Encoded WebDAV path to this folder.</param>
        /// <param name="created">Date when the folder was created.</param>
        /// <param name="modified">Date when the folder was modified.</param>
        /// <param name="fileAttributes">File attributes of the folder (hidden, read-only etc.)</param>
        public DavFolder(DavContext context, Guid itemId,  Guid parentId, string name, string path, DateTime created, DateTime modified, FileAttributes fileAttributes)
            : base(context, itemId, parentId, name, path, created, modified, fileAttributes)
        {
        }

        /// <summary>
        /// Gets child items of this folder (files or folders).
        /// </summary>
        /// <param name="props">
        /// List of properties which will be requested from children later. We don't use it here.
        /// </param>
        /// <returns>Enumerable with files and folders.</returns>
        public IEnumerable<IHierarchyItem> GetChildren(IList<PropertyName> props)
        {
            string command =
                @"SELECT ID, ParentID, 3 as ItemType, Name, CreatedOn, ModifiedOn, Attributes
                          FROM DMS_Folders
                          WHERE ParentID = @Parent
                  UNION ALL
                 SELECT ID, ParentID, 2 as ItemType, Name, CreatedOn, ModifiedOn, Attributes
                          FROM DMS_Documents
                          WHERE ParentID = @Parent";
            return Context.ExecuteItem<IHierarchyItem>(
                Path,
                command,
                "@Parent", ItemId);
        }

        /// <summary>
        /// Creates file with specified name in this folder.
        /// </summary>
        /// <param name="name">File name.</param>
        /// <returns>Instance of <see cref="File"/> referring to newly created file.</returns>
        public IFile CreateFile(string name)
        {
            if (!ClientHasToken())
            {
                throw new LockedException();
            }
            var child = createChild(name, ItemType.File);
            return (IFile)child;
        }

        /// <summary>
        /// Creates folder with specified name in this folder.
        /// </summary>
        /// <param name="name">Name of folder to be created.</param>
        public void CreateFolder(string name)
        {
            if (!ClientHasToken())
            {
                throw new LockedException();
            }

            createChild(name, ItemType.Folder);
        }

        /// <summary>
        /// Copies this folder to another folder with option to rename it.
        /// </summary>
        /// <param name="destFolder">Folder to copy this folder to.</param>
        /// <param name="destName">New name of this folder.</param>
        /// <param name="deep">Whether children shall be copied.</param>
        /// <param name="multistatus">Container for errors. We put here errors which occur with
        /// individual items being copied.</param>
        public override void CopyTo(IItemCollection destFolder,  string destName, bool deep, MultistatusException multistatus)
        {
            DavFolder destDavFolder = destFolder as DavFolder;
            if (destFolder == null)
            {
                throw new DavException("Destination folder doesn't exist", DavStatus.CONFLICT);
            }
            if (!destDavFolder.ClientHasToken())
            {
                throw new LockedException("Doesn't have token for destination folder.");
            }

            if (isRecursive(destDavFolder))
            {
                throw new DavException("Cannot copy folder to its subtree", DavStatus.FORBIDDEN);
            }

            IHierarchyItem destItem = destDavFolder.FindChild(destName);

            if (destItem != null)
            {
                try
                {
                    destItem.Delete(multistatus);
                }
                catch (DavException ex)
                {
                    multistatus.AddInnerException(destItem.Path, ex);
                    return;
                }
            }

            DavFolder newDestFolder = CopyThisItem(destDavFolder, null, destName);

            // copy children
            if (deep)
            {
                foreach (IHierarchyItem child in GetChildren(new PropertyName[0]))
                {
                    var dbchild = child as DavHierarchyItem;
                    try
                    {
                        dbchild.CopyTo(newDestFolder, child.Name, deep, multistatus);
                    }
                    catch (DavException ex)
                    {
                        multistatus.AddInnerException(dbchild.Path, ex);
                    }
                }
            }
        }

        /// <summary>
        /// Moves this folder to destination folder with option to rename.
        /// </summary>
        /// <param name="destFolder">Folder to copy this folder to.</param>
        /// <param name="destName">New name of this folder.</param>
        /// <param name="multistatus">Container for errors. We put here errors occurring while moving
        /// individual files/folders.</param>
        public override void MoveTo(IItemCollection destFolder, string destName, MultistatusException multistatus)
        {
            DavFolder destDavFolder = destFolder as DavFolder;
            if (destFolder == null)
            {
                throw new DavException("Destination folder doesn't exist", DavStatus.CONFLICT);
            }

            if (isRecursive(destDavFolder))
            {
                throw new DavException("Cannot move folder to its subtree", DavStatus.FORBIDDEN);
            }

            DavFolder parent = GetParent();
            if (parent == null)
            {
                throw new DavException("Cannot move root", DavStatus.CONFLICT);
            }
            if (!ClientHasToken() || !destDavFolder.ClientHasToken() || !parent.ClientHasToken())
            {
                throw new LockedException();
            }

            DavHierarchyItem destItem = destDavFolder.FindChild(destName);
            DavFolder newDestFolder;

            // copy this folder
            if (destItem != null)
            {
                if (destItem is IFile)
                {
                    try
                    {
                        destItem.Delete(multistatus);
                    }
                    catch (DavException ex)
                    {
                        multistatus.AddInnerException(destItem.Path, ex);
                        return;
                    }

                    newDestFolder = CopyThisItem(destDavFolder, null, destName);
                }
                else
                {
                    newDestFolder = destItem as DavFolder;
                    if (newDestFolder == null)
                    {
                        multistatus.AddInnerException(
                            destItem.Path,
                            new DavException("Destionation item is not folder", DavStatus.CONFLICT));
                    }
                }
            }
            else
            {
                newDestFolder = CopyThisItem(destDavFolder, null, destName);
            }

            // move children
            bool movedAllChildren = true;
            foreach (IHierarchyItem child in GetChildren(new PropertyName[0]))
            {
                DavHierarchyItem dbchild = child as DavHierarchyItem;
                try
                {
                    dbchild.MoveTo(newDestFolder, child.Name, multistatus);
                }
                catch (DavException ex)
                {
                    multistatus.AddInnerException(dbchild.Path, ex);
                    movedAllChildren = false;
                }
            }

            if (movedAllChildren)
            {
                DeleteThisItem(parent);
            }
        }

        /// <summary>
        /// Deletes this folder.
        /// </summary>
        /// <param name="multistatus">Container for errors.
        /// If some child file/folder fails to remove we report error in this container.</param>
        public override void Delete(MultistatusException multistatus)
        {
            DavFolder parent = GetParent();
            if (parent == null)
            {
                throw new DavException("Cannot delete root.", DavStatus.CONFLICT);
            }
            if (!parent.ClientHasToken())
            {
                throw new LockedException();
            }

            if (!ClientHasToken())
            {
                throw new LockedException();
            }

            bool deletedAllChildren = true;
            foreach (IHierarchyItem child in GetChildren(new PropertyName[0]))
            {
                DavHierarchyItem dbchild = child as DavHierarchyItem;
                try
                {
                    dbchild.Delete(multistatus);
                }
                catch (DavException ex)
                {
                    multistatus.AddInnerException(dbchild.Path, ex);
                    deletedAllChildren = false;
                }
            }

            if (deletedAllChildren)
            {
                DeleteThisItem(parent);
            }
        }
        /// <summary>
        /// Returns free bytes available to current user.
        /// </summary>
        /// <returns>Free bytes available.</returns>
        public long GetAvailableBytes()
        {
            //let's assume total space is 5GB.
            return (5L * 1024 * 1024 * 1024) - GetUsedBytes();
        }

        /// <summary>
        /// Returns used bytes by current user.
        /// </summary>
        /// <returns>Number of bytes consumed by files of current user.</returns>
        public long GetUsedBytes()
        {
            return Context.ExecuteScalar<long>("SELECT SUM(DATALENGTH(FileContent)) FROM DMS_Documents");
        }
        /// <summary>
        /// Searches files and folders in current folder using search phrase and options.
        /// </summary>
        /// <param name="searchString">A phrase to search.</param>
        /// <param name="options">Search options.</param>
        /// <param name="propNames">
        /// List of properties to retrieve with each item returned by this method. They will be requested by the 
        /// Engine in <see cref="IHierarchyItemAsync.GetProperties(IList{PropertyName}, bool)"/> call.
        /// </param>
        /// <returns>List of <see cref="IHierarchyItemAsync"/> satisfying search request.</returns>
        public IEnumerable<IHierarchyItem> Search(string searchString, SearchOptions options, List<PropertyName> propNames)
        {
            bool includeSnippet = propNames.Any(s => s.Name == SNIPPET);
            string condition = "Name LIKE @Name";

            // To enable full-text search, uncoment the code below and follow instructions 
            // in DB.sql to enable full-text indexing
            /*
            if (options.SearchContent)
            {
                condition += " OR FREETEXT(FileContent, '@FileContent')";
            }
            */

            string commandText = String.Format(
               @"SELECT ID, ParentID, 3 as ItemType, Name, CreatedOn, ModifiedOn, Attributes                          
                   FROM DMS_Folders
                   WHERE ParentID = @Parent AND ({0})
                    UNION ALL
                 SELECT ID, ParentID, 2 as ItemType, Name, CreatedOn, ModifiedOn, Attributes                          
                   FROM DMS_Documents
                   WHERE ParentID = @Parent AND ({0})
                    ", condition);

            List<IHierarchyItem> result = new List<IHierarchyItem>();
            GetSearchResults(result, commandText, searchString, includeSnippet);

            return result;
        }

        /// <summary>
        /// Produces recursive search in current folder.
        /// </summary>
        /// <param name="result">A list to add search results to.</param>
        /// <param name="commandText">SQL command text for search in a folder.</param>
        /// <param name="searchString">A phrase to search.</param>
        private void GetSearchResults(List<IHierarchyItem> result, string commandText, string searchString, bool includeSnippet)
        {
            // search this folder
            IEnumerable<IHierarchyItem> folderSearchResults = Context.ExecuteItem<IHierarchyItem>(
                Path,
                commandText,
                "@Parent", ItemId,
                "@Name", searchString,
                "@Content", searchString);

            foreach (IHierarchyItem item in folderSearchResults)
            {
                if (includeSnippet && item is DavFile)
                    (item as DavFile).Snippet = "Not Implemented";
            }
            result.AddRange(folderSearchResults);

            // search children
            foreach (IHierarchyItem item in GetChildrenFolders())
            {
                DavFolder folder = item as DavFolder;
                if (folder != null)
                    folder.GetSearchResults(result, commandText, searchString, includeSnippet);
            }
        }

        /// <summary>
        /// Gets the children of current folder (non-recursive).
        /// </summary>
        /// <returns>The children folders of current folder.</returns>
        public IEnumerable<IHierarchyItem> GetChildrenFolders()
        {
            string command =
                 @"SELECT ID, ParentID, 3 as ItemType, Name, CreatedOn, ModifiedOn, Attributes
                   FROM DMS_Folders
                   WHERE ParentID = @Parent"; // folders only

            return Context.ExecuteItem<IHierarchyItem>(
                Path,
                command,
                "@Parent", ItemId);
        }

        /// <summary>
        /// Finds file or folder with specified name inside this folder.
        /// </summary>
        /// <param name="childName">Name of child to find.</param>
        /// <returns>Instance of <see cref="DavHierarchyItem"/> or <c>null</c>.</returns>
        internal DavHierarchyItem FindChild(string childName)
        {
            string commandText =
                @"SELECT ID, ParentID, 3 as ItemType, Name, CreatedOn, ModifiedOn, Attributes  
                  FROM DMS_Folders
                  WHERE ParentID = @Parent AND Name = @Name
                  UNION ALL
                  SELECT ID, ParentID, 2 as ItemType, Name, CreatedOn, ModifiedOn, Attributes  
                  FROM DMS_Documents
                  WHERE ParentID = @Parent AND Name = @Name";

            var davHierarchyItems = Context.ExecuteItem<DavHierarchyItem>(
                Path,
                commandText,
                "@Parent", ItemId,
                "@Name", childName);
            return davHierarchyItems.FirstOrDefault();
        }
        /// <summary>
        /// Determines whether the client has submitted lock tokens for all locked files in the subtree.
        /// </summary>
        /// <returns>Returns <c>true</c> if lock tockens for all locked files in the subtree are submitted.</returns>
        internal bool ClientHasTokenForTree()
        {
            if (!ClientHasToken())
            {
                return false;
            }

            foreach (IHierarchyItem child in GetChildren(new PropertyName[0]))
            {
                DavFolder childFolder = child as DavFolder;
                if (childFolder != null)
                {
                    if (!childFolder.ClientHasTokenForTree())
                    {
                        return false;
                    }
                }
                else
                {
                    DavHierarchyItem childItem = child as DavHierarchyItem;
                    if (!childItem.ClientHasToken())
                    {
                        return false;
                    }
                }
            }

            return true;
        }

        /// <summary>
        /// Determines whether <paramref name="destFolder"/> is inside this folder.
        /// </summary>
        /// <param name="destFolder">Folder to test.</param>
        /// <returns>Returns <c>true</c>if <paramref name="destFolder"/> is inside this folder.</returns>
        private bool isRecursive(DavFolder destFolder)
        {
            return destFolder.Path.StartsWith(Path);
        }

        /// <summary>
        /// Creates file or folder with specified name inside this folder.
        /// </summary>
        /// <param name="name">File/folder name.</param>
        /// <param name="itemType">Type of item: file or folder.</param>
        /// <returns>Newly created item.</returns>
        private DavHierarchyItem createChild(string name, ItemType itemType)
        {
            Guid newID = Guid.NewGuid();

            string commandText = itemType == ItemType.Folder ?
                @"INSERT INTO DMS_Folders(ID, Name, CreatedOn, ModifiedOn, ParentID,  CreatorDisplayName, AutoVersion, AutoCheckedOut, TotalContentLength, Attributes)
                  VALUES(@Identity, @Name, GETUTCDATE(), GETUTCDATE(), @Parent,  @CreatorDisplayName, 0, 0, 0, @Attributes)"
:
               @"INSERT INTO DMS_Documents(ID, Name, CreatedOn, ModifiedOn, ParentID,  Comment, CreatorDisplayName, AutoVersion, AutoCheckedOut, TotalContentLength, Attributes)
                  VALUES(@Identity, @Name, GETUTCDATE(), GETUTCDATE(), @Parent, '', @CreatorDisplayName, 0, 0, 0, @Attributes)";

            Context.ExecuteNonQuery(
                commandText,
                "@Name", name,
                "@Parent", ItemId,
                "@CreatorDisplayName", CurrentUserName,
                "@Attributes", (itemType == ItemType.Folder ? (int)FileAttributes.Directory : (int)FileAttributes.Normal),
                "@Identity", newID);

            //UpdateModified(); do not update time for folder as transaction will block concurrent files upload
            switch (itemType)
            {
                case ItemType.File:
                    return new DavFile(
                        Context,
                        newID,
                        ItemId,
                        name,
                        Path + EncodeUtil.EncodeUrlPart(name),
                        DateTime.UtcNow,
                        DateTime.UtcNow, FileAttributes.Normal);
                case ItemType.Folder:
                    // do not need to return created folder
                    return null;
                default:
                    return null;
            }
        }
    }
}
