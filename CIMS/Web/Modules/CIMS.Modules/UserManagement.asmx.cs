using AX.PortalAdmin.UserManagement;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace CIMS.Modules
{
    /// <summary>
    /// Summary description for UserManagement
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class UserManagement : System.Web.Services.WebService
    {

        [WebMethod(EnableSession = true)]
        public string CreateUser(RegistrationData data, string teamid)
        {

            try
            {
                if (String.IsNullOrEmpty(teamid))
                {
                    teamid = BLL.UserManagement.GetCurrentUserTeam();
                }
                BLL.UserManagement.VerifyAccess(teamid);
                Handler.CreateUserByAdmin(data);
                BLL.UserManagement.AssignUserToTeam(data.UserName, teamid);
            }
            catch (Exception error)
            {
                return error.Message;
            }
            return "";
        }


    }
}
