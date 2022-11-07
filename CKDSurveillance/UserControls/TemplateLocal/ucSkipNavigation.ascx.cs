using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CKDSurveillance_RD.UserControls.TemplateLocal
{
    public partial class ucSkipNavigation : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void addskipLink(String text, string id)
        {
            string link = "<a href='{0}' class='skippy' tabindex=0> {1}</a>";
            link = string.Format(link, id, text);
            litskip.Text = litskip.Text + link;
        }
    }
}