using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ckdlibV2;

namespace CKDSurveillance_RD.UserControls
{
    public partial class AccordionIndicatorControlSearch : System.Web.UI.UserControl
    {
        #region Properties
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
        public DataTable SearchList
        {

            get
            {
                if (ViewState["SearchList"] != null)
                {
                    return (DataTable)ViewState["SearchList"];
                }
                else
                {
                    return null;
                }
            }
            set { ViewState["SearchList"] = value; }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ArborDataAccessV2 DAL = new ArborDataAccessV2();
                DataTable dtIndicators = new DataTable("Indicators");
                dtIndicators = DAL.getIndicatorsSearch(categoryid, SearchList);


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
    }
}