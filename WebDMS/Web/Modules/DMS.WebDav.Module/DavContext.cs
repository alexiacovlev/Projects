using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Security.Principal;
using System.Web;
 

using ITHit.WebDAV.Server;
using ITHit.WebDAV.Server.Class2;
using ITHit.WebDAV.Server.DeltaV;

namespace DMS.WebDav.Module
{
    /// <summary>
    /// WebDAV request context. Is used by WebDAV engine to resolve path into items.
    /// Implements abstract methods from <see cref="DavContextBaseAsync"/>,
    /// contains useful methods for working with transactions, connections, reading
    /// varios items from database.
    /// </summary>
    public class DavContext : DavContextBase, IDisposable
    {
        /// <summary>
        /// Database connection string.
        /// </summary>
        private static readonly string connectionString = 
            ConfigurationManager.ConnectionStrings["LocalSqlServer"].ConnectionString;

        /// <summary>
        /// Id of root folder.
        /// </summary>
        private readonly Guid rootId = new Guid("00000000-0000-0000-0000-000000000001");
        
        /// <summary>
        /// Currently authenticated user.
        /// </summary>
        private readonly IPrincipal user;

        /// <summary>
        /// Cached connection for the request.
        /// </summary>
        private SqlConnection connection;

        /// <summary>
        /// Transaction for the request.
        /// </summary>
        private SqlTransaction transaction;

        /// <summary>
        /// Initializes a new instance of the <see cref="DavContext"/> class from <see cref="HttpContext"/>.
        /// </summary>
        /// <param name="context">Instance of <see cref="HttpContext"/>.</param>
        public DavContext(HttpContext context) : base(context)
        {
            this.user = context.User;
        }

        /// <summary>
        /// Gets currently logged in user. <c>null</c> if request is anonymous.
        /// </summary>
        public IPrincipal User
        {
            get { return user; }
        }

        /// <summary>
        /// Resolves path to instance of <see cref="IHierarchyItemAsync"/>.
        /// This method is called by WebDAV engine to resolve paths it encounters
        /// in request.
        /// </summary>
        /// <param name="path">Relative path to the item including query string.</param>
        /// <returns><see cref="IHierarchyItemAsync"/> instance if item is found, <c>null</c> otherwise.</returns>
        public override IHierarchyItem GetHierarchyItem(string path)
        {
            path = path.Trim(new[] { ' ', '/' });

            if (path.Contains("?version="))
            {
                return readVersion(path);
            }

            if (path.Contains("?history"))
            {
                return readVersionHistory(path);
            }

            //remove query string.
            int ind = path.IndexOf('?');
            if (ind > -1)
            {
                path = path.Remove(ind);
            }

            if (path == "")
            {
                // get root folder
                return getRootFolder();
            }

            // find root
            return getItemByPath(path);
        }

        /// <summary>
        /// The method is called by WebDAV engine right before starting sending response to client.
        /// It is good point to either commit or rollback a transaction depending on whether
        /// and exception occurred.
        /// </summary>
        public override void BeforeResponse()
        {
            //analyze Exception property to see if there was an exception during request execution.
            //The property is set by engine.
            if (Exception != null)
            {
                //rollback the transaction if something went wrong.
                RollBackTransaction();
            }
            else
            {
                //commit the transaction if everything is ok.
                CommitTransaction();
            }
        }

        /// <summary>
        /// We implement <see cref="IDisposable"/> to have connection closed.
        /// </summary>
        public void Dispose()
        {
            CloseConnection();
        }

        /// <summary>
        /// Commits active transaction.
        /// </summary>
        public void CommitTransaction()
        {
            if (transaction != null)
            {
                transaction.Commit();
            }
        }

        /// <summary>
        /// Rollbacks active transaction.
        /// </summary>
        public void RollBackTransaction()
        {
            if (transaction != null)
            {
                transaction.Rollback();
            }
        }

