using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Text.RegularExpressions;
using ckdlibV2;

namespace CKDSurveillance_RD.UserControls.RDVersions
{
    public partial class SiteNavigationRD2_Options : System.Web.UI.UserControl
    {
        public string IndicatorText;
        public string TopicSelected;
        ArborDataAccessV2 DAL = new ArborDataAccessV2();
        public string directoryPath;

        protected void Page_Load(object sender, EventArgs e)
        {
            string path = HttpContext.Current.Request.Url.AbsolutePath;
            if (path.ToLower().IndexOf("topichome") > -1) //trying to account for the additional folder level of the topichome pages
                directoryPath = "../";
            else
                directoryPath = "";

            if (path.ToLower().IndexOf("detail") == -1)
                Session["SelectedIndicator"] = "";

            //*Get Topics*
            DataTable dtTopicList = DAL.getTopics(0);

            //*Get measures/Indicators for each topic*
            foreach (DataRow dr in dtTopicList.Rows)
            {
                Int32 topicID = Convert.ToInt32(dr["TopicID"]);
                string topicText = Convert.ToString(dr["TopicText"]);
                //string tbl = MethodsIndicatorsTable(topicID);
                string tbl = MethodsIndicatorsTable_Options(topicID, topicText);
                populateDivs(topicID, tbl);

                litMobileIndicators.Text = litMobileIndicators.Text + MethodsIndicatorsTableMobile_Options(topicID, topicText);
            }


            // *Clean-up*
            DAL = null;
            dtTopicList.Dispose();
        }

        private string MethodsIndicatorsTable_Options(int TopicID, string TopicText)
        {
            StringBuilder sbTable = new StringBuilder();
            
            // Holds the html for the right panel


            //<div class="span8 col-xs-4 col-sm-4">Awareness 1 with very long text that hopefully will wrap around within the div tags</div>
            //      <div class="span8 col-xs-4 col-sm-4">Awareness 2 and additionally long text which is still going to wrap around the div I hope</div>
            //      <div class="span8 col-xs-4 col-sm-4">Awareness 3, the final component of text that wraps around again with much hope!!!!!!!!</div>

            
            //Start table HTML
            sbTable.Append("<div class=\"col-4 menucolumn\" style=' margin-left:25px;' >");
            DataTable dtMeasures = DAL.getMeasuresByTopicID(TopicID);

            int loopcnt = 0;
            int rowcnt = dtMeasures.Rows.Count;
            int totalloops = 1;
            Decimal thirdofrow = Math.Round(Convert.ToDecimal(rowcnt / 3), MidpointRounding.AwayFromZero);
            if (rowcnt == 4 || rowcnt == 5 || rowcnt == 6)//accounting for small counts
                thirdofrow = 1;
            if (thirdofrow == 0) //if this check isn't in place the values are added to the second column to start
                thirdofrow = 1;
            bool containsLitInd = false;

            // if this is the first measure of the topic
            //if (loopcnt == 0)
            //    sbTable.Append("<div class='TopicHomeTextTD'>View more information regarding <a href='topichomepoc.aspx'>" + TopicText + "</a></div>");

            // *Get all Measures for this Topic
            foreach (DataRow dr in dtMeasures.Rows)
            {
                
                if (loopcnt == thirdofrow && totalloops < 3)//if we reach the last column, then we want to add the remaining measures/indicators to it.
                {
                    totalloops++;//incrementing the total number of loops
                    loopcnt = 0; //resetting the counter
                    sbTable.Append("</div><div class='span1 menudivider' >&nbsp;</div><div class=\"col-4 menucolumn\" style='flex:7;' >");

                    if (thirdofrow == 1 && (rowcnt == 4 || rowcnt == 5))
                        thirdofrow = 2;//forcing the increase to account for 'Health Care System Capacity' formatting -- HARD CODE
                }
                //*Get Measure values*
                string measureText = dr["MeasureText"].ToString().Trim();
                int measureID = ((int)(dr["MeasureID"]));
                //adding the measure string below, moved 3/3/2017, BS

                //*Add Bulleted list of Indicator Links for this Measure*
                DataTable dtIndicators = DAL.getIndicatorsByMeasureID(measureID);

                //*Cycle through all indicators*
                StringBuilder sb_indTable = new StringBuilder();

               

                bool containsIndi = false;
                foreach (DataRow drInd in dtIndicators.Rows)
                {
                    // Build link
                    string linkStart = ("<a href=\""+ directoryPath + "detail.aspx?Qnum=" + (drInd["QNUM"].ToString().Trim() + "#refreshPosition\">"));
                    string text = drInd["IndicatorText"].ToString().Trim();
                    string linkEnd = "</a>";

                    //Compare IndicatorID instead? (ML 1/20/2020)
                    string menuSelectedIndicatorID  = "";
                    if (Session["menuSelectedIndicatorID"] != null) { menuSelectedIndicatorID = Session["menuSelectedIndicatorID"].ToString().Trim(); }
                    string pageSelectedIndicator = drInd["IndicatorID"].ToString().Trim();

                    
                    if(menuSelectedIndicatorID != "")
                    {                        
                        if(menuSelectedIndicatorID == pageSelectedIndicator)
                        {
                            sb_indTable.Append("<li class='selectedIndicator'>");
                            HF_SN2_TopicText.Value = TopicText;
                            containsIndi = true;
                        }
                        else
                            sb_indTable.Append("<li>");
                    }
                    else
                        sb_indTable.Append("<li>");

                    sb_indTable.Append(linkStart + text + linkEnd);

                    if (drInd["LiteratureInd"].ToString() == "1")
                    {
                        sb_indTable.Append("<img runat='server' src='"+ directoryPath + "images/bookicon.PNG' alt='Published literature or one-time analysis, ongoing surveillance not available' />");
                        containsLitInd = true;
                    }

                    sb_indTable.Append("</li>");                    
                }

                string highlightclass_measure = "";
                string highlightclass_indicatorgroup = "";
                if (containsIndi)
                {
                    highlightclass_measure = " selectedBackgroundMeasure";
                    highlightclass_indicatorgroup = "selectedBackgroundIndicatorGroup";
                }


                sbTable.Append("<div class=\"MeasureTextTD" + highlightclass_measure + "\">" + measureText + "</div>"); //adding the measure, checking to see if the indicator is in the measure and if so, then adding a class to highlight it
                //Open the row and list
                sbTable.Append("<div class=\"IndicatorTD " + highlightclass_indicatorgroup + "\"><ul class=\"siteNavUL\">");

                sbTable.Append(sb_indTable); //adding the indicator links
                sbTable.Append("</ul></div>");
                //*Close the list and row*

                // *Clean-up*
                dtIndicators.Dispose();
                loopcnt++;
                
            }

            if(containsLitInd)
                sbTable.Append("<div><img runat='server' src='" + directoryPath + "images/bookicon.PNG' alt='Published literature or one-time analysis, ongoing surveillance not available'/>=<span style='font-size:10px;'>Published literature or one-time analysis, ongoing surveillance not available</span></div>");
            //Close Table HTML
            sbTable.Append("</div>");


            //*Clean-up*
            dtMeasures.Dispose();


            return sbTable.ToString();
        }

