using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ckdlibV2;

namespace CKDSurveillance_RD.UserControls
{
    public partial class FAQGlossaryControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string url = HttpContext.Current.Request.Url.AbsoluteUri;

            if (url.ToLower().IndexOf("topichome") > 0)
            {
                lnkAboutProject.Attributes.Add("onclick", "return popupWindow('../help.aspx?section=H', " + ApplicationConstants.SECONDARY_WINDOW_WIDTH + ", " + ApplicationConstants.SECONDARY_WINDOW_HEIGHT + ");");
                lnkFaq.Attributes.Add("onclick", "return popupWindow('../help.aspx?section=F', " + ApplicationConstants.SECONDARY_WINDOW_WIDTH + ", " + ApplicationConstants.SECONDARY_WINDOW_HEIGHT + ");");
                lnkGlossary.Attributes.Add("onclick", "return popupWindow('../help.aspx?section=G', " + ApplicationConstants.SECONDARY_WINDOW_WIDTH + ", " + ApplicationConstants.SECONDARY_WINDOW_HEIGHT + ");");
                lnkDS.Attributes.Add("onclick", "return popupWindow('../help.aspx?section=D', " + ApplicationConstants.SECONDARY_WINDOW_WIDTH + ", " + ApplicationConstants.SECONDARY_WINDOW_HEIGHT + ");");
                //lnkBib.Attributes.Add("onclick", "return popupWindow('../help.aspx?section=B', " + ApplicationConstants.SECONDARY_WINDOW_WIDTH + ", " + ApplicationConstants.SECONDARY_WINDOW_HEIGHT + ");");
            }
            else
            {
                lnkAboutProject.Attributes.Add("onclick", "return popupWindow('./Help.aspx?section=H', " + ApplicationConstants.SECONDARY_WINDOW_WIDTH + ", " + ApplicationConstants.SECONDARY_WINDOW_HEIGHT + ");");
                lnkFaq.Attributes.Add("onclick", "return popupWindow('help.aspx?section=F', " + ApplicationConstants.SECONDARY_WINDOW_WIDTH + ", " + ApplicationConstants.SECONDARY_WINDOW_HEIGHT + ");");
                lnkGlossary.Attributes.Add("onclick", "return popupWindow('help.aspx?section=G', " + ApplicationConstants.SECONDARY_WINDOW_WIDTH + ", " + ApplicationConstants.SECONDARY_WINDOW_HEIGHT + ");");
                lnkDS.Attributes.Add("onclick", "return popupWindow('help.aspx?section=D', " + ApplicationConstants.SECONDARY_WINDOW_WIDTH + ", " + ApplicationConstants.SECONDARY_WINDOW_HEIGHT + ");");
                //lnkBib.Attributes.Add("onclick", "return popupWindow('help.aspx?section=B', " + ApplicationConstants.SECONDARY_WINDOW_WIDTH + ", " + ApplicationConstants.SECONDARY_WINDOW_HEIGHT + ");");
            }            
        }
    }
}