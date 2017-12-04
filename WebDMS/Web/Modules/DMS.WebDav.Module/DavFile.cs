using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;


using ITHit.WebDAV.Server;
using ITHit.WebDAV.Server.Class1;
using ITHit.WebDAV.Server.Class2;
using ITHit.WebDAV.Server.DeltaV;
using ITHit.WebDAV.Server.ResumableUpload;

namespace DMS.WebDav.Module
{
    /// <summary>
    /// Represents file in WebDAV repository.
    /// </summary>
    public class DavFile : DavHierarchyItem, IFile, IVersionableItem, IResumableUpload, IUploadProgress
    {
        /// <summary>
        /// Autoversioning mode as specified in configuration.
        /// </summary>
        private static readonly AutoVersion autoVersionMode =
            (AutoVersion)Enum.Parse(typeof(AutoVersion), ConfigurationManager.AppSettings["AutoVersionMode"]);

        /// <summary>
        /// Initializes a new instance of the DavFile class.
        /// </summary>
        /// <param name="context">Instance of <see cref="DavContext"/>.</param>
        /// <param name="itemId">Item identifier.</param>
        /// <param name="parentId">Parent identifier.</param>
        /// <param name="name">Item name.</param>
        /// <param name="path">Item path (encoded)</param>
        /// <param name="created">Item creation date.</param>
        /// <param name="modified">Item modification date.</param>
        /// <param name="fileAttributes">File attributes for the item.</param>
        public DavFile(DavContext context, Guid itemId, Guid parentId, string name, string path, DateTime created, DateTime modified, FileAttributes fileAttributes)
            : base(context, itemId, parentId, name, path, created, modified, fileAttributes)
        {
        }

        /// <summary>
        /// Gets item's content type.
        /// </summary>
        public string ContentType
        {
            get
            {
                string contentType = null;

                int extIndex = Name.LastIndexOf('.');
                if (extIndex != -1)
                {
                    contentType = MimeType.GetMimeType(Name.Substring(extIndex + 1));
                }

                if (string.IsNullOrEmpty(contentType))
                {
                    contentType = getDbField<string>("ContentType", null);
                }

                if (string.IsNullOrEmpty(contentType))
                {
                    contentType = "application/octet-stream";
                }

                return contentType;
            }
        }

        /// <summary>
        /// Gets file length.
        /// </summary>
        public long ContentLength
        {
            get
            {
                object result = Context.ExecuteScalar<object>(
                    "SELECT DATALENGTH(FileContent) FROM DMS_Documents WHERE ID = @ItemId",
                    "@ItemId", ItemId);

                return result == DBNull.Value ? 0 : Convert.ToInt64(result);
            }
        }

        /// <summary>
        /// Gets Etag.
        /// </summary>
        public string Etag
        {
            get
            {
                int serialNumber = getDbField("SerialNumber", 0);
                return string.Format("{0}-{1}", Modified.ToBinary(), serialNumber);
            }
        }
        /// <summary>
        /// Gets or Sets snippet of file content that matches search conditions.
        /// </summary>
        public string Snippet { get; set; }
        /// <summary>
        /// Gets version history item for this file.
        /// </summary>
        public IHistory VersionHistory
        {
            get
            {
                string command =
                    @"SELECT VersionId
                      FROM DMS_DocumentVersions
                      WHERE ItemId = @ItemId";

                if (Context.ExecuteScalar<object>(command, "@ItemId", ItemId) != null)
                {
                    return new VersionHistory(Context, ItemId, Path + "?history");
                }

                return null;
            }
        }

        /// <summary>
        /// Gets a value indicating whether the file is checked out.
        /// </summary>
        public bool IsCheckedOut
        {
            get { return getDbField("CheckedOut", false); }
        }

        /// <summary>
        /// Gets or sets a value indicating whether the file was automatically checked out
        /// by the engine as result of autoversioning.
        /// </summary>
        public bool IsAutoCheckedOut
        {
            get { return getDbField("AutoCheckedOut", false); }
            set { SetDbField("AutoCheckedOut", value); }
        }

