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
                case "February_2024":
                    bcSelListItem.InnerText = "> Quality of Care";
                    break;
                case "April_2023":
                case "June_2024":
                    bcSelListItem.InnerText = "> Awareness";
                    break;
                case "December_2023":
                case "October_2022":
                case "August_2024":
                    bcSelListItem.InnerText = "> Risk Factors";
                    break;
                case "August_2023":
                    bcSelListItem.InnerText = "> Prevalence & Incidence";
                    break;
                case "June_2023":
                case "October_2023":
                case "April_2024":
                    bcSelListItem.InnerText = "> Social Determinants";
                    break;
            }

        }
    }
}