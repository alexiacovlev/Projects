using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;


using ITHit.WebDAV.Server;
using ITHit.WebDAV.Server.Class1;
using ITHit.WebDAV.Server.DeltaV;

namespace DMS.WebDav.Module
{
    /// <summary>
    /// Represents single file version.
    /// </summary>
    public class Version : IVersion, IContent
    {
        /// <summary>
        /// Id of the version.
        /// </summary>
        private readonly Guid versionId;

        /// <summary>
        /// Id of corresponding file.
        /// </summary>
        private readonly Guid itemId;

        /// <summary>
        /// Revision number.
        /// </summary>
        private readonly int versionNumber;

        /// <summary>
        /// Instance of <see cref="DavContext"/>.
        /// </summary>
        private readonly DavContext context;

        /// <summary>
        /// Version display name.
        /// </summary>
        private readonly string name;

        /// <summary>
        /// Version path.
        /// </summary>
        private readonly string path;

        /// <summary>
        /// Date when version was created.
        /// </summary>
        private readonly DateTime created;

        /// <summary>
        /// Number of times corresponding file was modified when version was created.
        /// </summary>
        private readonly string serialNumber;

        /// <summary>
        /// Initializes a new instance of the Version class.
        /// </summary>
        /// <param name="context">Instance of <see cref="DavContext"/> class.</param>
        /// <param name="versionId">Id of the version.</param>
        /// <param name="itemId">Id of item version relates to.</param>
        /// <param name="versionNumber">Revision number of the version.</param>
        /// <param name="name">Version name.</param>
        /// <param name="path">Version path.</param>
        /// <param name="created">Time when version was created.</param>
        /// <param name="serialNumber">Number of times corresponding file was modified when version was created.</param>
        public Version(
            DavContext context,
            Guid versionId,
            Guid itemId,
            int versionNumber,
            string name,
            string path,
            DateTime created,
            string serialNumber)
        {
            this.versionId = versionId;
            this.versionNumber = versionNumber;

            this.context = context;
            this.itemId = itemId;
            this.name = name;
            this.path = path;
            this.created = created;
            this.serialNumber = serialNumber;
        }

        /// <summary>
        /// Gets file to which this version relates.
        /// </summary>
        public IVersionableItem GetVersionableItem()
        {
                string itemPath = path.Remove(path.IndexOf('?'));
                return (IVersionableItem) context.GetHierarchyItem(itemPath);
        }

        /// <summary>
        /// Gets display name for the version.
        /// </summary>
        public string VersionName
        {
            get { return "V" + this.versionNumber; }
        }

        /// <summary>
        /// Gets content type of the version.
        /// </summary>
        public string ContentType
        {
            get
            {
                return context.ExecuteScalar<string>(
                    "SELECT ContentType FROM DMS_DocumentVersions WHERE VersionId = @VersionId",
                    "@VersionId", VersionId) ?? string.Empty;
            }
        }

        /// <summary>
        /// Gets content length of the version.
        /// </summary>
        public long ContentLength
        {
            get
            {
                object val = context.ExecuteScalar<object>(
                    "SELECT DATALENGTH(FileContent) FROM DMS_DocumentVersions WHERE VersionId = @VersionId",
                    "@VersionId", versionId);

                return val == null ? 0 : Convert.ToInt64(val);
            }
        }

        /// <summary>
        /// Gets version etag.
        /// </summary>
        public string Etag
        {
            get { return string.Format("{0}-{1}", Modified.ToBinary(), serialNumber); }
        }

        /// <summary>
        /// Gets version display name.
        /// </summary>
        public string Name
        {
            get { return name; }
        }

        /// <summary>
        /// Gets date when the version was created.
        /// </summary>
        public DateTime Created
        {
            get { return created; }
        }

        /// <summary>
        /// Gets version modification date.
        /// </summary>
        public DateTime Modified
        {
            get { return DateTime.MinValue; }
        }

        /// <summary>
        /// Gets parent folder. Don't need it.
        /// </summary>
        public IFolder Parent
        {
            get { throw new Exception("The method or operation is not implemented."); }
        }

