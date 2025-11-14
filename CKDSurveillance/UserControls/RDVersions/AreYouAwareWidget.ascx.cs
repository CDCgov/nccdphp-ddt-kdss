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

            string topicText = Request.QueryString["TopicText"];
            bcSelListItem.InnerText = "> " + topicText;
        }
    }
}