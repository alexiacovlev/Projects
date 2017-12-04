using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Web;

namespace CIMS.Modules.DAL
{
    /// <summary>
    /// The DataAccessProvider calss- provides methods to access data storage.
    /// </summary>
    public class DataAccessProvider : IDataAccessProvider
    {




        /// <summary>
        ///  Gets an instance of the current DataAccessProvider.
        /// </summary>
        private static DataAccessProvider dataAccessProvider;

        public static DataAccessProvider Current
        {
            get
            {
                if (dataAccessProvider == null)
                {
                    dataAccessProvider = new DataAccessProvider();
                }
                return dataAccessProvider;
            }
        }

        /// <summary>
        /// Represents a set of methods for creating instances of a provider's implementation of the data source classes.
        /// </summary>
        private DbProviderFactory DbProviderFactory;




        /// <summary>
        /// Initializes a new instance of the AX.Kernel.DataAccess.DataAccessProvider class.
        /// </summary>
        public DataAccessProvider()
        {
            DbProviderFactory = DbProviderFactories.GetFactory(AX.Kernel.Settings.DbProviderName);
        }

        /// <summary>
        /// Initializes a new instance of the AX.Kernel.DataAccess.DataAccessProvider class.
        /// </summary>
        /// <param name="DbProviderName">Invariant name of a provider.</param>
        public DataAccessProvider(string DbProviderName)
        {
            DbProviderFactory = DbProviderFactories.GetFactory(DbProviderName);
        }


        #region IDataAccessProvider Members



        /// <summary>
        /// Initializes a new instance of the DataAdapter class.
        /// </summary>
        /// <returns>The IDataAdapter object that use a set of data commands and a database connection to fill the System.Data.DataSet and update database.</returns>
        public IDataAdapter GetDataAdaptor()
        {
            return DbProviderFactory.CreateDataAdapter();
        }

        /// <summary>
        /// Initializes a new instance of the DataAdapter class,
        /// with the specified System.Data.IDbCommand as the DataAdapter.SelectCommand  property.
        /// </summary>
        /// <param name="Command">The System.Data.IDbCommand object.</param>
        /// <returns>The IDataAdapter object that use a set of data commands and a database connection to fill the System.Data.DataSet and update database.</returns>
        public IDataAdapter GetDataAdaptor(IDbCommand Command)
        {
            DbDataAdapter DbDataAdapter = DbProviderFactory.CreateDataAdapter();
            DbDataAdapter.SelectCommand = (DbCommand)Command;
            return DbDataAdapter;
        }

        /// <summary>
        /// Initializes a new instance of the System.Data.Common.DbConnection class.
        /// </summary>
        /// <returns>The initialized IDbConnection object.</returns>
        public IDbConnection GetDbConnection()
        {
            return DbProviderFactory.CreateConnection();
        }

        /// <summary>
        /// Initializes a new instance of the System.Data.Common.DbConnection class, specified by ConnectionString.
        /// </summary>
        /// <param name="ConnectionString">The ConnectionString text.</param>
        /// <returns>The initialized by ConnectionString text IDbConnection object.</returns>
        public IDbConnection GetDbConnection(string ConnectionString)
        {
            DbConnection Connection = DbProviderFactory.CreateConnection();
            Connection.ConnectionString = ConnectionString;
            return Connection;
        }

        /// <summary>
        ///  Initializes a new instance of the System.Data.DbCommand class.
        /// </summary>
        /// <returns>The initialized System.Data.DbCommand object.</returns>
        public IDbCommand GetDbCommand()
        {
            return DbProviderFactory.CreateCommand();
        }

        /// <summary>
        ///  Initializes a new instance of the System.Data.DbCommand class, with the text of the query.
        /// </summary>
        /// <param name="CommandText">The command text.</param>
        /// <returns>The initialized be command text, System.Data.DbCommand object.</returns>
        public IDbCommand GetDbCommand(string CommandText)
        {
            DbCommand Command = DbProviderFactory.CreateCommand();
            Command.CommandText = CommandText;
            return Command;
        }

        /// <summary>
        ///  Initializes a new instance of the System.Data.DbParameter class.
        /// </summary>
        /// <returns>The new instance of the System.Data.DbParameter class.</returns>
        public IDataParameter GetDataParameter()
        {
            return DbProviderFactory.CreateParameter();
        }

        public IDataParameter GetDataOutputParameter(string Name, int size)
        {
            var parameter = DbProviderFactory.CreateParameter();
            parameter.Direction = ParameterDirection.Output;
            parameter.ParameterName = Name;
            parameter.Size = size;
            return parameter;
        }

        public IDataParameter GetDataOutputParameter(string Name)
        {
            var parameter = DbProviderFactory.CreateParameter();
            parameter.Direction = ParameterDirection.Output;
            parameter.ParameterName = Name;

            return parameter;
        }


        /// <summary>
        ///  Initializes a new instance of the System.Data.DbParameter class
        ///  that uses the parameter name and a value of the new System.Data.DbParameter.
        /// </summary>
        /// <param name="Name">The name of the parameter to map.</param>
        /// <param name="Value">An System.Object that is the value of the System.Data.DbParameter.</param>
        /// <returns>The new instance of the System.Data.DbParameter class.</returns>
        public IDataParameter GetDataParameter(string Name, object Value)
        {
            DbParameter Paramenter = DbProviderFactory.CreateParameter();
            Paramenter.ParameterName = Name;
            Paramenter.Value = Value;
            return Paramenter;
        }

        #endregion

    }
}