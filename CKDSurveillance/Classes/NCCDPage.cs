using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CKDSurveillance_RD.Classes
{
    public class NCCDPage : System.Web.UI.Page
    {
        private string strContentArea = string.Empty;
        private string strAccessLevel = string.Empty;
        private bool blnEditAccess = true;

        public NCCDPage()
        {
            this.Init += new EventHandler(this.Page_Init);
            this.Load += new EventHandler(this.Page_Load);
        }

        public string PageContentArea
        {
            get
            {
                return strContentArea;
            }
            set
            {
                strContentArea = value;
            }
        }


        public bool HasEditAccess
        {
            get
            {
                return blnEditAccess;
            }
        }

        public string AccessLevel
        {
            get
            {
                return strAccessLevel;
            }
        }

      

        private void Page_Load(object sender, System.EventArgs e)
        {

#if !INTERNET

            //if (!Request.IsAuthenticated) {  
            //    Response.Redirect("~/AccessDenied.aspx"); 
            //} 
            //else if ( ((HttpContext.Current.Cache[ApplicationConstants.USER_INFO_CACHE_KEY + Session.SessionID] == null))) {  
            //    Response.Redirect("~/AccessDenied.aspx"); 
            //} 
            //else {  
            //    GetAccessPermission();  
            //}
#endif

            //if (HttpContext.Current.Session.IsNewSession)
            //{
            //    Response.Redirect("~/SessionTimeout.aspx");
            //}
            //string SessionTimeOutPage = "http://" + Request.ServerVariables["HTTP_HOST"] +
            //      Request.ServerVariables["URL"].Substring(0, Request.ServerVariables["URL"].LastIndexOf("/")) +
            //      "/SessionTimeout.aspx";


            ////";url=" + SessionTimeOutPage;

            //HtmlMeta meta = new HtmlMeta();
            //meta.HttpEquiv = "refresh";
            //meta.Content =  (Session.Timeout * 1).ToString() + ";url=" + SessionTimeOutPage;
            //PlaceHolder MetaPlaceHolder = (PlaceHolder)Page.Master.FindControl("MetaPlaceHolder");
            //MetaPlaceHolder.Controls.Add(meta);

        }

        private void GetAccessPermission()
        {
            //NCCDPrincipal objPrincipal = (NCCDPrincipal)Context.User; 
            ////Performed for all other Modules 

            //switch (objPrincipal.UserInfo.GetAccess(strContentArea))
            //{
            //    case AppUser.AccessLevel.Write:
            //        strAccessLevel = NG.NCCDPHP.NCCDAppUser.ApplicationConstants.MODIFY_ACCESS;
            //        blnEditAccess = true;   
            //        break;
            //    case AppUser.AccessLevel.Read:
            //        strAccessLevel =NG.NCCDPHP.NCCDAppUser.ApplicationConstants.READ_ACCESS;
            //        blnEditAccess = false;   
            //        break;
            //    case AppUser.AccessLevel.NoAccess:   
            //        throw new System.Security.SecurityException(); 
            //}
        }

        private void Page_Init(object sender, System.EventArgs e)
        {

            Page.ViewStateUserKey = HttpContext.Current.Session.SessionID;
            if (Response.Cookies.Count > 0)
            {
                foreach (string s in Response.Cookies.AllKeys)
                {
                    if (s == System.Web.Security.FormsAuthentication.FormsCookieName || s.ToLower() == "asp.net_sessionid")
                    {
                        Response.Cookies[s].Secure = true;
                    }
                }
            }

        }
    }
}