        /// <summary>
        /// Reads file's content from storage (to send to client).
        /// </summary>
        /// <param name="output">Stream to read body to.</param>
        /// <param name="byteStart">Number of first byte to write.</param>
        /// <param name="count">Number of bytes to be written.</param>
        public void Read(Stream output, long byteStart, long count)
        {
            //Set timeout to maximum value to be able to download large files.
            HttpContext.Current.Server.ScriptTimeout = int.MaxValue;
            if (ContainsDownloadParam(Context.Request.RawUrl))
            {
                AddContentDisposition(Context, Name);
            }

            using (SqlDataReader reader = Context.ExecuteReader(
                CommandBehavior.SequentialAccess,
                @"SELECT FileContent FROM DMS_Documents WHERE ID = @ItemId",
                "@ItemId", ItemId))
            {
                reader.Read();

                long bufSize = 1048576; // 1Mb
                var buf = new byte[bufSize];
                long retval;
                long startIndex = byteStart;

                try
                {
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
                catch (HttpException)
                {
                    // The remote host closed the connection (for example Cancel or Pause pressed).
                }
            }
        }

        internal static bool ContainsDownloadParam(string url)
        {
            int ind = url.IndexOf('?');
            if (ind > 0 && ind < url.Length - 1)
            {
                var param = url.Substring(ind + 1).Split('&');
                return param.Any(p => p.StartsWith("download"));
            }
            return false;
        }

        internal static void AddContentDisposition(DavContext context, string name)
        {
            if (context.Request.UserAgent.Contains("MSIE")) // problem with file extensions in IE
            {
                var fileName = EncodeUtil.EncodeUrlPart(name);
                context.Response.AddHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
            }
            else
                context.Response.AddHeader("Content-Disposition", "attachment;");
        }

        /// <summary>
        /// Stores file contents to storage (when client updates it).
        /// </summary>
        /// <param name="segment">Stream with new file content.</param>
        /// <param name="contentType">New content type.</param>
        /// <param name="startIndex">Index of first byte in the file where update shall be applied.</param>
        /// <param name="totalContentLength">Length of the file after it will be updated with the new content.</param>
        /// <returns>Boolean value indicating if entire stream was written.</returns>
        public bool Write(Stream segment, string contentType, long startIndex, long totalContentLength)
        {
            RequireHasToken();
            //Set timeout to maximum value to be able to upload large files.
            HttpContext.Current.Server.ScriptTimeout = int.MaxValue;
            string commandText =
                @"UPDATE DMS_Documents
                  SET
                      ModifiedOn = GETUTCDATE(),
                      TotalContentLength = CASE WHEN @TotalContentLength >= 0 THEN @TotalContentLength ELSE 0 END,
                      ContentType = @ContentType,
                      FileContent = CASE WHEN @ResetContent = 1 THEN 0x ELSE FileContent END,
                      SerialNumber = ISNULL(SerialNumber, 0) + 1
                  WHERE ID = @ItemId";

            Context.ExecuteNonQuery(
                 commandText,
                 "@ContentType", (object)contentType ?? DBNull.Value,
                 "@ItemId", ItemId,
                 "@TotalContentLength", totalContentLength,
                 "@ResetContent", startIndex == 0 ? 1 : 0);

            const int bufSize = 1048576; // 1Mb
            byte[] buffer = new byte[bufSize];

            long bytes = 0;

            int lastBytesRead;

            try
            {
                while ((lastBytesRead = segment.Read(buffer, 0, bufSize)) > 0)
                {
                    SqlParameter dataParm = new SqlParameter("@Data", SqlDbType.VarBinary, bufSize);
                    SqlParameter offsetParm = new SqlParameter("@Offset", SqlDbType.Int);
                    SqlParameter bytesParm = new SqlParameter("@Bytes", SqlDbType.Int, bufSize);
                    SqlParameter itemIdParm = new SqlParameter("@ItemId", ItemId);

                    dataParm.Value = buffer;
                    dataParm.Size = lastBytesRead;
                    offsetParm.Value = bytes + startIndex;
                    bytesParm.Value = lastBytesRead;

                    string updateItemCommand =
                        @"UPDATE DMS_Documents SET
                            LastChunkSaved = GetUtcDate(),
                            FileContent .WRITE(@Data, @Offset, @Bytes)
                          WHERE ID = @ItemId";

                    Context.ExecuteNonQuery(
                        updateItemCommand,
                        dataParm,
                        offsetParm,
                        bytesParm,
                        itemIdParm);

                    bytes += lastBytesRead;
                }
            }
            catch (HttpException)
            {
                // The remote host closed the connection (for example Cancel or Pause pressed).
            }

            return true;
        }

        /// <summary>
        /// Copies this file to another folder.
        /// </summary>
        /// <param name="destFolder">Destination folder.</param>
        /// <param name="destName">New file name in destination folder.</param>
        /// <param name="deep">Is not used.</param>
        /// <param name="multistatus">Container for errors with items other than this file.</param>
        public override void CopyTo(
            IItemCollection destFolder,
            string destName,
            bool deep,
            MultistatusException multistatus)
        {
            DavFolder destDavFolder = destFolder as DavFolder;
            if (destFolder == null)
            {
                throw new DavException("Destination folder doesn't exist.", DavStatus.CONFLICT);
            }
            if (!destDavFolder.ClientHasToken())
            {
                throw new LockedException("Doesn't have token for destination folder.");
            }

            DavHierarchyItem destItem = destDavFolder.FindChild(destName);
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

            CopyThisItem(destDavFolder, null, destName);
        }

        /// <summary>
        /// Deletes this file.
        /// </summary>
        /// <param name="multistatus">Is not used.</param>
        public override void Delete(MultistatusException multistatus)
        {
            DavFolder parent = GetParent();
            if (parent == null)
            {
                throw new DavException("Parent is null.", DavStatus.CONFLICT);
            }
            if (!parent.ClientHasToken())
            {
                throw new LockedException();
            }

            if (!ClientHasToken())
            {
                throw new LockedException();
            }

            DeleteThisItem(parent);
        }

        /// <summary>
        /// Moves this file to different folder and renames it.
        /// </summary>
        /// <param name="destFolder">Destination folder.</param>
        /// <param name="destName">New file name.</param>
        /// <param name="multistatus">Container for errors with items other than this file.</param>
        public override void MoveTo(IItemCollection destFolder, string destName, MultistatusException multistatus)
        {
            DavFolder destDavFolder = destFolder as DavFolder;
            if (destFolder == null)
            {
                throw new DavException("Destination folder doesn't exist.", DavStatus.CONFLICT);
            }

            DavFolder parent = GetParent();
            if (parent == null)
            {
                throw new DavException("Cannot move root.", DavStatus.CONFLICT);
            }
            if (!ClientHasToken() || !destDavFolder.ClientHasToken() || !parent.ClientHasToken())
            {
                throw new LockedException();
            }

            DavHierarchyItem destItem = destDavFolder.FindChild(destName);
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

            MoveThisItem(destDavFolder, destName, parent);
        }
        /// <summary>
        /// Checkins the file. This creates new version and marks the file as checked in.
        /// </summary>
        /// <returns>Path to the version created.</returns>
        public string CheckIn()
        {
            string newVersionUrl;
            RequireHasToken();

            if (this.VersionHistory != null)
            {
                // Create new version. Copy content and properties from this item to new version.

                IVersion v = this.VersionHistory.GetCurrentVersion();
                Version version = v as Version;
                Debug.Assert(version != null);
                int newVersionNumber = version.VersionNumber + 1;
                string newVersionPath = Version.CreateVersionPath(Path, newVersionNumber);

                Guid newId = Guid.NewGuid();
                // Create new version.
                string command =
                    @"INSERT INTO DMS_DocumentVersions
                         (ItemId,
                          VersionId,
                          VersionNumber,
                          Name,
                          Comment,
                          CreatorDisplayName,
                          FileContent,
                          ContentType,
                          CreatedOn,
                          SerialNumber)
                      SELECT
                          @ItemId,
                          @Identity,
                          @VersionNumber,
                          Name,
                          Comment,
                          IsNull(@CreatorDisplayName, CreatorDisplayName),
                          FileContent,
                          ContentType,
                          GETUTCDATE(),
                          COALESCE(SerialNumber, 1)
                      FROM DMS_Documents
                      WHERE ID = @ItemId";
                // COALESCE returns the first nonnull expression among its arguments.

                Context.ExecuteNonQuery(
                    command,
                    "@ItemId", ItemId,
                    "@VersionNumber", newVersionNumber,
                    "@CreatorDisplayName",
                    string.IsNullOrEmpty(CurrentUserName) ? (object)DBNull.Value : CurrentUserName,
                    "@Identity", newId);

               Context.ExecuteNonQuery(
                    "UPDATE DMS_Documents SET Comment = '' WHERE ID = @ItemId",
                    "@ItemId", ItemId);

                // Copy properties to new version
                string copyCommand =
                    @"INSERT INTO DMS_DocumentVersionProperties( VersionId, Name, Namespace, PropVal)
                      SELECT @VersionId, Name, Namespace, PropVal
                      FROM  DMS_DocumentProperties 
                      WHERE ItemId = @ItemId";

                Context.ExecuteNonQuery(
                    copyCommand,
                    "@VersionId", newId,
                    "@ItemId", ItemId);

                // Copy FileContent to new version
                newVersionUrl = newVersionPath;
            }
            else
            {
                newVersionUrl = this.Path;
            }

            setFileCheckedOut(false, false);
            return newVersionUrl;
        }

        /// <summary>
        /// Marks the item as checkedout.
        /// </summary>
        /// <param name="autoCheckout">Whether this checkout is performed by the engine itself as result of
        /// autoversioning. We blindly store the value, so it can be retrieved by the engine later.</param>
        public void CheckOut(bool autoCheckout)
        {
            RequireHasToken();

            setFileCheckedOut(true, autoCheckout);
        }

        /// <summary>
        /// Cancels last checkout.
        /// </summary>
        public void UnCheckOut()
        {
            RequireHasToken();

            if (this.VersionHistory != null)
            {
                // Discard changes.
                // Copy FileContent and properties from current version to this item. Mark item as checked in.

                Version version = (Version)VersionHistory.GetCurrentVersion();

                // Restore properties.
                Context.ExecuteNonQuery(
                    "DELETE FROM DMS_DocumentProperties WHERE ItemId = @ItemId",
                    "@ItemId", ItemId);

                string command =
                     @"INSERT INTO  DMS_DocumentProperties (ItemId, Name, Namespace, PropVal)
                       SELECT @ItemId, Name, Namespace, PropVal
                       FROM DMS_DocumentVersionProperties
                       WHERE VersionId = @VersionId";

                Context.ExecuteNonQuery(
                    command,
                    "@VersionId", version.VersionId,
                    "@ItemId", ItemId);

                string updateItemCommand =
                     @"UPDATE DMS_Documents
                       SET FileContent = (SELECT FileContent FROM DMS_DocumentVersions WHERE VersionId = @versionID)
                       WHERE ID = @ItemId";

                Context.ExecuteNonQuery(
                    updateItemCommand,
                    "@ItemId", ItemId,
                    "@VersionId", version.VersionId);
            }
            // Mark item as checked in.
            setFileCheckedOut(false, false);
        }

        /// <summary>
        /// Updates content of the file to the content of the version specified.
        /// </summary>
        /// <param name="version">Version to get content from.</param>
        public void UpdateToVersion(IVersion version)
        {
            RequireHasToken();
            // Create a new version and copy content and properties from IVersion passed as a parameter. 
            // Replace content and properties of this item.
            Version ver = version as Version;
            if (ver.ItemId != this.ItemId)
            {
                throw new DavException("The version must be from the same item.", DavStatus.CONFLICT);
            }

            IVersion v = this.VersionHistory.GetCurrentVersion();
            Version currVersion = v as Version;
            int newVersionNumber = currVersion.VersionNumber + 1;

            Guid newID = Guid.NewGuid();

            string command =
                 @"INSERT INTO DMS_DocumentVersions(
                       ItemId,
                       VersionId,
                       VersionNumber,
                       Name,
                       Comment,
                       CreatorDisplayName,
                       FileContent,
                       ContentType,
                       CreatedOn,
                       SerialNumber)
                   SELECT 
                       @ID,
                       @Identity,
                       @VersionNumber,
                       i.Name,
                       i.Comment,
                       i.CreatorDisplayName,
                       v.FileContent,
                       i.ContentType,
                       GETUTCDATE(),
                       v.SerialNumber
                   FROM DMS_Documents i
                   INNER JOIN DMS_DocumentVersions v ON v.ItemId = i.ID
                   WHERE i.ID = @ID AND v.VersionId = @VersionId";

            Context.ExecuteNonQuery(
                command,
                "@ID", ItemId,
                "@VersionNumber", newVersionNumber,
                "@Identity", newID,
                "@VersionID", ver.VersionId);

            string updateContentCommand =
                @"UPDATE DMS_Documents
                  SET
                      FileContent = v.FileContent,
                      SerialNumber = v.SerialNumber
                  FROM DMS_Documents i
                      INNER JOIN DMS_DocumentVersions v ON i.ID = v.ItemId
                  WHERE
                      i.ID = @ID AND v.VersionId = @versionID";

            Context.ExecuteNonQuery(
                updateContentCommand,
                "@ID", ItemId,
                "@VersionId", ver.VersionId);

            // Copy properties to this item
            Context.ExecuteNonQuery(
                "DELETE FROM DMS_DocumentProperties WHERE ItemId = @ItemId",
                "@ItemId", ItemId);

            string insertPropertyCommand =
                 @"INSERT INTO  DMS_DocumentProperties (ItemId, Name, Namespace, PropVal)
                   SELECT @ItemId, Name, Namespace, PropVal
                   FROM DMS_DocumentVersionProperties
                   WHERE VersionId = @VersionId";

            Context.ExecuteNonQuery(
                insertPropertyCommand,
                "@ItemId", ItemId,
                "@VersionId", ver.VersionId);

            string insertVersionPropertyCommand =
                @"INSERT INTO DMS_DocumentVersionProperties(VersionId, Name, Namespace, PropVal)
                  SELECT @NewVerId, Name, Namespace, PropVal
                  FROM DMS_DocumentVersionProperties
                  WHERE VersionId = @VersionId";

            Context.ExecuteNonQuery(
                insertVersionPropertyCommand,
                "@NewVerId", newID,
                "@VersionId", ver.VersionId);
        }