        /// <summary>
        /// Gets version path.
        /// </summary>
        public string Path
        {
            get { return this.path; }
        }

        /// <summary>
        /// Gets revision number.
        /// </summary>
        internal int VersionNumber
        {
            get { return this.versionNumber; }
        }

        /// <summary>
        /// Gets file identifier.
        /// </summary>
        internal Guid ItemId
        {
            get { return this.itemId; }
        }

        /// <summary>
        /// Gets version identifier.
        /// </summary>
        internal Guid VersionId
        {
            get { return versionId; }
        }

        /// <summary>
        /// Creates path for version for specified file and revision number.
        /// </summary>
        /// <param name="itemPath">Path to the file.</param>
        /// <param name="versionNumber">Revision number.</param>
        /// <returns>Path to the corresponding version.</returns>
        public static string CreateVersionPath(string itemPath, int versionNumber)
        {
            return itemPath + "?version=" + versionNumber;
        }

        /// <summary>
        /// Gets next version after this.
        /// </summary>
        /// <returns>Next version or <c>null</c>.</returns>
        public IVersion GetSuccessor()
        {
            string command = 
                @"SELECT VersionId, ItemId, VersionNumber, Name, CreatedOn, SerialNumber
                  FROM DMS_DocumentVersions
                  WHERE (ItemId = @ItemId) AND (VersionNumber =
                        (SELECT MIN(VersionNumber)
                         FROM DMS_DocumentVersions
                         WHERE (ItemId = @ItemId) AND (VersionNumber > @VersionNumber)))";
            
            return context.ExecuteVersion(
                path.Remove(path.IndexOf('?')),
                command,
                "@ItemId", itemId,
                "@VersionNumber", versionNumber).FirstOrDefault();
        }


        /// <summary>
        /// Gets previous version.
        /// </summary>
        /// <returns>Previous version or <c>null</c>.</returns>
        public IVersion GetPredecessor()
        {
            string command = 
                @"SELECT VersionId, ItemId, VersionNumber, Name, CreatedOn, SerialNumber
                  FROM DMS_DocumentVersions
                  WHERE (ItemId = @ItemId) AND (VersionNumber =
                        (SELECT MAX(VersionNumber)
                         FROM DMS_DocumentVersions
                         WHERE (ItemId = @ItemId) AND (VersionNumber < @VersionNumber)))";

            return context.ExecuteVersion(
                path.Remove(path.IndexOf('?')),
                command,
                "@ItemId", itemId,
                "@VersionNumber", versionNumber).FirstOrDefault();
        }


        /// <summary>
        /// Gets comment for this version.
        /// </summary>
        /// <returns>Version comment.</returns>
        public string GetComment()
        {
            return context.ExecuteScalar<string>(
                "SELECT Comment FROM DMS_DocumentVersions WHERE VersionId = @VersionId",
                "@VersionId", VersionId);
        }

        /// <summary>
        /// Sets comment for this version.
        /// </summary>
        /// <param name="comment">Version comment.</param>
        public void SetComment(string comment)
        {
            context.ExecuteNonQuery(
                "UPDATE DMS_DocumentVersions SET Comment = @Comment WHERE VersionId = @VersionId",
                "@VersionId", versionId,
                "@Comment", comment);
        }

        /// <summary>
        /// Gets name of user who created this version.
        /// </summary>
        /// <returns>Creator name.</returns>
        public string GetCreatorDisplayName()
        {
            return context.ExecuteScalar<string>(
                "SELECT CreatorDisplayName FROM DMS_DocumentVersions WHERE VersionId = @VersionId",
                "@VersionId", VersionId);
        }

        /// <summary>
        /// Sets name of the user who created this version.
        /// </summary>
        /// <param name="creatorName">User name.</param>
        public void SetCreatorDisplayName(string creatorName)
        {
            context.ExecuteNonQuery(
                @"UPDATE DMS_DocumentVersions SET CreatorDisplayName = @CreatorDisplayName
                  WHERE VersionId = @VersionId",
                "@VersionId", VersionId,
                "@CreatorDisplayName", creatorName);
        }

