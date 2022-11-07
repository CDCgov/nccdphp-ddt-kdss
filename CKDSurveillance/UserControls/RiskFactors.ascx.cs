using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ckdlibV2;
using System.Data;

namespace CKDSurveillance_RD.UserControls
{
    public partial class RiskFactors : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ArborDataAccessV2 DAL = new ArborDataAccessV2();

            DataTable dtSpecPops = DAL.getFactorsOfInterest();

            rptFactors.DataSource = dtSpecPops;
            rptFactors.DataBind();


            //*Cleanup*
            DAL = null;
            dtSpecPops.Dispose();
        }
    }
}