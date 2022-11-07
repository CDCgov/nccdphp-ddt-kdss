using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;


namespace CKDSurveillance_RD.UserControls
{
    public partial class SuggestedCitationControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        string configCitation = ConfigurationManager.AppSettings["chartboilerplate"].ToString();
        string link = "<a href=\"http://www.cdc.gov/ckd\">http://www.cdc.gov/ckd</a>";
        string citationLine1 = configCitation.Replace("@DT@", DateTime.Now.Year.ToString()).Replace("|", "/").Replace("-", "—").Replace("Web site. http://nccd.cdc.gov/CKD.", "").Trim();
        string citationLine2 = "website. " + link; 
        litCitation.Text = citationLine1 + "<br />" + citationLine2;
        }
    }
}