        /// <summary>
        /// Reads version content.
        /// </summary>
        /// <param name="output">Stream to write content to.</param>
        /// <param name="startIndex">First byte to read.</param>
        /// <param name="count">Number of bytes to read.</param>
        public void Read(Stream output, long startIndex, long count)
        {
            if (DavFile.ContainsDownloadParam(context.Request.RawUrl))
            {
                DavFile.AddContentDisposition(context, Name);
            }

            using (SqlDataReader reader = context.ExecuteReader(
                CommandBehavior.SequentialAccess,
                "SELECT FileContent FROM DMS_DocumentVersions WHERE VersionId = @VersionId",
                "@VersionId", versionId))
            {
                reader.Read();

                long bufSize = 1048576; // 1Mb
                byte[] buf = new byte[bufSize];
                long retval;

                while ((retval = reader.GetBytes(
                    reader.GetOrdinal("FileContent"),
                    startIndex,
                    buf,
                    0,
                    (int)(count > bufSize ? bufSize : count))) > 0)
                {
                    output.Write(buf, 0, (int)retval);
                    startIndex += retval;
                    count -= retval;
                }
            }
        }

        /// <summary>
        /// Updating version content is not supported.
        /// </summary>
        public bool Write(Stream content, string contentType, long startIndex, long totalFileSize)
        {
            throw new DavException("Cannot update version.", DavStatus.FORBIDDEN);
        }

        /// <summary>
        /// Retrieves dead properties from the version.
        /// </summary>
        /// <param name="names">Names of properties to be retrieved.</param>
        /// <param name="allprop">Whether all properties shall be retrieved.</param>
        /// <returns>Property values.</returns>
        public IEnumerable<PropertyValue> GetProperties(IList<PropertyName> names, bool allprop)
        {
            IList<PropertyValue> propVals = context.ExecutePropertyValue(
                @"SELECT Name, Namespace, PropVal
                  FROM DMS_DocumentVersionProperties
                  WHERE VersionId = @VersionId",
                "@VersionId", versionId);

            if (allprop)
            {
                return propVals;
            }
            else
            {
                IList<PropertyValue> requestedPropVals = new List<PropertyValue>();
                foreach (PropertyValue p in propVals)
                {
                    if (names.Contains(p.QualifiedName))
                    {
                        requestedPropVals.Add(p);
                    }
                }
                return requestedPropVals;
            }
        }

        /// <summary>
        /// Gets names of dead properties for this version.
        /// </summary>
        /// <returns>Enumerable with property names.</returns>
        public IEnumerable<PropertyName> GetPropertyNames()
        {
            IList<PropertyName> propNames = new List<PropertyName>();
            foreach (PropertyValue propName in GetProperties(new PropertyName[0], true))
            {
                propNames.Add(propName.QualifiedName);
            }
            return propNames;
        }

        /// <summary>
        /// Copying of versions is not supported.
        /// </summary>
        public void CopyTo(IItemCollection destFolder, string destName, bool deep, MultistatusException multistatus)
        {
            throw new DavException("Cannot copy version.", DavStatus.NOT_ALLOWED);
        }

        /// <summary>
        /// Moving versions is not supported.
        /// </summary>
        public void MoveTo(IItemCollection destFolder, string destName, MultistatusException multistatus)
        {
            throw new DavException("Cannot move version.", DavStatus.NOT_ALLOWED);
        }

        /// <summary>
        /// Delets the version.
        /// </summary>
        /// <param name="multistatus">We don't use it here.</param>
        public void Delete(MultistatusException multistatus)
        {
            context.ExecuteNonQuery(
                "DELETE FROM DMS_DocumentVersions WHERE VersionId = @VersionId",
                "@VersionId", versionId);
        }

        /// <summary>
        /// Updating properties is not supported.
        /// </summary>
        public void UpdateProperties(
            IList<PropertyValue> setProps,
            IList<PropertyName> delProps,
            MultistatusException multistatus)
        {
            throw new DavException("Cannot update version properties", DavStatus.NOT_ALLOWED);
        }
    }
}
