using System;
using System.Security;
using System.Security.Principal;
using System.Text;
using System.Web;
using System.Web.Security;

namespace DMS.WebDav.Module
{
    /// <summary>
    /// Base class for challenge/response authentication ASP.NET modules, like Digest, Basic.
    /// </summary>
    public abstract class AuthenticationModuleBase : IHttpModule
    {

        public void Init(HttpApplication application)
        {
            application.AuthenticateRequest += App_OnAuthenticateRequest;
            application.EndRequest += App_OnEndRequest;
        }

        public void Dispose()
        {
        }

        
        protected abstract IPrincipal AuthenticateRequest(HttpRequest request);
        
        protected abstract string GetChallenge();

        protected abstract bool IsAuthorizationPresent(HttpRequest request);
        
        private void App_OnAuthenticateRequest(object source, EventArgs eventArgs)
        {
            if (IsAuthorizationPresent(HttpContext.Current.Request))
            {
                IPrincipal principal = AuthenticateRequest(HttpContext.Current.Request);
                if (principal != null)
                { // authenticated succesfully
                    HttpContext.Current.User = principal;
                }
                else
                { // invalid credentials
                    unauthorized();
                }
            }
        }
        
        private void App_OnEndRequest(object source, EventArgs eventArgs)
        {
            if (HttpContext.Current.Response.StatusCode == 302 &&
                isLoginUrl(HttpContext.Current.Response.RedirectLocation) &&
                isNonBrowserRequest())
            {
                rewriteUnauthorizedResponse(HttpContext.Current);
            }

            HttpApplication app = (HttpApplication)source;
            if (app.Response.StatusCode == 401)
            { // show login dialog
                app.Response.AppendHeader("WWW-Authenticate", GetChallenge());
            }
            else if ((app.Response.StatusCode == 302) && isWebDavRequest(app.Request))
            { 
                // WebDAV request is sent while ASP.NET Forms authentication is used. XHR 
                // request can not display the  log-in page or capture the 302 code. 
                // In this case, instead of 302 Found we send 278 response code, 
                // so XHR can process it and redirect to log-in page.
                app.Response.StatusCode = 278; // 278 is an unused status code, it sometimes used instead of 302 for XHR support

                // also change the return Url to Referer, as it points to the 
                // page on which XHR resides, while original Url points to some WebDAV url
                app.Response.RedirectLocation = FormsAuthentication.LoginUrl + "?ReturnUrl=" + app.Server.UrlEncode(app.Request.UrlReferrer.ToString());

                // allow CORS
                addCrossDomainHeaders(HttpContext.Current);
            }
        }

        private static void unauthorized()
        {
            HttpResponse response = HttpContext.Current.Response;
            response.StatusCode = 401;
            response.StatusDescription = "Unauthorized";
            response.Write("401 Unauthorized");
        }
        private static bool isLoginUrl(string url)
        {

            var loginUrl = FormsAuthentication.LoginUrl;
            if (string.IsNullOrEmpty(loginUrl) || string.IsNullOrEmpty(url))
            {
                return false;
            }

            int index = loginUrl.IndexOf('?');
            if (index >= 0)
            {
                loginUrl = loginUrl.Substring(0, index);
            }

            index = url.IndexOf('?');
            if (index >= 0)
            {
                url = url.Substring(0, index);
            }

            if (loginUrl.Equals(url, StringComparison.InvariantCultureIgnoreCase))
            {
                return true;
            }

            return false;
        }

        /// <summary>
        /// Analyzes User-Agent header.
        /// </summary>
        /// <remarks>
        /// If the request is sent by a web browser, the User-Agent header starts 
        /// with 'Mozilla'. Depending on the presence of this string we will use 
        /// Challenge-response authentication or Forms authentication.
        /// </remarks>
        private static bool isNonBrowserRequest()
        {
            string userAgent = HttpContext.Current.Request.UserAgent;
            return userAgent == null || userAgent.IndexOf("Mozilla", StringComparison.InvariantCultureIgnoreCase) < 0;
        }

        private static void rewriteUnauthorizedResponse(HttpContext context)
        {
            if (context == null)
            {
                throw new ArgumentNullException("context");
            }

            HttpResponse response = context.Response;

            response.StatusCode = 401;
            response.StatusDescription = "Unauthorized";

            // Null out the Location header from the 302 response so that it
            // doesn't get transmitted to the client unnecessarily.

            response.RedirectLocation = null;

            // Change the response entity to reflect the right message. If we
            // don't clear out the response and re-write it here, then the user
            // might get the wrong message---that is, she might see an HTML page
            // stating that the resource has been moved (which would have been
            // right for 302) when what we want to indicate is an attempt to
            // access an unauthorized resource.

            response.Clear();
            response.ContentType = "text/html";
            writeUnauthorizedResponseHtml(context);
        }

        private static void writeUnauthorizedResponseHtml(HttpContext context)
        {
            // Let's try to get the ASP.NET runtime to give us the HTML for a
            // security exception. If we can't get this, then we'll write out
            // our own default message. A derived implementation may want to
            // also want to involve custom error messages for production 
            // scenarios, which is not done here.

            HttpException error = new HttpException(401, null, new SecurityException());
            string html = error.GetHtmlErrorMessage() ?? string.Empty;

            if (html.Length == 0)
            {
                html = defaultUnauthorizedResponseHtml;
            }

            context.Response.Write(html);
        }

        private static string defaultUnauthorizedResponseHtml
        {
            get
            {
                return @"
<html>
    <head>
        <title>401 Authorization Required</title>
    </head>
    <body>
        <h1>Authorization Required</h1>
        <p>This server could not verify that you are authorized to access the document
            requested.  Either you supplied the wrong credentials (e.g., bad password), or your
            browser doesn't understand how to supply the credentials required.</p>
    </body>
</html>";
            }
        }

        /// <summary>
        /// This method is used to distinguish requests sent by XmlHttpRequest 
        /// and by web browser UI, to avoid log-in page redirect for XmlHttpRequest
        /// </summary>
        private static bool isWebDavRequest(HttpRequest request)
        {
            return !(request.HttpMethod == "GET" || request.HttpMethod == "HEAD" || request.HttpMethod == "POST");
        }

        private void addCrossDomainHeaders(HttpContext context)
        {
            string origin = context.Request.Headers["Origin"];
            context.Response.AddHeader("Access-Control-Allow-Origin", String.IsNullOrEmpty(origin) ? "*" : origin.TrimEnd('/'));
            context.Response.AddHeader("Access-Control-Allow-Credentials", "true");
            context.Response.AddHeader("Access-Control-Expose-Headers", "Location");
            context.Response.AddHeader("Access-Control-Max-Age", int.MaxValue.ToString());
        }
    }

}
