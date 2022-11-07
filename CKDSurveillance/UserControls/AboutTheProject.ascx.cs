using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ckdlibV2;

namespace CKDSurveillance_RD.UserControls
{
    public partial class AboutTheProject : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string urlParam = Request.Params["section"];
            
            if ((urlParam.ToUpper() != "H"))
            {
                return;
            }          
        }       
    }
}