        /// <summary>
        /// Gets autoversioning mode for the file.
        /// </summary>
        /// <returns>Autoversioning mode for the file.</returns>
        public AutoVersion GetAutoVersion()
        {
            return getDbField<AutoVersion>("AutoVersion", AutoVersion.NoAutoVersioning);
        }

        /// <summary>
        /// Sets autoversioning mode for the file.
        /// </summary>
        /// <param name="value">Autoversioning mode.</param>
        public void SetAutoVersion(AutoVersion value)
        {
            SetDbField("AutoVersion", value);
        }

        /// <summary>
        /// Enables/disables versioning for this file.
        /// </summary>
        /// <param name="enable">Whether versioning shall be enabled or disabled.</param>
        public void PutUnderVersionControl(bool enable)
        {
            if (enable && this.VersionHistory == null)
            {
                // Create new version. The content and properties of the new version is being copied from this item.
                SetAutoVersion(autoVersionMode);

                Guid newID = Guid.NewGuid();
                string insertVersionCommand =
                    @"INSERT INTO DMS_DocumentVersions(
                          ItemId,
                          VersionId,
                          VersionNumber,
                          Name,
                          Comment,
                          CreatorDisplayName,
                          FileContent,
                          ContentType,
                          CreatedOn,
                          SerialNumber)
                       SELECT
                          @ItemId,
                          @Identity,
                          1,
                          Name,
                          Comment,
                          @CreatorDisplayName,
                          FileContent,
                          ContentType,
                          GETUTCDATE(),
                          0
                        FROM DMS_Documents
                        WHERE ID = @ItemId";

                Context.ExecuteNonQuery(
                    insertVersionCommand,
                    "@ItemId", ItemId,
                    "@CreatorDisplayName", CurrentUserName,
                    "@Identity", newID);

                string insertVersionPropertyCommand =
                    @"INSERT INTO DMS_DocumentVersionProperties(VersionId, Name, Namespace, PropVal)
                      SELECT @VersionId, Name, Namespace, PropVal
                      FROM  DMS_DocumentProperties 
                      WHERE ItemId = @ItemId";

                Context.ExecuteNonQuery(
                    insertVersionPropertyCommand,
                    "@VersionId", newID,
                    "@ItemId", ItemId);

                setFileCheckedOut(false, false);
            }
            else if (!enable)
            {
                // Delete all versions
                Context.ExecuteNonQuery(
                    "DELETE FROM DMS_DocumentVersions WHERE ItemId = @ItemId",
                    "@ItemId", ItemId);
            }
        }

