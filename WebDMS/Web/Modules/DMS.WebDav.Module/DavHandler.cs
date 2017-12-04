using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Web;
using System.Xml;
using System.Xml.Serialization;


using ITHit.WebDAV.Server;

namespace DMS.WebDav.Module
{
    /// <summary>
    /// This handler processes WebDAV requests.
    /// </summary>
    public class DavHandler : IHttpHandler
    {
        /// <summary>
        /// This license file is used to activate:
        ///  - IT Hit WebDAV Server Engine for .NET
        ///  - IT Hit iCalendar and vCard Library if used in a project
        /// </summary>
        private static string license = @"<?xml version=""1.0"" encoding=""utf-8""?><License><Data><Product>IT Hit WebDAV Server .Net</Product><LicensedTo><![CDATA[Alexandr Pascalov]]></LicensedTo><Quantity>1</Quantity><IssueDate><![CDATA[Thursday, April 13, 2017]]></IssueDate><ExpirationDate><![CDATA[Saturday, May 13, 2017]]></ExpirationDate><SupportExpirationDate><![CDATA[]]></SupportExpirationDate><Type>Evaluation</Type><Modules>Class1, Class2</Modules><Id>6014d4c1-2f28-426e-8e18-a86a29e7a981</Id></Data><Signature><![CDATA[Zb6SjfK4MOB+vQOsSblZ1zbkB2Z7X5gjq0j7U+QXABpgbODsHXpcBL/SKEx9AJKUakdIe+t19qBNhaII7TaRkVGwkLUtQ7JIW0G7lSdrSxgS0Jqrxx4C7qhLVsIbrNSLiFmQgjmQhiojCKF23EuBfOID5NfbfKagMh450sxOGpg=]]></Signature></License>";

        /// <summary>
        /// If debug logging is enabled reponses are output as formatted XML,
        /// all requests and response headers and most bodies are logged.
        /// If debug logging is disabled only errors are logged.
        /// </summary>
        private static readonly bool debugLoggingEnabled =
            "true".Equals(
                ConfigurationManager.AppSettings["DebugLoggingEnabled"],
                StringComparison.InvariantCultureIgnoreCase);

        private static readonly bool autoPutUnderVersionControl =
            Convert.ToBoolean(ConfigurationManager.AppSettings["AutoPutUnderVersionControl"]);

        /// <summary>
        /// Gets a value indicating whether another request can use the
        /// <see cref="T:System.Web.IHttpHandler"/> instance.
        /// </summary>
        /// <returns>
        /// true if the <see cref="T:System.Web.IHttpHandler"/> instance is reusable; otherwise, false.
        /// </returns>
        public bool IsReusable
        {
            get { return true; }
        }
      

        /// <summary>
        /// Enables processing of HTTP Web requests.
        /// </summary>
        /// <param name="context">An <see cref="T:System.Web.HttpContext"/> object that provides references to the
        /// intrinsic server objects (for example, Request, Response, Session, and Server) used to service
        /// HTTP requests. 
        /// </param>
        public void ProcessRequest(HttpContext context)
        {
            DavEngine engine = getOrInitializeEngine(context);

            context.Response.BufferOutput = false;

            using (var sqlDavContext = new DavContext(context))
            {
                engine.Run(sqlDavContext);
            }
        }

        /// <summary>
        /// Initializes engine.
        /// </summary>
        /// <param name="context">Instance of <see cref="HttpContext"/>.</param>
        /// <returns>Initialized <see cref="DavEngine"/>.</returns>
        private DavEngine initializeEngine(HttpContext context)
        {

            ILogger logger = Logger.Instance;
            var engine = new DavEngine
            {
                Logger = logger

                // Use idented responses if debug logging is enabled.
                , OutputXmlFormatting = debugLoggingEnabled ? Formatting.Indented : Formatting.None

                , AutoPutUnderVersionControl = autoPutUnderVersionControl
            };

            engine.License = license;

            // Set custom handler to process GET and HEAD requests to folders and display 
            // info about how to connect to server. We are using the same custom handler 
            // class (but different instances) here to process both GET and HEAD because 
            // these requests are very similar. Some WebDAV clients may fail to connect if HEAD 
            // request is not processed.
            var handlerGet  = new MyCustomGetHandler();
            var handlerHead = new MyCustomGetHandler();
            handlerGet.OriginalHandler  = engine.RegisterMethodHandler("GET",  handlerGet);
            handlerHead.OriginalHandler = engine.RegisterMethodHandler("HEAD", handlerHead);

            return engine;
        }

        /// <summary>
        /// Initializes or gets engine singleton.
        /// </summary>
        /// <param name="context">Instance of <see cref="HttpContext"/>.</param>
        /// <returns>Instance of <see cref="DavEngineAsync"/>.</returns>
        private DavEngine getOrInitializeEngine(HttpContext context)
        {
            //we don't use any double check lock pattern here because nothing wrong
            //is going to happen if we created occasionally several engines.
            const string ENGINE_KEY = "$DavEngine$";
            if (context.Application[ENGINE_KEY] == null)
            {
                context.Application[ENGINE_KEY] = initializeEngine(context);
            }

            return (DavEngine)context.Application[ENGINE_KEY];
        }
    }
}
