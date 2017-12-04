using System;
using System.Collections.Generic;
using System.Linq;


using ITHit.WebDAV.Server;
using ITHit.WebDAV.Server.DeltaV;

namespace DMS.WebDav.Module
{
    /// <summary>
    /// Is used for various operations with a file's versions.
    /// </summary>
    public class VersionHistory : IHistory
    {
        /// <summary>
        /// Instance of <see cref="DavContext"/>.
        /// </summary>
        private readonly DavContext context;

        /// <summary>
        /// Identifier of corresponding file.
        /// </summary>
        private readonly Guid itemId;

        /// <summary>
        /// Encoded WebDAV path to this version history item.
        /// </summary>
        private readonly string path;

        /// <summary>
        /// Initializes a new instance of the VersionHistory class.
        /// </summary>
        /// <param name="context">Instance of <see cref="DavContext"/>.</param>
        /// <param name="itemId">File id.</param>
        /// <param name="path">Version history encoded path.</param>
        public VersionHistory(DavContext context, Guid itemId, string path)
        {
            this.context = context;
            this.itemId = itemId;
            this.path = path;
        }

        /// <summary>
        /// Gets version history path.
        /// </summary>
        public string Path
        {
            get { return path; }
        }

        /// <summary>
        /// Gets display name - not implemented.
        /// </summary>
        public string Name
        {
            get { throw new DavException("The method or operation is not implemented.", DavStatus.NOT_IMPLEMENTED); }
        }

        /// <summary>
        /// Not needed.
        /// </summary>
        public DateTime Created
        {
            get { throw new DavException("The method or operation is not implemented.", DavStatus.NOT_IMPLEMENTED); }
        }

        /// <summary>
        /// Not needed.
        /// </summary>
        public DateTime Modified
        {
            get { throw new DavException("The method or operation is not implemented.", DavStatus.NOT_IMPLEMENTED); }
        }

        /// <summary>
        /// Gets curret version for the corresponding file.
        /// </summary>
        /// <returns>Instance of <see cref="IVersionAsync"/>.</returns>
        public IVersion GetCurrentVersion()
        {
            string command = 
                @"SELECT VersionId, ItemId, VersionNumber, Name, Created, SerialNumber
                  FROM DMS_DocumentVersions
                  WHERE ItemId = @ItemId AND VersionNumber = 
                       (SELECT MAX(VersionNumber) FROM DMS_DocumentVersions WHERE ItemId = @ItemId)";

            return context.ExecuteVersion(
                path.Remove(path.IndexOf('?')),
                command,
                "@ItemId", itemId).FirstOrDefault();
        }


        /// <summary>
        /// Retrieves all versions for corresponding file.
        /// </summary>
        /// <param name="propNames">Properties that will be requested later from the items returned.</param>
        /// <returns>Enumerable with versions.</returns>
        public IEnumerable<IVersion> GetVersionSet(IList<PropertyName> propNames)
        {
            string command = 
                @"SELECT VersionId, ItemId, VersionNumber, Name, Created, SerialNumber
                  FROM DMS_DocumentVersions
                  WHERE ItemId = @ItemId";

            return context.ExecuteVersion(
                path.Remove(path.IndexOf('?')),
                command,
                "@ItemId", itemId);
        }


        /// <summary>
        /// Gets first version.
        /// </summary>
        /// <returns>Instance of <see cref="IVersionAsync"/>.</returns>
        public IVersion GetRootVersion()
        {
            string command = 
                @"SELECT VersionId, ItemId, VersionNumber, Name, Created, SerialNumber
                  FROM DMS_DocumentVersions
                  WHERE ItemId = @ItemId AND VersionNumber =
                                   (SELECT MIN(VersionNumber) FROM DMS_DocumentVersions WHERE ItemId = @ItemId)";

            return context.ExecuteVersion(
                path.Remove(path.IndexOf('?')),
                command,
                "@ItemId", itemId).FirstOrDefault();
        }

        /// <summary>
        /// Not supported.
        /// </summary>
        public void CopyTo(IItemCollection destFolder, string destName, bool deep, MultistatusException multistatus)
        {
            throw new DavException("Cannot copy history resource", DavStatus.NOT_ALLOWED);
        }

        /// <summary>
        /// Not supported.
        /// </summary>
        public void MoveTo(IItemCollection destFolder, string destName, MultistatusException multistatus)
        {
            throw new DavException("Cannot move history resource", DavStatus.NOT_ALLOWED);
        }

        /// <summary>
        /// Not supported.
        /// </summary>
        public void Delete(MultistatusException multistatus)
        {
            throw new DavException("Cannot delete history resource", DavStatus.NOT_ALLOWED);
        }

        /// <summary>
        /// Not supported.
        /// </summary>
        /// <param name="names"></param>
        /// <param name="allprop"></param>
        /// <returns></returns>
        public IEnumerable<PropertyValue> GetProperties(IList<PropertyName> names, bool allprop)
        {
            throw new DavException("Cannot get properties of history resource.", DavStatus.NOT_ALLOWED);
        }

        /// <summary>
        /// Not supported.
        /// </summary>
        public IEnumerable<PropertyName> GetPropertyNames()
        {
            throw new DavException("Cannot get property names of history resource.", DavStatus.NOT_ALLOWED);
        }

        /// <summary>
        /// Not supported.
        /// </summary>
        public void UpdateProperties(
            IList<PropertyValue> setProps,
            IList<PropertyName> delProps,
            MultistatusException multistatus)
        {
            throw new DavException("Cannot update properties of history resource.", DavStatus.NOT_ALLOWED);
        }
    }
}
