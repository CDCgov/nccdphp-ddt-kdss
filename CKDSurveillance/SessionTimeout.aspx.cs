using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CKDSurveillance_RD.Classes;

namespace CKDSurveillance_RD
{
    public partial class SessionTimeout : System.Web.UI.Page
    {

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