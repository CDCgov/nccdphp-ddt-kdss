using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CKDSurveillance_RD.MasterPages
{
    public partial class Blank : System.Web.UI.MasterPage
    {

        protected void Page_Init(object sender, EventArgs e)
        {
            Page.ViewStateUserKey = Session.SessionID;
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}