        /// <summary>
        /// Closes connection.
        /// </summary>
        public void CloseConnection()
        {
            if (connection != null && connection.State != ConnectionState.Closed)
            {
                connection.Close();
            }
        }

        
        /// <summary>
        /// Reads <see cref="DavFile"/> or <see cref="DavFolder"/> depending on type 
        /// <typeparamref name="T"/> from database.
        /// </summary>
        /// <typeparam name="T">Type of hierarchy item to read(file or folder).</typeparam>
        /// <param name="parentPath">Path to parent hierarchy item.</param>
        /// <param name="command">SQL expression which returns hierachy item records.</param>
        /// <param name="prms">Sequence: sql parameter1 name, sql parameter1 value, sql parameter2 name,
        /// sql parameter2 value...</param>
        /// <returns>List of requested items.</returns>
        public IList<T> ExecuteItem<T>(string parentPath, string command, params object[] prms) 
            where T : class, IHierarchyItem
        {
            IList<T> children = new List<T>();
            using (SqlDataReader reader = prepareCommand(command, prms).ExecuteReader())
            {
                while (reader.Read())
                {
                    Guid itemId = (Guid)reader["ID"];
                    Guid parentId = (Guid)reader["ParentID"];
                    ItemType itemType = (ItemType)reader.GetInt32(reader.GetOrdinal("ItemType"));
                    string name = reader.GetString(reader.GetOrdinal("Name"));
                    DateTime created = reader.GetDateTime(reader.GetOrdinal("CreatedOn"));
                    DateTime modified = reader.GetDateTime(reader.GetOrdinal("ModifiedOn"));
                    FileAttributes fileAttributes = (FileAttributes)reader.GetInt32(
                        reader.GetOrdinal("Attributes"));
                    switch (itemType)
                    {
                        case ItemType.File:
                            children.Add(new DavFile(
                                this,
                                itemId,
                                parentId,
                                name,
                                parentPath + EncodeUtil.EncodeUrlPart(name),
                                created,
                                modified,fileAttributes) as T);
                            break;
                        case ItemType.Folder:
                            children.Add(new DavFolder(
                                this,
                                itemId,
                                parentId,
                                name,
                                (parentPath + EncodeUtil.EncodeUrlPart(name) + "/").TrimStart('/'),
                                created,
                                modified,fileAttributes) as T);
                            break;
                    }
                }
            }

            return children;
        }
        /// <summary>
        /// Reads list of item's <see cref="Version"/> items from database.
        /// </summary>
        /// <param name="itemPath">Path of item which versions shall be read.</param>
        /// <param name="command">SQL expressions which queries version items.</param>
        /// <param name="prms">Sequence: sql parameter1 name, sql parameter1 value, sql parameter2 name,
        ///  sql parameter2 value...</param>
        /// <returns>List of items returned by executing <paramref name="command"/>.</returns>
        public IList<IVersion> ExecuteVersion(string itemPath, string command, params object[] prms)
        {
            IList<IVersion> versions = new List<IVersion>();
            using (SqlDataReader reader = prepareCommand(command, prms).ExecuteReader())
            {
                while (reader.Read())
                {
                    Guid newVersionId = reader.GetGuid(reader.GetOrdinal("VersionId"));
                    Guid itemId = reader.GetGuid(reader.GetOrdinal("ItemId"));
                    int versionNumber = reader.GetInt32(reader.GetOrdinal("VersionNumber"));
                    string name = reader.GetString(reader.GetOrdinal("Name"));
                    string serialNumber = reader.GetInt32(reader.GetOrdinal("SerialNumber")).ToString();
                    DateTime created = reader.GetDateTime(reader.GetOrdinal("CreatedOn"));

                    string versionPath = itemPath + "?version=" + versionNumber;

                    var version = 
                        new Version(this, newVersionId, itemId, versionNumber, name, versionPath, created, serialNumber);
                    versions.Add(version);
                }
            }

            return versions;
        }

        /// <summary>
        /// Reads <see cref="PropertyValue"/> from database by executing SQL command.
        /// </summary>
        /// <param name="command">Command text.</param>
        /// <param name="prms">SQL parameter pairs: SQL parameter name, SQL parameter value</param>
        /// <returns>List of <see cref="PropertyValue"/>.</returns>
        public IList<PropertyValue> ExecutePropertyValue(string command, params object[] prms)
        {
            List<PropertyValue> l = new List<PropertyValue>();
            using (SqlDataReader reader = prepareCommand(command, prms).ExecuteReader())
            {
                while (reader.Read())
                {
                    string name = reader.GetString(reader.GetOrdinal("Name"));
                    string ns = reader.GetString(reader.GetOrdinal("Namespace"));
                    string value = reader.GetString(reader.GetOrdinal("PropVal"));
                    l.Add(new PropertyValue(new PropertyName(name, ns), value));
                }
            }

            return l;
        }

        /// <summary>
        /// Executes SQL command which returns scalar result.
        /// </summary>
        /// <param name="command">Command text.</param>
        /// <param name="prms">SQL parameter pairs: SQL parameter name, SQL parameter value.</param>
        /// <typeparam name="T">Type of object SQL command returns.</typeparam>
        /// <returns>Command result of type <typeparamref name="T"/>.</returns>
        public T ExecuteScalar<T>(string command, params object[] prms)
        {
            object o = prepareCommand(command, prms).ExecuteScalar();
            return o is DBNull ? default(T) : (T)o;
        }

