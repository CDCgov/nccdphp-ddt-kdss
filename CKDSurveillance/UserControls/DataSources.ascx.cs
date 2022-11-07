using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ckdlibV2;

namespace CKDSurveillance_RD.UserControls
{
    public partial class DataSources : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string urlParam = Request.Params["section"];
            
            if ((urlParam.ToUpper() != "D"))
            {
                return;
            }

            ArborDataAccessV2 DAL = new ArborDataAccessV2();
            DataTable dt = DAL.getDataSources();
            DataTable dtLabels = dt.Copy();
            DataTable dtDesc = dt.Copy();

            // ********
            // *Labels*
            // ********
            populateRepeater("", rptLabels, dtLabels);


            // **************
            // *Descriptions*
            // **************
            populateRepeater("", rptDesc, dtDesc);


            // **********
            // *Clean-Up*
            // **********
            dtLabels.Dispose();
            dtDesc.Dispose();
            dt.Dispose();
            DAL = null;
        }

        private void populateRepeater(string filter, Repeater rptCtrl, DataTable dt)
        {
            DataView dv = dt.DefaultView;

            if (filter != "")
            {
                dv.RowFilter = filter;
            }

            rptCtrl.DataSource = dv;
            rptCtrl.DataBind();
        }
    }
}