        /// <summary>
        /// Retrieves a brief comment about a file that is suitable for presentation to a user.
        /// </summary>
        /// <returns>Brief comment about a file.</returns>
        public string GetComment()
        {
            return getDbField<string>("Comment", null);
        }

        /// <summary>
        /// Sets a brief comment about a file that is suitable for presentation to a user.
        /// </summary>
        /// <param name="comment">Comment string.</param>
        public void SetComment(string comment)
        {
            SetDbField("Comment", comment);
        }

        /// <summary>
        /// Gets creator display name.
        /// </summary>
        /// <returns>Name of person who created this item.</returns>
        public string GetCreatorDisplayName()
        {
            return getDbField<string>("CreatorDisplayName", null);
        }

        /// <summary>
        /// Sets name of person who created the version.
        /// </summary>
        /// <param name="name">Creator name.</param>
        public void SetCreatorDisplayName(string name)
        {
            SetDbField("CreatorDisplayName", name);
        }
        /// <summary>
        /// Cancels incomplete upload.
        /// </summary>
        public void CancelUpload()
        {
            // UnCheckOut();
        }

        /// <summary>
        /// Gets time when last upload piece was saved to disk.
        /// </summary>
        public DateTime LastChunkSaved
        {
            get { return getDbField("LastChunkSaved", DateTime.MinValue); }
        }

