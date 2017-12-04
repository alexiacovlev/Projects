using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;


using ITHit.WebDAV.Server;
using ITHit.WebDAV.Server.Class1;
using ITHit.WebDAV.Server.Class2;
using ITHit.WebDAV.Server.MicrosoftExtensions;

namespace DMS.WebDav.Module
{
    /// <summary>
    /// Base class for items like files, folders, versions etc.
    /// </summary>
    public abstract class DavHierarchyItem : IHierarchyItem, ILock, IMsItem
    {
        /// <summary>
        /// Property name to return text anound search phrase.
        /// </summary>
        internal const string SNIPPET = "snippet";

        protected DavContext Context { get; private set; }

        public Guid ItemId { get; private set; }

        public string Name { get; private set; }

        public string Path { get; private set; }

        public DateTime Created { get; private set; }

        public DateTime Modified { get; private set; }

        protected Guid ParentId { get; private set; }
        private FileAttributes fileAttributes;

        public DavHierarchyItem(
            DavContext context,
            Guid itemId,
            Guid parentId,
            string name,
            string path,
            DateTime created,
            DateTime modified,FileAttributes fileAttributes)
        {
            Context = context;
            ItemId = itemId;
            ParentId = parentId;
            Name = name;
            Path = path;
            Created = created;
            Modified = modified;
            this.fileAttributes = fileAttributes;
        }

        public DavFolder GetParent()
        {
            string[] parts = Path.TrimEnd('/').Split('/');
            string parentParentPath = "/";
            if (parts.Length > 2)
            {
                parentParentPath = string.Join("/", parts, 0, parts.Length - 2);
            }

            string command =
               @"SELECT ID, ParentID, 3 as ItemType, Name, CreatedOn, ModifiedOn, Attributes
                  FROM DMS_Folders
                  WHERE ID = @ItemId";

            var davFolders = Context.ExecuteItem<DavFolder>(
                parentParentPath,
                command,
                "@ItemId", ParentId);
            return davFolders.FirstOrDefault();
        }

        public abstract void CopyTo(
            IItemCollection destFolder,
            string destName,
            bool deep,
            MultistatusException multistatus);

        public abstract void MoveTo(IItemCollection destFolder, string destName, MultistatusException multistatus);

        public abstract void Delete(MultistatusException multistatus);

        public IEnumerable<PropertyValue> GetProperties(IList<PropertyName> names, bool allprop)
        {
            IList<PropertyValue> requestedPropVals = new List<PropertyValue>();
            IList<PropertyValue> propVals = Context.ExecutePropertyValue(
                    "SELECT Name, Namespace, PropVal FROM DMS_DocumentProperties WHERE ItemId = @ItemId",
                    "@ItemId", ItemId);
            PropertyName snippet = names.FirstOrDefault(s => s.Name == SNIPPET);
            if (allprop)
            {
                requestedPropVals= propVals;
            }
            else
            {              
                foreach (PropertyValue p in propVals)
                {
                    if (names.Contains(p.QualifiedName))
                    {
                        requestedPropVals.Add(p);
                    }
                }
            }
            if (snippet.Name == SNIPPET && this is DavFile)
                 requestedPropVals.Add(new PropertyValue(snippet, (this as DavFile).Snippet));
            return requestedPropVals;
        }

        public virtual void UpdateProperties(
            IList<PropertyValue> setProps,
            IList<PropertyName> delProps,
            MultistatusException multistatus)
        {
            RequireHasToken();

            foreach (PropertyValue p in setProps)
            {
                // Microsoft Mini-redirector may update file creation date, modification date and access time passing properties:
                // <Win32CreationTime xmlns="urn:schemas-microsoft-com:">Thu, 28 Mar 2013 20:15:34 GMT</Win32CreationTime>
                // <Win32LastModifiedTime xmlns="urn:schemas-microsoft-com:">Thu, 28 Mar 2013 20:36:24 GMT</Win32LastModifiedTime>
                // <Win32LastAccessTime xmlns="urn:schemas-microsoft-com:">Thu, 28 Mar 2013 20:36:24 GMT</Win32LastAccessTime>
                // In this case update creation and modified date in your storage or do not save this properties at all, otherwise 
                // Windows Explorer will display creation and modification date from this props and it will differ from the values 
                // in the CreatedOn and ModifiedOn fields in your storage 
                if (p.QualifiedName.Namespace == "urn:schemas-microsoft-com:")
                {
                    if (p.QualifiedName.Name == "Win32CreationTime")
                    {
                        SetDbField("CreatedOn", DateTime.Parse(p.Value, new System.Globalization.CultureInfo("en-US")).ToUniversalTime());
                    }
                    else if (p.QualifiedName.Name == "Win32LastModifiedTime")
                    {
                        SetDbField("ModifiedOn", DateTime.Parse(p.Value, new System.Globalization.CultureInfo("en-US")).ToUniversalTime());
                    }
                }
                else
                {
                    SetProperty(p); // create or update property
                }
            }

            foreach (PropertyName p in delProps)
            {
                RemoveProperty(p.Name, p.Namespace);
            }

            // You should not update modification date/time here. Mac OS X Finder expects that properties update do not change the file modification date.
        }

