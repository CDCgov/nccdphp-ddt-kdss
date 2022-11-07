using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CKDSurveillance_RD.UserControls.TemplateLocal
{
    public partial class ucBreadcrumbs : System.Web.UI.UserControl
    {
        string _extraCrumbs = "";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public string extraCrumbs
        {
            get
            {
                return _extraCrumbs;
            }
            set
            {
                _extraCrumbs = value;
                litExtraCrumbs.Text = _extraCrumbs;
            }
        }
    }
}