        private string MethodsIndicatorsTableMobile_Options(int TopicID, string TopicText)
        {
            StringBuilder sbTable = new StringBuilder();
            string cardState = "collapsed";
            string divState = "";
            sbTable.Append("<div class=\"accordion indicator-plus accordion-white \" role=\"tabpanel\" >");

            sbTable.Append("<div class=\"card bar\" style=\"padding-top:10px;\">"); //begin card bar

            sbTable.Append("<div class=\"card-header " + cardState + "\" style=\"background-color:#1a7aa2 !important; color:#fff !important;\" id=\"accordion-4m-card-" + TopicID.ToString() + "-mobile\" data-target=\"#accordion-4m-collapse-" + TopicID.ToString() + "-mobile\" data-toggle=\"collapse\" role=\"tab\" aria-expanded=\"false\">"); //begin header measureText
            sbTable.Append("<a class=\"card-title\" tabindex=\"0\"  style=\"padding-right: 0px !important;  color:#fff !important;\"  data-controls=\"accordion-4m-collapse-" + TopicID.ToString() + "-mobile\">" + TopicText + "</a>");
            sbTable.Append("</div>");

            sbTable.Append("<div aria-labelledby=\"accordion-4m-card-" + TopicID.ToString() + "-mobile\" class=\"collapse " + divState + "\" id=\"accordion-4m-collapse-" + TopicID.ToString() + "-mobile\" role=\"tabpanel\">"); //begin content panel
            sbTable.Append("<div class=\"card body\">"); //begin card body

            sbTable.Append("<div class=\"row\">"); //begin content row
                                                   //sbTable.Append("<div class=\"col-lg-1\"></div>"); //padding on the left
            sbTable.Append("<div class=\"col-12\" style=\"padding-left:20px;\">"); //begin content col 12 center

            //topic home page link
            string TopicText_NoSpaces = TopicText;
            TopicText_NoSpaces = TopicText_NoSpaces.Replace(" and ", ""); //hardcode for the Prevalence and Incidence page. I didn't include in word 'and' in the name of the aspx page
            TopicText_NoSpaces = Regex.Replace(TopicText_NoSpaces, @"\s+", "");
            sbTable.Append("<div class=\"row TopicHomeDiv\" >"); //adding padding right so that the text lines up with the menu text
            sbTable.Append("<div class=\"TopicHomeTextTD\" style=\"padding-right: 30px !important;\" data-topicid=\"" + TopicID.ToString() + "\" data-topicpage=\"" + TopicText_NoSpaces + "\"> View " + TopicText + " Summary");           
            
            sbTable.Append("</div>");
            sbTable.Append("</div>");
            //end topic home page link
            // Holds the html for the right panel

            DataTable dtMeasures = DAL.getMeasuresByTopicID(TopicID);

            int loopcnt = 0;
            int rowcnt = dtMeasures.Rows.Count;
            int totalloops = 1;

            bool containsLitInd = false;
            // *Get all Measures for this Topic
            foreach (DataRow dr in dtMeasures.Rows)
            {
                string measureText = dr["MeasureText"].ToString().Trim();
                int measureID = ((int)(dr["MeasureID"]));

                sbTable.Append("<div class=\"card bar\">"); //begin card bar

                sbTable.Append("<div class=\"card-header collapsed\" style=\"background-color:#C8D5E4  !important; color:#000 !important;\" id=\"accordion-4-card-" + TopicID.ToString() + measureID.ToString() + "\" data-target=\"#accordion-4-collapse-" + TopicID.ToString() + measureID.ToString() + "\" data-toggle=\"collapse\" role=\"tab\" aria-expanded=\"false\">"); //begin header measureText
                sbTable.Append("<a class=\"card-title\" tabindex=\"0\"  style=\"padding-right: 0px !important; color:#000 !important;\" data-controls=\"accordion-4-collapse-" + TopicID.ToString() + measureID.ToString() + "\">" + measureText + "</a>");
                sbTable.Append("</div>");

                sbTable.Append("<div aria-labelledby=\"accordion-4-card-" + TopicID.ToString() + measureID.ToString() + "\" class=\"collapse\" id=\"accordion-4-collapse-" + TopicID.ToString() + measureID.ToString() + "\" role=\"tabpanel\">"); //begin content panel
                sbTable.Append("<div class=\"card body\">"); //begin card body
                                                             //*Get Measure values*

                //adding the measure string below, moved 3/3/2017, BS

                //*Add Bulleted list of Indicator Links for this Measure*
                DataTable dtIndicators = DAL.getIndicatorsByMeasureID(measureID);

                //*Cycle through all indicators*
                StringBuilder sb_indTable = new StringBuilder();


                sbTable.Append("<div><ul>");
                bool containsIndi = false;
                foreach (DataRow drInd in dtIndicators.Rows)
                {
                    // Build link
                    string linkStart = ("<a href=\"" + directoryPath + "detail.aspx?Qnum=" + (drInd["QNUM"].ToString().Trim() + "#refreshPosition\" >"));
                    string text = drInd["IndicatorText"].ToString().Trim();
                    string linkEnd = "</a>";

                    string linkIndicatorTextCompare = drInd["IndicatorText"].ToString().Trim().ToLower();

                    if (IndicatorText != null)
                    {
                        IndicatorText = IndicatorText.Trim().ToLower();
                        //if (linkIndicatorTextCompare.IndexOf("by") > 0) //removing all text to the right of 'by', 3/6 THIS DOESN'T RESOLVE ALL MATCH ISSUES
                        //    linkIndicatorTextCompare = linkIndicatorTextCompare.Substring(0, linkIndicatorTextCompare.IndexOf("by")).Trim();

                        if (IndicatorText == linkIndicatorTextCompare)//if the text matches, then add the appropriate highlight class
                        {
                            sb_indTable.Append("<li style='margin-left:25px; text-align:left; padding-top:5px;'>");
                            HF_SN2_TopicText.Value = TopicText;
                            containsIndi = true;
                        }
                        else
                            sb_indTable.Append("<li style='margin-left:25px;  text-align:left; padding-top:5px;'>");
                    }
                    else
                        sb_indTable.Append("<li style='margin-left:25px;  text-align:left; padding-top:5px;'>");

                    sb_indTable.Append(linkStart + text + linkEnd);

                    if (drInd["LiteratureInd"].ToString() == "1")
                    {
                        sb_indTable.Append("&nbsp;<img src='" + directoryPath + "images/bookicon.PNG' alt='Published literature or one-time analysis, ongoing surveillance not available' />");
                        containsLitInd = true;
                    }

                    sb_indTable.Append("</li>");
                }

                string highlightclass_measure = "";
                string highlightclass_indicatorgroup = "";
                if (containsIndi)
                {
                    highlightclass_measure = " selectedBackgroundMeasure";
                    highlightclass_indicatorgroup = "selectedBackgroundIndicatorGroup";
                }

                //sbTable.Append("<div class=\"THPMeasure\">" + measureText + "</div>"); //adding the measure, checking to see if the indicator is in the measure and if so, then adding a class to highlight it
                ////Open the row and list
                //sbTable.Append("<div class=\"IndicatorTD " + highlightclass_indicatorgroup + "\"><ul class=\"siteNavUL\">");

                sbTable.Append(sb_indTable); //adding the indicator links
                sbTable.Append("</ul></div>");
                //*Close the list and row*




                // *Clean-up*
                dtIndicators.Dispose();
                loopcnt++;

                sbTable.Append("</div>"); //end card body
                sbTable.Append("</div>"); //end content panel
                sbTable.Append("</div>"); //end card bar

            }

            if (containsLitInd)
                sbTable.Append("<div><img src='" + directoryPath + "images/bookicon.PNG' alt='Published literature or one-time analysis, ongoing surveillance not available'/>=<span style='font-size:10px;'>Published literature or one-time analysis, ongoing surveillance not available</span></div>");
            //Close Table HTML
            sbTable.Append("</div>"); //end content col 12 center

            sbTable.Append("</div>"); //end content row

            sbTable.Append("</div>"); //end card body
            sbTable.Append("</div>"); //end content panel
            sbTable.Append("</div>"); //end card bar
            sbTable.Append("</div>"); //end accordion 


            //*Clean-up*
            dtMeasures.Dispose();


            return sbTable.ToString();
        }

