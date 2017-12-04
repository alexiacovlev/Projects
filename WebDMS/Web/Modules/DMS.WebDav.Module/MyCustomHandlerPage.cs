
using System;
using System.Linq;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;


using ITHit.WebDAV.Server;

namespace DMS.WebDav.Module
{
    public class MyCustomHandlerPage : Page
    {
        protected MyCustomHandlerPage()
        {
            this.Load += Page_Load;
        }

        void Page_Load(object sender, EventArgs e)
        {
            GetPageData();
        }
        public void GetPageData()
        {
        }
    }
}