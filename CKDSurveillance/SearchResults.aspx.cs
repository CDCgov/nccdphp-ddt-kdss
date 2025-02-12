using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI;
using ckdlibV2;
using System.Web.Security.AntiXss;
using System.Text.RegularExpressions;

namespace CKDSurveillance_RD
{
    public partial class SearchResults : NCCDPage//System.Web.UI.Page
    {

        #region Properties
        public DataTable SearchList
        {

            get
            {
                if (ViewState["TopicSearchList"] != null)
                {
                    return (DataTable)ViewState["TopicSearchList"];
                }
                else
                {
                    return null;
                }
            }
            set { ViewState["TopicSearchList"] = value; }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            //*Get and title case the passed in searh string*
            if (!Page.IsPostBack)
            {
                string searchString = "";
                if (Request.QueryString["ss"] != null)
                {
                    searchString = fixSearchCharacters(Request.QueryString["ss"].Trim());
                }
                else
                {
                    searchString = txtSearch.Text.Trim();
                }

                //Scrub input [scan finding 3/2021]
                searchString = fixSearchCharacters(AntiXssEncoder.HtmlEncode(SanitizeHtml(searchString), false));


                //*Set page title*
                Page.Title = "Chronic Kidney Disease (CKD) in the United States - Local Search";


                //Get results from Database
                populatePage(searchString);
            }
        }


        //**********
        //*Populate*
        //**********
        private string getHintsText()
        {

            StringBuilder sb = new StringBuilder();
            sb.Append("<table class=\"HintsTable\">");
            sb.Append("<tr>");
            sb.Append("<td><em>Try double quotes (\" \") to search for an exact phrase. <br />(<em>eg:</em><strong>\"Acute Kidney Injury\"</strong>)</td>");
            sb.Append("</tr><tr>");
            sb.Append("<td>Use <strong>OR</strong> to search for pages that may have only one of the words. <br />(<em>eg:</em><strong>\"AKI\"</strong> or <strong>\"Acute Kidney Injury\"</strong>)</td>");
            sb.Append("</tr>");
            sb.Append("</table>");

            return sb.ToString().Trim();

        }
        private void populatePage(string term)
        {

            //Clear previous search
            litIndicators.Text = "";

            //**********
            //*Get Data*
            //**********
            ArborDataAccessV2 DAL = new ArborDataAccessV2();
            DataTable dtResults = new DataTable("iResults");
            DataSet ds = new DataSet("searchTables");

            try
            {
                //*Set the description*
                txtSearch.Text = term;

                //*Get all WKD topics*
                ds = DAL.getAccordionLocalSearchTopics(term);
                dtResults = ds.Tables[1];
                SearchList = ds.Tables[0];

            }
            catch (Exception ex)
            {
                string err = ex.Message + "|" + ex.StackTrace;
            }

            //*Build Results Accordion*            
            if (dtResults.Rows.Count > 0)
            {
                //*Build HTML for accordion*                
                litIndicators.Text = MethodsTableCreation(dtResults, 0);

                //Hide 'NO' Search results
                lblNoResults.Visible = false;
            }
            else
            {
                //Clear results
                litIndicators.Text = "";

                //*Show 'NO' Search results*
                lblNoResults.Visible = true;
            }

            //*Clean-up*
            DAL = null;
            dtResults.Dispose();
        }


        //*********
        //*Buttons*
        //*********
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string term = txtSearch.Text.Trim();

            //*Scrub term* - scan finding - 3/2021
            term = fixSearchCharacters(AntiXssEncoder.HtmlEncode(SanitizeHtml(term), false));


            //Get data
            populatePage(term);
        }


