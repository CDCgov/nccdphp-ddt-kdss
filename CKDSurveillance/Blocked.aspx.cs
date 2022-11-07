using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;

namespace CKDSurveillance_RD
{
    public partial class Blocked : System.Web.UI.Page
    {
        private void Page_Init(object sender, System.EventArgs e)
        {

            Page.ViewStateUserKey = HttpContext.Current.Session.SessionID;

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.Title = ConfigurationManager.AppSettings["AppName"].ToString() + " Blocked";
        }


       

    }
}