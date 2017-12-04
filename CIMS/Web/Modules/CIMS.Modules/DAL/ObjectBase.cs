using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CIMS.Modules.DAL
{
    /// <summary>
    /// ObjectBase provides an implmentation of common data access methods, used by each data access class.
    /// </summary>
    public abstract class ObjectBase
    {


        /// <summary>
        /// Physical Order error message
        /// </summary>
        public static readonly String PhysOrderReadMessage = "Could not do a physical-order read";

        /// <summary>
        /// System catalog error message
        /// </summary>
        public static readonly String SystemCatalogMessage = "Cannot read system catalog";

        /// <summary>
        /// Get the Current data access object command string text.
        /// </summary>
        protected string _CommandText;
        public string CommandText
        {
            get
            {
                return _CommandText;
            }
        }

        /// <summary>
        /// Get the current data access object connection string.
        /// </summary>
        public string ConnectionString
        {
            get
            {
                return AX.Kernel.Settings.ConnectionString;
            }
        }

        public DataAccessProvider DataAccessProvider
        {
            get
            {
                return DataAccessProvider.Current;
            }
        }


        /// <summary>
        /// Executes an DataAccess statement against the Connection object of a .NET Framework data provider, and returns the number of rows affected.
        /// </summary>
        /// <param name="DbCommand">The System.Data.IDbCommand object.</param>
        public void ExecNonQuery(IDbCommand DbCommand)
        {
            using (IDbConnection conn = DataAccessProvider.Current.GetDbConnection(this.ConnectionString))
            {
                DbCommand.Connection = conn;
                conn.Open();
                DbCommand.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// Adds or refreshes rows in the System.Data.DataSet to match those in the data
        /// source using the System.Data.DataSet name, and creates a System.Data.DataTable
        /// named "Table".
        /// </summary>
        /// <param name="DbCommand">The System.Data.IDbCommand object.</param>
        /// <param name="DataSet">The System.Data.DataSet object to wich data is read.</param>
        public void ExecDataSet(IDbCommand DbCommand, DataSet DataSet)
        {
            IDataAdapter da = DataAccessProvider.Current.GetDataAdaptor(DbCommand);

            using (IDbConnection conn = DataAccessProvider.Current.GetDbConnection(this.ConnectionString))
            {
                DbCommand.Connection = conn;
                da.Fill(DataSet);
            }
        }

        /// <summary>
        ///  Adds or refreshes rows in the System.Data.DataSet to match those in the data
        /// source using the System.Data.DataSet name, and creates a System.Data.DataTable
        /// named "Table".
        /// </summary>
        /// <param name="DbCommand">The System.Data.IDbCommand object.</param>
        /// <returns>The System.Data.DataSet object to wich data was readen.</returns>
        public DataSet ExecDataSet(IDbCommand DbCommand)
        {
            DataSet ds = new DataSet();
            using (IDbConnection conn = DataAccessProvider.Current.GetDbConnection(this.ConnectionString))
            {
                IDataAdapter da = DataAccessProvider.Current.GetDataAdaptor(DbCommand);
                DbCommand.Connection = conn;
                da.Fill(ds);
            }
            return ds;
        }

        /// <summary>
        ///  Executes the query, and returns the first column of the first row in the
        ///     resultset returned by the query. Extra columns or rows are ignored.
        /// </summary>
        /// <param name="DbCommand">The System.Data.IDbCommand object.</param>
        /// <returns>The first column of the first row in the resultset.</returns>
        public object ExecScalar(IDbCommand DbCommand)
        {
            object retValue = null;

            using (IDbConnection conn = DataAccessProvider.Current.GetDbConnection(this.ConnectionString))
            {
                DbCommand.Connection = conn;
                conn.Open();
                retValue = DbCommand.ExecuteScalar();
            }
            return retValue;
        }

        /// <summary>
        /// Executes the System.Data.IDbCommand.CommandText against the System.Data.IDbCommand.Connection
        ///     and builds an System.Data.IDataReader.
        /// </summary>
        /// <param name="DbCommand">The System.Data.IDbCommand object.</param>
        /// <returns>A System.Data.IDataReader object.</returns>
        public IDataReader ExecuteReader(IDbCommand DbCommand)
        {
            IDbConnection conn = DataAccessProvider.Current.GetDbConnection(this.ConnectionString);
            DbCommand.Connection = conn;
            conn.Open();
            return DbCommand.ExecuteReader(CommandBehavior.CloseConnection);
        }

        /// <summary>
        /// returns value from reader if exists otherwise default value for this type
        /// </summary>
        /// <typeparam name="T">returned type</typeparam>
        /// <param name="reader">an instance of DbDataReader</param>
        /// <param name="fieldName">the field name</param>
        /// <param name="defaultValue">default value if result value is DBNull.Value</param>
        /// <returns>value from reader if exists otherwise default value for this type</returns>
        protected T GetValue<T>(IDataReader reader, string fieldName, T defaultValue)
        {
            object o = reader[fieldName];
            return (o == DBNull.Value) ? defaultValue : (T)o;
        }


        /// <summary>
        /// returns value from reader if exists otherwise default value for this type
        /// </summary>
        /// <typeparam name="T">returned type</typeparam>
        /// <param name="reader">an instance of DbDataReader</param>
        /// <param name="fieldName">the field name</param>
        /// <returns>value from reader if exists otherwise default value for this type</returns>
        protected T GetValue<T>(IDataReader reader, string fieldName)
        {
            object o = reader[fieldName];
            return (o == DBNull.Value) ? default(T) : (T)o;
        }






    }
}