        //***********
        //*Accordion*
        //***********
        private string MethodsTableCreation(DataTable dtCategories, int healthypeople)
        {
            StringBuilder sbTable = new StringBuilder();
            string cardState = "";
            string divState = "show";

            foreach (DataRow row in dtCategories.Rows)
            {
                int qid = Convert.ToInt16(row["QuestionID"]);

                string qtext = row["QuestionText"].ToString();
                string desc = row["LongDesc"].ToString();

                sbTable.Append("<div class=\"card bar\" style=\"padding-top:10px; border-width:0px;\">"); //begin card bar

                sbTable.Append("<div class=\"card-header " + cardState + "\" style=\"background-color:#C8D5E4 !important;\" id=\"accordion-4m-card-" + qid.ToString() + "\" data-target=\"#accordion-4m-collapse-" + qid.ToString() + "\" data-toggle=\"collapse\" role=\"tab\" aria-expanded=\"true\">"); //begin header measureText
                sbTable.Append("<a class=\"card-title\" tabindex=\"0\" data-controls=\"accordion-4m-collapse-" + qid.ToString() + "\">" + qtext + "</a>");
                sbTable.Append("</div>");

                sbTable.Append("<div aria-labelledby=\"accordion-4m-card-" + qid.ToString() + "\" class=\"collapse " + divState + "\" id=\"accordion-4m-collapse-" + qid.ToString() + "\" role=\"tabpanel\">"); //begin content panel
                sbTable.Append("<div class=\"card body\">"); //begin card body

                sbTable.Append("<div class=\"row\">"); //begin content row
                //sbTable.Append("<div class=\"col-lg-1\"></div>"); //padding on the left
                sbTable.Append("<div class=\"col-12\" style=\"padding-left:20px;\">"); //begin content col 12 center
                sbTable.Append("<div>" + desc + "</div><br/>");
                sbTable.Append(MethodsIndicatorsTableCreation(qid, qtext, desc, healthypeople, cardState, divState));

                sbTable.Append("</div>"); //end content col 11 center

                sbTable.Append("</div>"); //end content row

                sbTable.Append("</div>"); //end card body
                sbTable.Append("</div>"); //end content panel
                sbTable.Append("</div>"); //end card bar

            }

            return sbTable.ToString();
        }
        private string MethodsIndicatorsTableCreation(int TopicID, string TopicText, string TopicDesc, int healthypeople, string cardState, string divState)
        {
            StringBuilder sbTable = new StringBuilder();

            //Start table HTML
            ArborDataAccessV2 DAL = new ArborDataAccessV2();

            //DataTable dtMeasures = DAL.getMeasuresByTopicID(TopicID, healthypeople);
            DataTable dtMeasures = DAL.getSubTopicsSearch(TopicID, SearchList);

            int loopcnt = 0;
            int rowcnt = dtMeasures.Rows.Count;
            int totalloops = 1;

            bool containsLitInd = false;
            // *Get all Measures for this Topic
            foreach (DataRow dr in dtMeasures.Rows)
            {
                string measureText = dr["QuestionText"].ToString().Trim();
                int measureID = ((int)(dr["QuestionID"]));

                sbTable.Append("<div class=\"card bar \" style=\"padding-left:20px;\">"); //begin card bar

                sbTable.Append("<div class=\"card-header ckd-accordion-subcat-header " + cardState + "\" id=\"accordion-4i-card-" + measureID.ToString() + "\" data-target=\"#accordion-4i-collapse-" + measureID.ToString() + "\" data-toggle=\"collapse\" role=\"tab\" aria-expanded=\"true\">"); //begin header measureText
                sbTable.Append("<a class=\"card-title\" tabindex=\"0\"  data-controls=\"accordion-4i-collapse-" + measureID.ToString() + "\">" + measureText + "</a>");
                sbTable.Append("</div>");

                sbTable.Append("<div aria-labelledby=\"accordion-4i-card-" + measureID.ToString() + "\" class=\"collapse " + divState + "\" id=\"accordion-4i-collapse-" + measureID.ToString() + "\" role=\"tabpanel\">"); //begin content panel
                sbTable.Append("<div class=\"card body\">"); //begin card body
                                                             //*Get Measure values*

                //adding the measure string below, moved 3/3/2017, BS

                //*Add Bulleted list of Indicator Links for this Measure*
                //DataTable dtIndicators = DAL.getIndicatorsByMeasureID(measureID);
                DataTable dtIndicators = DAL.getIndicatorsSearch(measureID, SearchList);

                //*Cycle through all indicators*
                StringBuilder sb_indTable = new StringBuilder();



                bool containsIndi = false;
                foreach (DataRow drInd in dtIndicators.Rows)
                {
                    sbTable.Append("<div class=\"row\" style=\"padding-bottom:2px\">"); //begin row
                    sbTable.Append("<div class=\"col-7\" style=\"padding-left:20px;\">"); //begin link col, no size definition because we want the layout to remain the same regardless of size
                    // Build link
                    string url = drInd["URL"].ToString().Trim();
                    url = url.Substring(2);
                    string linkStart = ("<a href=\"" + url + "#refreshPosition\">");
                    string text = drInd["QuestionText"].ToString().Trim();
                    string linkEnd = "</a>";
                    sbTable.Append(linkStart + text + linkEnd);

                    sbTable.Append("</div>"); //end begin link col
                    sbTable.Append("<div class=\"col-2\" style=\"text-align:center\">" + drInd["Most Recent Year"].ToString() + "</div>");
                    sbTable.Append("<div class=\"col-3\" style=\"text-align:center\">" + drInd["DataSources"].ToString() + "</div>");

                    sbTable.Append("</div>"); //end row                   
                }

                sbTable.Append(sb_indTable); //adding the indicator links
                //*Close the list and row*


                // *Clean-up*
                dtIndicators.Dispose();
                loopcnt++;

                sbTable.Append("</div>"); //end card body
                sbTable.Append("</div>"); //end content panel
                sbTable.Append("</div>"); //end card bar

            }


            //*Clean-up*
            dtMeasures.Dispose();


            return sbTable.ToString();
        }


        //*********
        //*Utility*
        //*********
        protected string SanitizeHtml(string html)
        {
            html = System.Web.HttpUtility.HtmlDecode(html);

            List<string> blackListedTags = new List<string>()
            {
                    "body", "script", "iframe", "form", "object", "embed", "link", "head", "meta"
            };

            foreach (string tag in blackListedTags)
            {
                html = Regex.Replace(html, "<" + tag, "<p", RegexOptions.IgnoreCase);
                html = Regex.Replace(html, "</" + tag, "</p", RegexOptions.IgnoreCase);
            }

            //*Scrub for SQL*
            List<string> blackListedSQL = new List<string>()
            {
                "insert", "select", "delete", "update", "drop", "truncate", "join", "backup", "dbreindex", "dbcc", "create", "alter", ";", "database", "table", "*", "from"
            };

            foreach (string word in blackListedSQL)
            {
                int index = html.IndexOf(word, StringComparison.OrdinalIgnoreCase);
                if (index >= 0)
                {
                    html = html.Remove(index, word.Length);
                }
            }

            return html;
        }
        private string fixSearchCharacters(string searchString)
        {
            string answer = "";

            answer = searchString.Replace("&quot;", "\"").Trim();

            return answer;
        }
    }
}