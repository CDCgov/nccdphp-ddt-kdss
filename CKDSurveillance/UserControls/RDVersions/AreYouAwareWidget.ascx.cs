using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CKDSurveillance_RD.UserControls.RDVersions
{
     
    public partial class AreYouAwareWidget : System.Web.UI.UserControl
    {
        public Boolean showNavButtons {get;set;}

        protected void Page_Load(object sender, EventArgs e)
        {
            if (showNavButtons)
            {
                //subPageDiv.Visible = false;
                homePageDiv.Visible = true;
            }
            else
            {
                //subPageDiv.Visible = true;
                homePageDiv.Visible = false;
            }

            bcTopic.InnerText = "> Are You Aware Topics ";

            String emailDate = Request.QueryString["emailDate"];
            switch (emailDate)
            { 
                case "April_2023":
                    bcSelListItem.InnerText = "> Awareness";
                    break;
                case "December_2023":
                case "October_2022":
                    bcSelListItem.InnerText = "> Risk Factors";
                    break;
                case "August_2023":
                    bcSelListItem.InnerText = "> Prevalence";
                    break;
                case "June_2023":
                case "October_2023":
                    bcSelListItem.InnerText = "> Social Determinants";
                    break;
            }

        }
    }
}