        /// <summary>
        /// Executes SQL command which returns no results.
        /// </summary>
        /// <param name="command">Command text.</param>
        /// <param name="prms">SQL parameter pairs: SQL parameter name, SQL parameter value.</param>
        public void ExecuteNonQuery(string command, params object[] prms)
        {
            prepareCommand(command, prms).ExecuteNonQuery();
        }

        /// <summary>
        /// Executes SQL command which returns no results.
        /// </summary>
        /// <param name="command">Command text.</param>
        /// <param name="prms">Command parameters as <see cref="SqlParameter"/> instances.</param>
        public void ExecuteNonQuery(string command, params SqlParameter[] prms)
        {
            SqlCommand cmd = createNewCommand();
            cmd.CommandText = command;
            cmd.Parameters.AddRange(prms);
            cmd.ExecuteNonQuery();
        }

        /// <summary>
        /// Executes specified command and returns <see cref="SqlDataReader"/>.
        /// </summary>
        /// <param name="commandBehavior">Value of <see cref="CommandBehavior"/> enumeration.</param>
        /// <param name="command">Command text.</param>
        /// <param name="prms">Parameter pairs: SQL param name, SQL param value</param>
        /// <returns>Instance of <see cref="SqlDataReader"/>.</returns>
        public SqlDataReader ExecuteReader(CommandBehavior commandBehavior, string command, params object[] prms)
        {
            return prepareCommand(command, prms).ExecuteReader(commandBehavior);
        }

        /// <summary>
        /// Returns list of <see cref="LockInfo"/> from database by executing specified command
        /// with specified parameters.
        /// </summary>
        /// <param name="command">Command text.</param>
        /// <param name="prms">Pairs of parameter name, parameter value.</param>
        /// <returns>List of <see cref="LockInfo"/>.</returns>
        public List<LockInfo> ExecuteLockInfo(string command, params object[] prms)
        {
            List<LockInfo> l = new List<LockInfo>();
            using (SqlDataReader reader = prepareCommand(command, prms).ExecuteReader())
            {
                while (reader.Read())
                {
                    LockInfo li = new LockInfo();
                    li.Token = reader.GetString(reader.GetOrdinal("Token"));
                    li.Level = reader.GetBoolean(reader.GetOrdinal("Shared")) ? LockLevel.Shared : LockLevel.Exclusive;
                    li.IsDeep = reader.GetBoolean(reader.GetOrdinal("Deep"));
                    
                    DateTime expires = reader.GetDateTime(reader.GetOrdinal("Expires"));
                    if (expires <= DateTime.UtcNow)
                    {
                        li.TimeOut = TimeSpan.Zero;
                    }
                    else
                    {
                        li.TimeOut = expires - DateTime.UtcNow;
                    }

                    li.Owner = reader.GetString(reader.GetOrdinal("Owner"));

                    l.Add(li);
                }
            }

            return l;
        }

        /// <summary>
        /// Reads item from database by path.
        /// </summary>
        /// <param name="path">Item path.</param>
        /// <returns>Instance of <see cref="IHierarchyItemAsync"/>.</returns>
        private IHierarchyItem getItemByPath(string path)
        {
            Guid id = rootId;

            string[] names = path.Split('/');
            int last = names.Length - 1;
            while (last > 0 && names[last] == string.Empty)
            {
                last--;
            }

            for (int i = 0; i < last; i++)
            {
                if (!string.IsNullOrEmpty(names[i]))
                {
                    object result = ExecuteScalar<object>(
                        @"SELECT ID FROM DMS_Documents
                          WHERE Name = @Name AND ParentID = @Parent
                          UNION ALL
                          SELECT ID FROM DMS_Folders
                          WHERE Name = @Name AND ParentID = @Parent",
                        "@Name", EncodeUtil.DecodeUrlPart(names[i]),
                        "@Parent", id);

                    if (result != null)
                    {
                        id = (Guid)result;
                    }
                    else
                    {
                        return null;
                    }
                }
            }

            // get item properties
            string command =
                  @"SELECT ID, ParentID, 2 as ItemType, Name, CreatedOn, ModifiedOn, Attributes       
                     FROM DMS_Documents
                    WHERE Name = @Name AND ParentID = @Parent
                    UNION ALL
                    SELECT ID, ParentID, 3 as ItemType, Name, CreatedOn, ModifiedOn, Attributes       
                     FROM DMS_Folders
                    WHERE Name = @Name AND ParentID = @Parent";
            var davHierarchyItems = ExecuteItem<DavHierarchyItem>(
                string.Join("/", names, 0, last) + "/",
                command,
                "@Name", EncodeUtil.DecodeUrlPart(names[last]),
                "@Parent", id);
            return davHierarchyItems.FirstOrDefault();
        }

