using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;

namespace CKDSurveillance_RD.UserControls.RDVersions
{
    public partial class VersionRD : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
         //<add key="LastReleaseDate" value="March 9, 2016"/>
	     //<add key="CurrentReleaseVersion" value="4.1"/>

            string lrd = "";
            string crv = "";

            lrd = ConfigurationManager.AppSettings["LastReleaseDate"].Trim();
            crv = ConfigurationManager.AppSettings["CurrentReleaseVersion"].Trim();

            lblLastUpdateDate.Text = lrd;
            lblCurrentVersion.Text = crv;
        }        
    }
}