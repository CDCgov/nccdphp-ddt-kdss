using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;


namespace CKDSurveillance_RD.UserControls
{
    public partial class UnfamiliarTermControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string glossaryText= ConfigurationManager.AppSettings["GlossaryLink"].ToString();
            string link = "<a id=\"lnkGlossary\" href=\"help.aspx?section=G\" target=\"_blank\">Glossary</a>.";
            string Line1 = glossaryText + link;        
            litGlossaryLink.Text = Line1;

        }
    }
}