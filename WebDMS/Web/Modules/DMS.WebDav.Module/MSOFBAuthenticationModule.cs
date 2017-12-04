using System;
using System.Web;
using System.Web.Security;

namespace DMS.WebDav.Module
{   /// <summary>
    /// ASP.NET module which implements Microsoft Office Forms Based Authentication (MS-OFBA) protocol.
    /// </summary>
    public class MSOFBAuthenticationModule : IHttpModule
    {
        /// <summary>
        /// Initializes a module and prepares it to handle requests.
        /// </summary>
        /// <param name="context">A System.Web.HttpApplication that provides access to the methods, properties, and events common to all application objects within an ASP.NET application</param>
        public void Init(HttpApplication context)
        {
            context.EndRequest += App_OnEndRequest;
        }

        /// <summary>
        /// Disposes of the resources (other than memory) used by the module that implements <see cref="System.Web.IHttpModule"/>.
        /// </summary>
        public void Dispose()
        {
        }

        /// <summary>
        /// Occurs as the last event in the HTTP pipeline chain of execution when ASP.NET responds to a request.
        /// </summary>
        /// <param name="sender">The http application</param>
        /// <param name="e">Event arguments.</param>
        private void App_OnEndRequest(object sender, EventArgs e)
        {

            HttpApplication context = (HttpApplication)sender;

            if ((context.User == null || !context.User.Identity.IsAuthenticated) && IsOFBAAccepted(context.Request))
            {
                string loginUri = ToAbsolute(context.Request, FormsAuthentication.LoginUrl);
                string successUri = ToAbsolute(context.Request, context.Request.RawUrl);
                
                context.Response.StatusCode = 403;
                context.Response.AppendHeader("X-FORMS_BASED_AUTH_REQUIRED", string.Format("{0}?ReturnUrl={1}", loginUri, successUri));
                context.Response.AppendHeader("X-FORMS_BASED_AUTH_RETURN_URL", successUri);
                context.Response.AppendHeader("X-FORMS_BASED_AUTH_DIALOG_SIZE", "800x600");
            }
        }

        /// <summary>
        /// Gets absolute URI from relative.
        /// </summary>
        /// <param name="request">The request.</param>
        /// <param name="relativeUrl">The relative URL.</param>
        private static string ToAbsolute(HttpRequest request, string relativeUrl)
        {
            return string.Format("{0}://{1}{2}{3}", 
                request.Url.Scheme, 
                request.Url.Host, 
                request.Url.Port == 80 ? string.Empty : ":" + request.Url.Port.ToString(), 
                relativeUrl);
        }

        /// <summary>
        /// Analyzes request headers to determine MS-OFBA support.
        /// </summary>
        /// <remarks>
        /// MS-OFBA is supported by Microsoft Office 2007 SP1 and later versions, by 
        /// Adobe Acrobat/Reader ar any application that provides 
        /// X-FORMS_BASED_AUTH_ACCEPTED: t header in OPTIONS request.
        /// </remarks>
        private bool IsOFBAAccepted(HttpRequest request)
        {
            // Adobe Acrobat/Reader submits X-FORMS_BASED_AUTH_ACCEPTED header.
            string ofbaAccepted = request.Headers["X-FORMS_BASED_AUTH_ACCEPTED"];
            if ((ofbaAccepted != null) && ofbaAccepted.Equals("T", StringComparison.InvariantCultureIgnoreCase))
            {
                return true;
            }

            // Microsoft Office does not submit X-FORMS_BASED_AUTH_ACCEPTED header, but it still supports MS-OFBA,
            // Microsoft Office includes "Microsoft Office" string into User-Agent header.
            string userAgent = request.Headers["User-Agent"];
            if ((userAgent != null) && userAgent.Contains("Microsoft Office"))
            {
                return true;
            }

            return false;
        }
    }
}
