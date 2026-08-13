using ckdlibV2;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace CKDSurveillance_RD
{

    public partial class Data : System.Web.UI.Page
    {
        ArborDataAccessV2 DAL = new ArborDataAccessV2();
        List<String> lsDataSources = new List<string>();

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


        protected void Page_Load(object sender, EventArgs e)
        {
            //*If there are erroneous params, just visit the page without params*
            if (hasParamErrors() == true)
            {
                Response.Redirect("Data.aspx");
            }


            //*Get Data*
            
            DataTable dtCategories = new DataTable("Categories");
            DataTable dtPops = new DataTable("SpecialPopulations");

            if ((Request.QueryString["CategoryID"] != null))
            {
                int catID = 0;
                try
                {
                    catID = Convert.ToInt32(Request.QueryString["CategoryID"]);
                    if (catID == 67)
                    {
                        //Get all HP topics
                        dtCategories = DAL.getAccordianTopics(1);
                        litHp2020.Text = litIndicators.Text + MethodsTableCreation(dtCategories, 1);
                        pnlHP2020.Visible = true;
                        pnlIndicators.Visible = false;
                        
                        litBrowseLabel.Text = "Healthy People 2020";                       
                    }
                    else
                    {
                        //Just get all non-HP topics
                        dtCategories = DAL.getAccordianTopics(0);
                        if (dtCategories != null)
                        {
                            litIndicators.Text = litIndicators.Text + MethodsTableCreation(dtCategories, 0);
                        }

                        dtPops = DAL.getAccordianTopics(0, 1);
                        if (dtPops != null)
                        {
                            litSpecialPops.Text = litSpecialPops.Text + MethodsTableCreation(dtPops, 0);
                        }
                        pnlHP2020.Visible = false;
                        pnlIndicators.Visible = true;
                        
                        litBrowseLabel.Text = "Browse Data by Topic";
                    }

                }
                catch (Exception ex)
                {
                    string err = ex.Message + "|" + ex.StackTrace;
                }
            }
            else
            {
                //get all non-HP topics
                dtCategories = DAL.getAccordianTopics(0);
                if (dtCategories != null)
                {
                    litIndicators.Text = litIndicators.Text + MethodsTableCreation(dtCategories, 0);
                }
                
                dtPops = DAL.getAccordianTopics(0, 1);
                if (dtPops != null)
                {
                    litSpecialPops.Text = litSpecialPops.Text + MethodsTableCreation(dtPops, 0);
                }

                pnlHP2020.Visible = false;
                pnlIndicators.Visible = true;
            }


            //Populate data sources
            populateDataSources();
        }

        private void populateDataSources()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div id='ds_list' class='dsList' style='display:none;'>");
            sb.Append("<ul>");
            
            //Line 'em up
            lsDataSources.Sort();

            foreach (string str in lsDataSources.Distinct())
            {
                sb.Append("<li>");
                sb.Append("<a href='./SearchResults.aspx?ss=");
                sb.Append("\"");
                sb.Append(str);
                sb.Append("\"");
                sb.Append("'>");
                sb.Append(str);
                sb.Append("</a>");
                sb.Append("</li>");
            }
            sb.Append("</ul>");
            sb.Append("</div>");

            litDataSources.Text = sb.ToString().Trim();
        }

        private void collectDataSources(DataTable dtIndicators)
        {
            foreach (DataRow dr in dtIndicators.Rows)
            {
                string entry = dr["DataSources"].ToString().Trim();
                if (!lsDataSources.Contains(entry))
                {
                    if (entry.Contains(","))
                    {
                        string[] values = entry.Split(',');
                        foreach (string str in values)
                        {
                            if (!lsDataSources.Contains(str))
                            {
                                lsDataSources.Add(str.Trim());
                            }
                        }
                    }
                    else
                    {
                        lsDataSources.Add(entry);
                    }
                }
            }
        }
        private string MethodsTableCreation(DataTable dtCategories, int healthypeople)
        {
            StringBuilder sbTable = new StringBuilder();
            string cardState = "collapsed";
            string divState = "";

            foreach (DataRow row in dtCategories.Rows)
            {
                int qid = Convert.ToInt16(row["QuestionID"]);
                if (healthypeople == 1 || Convert.ToInt32(Request.QueryString["CategoryID"]) == qid)
                {
                    cardState = "";
                    divState = "show";
                }
                else
                {
                    cardState = "collapsed";
                    divState = "";
                }
                string qtext = row["QuestionText"].ToString();
                string desc = row["LongDesc"].ToString();

                if (healthypeople == 1)
                {
                    // HP2030: output topic as a <th> group header row directly in the table
                    string topicId = "hp2030Topic_" + qid.ToString();
                    sbTable.Append("<tr><th id=\"" + topicId + "\" colspan=\"3\" class=\"ckd-accordion-subcat-header\" style=\"background:#f6fbff; text-align:left; padding:10px 15px; font-weight:600;\">" + qtext + "</th></tr>");
                    sbTable.Append(MethodsIndicatorsTableCreation(qid, qtext, desc, healthypeople, cardState, divState, topicId));
                }
                else
                {
                    // Browse by Topic: keep accordion structure
                    sbTable.Append("<div class=\"card bar\" style=\"padding-top:10px; border-width:0px;\">"); //begin card bar

                    sbTable.Append("<div aria-label=\"" + qtext + "\" class=\"collapse " + divState + "\" id=\"accordion-4m-collapse-" + qid.ToString() + "\" role=\"region\">"); //begin content panel
                    sbTable.Append("<div class=\"card body\" style=\"border-width:0px;\" >"); //begin card body

                    sbTable.Append("<div class=\"row\">"); //begin content row
                    sbTable.Append("<div class=\"col-12\" >");
                    sbTable.Append(MethodsIndicatorsTableCreation(qid, qtext, desc, healthypeople, cardState, divState));

                    sbTable.Append("</div>"); //end content col
                    sbTable.Append("</div>"); //end content row
                    sbTable.Append("</div>"); //end card body
                    sbTable.Append("</div>"); //end content panel
                    sbTable.Append("</div>"); //end card bar
                }
            }

            return sbTable.ToString();
        }

        private string MethodsIndicatorsTableCreation(int TopicID, string TopicText, string TopicDesc, int healthypeople, string cardState, string divState, string topicId = "")
        {
            StringBuilder sbTable = new StringBuilder();

            DataTable dtMeasures = DAL.getMeasuresByTopicID(TopicID, healthypeople);

            int loopcnt = 0;
            int rowcnt = dtMeasures.Rows.Count;

            foreach (DataRow dr in dtMeasures.Rows)
            {
                string measureText = dr["MeasureText"].ToString().Trim();
                int measureID = ((int)(dr["MeasureID"]));

                DataTable dtIndicators = DAL.getIndicators(measureID);

                collectDataSources(dtIndicators);

                if (healthypeople == 1)
                {
                    string measureId = "hp2030Measure_" + measureID.ToString();
                    sbTable.Append("<tr><th id=\"" + measureId + "\" colspan=\"3\" class=\"ckd-accordion-subcat-header\" style=\"background:#e8f0f7; text-align:left; padding:8px 15px 8px 30px; font-weight:600;\">" + measureText + "</th></tr>");

                    if (dtIndicators.Rows.Count > 0)
                    {
                        foreach (DataRow drInd in dtIndicators.Rows)
                        {
                            string url = drInd["URL"].ToString().Trim();
                            url = url.Substring(2);
                            string text = drInd["QuestionText"].ToString().Trim();
                            string dataSource = drInd["DataSources"].ToString();
                            string mostRecentYear = drInd["Most Recent Year"].ToString();

                            // Build the full headers chain: column header + topic group + measure subgroup
                            string indicatorHeaders = "hp2030ColIndicator " + topicId + " " + measureId;
                            string dataSourceHeaders = "hp2030ColDataSource " + topicId + " " + measureId;
                            string yearHeaders = "hp2030ColYear " + topicId + " " + measureId;

                            sbTable.Append("<tr>");
                            sbTable.Append("<td headers=\"" + indicatorHeaders + "\" style=\"padding-left:45px; text-align:left; width:50%;\">");
                            sbTable.Append("<a href=\"" + url + "#refreshPosition\" style=\"text-align:left; text-decoration:underline; letter-spacing:0px; color:#0b4778; opacity:1;\">" + text + "</a>");
                            sbTable.Append("</td>");
                            sbTable.Append("<td headers=\"" + dataSourceHeaders + "\" style=\"text-align:center; width:25%;\">" + dataSource + "</td>");
                            sbTable.Append("<td headers=\"" + yearHeaders + "\" style=\"text-align:center; width:25%;\">" + mostRecentYear + "</td>");
                            sbTable.Append("</tr>");
                        }
                    }
                }
                else
                {
                    // Browse by Topic: keep accordion structure with inner table
                    sbTable.Append("<div class=\"card bar \" style=\"border-width:0px;\">"); //begin card bar

                    sbTable.Append("<div style=\"background: #f6fbff 0% 0% no-repeat padding-box;\" class=\"card-header ckd-accordion-subcat-header " + cardState + "\"  id=\"accordion-4i-card-" + measureID.ToString() + "\" data-target=\"#accordion-4i-collapse-" + measureID.ToString() + "\" data-toggle=\"collapse\">"); //begin header measureText
                    sbTable.Append(measureText);
                    sbTable.Append("</div>"); //end ckd-accordion-subcat-header

                    sbTable.Append("<div aria-labelledby=\"accordion-4i-card-" + measureID.ToString() + "\" class=\"collapse " + divState + "\" id=\"accordion-4i-collapse-" + measureID.ToString() + "\" role=\"region\">"); //begin content panel
                    sbTable.Append("<div class=\"card body\" style=\"border-width:0px;\" >"); //begin card body

                    if (dtIndicators.Rows.Count > 0)
                    {
                        sbTable.Append("<table class=\"table indicator-table\" style=\"width: 100%; margin-bottom: 0;\">");
                        sbTable.Append("<thead class=\"visually-hidden\"><tr>");
                        sbTable.Append("<th scope=\"col\">Indicator</th>");
                        sbTable.Append("<th scope=\"col\">Data Source</th>");
                        sbTable.Append("<th scope=\"col\">Most Recent Year</th>");
                        sbTable.Append("</tr></thead>");
                        sbTable.Append("<tbody>");

                        foreach (DataRow drInd in dtIndicators.Rows)
                        {
                            sbTable.Append("<tr>"); //begin row

                            // Column 1: Indicator Link (50%)
                            sbTable.Append("<td style=\"padding-left:30px; text-align:left; width: 50%;\">");
                            string url = drInd["URL"].ToString().Trim();
                            url = url.Substring(2);
                            string linkStart = ("<a href=\"" + url + "#refreshPosition\" style=\"text-align: left; text-decoration: underline; letter-spacing: 0px; color: #0b4778; opacity: 1;\">");
                            string text = drInd["QuestionText"].ToString().Trim();
                            string linkEnd = "</a>";
                            sbTable.Append(linkStart + text + linkEnd);
                            sbTable.Append("</td>");

                            // Column 2: Data Source (25%)
                            sbTable.Append("<td style=\"text-align:center; width: 25%;\">" + drInd["DataSources"].ToString() + "</td>");

                            // Column 3: Most Recent Year (25%)
                            sbTable.Append("<td style=\"text-align:center; width: 25%;\">" + drInd["Most Recent Year"].ToString() + "</td>");

                            sbTable.Append("</tr>"); //end row
                        }

                        sbTable.Append("</tbody>");
                        sbTable.Append("</table>");
                    }

                    sbTable.Append("</div>"); //end card body
                    sbTable.Append("</div>"); //end content panel
                    sbTable.Append("</div>"); //end card bar
                }

                //*Clean-up*
                dtIndicators.Dispose();
                loopcnt++;
            }

            //*Clean-up*
            dtMeasures.Dispose();

            return sbTable.ToString();
        }

        private bool hasParamErrors()
        {

            bool hasErrors = false;

            string url = Request.RawUrl;


            //*Has Params?*
            if (url.Contains("?"))
            {
                string[] splitter = url.Split('?')[1].Split('=');

                //*Should be only one parameter - any non-numeric params appear as an error*
                string paramName = splitter[0].Trim();
                string paramValue = splitter[1].Trim();                


                if (paramName.ToLower() != "categoryid")
                {
                    hasErrors = true;
                }
                else if (checkForINT(paramValue) == false)
                {
                    hasErrors = true;
                }
            }

            return hasErrors;
        }

        private bool checkForINT(string val)
        {
            bool answer = false;

            Int32 Out = 0;
            if (Int32.TryParse(val, out Out) == true)
            {
                answer = true;
            }

            return answer;
        }
    }
}