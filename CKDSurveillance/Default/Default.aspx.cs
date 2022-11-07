using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;


namespace CKDSurveillance_RD.ErrorDefault
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            Response.Redirect("~/Error.aspx");
        
        }

       
    }
}