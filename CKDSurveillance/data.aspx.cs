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
                if (healthypeople == 1 || Convert.ToInt32(Request.QueryString["CategoryID"]) == qid) //if it is healthy people or a match on a category query string then show that card
                {
                    cardState = "";
                    divState = "show";
                }
                else //otherwise hide the card, needs to be reset in each loop
                {
                    cardState = "collapsed";
                    divState = "";
                }
                string qtext = row["QuestionText"].ToString();
                string desc = row["LongDesc"].ToString();                

                sbTable.Append("<div class=\"card bar\" style=\"padding-top:10px;\">"); //begin card bar

                //sbTable.Append("<div class=\"card-header " + cardState + "\" style=\"background-color:#C8D5E4 !important;\" id=\"accordion-4m-card-" + qid.ToString() + "\" data-target=\"#accordion-4m-collapse-" + qid.ToString() + "\" data-toggle=\"collapse\" role=\"tab\" aria-expanded=\"false\">"); //begin header measureText
                //sbTable.Append("<a class=\"card-title\" tabindex=\"0\"  data-controls=\"accordion-4m-collapse-" + qid.ToString() + "\">" + qtext + "</a>");
                //sbTable.Append("</div>");

                sbTable.Append("<div aria-labelledby=\"accordion-4m-card-" + qid.ToString() + "\" class=\"collapse " + divState + "\" id=\"accordion-4m-collapse-" + qid.ToString() + "\" role=\"tabpanel\">"); //begin content panel
                sbTable.Append("<div class=\"card body\">"); //begin card body

                sbTable.Append("<div class=\"row\">"); //begin content row                
                sbTable.Append("<div class=\"col-12\" >"); //begin content col 12 center    ---style=\"padding-left:20px;\"
                //sbTable.Append("<div>" + desc + "</div><br/>");
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

            DataTable dtMeasures = DAL.getMeasuresByTopicID(TopicID, healthypeople);

            int loopcnt = 0;
            int rowcnt = dtMeasures.Rows.Count;            

            
            // *Get all Measures for this Topic
            foreach (DataRow dr in dtMeasures.Rows)
            {
                string measureText = dr["MeasureText"].ToString().Trim();
                int measureID = ((int)(dr["MeasureID"]));

                sbTable.Append("<div class=\"card bar \" >"); //begin card bar   ---style=\"padding-left:20px;\"

                sbTable.Append("<div class=\"card-header ckd-accordion-subcat-header " + cardState + "\"  id=\"accordion-4i-card-" + measureID.ToString() + "\" data-target=\"#accordion-4i-collapse-" + measureID.ToString() + "\" data-toggle=\"collapse\" role=\"tab\" aria-expanded=\"false\">"); //begin header measureText
                sbTable.Append("<a class=\"card-title\" tabindex=\"0\"  data-controls=\"accordion-4i-collapse-" + measureID.ToString() + "\">" + measureText + "</a>");
                sbTable.Append("</div>");

                sbTable.Append("<div aria-labelledby=\"accordion-4i-card-" + measureID.ToString() + "\" class=\"collapse " + divState + "\" id=\"accordion-4i-collapse-" + measureID.ToString() + "\" role=\"tabpanel\">"); //begin content panel
                sbTable.Append("<div class=\"card body\">"); //begin card body
                
                                
                //*Add Bulleted list of Indicator Links for this Measure*                
                DataTable dtIndicators = DAL.getIndicators(measureID);

                //Manage datasource list
                collectDataSources(dtIndicators);


                //*Cycle through all indicators*
                StringBuilder sb_indTable = new StringBuilder();


                
                //bool containsIndi = false;
                foreach (DataRow drInd in dtIndicators.Rows)
                {
                    sbTable.Append("<div class=\"row\" style=\"padding-bottom:2px\">"); //begin row
                    sbTable.Append("<div class=\"col-7\" style=\"padding-left:30px;\">"); //begin link col, no size definition because we want the layout to remain the same regardless of size
                    // Build link
                    string url = drInd["URL"].ToString().Trim();
                    url = url.Substring(2);
                    string linkStart = ("<a href=\"" + url + "#refreshPosition\">");
                    string text = drInd["QuestionText"].ToString().Trim();
                    string linkEnd = "</a>";
                    sbTable.Append(linkStart + text + linkEnd);

                    sbTable.Append("</div>"); //end begin link col
                    sbTable.Append("<div class=\"col-2\" style=\"text-align:center\">" + drInd["DataSources"].ToString() + "</div>");
                    sbTable.Append("<div class=\"col-3\" style=\"text-align:center\">" + drInd["Most Recent Year"].ToString() + "</div>");
                    //sbTable.Append("<div class=\"col-2\" style=\"text-align:center\">" + drInd["Most Recent Year"].ToString() + "</div>");
                    //sbTable.Append("<div class=\"col-3\" style=\"text-align:center\">" + drInd["DataSources"].ToString() + "</div>");
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