        public IEnumerable<PropertyName> GetPropertyNames()
        {
            IList<PropertyName> propNames = new List<PropertyName>();
            foreach (PropertyValue propName in GetProperties(new PropertyName[0], true))
            {
                propNames.Add(propName.QualifiedName);
            }
            return propNames;
        }
        protected void RequireHasToken()
        {
            if (!ClientHasToken())
            {
                throw new LockedException();
            }
        }

        public LockResult Lock(LockLevel level, bool isDeep, TimeSpan? timeout, string owner)
        {
            if (ItemHasLock(level == LockLevel.Shared))
            {
                throw new LockedException();
            }

            if (isDeep)
            {
                // check if no items are locked in this subtree
                FindLocksDown(this, level == LockLevel.Shared);
            }

            if (!timeout.HasValue || timeout == TimeSpan.MaxValue)
            {
                // If timeout is absent or infinity timeout requested,
                // grant 5 minute lock.
                timeout = TimeSpan.FromMinutes(5);
            }

            // We store expiration time in UTC. If server/database is moved 
            // to other time zone the locks expiration time is always correct.
            DateTime expires = DateTime.UtcNow + timeout.Value;

            string token = Guid.NewGuid().ToString();
            string insertLockCommand =
                @"INSERT INTO DMS_Locks (ItemId,Token,Shared,Deep,Expires,Owner)
                   VALUES(@ItemId, @Token, @Shared, @Deep, @Expires, @Owner)";

            Context.ExecuteNonQuery(
                insertLockCommand,
                "@ItemId", ItemId,
                "@Token", token,
                "@Shared", level == LockLevel.Shared,
                "@Deep", isDeep,
                "@Expires", expires,
                "@Owner", owner);

            return new LockResult(token, timeout.Value);
        }

        public RefreshLockResult RefreshLock(string token, TimeSpan? timeout)
        {
            IEnumerable<LockInfo> activeLocks = GetActiveLocks();
            LockInfo l = activeLocks.FirstOrDefault(al => al.Token == token);

            if (l == null)
            {
                throw new DavException("The lock doesn't exist", DavStatus.PRECONDITION_FAILED);
            }

            if (!timeout.HasValue || timeout == TimeSpan.MaxValue)
            {
                // If timeout is absent or infinity timeout requested,
                // grant 5 minute lock.
                l.TimeOut = TimeSpan.FromMinutes(5);
            }
            else
            {
                // Otherwise use new timeout.
                l.TimeOut = timeout.Value;
            }

            DateTime expires = DateTime.UtcNow + (TimeSpan)l.TimeOut;

            Context.ExecuteNonQuery(
                "UPDATE DMS_Locks SET Expires = @Expires WHERE Token = @Token",
                "@Expires", expires,
                "@Token", token);

            return new RefreshLockResult(l.Level, l.IsDeep, (TimeSpan)l.TimeOut, l.Owner);
        }

        public void Unlock(string lockToken)
        {
            IEnumerable<LockInfo> activeLocks = GetActiveLocks();
            if (activeLocks.All(al => al.Token != lockToken))
            {
                throw new DavException("This lock token doesn't correspond to any lock", DavStatus.PRECONDITION_FAILED);
            }

            // remove lock from existing item
            Context.ExecuteNonQuery(
                "DELETE FROM DMS_Locks WHERE Token = @Token",
                "@Token", lockToken);
        }

        public IEnumerable<LockInfo> GetActiveLocks()
        {
            Guid itemID = ItemId;
            List<LockInfo> l = new List<LockInfo>();
           
                l.AddRange(GetLocks(itemID, false)); // get all locks
             
                while (itemID != Guid.Empty)
                {
                    
                    itemID = Context.ExecuteScalar<Guid>("SELECT ParentID FROM DMS_Folders WHERE ID = @ItemId UNION ALL SELECT ParentID FROM DMS_Documents WHERE ID = @ItemId", "@ItemId", itemID);

                    l.AddRange(GetLocks(itemID, true)); // get only deep locks
                }
            
            return l;
        }

