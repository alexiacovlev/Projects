using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CIMS.Modules.DAL
{
    // IAccessDataProvider interface that provides methods to access data storage.
    /// </summary>
    public interface IDataAccessProvider
    {


        /// <summary>
        /// Initializes a new instance of the DataAdapter class.
        /// </summary>
        /// <returns>The IDataAdapter object that use a set of data commands and a database connection to fill the System.Data.DataSet and update database.</returns>
        IDataAdapter GetDataAdaptor();


        /// <summary>
        /// Initializes a new instance of the DataAdapter class,
        /// with the specified System.Data.IDbCommand as the DataAdapter.SelectCommand  property.
        /// </summary>
        /// <param name="Command">The System.Data.IDbCommand object.</param>
        /// <returns>The IDataAdapter object that use a set of data commands and a database connection to fill the System.Data.DataSet and update database.</returns>
        IDataAdapter GetDataAdaptor(IDbCommand Command);

        /// <summary>
        /// Initializes a new instance of the System.Data.Common.DbConnection class.
        /// </summary>
        /// <returns>The initialized IDbConnection object.</returns>
        IDbConnection GetDbConnection();

        /// <summary>
        /// Initializes a new instance of the System.Data.Common.DbConnection class, specified by ConnectionString.
        /// </summary>
        /// <param name="ConnectionString">The ConnectionString text.</param>
        /// <returns>The initialized by ConnectionString text IDbConnection object.</returns>
        IDbConnection GetDbConnection(string ConnectionString);

        /// <summary>
        ///  Initializes a new instance of the System.Data.DbCommand class.
        /// </summary>
        /// <returns>The initialized System.Data.DbCommand object.</returns>
        IDbCommand GetDbCommand();

        /// <summary>
        ///  Initializes a new instance of the System.Data.DbCommand class, with the text of the query.
        /// </summary>
        /// <param name="CommandText">The command text.</param>
        /// <returns>The initialized be command text, System.Data.DbCommand object.</returns>
        IDbCommand GetDbCommand(string CommandText);

        /// <summary>
        ///  Initializes a new instance of the System.Data.DbParameter class.
        /// </summary>
        /// <returns>The new instance of the System.Data.DbParameter class.</returns>
        IDataParameter GetDataParameter();

        /// <summary>
        ///  Initializes a new instance of the System.Data.DbParameter class
        ///  that uses the parameter name and a value of the new System.Data.DbParameter.
        /// </summary>
        /// <param name="Name">The name of the parameter to map.</param>
        /// <param name="Value">An System.Object that is the value of the System.Data.DbParameter.</param>
        /// <returns>The new instance of the System.Data.DbParameter class.</returns>
        IDataParameter GetDataParameter(string Name, object Value);

    }
}