using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CIMS.Modules.DAL
{
    public class UserManagement : ObjectBase
    {
        private static readonly UserManagement _instance = new UserManagement();
        public static UserManagement Instance
        {
            get
            {
                return _instance;
            }
        }

        public void AssignUserToTeam(string userId, string teamId)
        {
            IDbCommand cmd = base.DataAccessProvider.GetDbCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = @"prc_CIMS_UM_AssignUserToTeam";
            cmd.Parameters.Add(base.DataAccessProvider.GetDataParameter("@userId", userId));
            cmd.Parameters.Add(base.DataAccessProvider.GetDataParameter("@teamId", teamId));
            base.ExecNonQuery(cmd);
        }

        public string GetUserTeam(string userName)
        {
            IDbCommand cmd = base.DataAccessProvider.GetDbCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = @"prc_CIMS_UM_GetUserTeam";
            cmd.Parameters.Add(base.DataAccessProvider.GetDataParameter("@userName", userName));

            var obj = base.ExecScalar(cmd);
            if (obj != null && obj != DBNull.Value)
                return obj.ToString();
            return "";
        }

        public bool IsUserInTheSameTeam(Guid userId, string teamId)
        {
            IDbCommand cmd = base.DataAccessProvider.GetDbCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = @"prc_CIMS_UM_IsUserInTheSameTeam";
            cmd.Parameters.Add(base.DataAccessProvider.GetDataParameter("@userId", userId));
            cmd.Parameters.Add(base.DataAccessProvider.GetDataParameter("@teamId", teamId));
            var obj = base.ExecScalar(cmd);
            if (obj != null && obj != DBNull.Value)
                return ((int)obj) == 1;
            return false;
        }


    }
}