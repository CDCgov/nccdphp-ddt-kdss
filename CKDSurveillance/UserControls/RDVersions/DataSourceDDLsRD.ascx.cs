using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CKDSurveillance_RD.UserControls.RDVersions
{
    public partial class DataSourceDDLsRD : System.Web.UI.UserControl
    {
        DataTable dtDataSources;

        public DataTable DataSources
        {
            get
            {
                return dtDataSources;
            }
            set
            {
                dtDataSources = value;
                try
                {

                    AddLinkColumn();
                    updateLinks();

                    //Now the phone only DDL version of the Data Source Tab
                    rptDDLDataSources.DataSource = dtDataSources;                    
                    rptDDLDataSources.DataBind();
                }
                catch (Exception ex)
                {
                    //gracefully fail;
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            
            

        }

        private void AddLinkColumn()
        {
            DataColumn dc1 = new DataColumn("link");
            dtDataSources.Columns.Add(dc1);

            foreach(DataRow dr in dtDataSources.Rows)
            {
                dr["link"] = "~/detail.aspx?QNum=" + dr["QNum"].ToString().Trim();
            }

        }

        private void updateLinks()
        {
            foreach (DataRow dr in dtDataSources.Rows)
            {
                string url = Request.Url.ToString().Trim();
                if (url.Contains("="))
                {
                    string QNum = url.Split('=')[1].Split('&')[0].Trim();
                    string myQnum = dr["QNum"].ToString();
                    if (myQnum == QNum)
                    {
                        dr["link"] = "";
                        hfCurrentDS.Value = dr["DataSourceShortName"].ToString().Trim();
                    }
                }
            }
        }
    }
}