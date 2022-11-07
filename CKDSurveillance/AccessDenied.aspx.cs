using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CKDSurveillance_RD
{
    public partial class AccessDenied : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = Page.Title = ConfigurationManager.AppSettings["AppName"].ToString() + " Access Denied";

            lnkAdmin.NavigateUrl = "http://www.cdc.gov/cdc-info/requestform.html";

        }

        private void Page_Init(object sender, System.EventArgs e)
        {

            if (Session.Keys.Count == 0)
            {
                //Response.Redirect("~/ApplicationError.aspx?Action=Timeout")
            }
            else
            {
                Page.ViewStateUserKey = HttpContext.Current.Session.SessionID;
            }

        }
    }
}