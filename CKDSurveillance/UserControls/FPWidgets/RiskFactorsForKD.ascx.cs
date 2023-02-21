using ckdlibV2;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CKDSurveillance_RD.UserControls.FPWidgets
{
    public partial class RiskFactorsForKD : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //setRiskFactorLink();
        }

        private void setRiskFactorLink()
        {

            string link = "detailpagelink".ToString().Trim();


            //*Build url string*
            StringBuilder sb = new StringBuilder();
            sb.Append("<a href='");
            sb.Append(link);
            sb.Append("' class='float-right'>");
            sb.Append("View Page");
            sb.Append("</a>");


            //*Send to PageURL*
            //litBtnViewPage.Text = sb.ToString().Trim();
        }

    }
}