        private void populateDivs(int id, string tbl)
        {
            DataSet ds = DAL.getIndicatorsByTopicID(id);
            if (ds != null)
            {
                Literal litDesc = null;
                Literal litIndicators = null;
                switch (id)
                {
                    case 1:
                        // litDesc = litPrevalenceDescription;
                        litIndicators = litPrevalenceIndicators;
                        break;
                    //case 2:
                    //    //litDesc = litIncidenceDescription;
                    //    litIndicators = litIncidenceIndicators;
                    //    break;
                    case 3:
                        //litDesc = litAwarenessDescription;
                        litIndicators = litAwarenessIndicators;
                        break;
                    case 4:
                        //litDesc = litBurdenDescription;
                        litIndicators = litBurdenIndicators;
                        break;
                    case 5:
                        //litDesc = litHealthConsequencesDescription;
                        litIndicators = litHealthConsequencesIndicators;
                        break;
                    case 6:
                        //litDesc = litProcessDescription;
                        litIndicators = litQualityIndicators;
                        break;
                    case 7:
                        //litDesc = litHealthSystemDescription;
                        litIndicators = litHealthSystemIndicators;
                        break;
                    case 24:
                        litIndicators = litSocialDeterminants;
                        break;
                }


                //*Limited rows to only applicable MAIN topics (only 7 currently) [ exec proc_GetAccordionTopics 0,0 ]*
                string td = "";
                if (ds.Tables[0].Rows[0]["TopicDescription"] != null)
                {
                    td = ds.Tables[0].Rows[0]["TopicDescription"].ToString().Trim();
                }
                //litDesc.Text = td;
                litIndicators.Text = tbl.Trim();
            }
        }
        

        

        #region Utilities

        private string buildtableString(DataTable dt)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<ul>");

            foreach (DataRow dr in dt.Rows)
            {
                sb.Append(("<li>" + (dr["IndicatorText"].ToString() + "</li>")));
            }

            sb.Append("</ul>");

            return sb.ToString();
        }

        #endregion
    }
}