        /// <summary>
        /// Reads root folder.
        /// </summary>
        /// <param name="path">Root folder path.</param>
        /// <returns>Instance of <see cref="IHierarchyItemAsync"/>.</returns>
        private IHierarchyItem getRootFolder()
        {
            string command =
               @"SELECT ID, ParentID, 3 as ItemType, Name, CreatedOn, ModifiedOn, Attributes       
                    FROM DMS_Folders
                 WHERE ID = @ID";
            var hierarchyItems = ExecuteItem<IHierarchyItem>(
                "",
                command,
                "@ID", rootId);
            return hierarchyItems.FirstOrDefault();
        }
        /// <summary>
        /// Reads version history from database.
        /// </summary>
        /// <param name="path">Version history path.</param>
        /// <returns>Instance of <see cref="VersionHistory"/>.</returns>
        private VersionHistory readVersionHistory(string path)
        {
            int ind = path.IndexOf('&', path.IndexOf('?'));
            if (ind > 0)
                path = path.Remove(ind);
            string itemPath = path.Remove(path.IndexOf('?'));
            IHierarchyItem item = GetHierarchyItem(itemPath);

            if (item != null)
            {
                Guid newItemId = (item as DavFile).ItemId;

                string command =
                    @"SELECT ItemId, VersionId, VersionNumber, Name, CreatedOn, SerialNumber
                      FROM DMS_DocumentVersions
                      WHERE ItemId = @ItemId";

                IList<IVersion> versions = ExecuteVersion(
                    itemPath,
                    command,
                    "@ItemId", newItemId);

                if (versions.Count > 0)
                {
                    return new VersionHistory(this, newItemId, path);
                }
            }

            return null;
        }

        /// <summary>
        /// Reads version from database.
        /// </summary>
        /// <param name="path">Version path.</param>
        /// <returns>Instance of <see cref="IVersionAsync"/>.</returns>
        private IVersion readVersion(string path)
        {
            int ind = path.IndexOf('&', path.IndexOf('?'));
            if (ind > 0)
                path = path.Remove(ind);
            string versionNum = path.Substring(path.LastIndexOf('=') + 1);
            string itemPath = path.Remove(path.IndexOf('?'));

            DavFile item = (DavFile) GetHierarchyItem(itemPath);
            if (item == null)
            {
                return null;
            }

            string command =
                @"SELECT ItemId, VersionId, VersionNumber, Name, CreatedOn, SerialNumber
                  FROM DMS_DocumentVersions
                  WHERE ItemId = @ItemId AND VersionNumber = @versionNum";

            return ExecuteVersion(
                itemPath,
                command,
                "@ItemId", item.ItemId,
                "@versionNum", versionNum).FirstOrDefault(); 
           
        }

        /// <summary>
        /// Creates <see cref="SqlCommand"/>.
        /// </summary>
        /// <returns>Instance of <see cref="SqlCommand"/>.</returns>
        private SqlCommand createNewCommand()
        {
            if (this.connection == null)
            {
                this.connection = new SqlConnection(connectionString);
                this.connection.Open();
                this.transaction = this.connection.BeginTransaction(IsolationLevel.ReadUncommitted);
            }

            SqlCommand newCmd = connection.CreateCommand();
            newCmd.Transaction = transaction;
            return newCmd;
        }

        /// <summary>
        /// Creates <see cref="SqlCommand"/>.
        /// </summary>
        /// <param name="command">Command text.</param>
        /// <param name="prms">Command parameters in pairs: name, value</param>
        /// <returns>Instace of <see cref="SqlCommand"/>.</returns>
        private SqlCommand prepareCommand(string command, params object[] prms)
        {
            if (prms.Length % 2 != 0)
            {
                throw new ArgumentException("Incorrect number of parameters");
            }

            SqlCommand cmd = createNewCommand();
            cmd.CommandText = command;
            for (int i = 0; i < prms.Length; i += 2)
            {
               if (!(prms[i] is string))
               {
                  throw new ArgumentException(prms[i] + "is invalid parameter name");
               }

               cmd.Parameters.AddWithValue((string)prms[i], prms[i + 1]);
            }

            return cmd;
        }
    }
}
