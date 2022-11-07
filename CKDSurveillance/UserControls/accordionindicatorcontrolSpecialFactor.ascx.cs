using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ckdlibV2;

namespace CKDSurveillance_RD.UserControls
{
    public partial class accordionindicatorcontrolSpecialFactor : System.Web.UI.UserControl
    {
        public int categoryid
        {
            get
            {
                object o = null;
                o = ViewState["categoryid"];
                if ((o != null))
                {
                    return Convert.ToInt32(o);
                }
                else
                {
                    return -1;
                }
            }
            set { ViewState["categoryid"] = value; }
        }

        //public string TrendID
        //{
        //    get
        //    {
        //        if (Request["categoryID"] != null)
        //        {
        //            return Request["CategoryID"];
        //        }
        //        else
        //        {
        //            return "1";
        //        }
        //    }
        //}

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //*Get the Factor*
                string factor = "";
                if (Request.QueryString["type"] != null)
                {
                    factor = Request.QueryString["type"].ToString();
                }

                ArborDataAccessV2 DAL = new ArborDataAccessV2();
                DataTable dtIndicators = new DataTable("Indicators");
                dtIndicators = DAL.getIndicatorsSpecialFactors(this.categoryid, factor);
                dtIndicators = cleanURL(dtIndicators);


                if (dtIndicators.Rows.Count > 0)
                {
                    //*508 requirements - table must have a summary attribute*
                    string pqid = dtIndicators.Rows[0]["ParentQuestionID"].ToString();
                    string parentText = dtIndicators.Rows[0]["ParentText"].ToString().Trim();

                    string header = "<table id=\"ckd-accordion-indicator-table\" summary=\"This table gives 2 indicator headings, Most Recent Year and Data Source for each " + parentText + " for all Indicators row headings\">";
                    header += "<tr>";
                    header += "<th scope=\"col\" class=\"accessibleHide\" ID=\"" + pqid + "col1\">Indicator</th>";
                    header += "<th scope=\"col\" class=\"accessibleHide\" ID=\"" + pqid + "col2\">Most Recent Year</th>";
                    header += "<th scope=\"col\" class=\"accessibleHide\" ID=\"" + pqid + "col3\">Data Source</th>";
                    header += "</tr>";

                    LitParentMeasure.Text = header;


                    this.rptIndicators.DataSource = dtIndicators.DefaultView;
                    this.rptIndicators.DataBind();
                }


                //*Clean-up*
                DAL = null;
                dtIndicators.Dispose();

            }
        }

        private DataTable cleanURL(DataTable dt)
        {
            
            //*Must URLEncode the Strats in the URL otherwise, pasting the URL can fail due to spaces in Strat names (Nilka email from 6/16/2016)
            //*6/17/2016*

            DataTable answer = null;

            foreach (DataRow dr in dt.Rows)
            {
                string url = dr["URL"].ToString();

                string pageSection = url.Split('?')[0].ToString().Trim();
                string paramSection = url.Split('?')[1].ToString().Trim();
                string QNumSection = paramSection.Split('&')[0];
                string stratSection = paramSection.Split('&')[1];
                string rawStrat = stratSection.Split('=')[1];
                string encodedRawStrat = HttpUtility.UrlEncode(rawStrat);


                dr["URL"] = pageSection + "?" + QNumSection + "&Strat=" + encodedRawStrat;
            }

            answer = dt;
            return answer;
        }
    }
}