        protected void SetProperty(PropertyValue prop)
        {
            string selectCommand =
                @"SELECT Count(*) FROM DMS_DocumentProperties
                  WHERE ItemId = @ItemId AND Name = @Name AND Namespace = @Namespace";

            int count = Context.ExecuteScalar<int>(
                selectCommand,
                "@ItemId", ItemId,
                "@Name", prop.QualifiedName.Name,
                "@Namespace", prop.QualifiedName.Namespace);

            // insert
            if (count == 0)
            {
                string insertCommand = @"INSERT INTO DMS_DocumentProperties(ItemId, Name, Namespace, PropVal)
                                          VALUES(@ItemId, @Name, @Namespace, @PropVal)";

                Context.ExecuteNonQuery(
                    insertCommand,
                    "@PropVal", prop.Value,
                    "@ItemId", ItemId,
                    "@Name", prop.QualifiedName.Name,
                    "@Namespace", prop.QualifiedName.Namespace);
            }
            else
            {
                // update
                string command = @"UPDATE DMS_DocumentProperties
                      SET PropVal = @PropVal
                      WHERE ItemId = @ItemId AND Name = @Name AND Namespace = @Namespace";

                Context.ExecuteNonQuery(
                    command,
                    "@PropVal", prop.Value,
                    "@ItemId", ItemId,
                    "@Name", prop.QualifiedName.Name,
                    "@Namespace", prop.QualifiedName.Namespace);
            }
        }

        protected void RemoveProperty(string name, string ns)
        {
            string command = @"DELETE FROM DMS_DocumentProperties
                              WHERE ItemId = @ItemId
                              AND Name = @Name
                              AND Namespace = @Namespace";

            Context.ExecuteNonQuery(
                command,
                "@ItemId", ItemId,
                "@Name", name,
                "@Namespace", ns);
        }

        internal DavFolder CopyThisItem(DavFolder destFolder, DavHierarchyItem destItem, string destName)
        {
            // returns created folder, if any, otherwise null
            DavFolder createdFolder = null;

            Guid destID;
            if (destItem == null)
            {
                // copy item
                string commandText =  
                    @"INSERT INTO DMS_Folders(ID, Name, CreatedOn, ModifiedOn, ParentID, CreatorDisplayName, AutoVersion, AutoCheckedOut, TotalContentLength, Attributes)
                      SELECT @Identity, @Name, GETUTCDATE(), GETUTCDATE(), @Parent, CreatorDisplayName, AutoVersion, AutoCheckedOut, TotalContentLength, Attributes
                      FROM DMS_Folders
                      WHERE ID = @ItemId;
                                            
                      INSERT INTO DMS_Documents(ID, Name, CreatedOn, ModifiedOn, ParentID, FileContent, ContentType, SerialNumber, CreatorDisplayName, Comment, AutoVersion, AutoCheckedOut, TotalContentLength, LastChunkSaved, Attributes)
                      SELECT @Identity, @Name, GETUTCDATE(), GETUTCDATE(), @Parent, FileContent, ContentType, SerialNumber, CreatorDisplayName, Comment, AutoVersion, AutoCheckedOut, TotalContentLength, LastChunkSaved, Attributes
                      FROM DMS_Documents
                      WHERE ID = @ItemId";

                destID = Guid.NewGuid();
                Context.ExecuteNonQuery(
                    commandText,
                    "@Name", destName,
                    "@Parent", destFolder.ItemId,
                    "@ItemId", ItemId,
                    "@Identity", destID);

                destFolder.UpdateModified();

                if (this is IFolder)
                {
                    createdFolder = new DavFolder(
                        Context,
                        destID,
                        destFolder.ItemId,
                        destName,
                        destFolder.Path + EncodeUtil.EncodeUrlPart(destName) + "/",
                        DateTime.UtcNow,
                        DateTime.UtcNow,fileAttributes);
                }
            }
            else
            {
                // update existing destination
                destID = destItem.ItemId;

                string commandText = 
                                  @"UPDATE DMS_Folders SET ModifiedOn = GETUTCDATE()                                       
                                       FROM (SELECT * FROM DMS_Folders WHERE ID=@SrcID) src
                                       WHERE DMS_Folders.ID=@DestID ;
                                         
                                      UPDATE DMS_Documents SET ModifiedOn = GETUTCDATE()                                       
                                       , ContentType = src.ContentType
                                       FROM (SELECT * FROM DMS_Documents WHERE ID=@SrcID) src
                                       WHERE DMS_Documents.ID=@DestID";

                Context.ExecuteNonQuery(
                    commandText,
                    "@SrcID", ItemId,
                    "@DestID", destID);

                // remove old properties from the destination
                Context.ExecuteNonQuery(
                    "DELETE FROM DMS_DocumentProperties WHERE ItemId = @ItemId",
                    "@ItemId", destID);
            }

            // copy properties
            string command =
                @"INSERT INTO DMS_DocumentProperties(ItemId, Name, Namespace, PropVal)
                  SELECT @DestID, Name, Namespace, PropVal
                  FROM DMS_DocumentProperties
                  WHERE ItemId = @SrcID";

            Context.ExecuteNonQuery(
                command,
                "@SrcID", ItemId,
                "@DestID", destID);

            return createdFolder;
        }

