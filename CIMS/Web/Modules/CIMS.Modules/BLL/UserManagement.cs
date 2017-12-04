using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;

namespace CIMS.Modules.BLL
{
    public class UserManagement
    {

        public static string GetCurrentUserTeam()
        {

            if (HttpContext.Current.User.IsInRole("CollegeAdmin")|| HttpContext.Current.User.IsInRole("Administrators"))
                return DAL.UserManagement.Instance.GetUserTeam(HttpContext.Current.User.Identity.Name);

            throw new Exception("For user is not in 'CollegeAdmin' cannot create users;");
        }

        public static bool IsUserInTheSameTeam(string teamid)
        {
            return DAL.UserManagement.Instance.IsUserInTheSameTeam(AX.Kernel.User.Current.ID, teamid);
        }

        public static void VerifyAccess(string teamid)
        {
            if (String.IsNullOrEmpty(teamid))
                throw new Exception("TeamId cannot be null");
            if (AX.Kernel.User.IsAdminUser || BLL.UserManagement.IsUserInTheSameTeam(teamid))
            {

            }
            else
            {
                throw new Exception("Access Denied!!!");
            }
        }

        public static void AssignUserToTeam(string userName, string teamId)
        {
            var user = Membership.GetUser(userName, false);

            if (user != null && !String.IsNullOrEmpty(teamId))
            {
                DAL.UserManagement.Instance.AssignUserToTeam(user.ProviderUserKey.ToString(), teamId);
            }
        }



    }
}