        /// <summary>
        /// Gets bytes uploaded sofar.
        /// </summary>
        public long BytesUploaded
        {
            get { return ContentLength; }
        }

        /// <summary>
        /// Gets length of the file which it will have after upload finishes.
        /// </summary>
        public long TotalContentLength
        {
            get { return getDbField<long>("TotalContentLength", -1); }
        }

        /// <summary>
        /// Returns instance of <see cref="IResumableUploadAsync"/> interface for this item.
        /// </summary>
        /// <returns>Instance of <see cref="IResumableUploadAsync"/> interface.</returns>
        public IEnumerable<IResumableUpload> GetUploadProgress()
        {
            return new[] { this };
        }
        /// <summary>
        /// Sets checked out flag.
        /// </summary>
        /// <param name="value">Checked out or not.</param>
        /// <param name="autoCheckOut">Whether this is invoked by the enging as result of autoversioning.</param>
        private void setFileCheckedOut(bool value, bool autoCheckOut)
        {
            SetDbField("CheckedOut", value);
            SetDbField("AutoCheckedOut", autoCheckOut);
        }

        /// <summary>
        /// Returns database field of the file.
        /// </summary>
        /// <typeparam name="T">Type of field value.</typeparam>
        /// <param name="columnName">DB columen in which field is stored.</param>
        /// <param name="defaultValue">Default value to return.</param>
        /// <returns>Value from database or default value if it is null.</returns>
        private T getDbField<T>(string columnName, T defaultValue)
        {
            string commandText = string.Format("SELECT {0} FROM DMS_Documents WHERE ID = @ItemId", columnName);
            object obj = Context.ExecuteScalar<object>(commandText, "@ItemId", ItemId);

            return obj != null ? (T)obj : defaultValue;
        }
    }
}