        internal void MoveThisItem(DavFolder destFolder, string destName, DavFolder parent)
        {
            string command = 
                @"UPDATE DMS_Folders SET
                     Name = @Name,
                     ParentID = @Parent
                    WHERE ID = @ItemId ;
                    
                    UPDATE DMS_Documents SET
                     Name = @Name,
                     ParentID = @Parent
                  WHERE ID = @ItemId";

            Context.ExecuteNonQuery(
                command,
                "@ItemId", ItemId,
                "@Name", destName,
                "@Parent", destFolder.ItemId);

            parent.UpdateModified();
            destFolder.UpdateModified();
        }

        internal void DeleteThisItem()
        {
            DeleteThisItem(GetParent());
        }

        internal void DeleteThisItem(DavFolder parentFolder)
        {
            Context.ExecuteNonQuery(
                "DELETE FROM DMS_Folders WHERE ID = @ItemId;  DELETE FROM DMS_Documents WHERE ID = @ItemId",
                "@ItemId", ItemId);

            if (parentFolder != null)
            {
                parentFolder.UpdateModified();
            }
        }
        private List<LockInfo> GetLocks(Guid itemId, bool onlyDeep)
        {
            try
            {
                if (onlyDeep)
                {
                    string command =
                        @"SELECT Token, Shared, Deep, Expires, Owner
                      FROM DMS_Locks
                      WHERE ItemId = @ItemId AND Deep = @Deep AND (Expires IS NULL OR Expires > GetUtcDate())";

                    return Context.ExecuteLockInfo(
                        command,
                        "@ItemId", itemId,
                        "@Deep", true);
                }

                string selectCommand =
                   @"SELECT Token, Shared, Deep, Expires, Owner
                 FROM DMS_Locks
                 WHERE ItemId = @ItemId AND (Expires IS NULL OR Expires > GetUtcDate())";

                return Context.ExecuteLockInfo(
                    selectCommand,
                    "@ItemId", itemId);
            }catch(Exception error)
            {
                Logger.Instance.LogError("ERROR=", error);
            }
            return new List<LockInfo>();
        }

        internal bool ClientHasToken()
        {
            IEnumerable<LockInfo> activeLocks = GetActiveLocks();
            List<LockInfo> itemLocks = activeLocks.ToList();
            if (itemLocks.Count == 0)
            {
                return true;
            }

            IList<string> clientLockTokens = Context.Request.ClientLockTokens;
            return itemLocks.Any(il => clientLockTokens.Contains(il.Token));
        }

        protected bool ItemHasLock(bool skipShared)
        {
            IEnumerable<LockInfo> activeLocks = GetActiveLocks();
            List<LockInfo> locks = activeLocks.ToList();
            if (locks.Count == 0)
            {
                return false;
            }

            return !skipShared || locks.Any(l => l.Level != LockLevel.Shared);
        }

        protected static void FindLocksDown(IHierarchyItem root, bool skipShared)
        {
            IFolder folder = root as IFolder;
            if (folder != null)
            {
                foreach (IHierarchyItem child in folder.GetChildren(new PropertyName[0]))
                {
                    DavHierarchyItem dbchild = child as DavHierarchyItem;
                    if (dbchild.ItemHasLock(skipShared))
                    {
                        MultistatusException mex = new MultistatusException();
                        mex.AddInnerException(dbchild.Path, new LockedException());
                        throw mex;
                    }

                    FindLocksDown(child, skipShared);
                }
            }
        }

        internal void UpdateModified()
        {
            Context.ExecuteNonQuery( 
                "UPDATE DMS_Folders SET ModifiedOn = GETUTCDATE() WHERE ID = @ItemId;  UPDATE DMS_Documents SET ModifiedOn = GETUTCDATE() WHERE ID = @ItemId",
                "@ItemId", ItemId);
        }

        protected string CurrentUserName
        {
            get { return Context.User != null ? Context.User.Identity.Name : string.Empty; }
        }        

        protected void SetDbField<T>(string columnName, T value)
        {
            string commandText = string.Format("UPDATE DMS_Documents SET {0} = @value WHERE ID = @ItemId", columnName);
            Context.ExecuteNonQuery(
                commandText,
                "@value", value,
                "@ItemId", ItemId);
        }
        public FileAttributes GetFileAttributes()
        {
            if (Name.StartsWith("."))
            {
                return fileAttributes | FileAttributes.Hidden;
            }

            return fileAttributes;
        }

        public void SetFileAttributes(FileAttributes value)
        {
            SetDbField("Attributes", (int)value);
        }
 
    }
}
