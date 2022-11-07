using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using ckdlibV2;

namespace CKDSurveillance_RD.UserControls.FPWidgets
{
    public partial class SuggestedCitationAndVersioning : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            setVersionAndReleaseDate();
        }

        private void setVersionAndReleaseDate()
        {
            string lrd = "";
            string crv = "";

            DataTable dt = getVersionSettings();
            foreach (DataRow dr in dt.Rows)
            {
                if (dr["name"].ToString().Trim().ToLower() == "currentreleaseversion") { crv = dr["Value"].ToString(); }
                else if (dr["name"].ToString().ToLower() == "lastreleasedate") { lrd = dr["Value"].ToString(); }
            }


            lblLastUpdateDate.Text = lrd;
            lblCurrentVersion.Text = crv;
        }
        private DataTable getVersionSettings()
        {
            DataTable answer = new DataTable("versioning");

            //Ensure Cache is not empty
            if (Cache["ApplicationSettings"] == null)
            {
                ArborDataAccessV2 DAL = new ArborDataAccessV2();
                DataTable tempAnswer = DAL.getApplicationSettings();

                if (tempAnswer != null)
                {
                    Cache.Insert("ApplicationSettings", tempAnswer, null, DateTime.MaxValue, TimeSpan.FromDays(2));
                }

                //Clean-up
                tempAnswer.Dispose();
                tempAnswer = null;
            }

            DataTable dt = (DataTable)Cache["ApplicationSettings"];
            DataRow[] drs = dt.Select("Name='CurrentReleaseVersion' OR Name='LastReleaseDate'");
            answer = drs.CopyToDataTable();


            return answer;
        }
    }
}