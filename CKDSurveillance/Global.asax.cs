using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using NG.NCCDPHP.NCCDAppUser;
using System.Security.Principal;
using System.Web.Caching;
using ckdlibV2;

namespace CKDSurveillance_RD
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            //if (applicationStartupComplete) return;
            try
            {
                object osm = new System.Web.UI.ScriptManager();
            }
            catch (Exception)
            { }
        }

        protected void Session_Start(object sender, EventArgs e)
        {

#if !INTERNET

           

#endif
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AcquireRequestState(object sender, System.EventArgs e)
        {
            if ((HttpContext.Current.Session != null) && (HttpContext.Current.Cache.Get(ApplicationConstants.USER_INFO_CACHE_KEY + HttpContext.Current.Session.SessionID) != null))
            {
                Context.User = (NCCDPrincipal)HttpContext.Current.Cache.Get(ApplicationConstants.USER_INFO_CACHE_KEY + HttpContext.Current.Session.SessionID);
                return;
                
            }
        }

       

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}