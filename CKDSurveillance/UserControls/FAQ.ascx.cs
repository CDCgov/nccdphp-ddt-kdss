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
    public partial class FAQ : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string urlParam = Request.Params["section"];

            if (urlParam.ToUpper() != "F")
            {
                return;
            }


            ArborDataAccessV2 DAL = new ArborDataAccessV2();
            DataSet ds = DAL.getFAQs();
            DataTable dtQuestions = ds.Tables[0];
            DataTable dtAnswers = ds.Tables[0];


            //***********
            //*Questions*
            //***********
            populateRepeater("", rptQuestions, dtQuestions);


            //*********
            //*Answers*
            //*********
            populateRepeater("", rptAnswers, dtAnswers);


            //**********
            //*Clean-Up*
            //**********
            dtQuestions.Dispose();
            dtAnswers.Dispose();
            ds.Dispose();
            DAL = null;

        }


        private void populateRepeater(string filter, Repeater rptCtrl, DataTable dt)
        {
            DataView dv = dt.DefaultView;
            if ((filter != ""))
            {
                dv.RowFilter = filter;
            }
            rptCtrl.DataSource = dv;
            rptCtrl.DataBind();
        }

    }
}