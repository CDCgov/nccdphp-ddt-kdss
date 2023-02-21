using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Text.RegularExpressions;
using ckdlibV2;
using DocumentFormat.OpenXml.Spreadsheet;

namespace CKDSurveillance_RD
{
    public partial class SideNavHP : System.Web.UI.UserControl
    {
        public string IndicatorText;
        public string TopicSelected;
        ArborDataAccessV2 DAL = new ArborDataAccessV2();
        public string directoryPath;
        public bool isDetailpage = true;

        #region Properties

        public string QNum
        {
            get
            {
                object o = null;
                o = ViewState["QNum"];
                if (o != null)
                {
                    return Convert.ToString(o);
                }
                else
                {
                    return "";
                }
            }
            set { ViewState["QNum"] = value; }
        }
        public string TopicID
        {
            get
            {
                object o = null;
                o = ViewState["TopicID"];
                if (o != null)
                {
                    return Convert.ToString(o);
                }
                else
                {
                    return "";
                }
            }
            set { ViewState["TopicID"] = value; }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            string path = HttpContext.Current.Request.Url.AbsolutePath;
            if (path.ToLower().IndexOf("topichome") > -1) //trying to account for the additional folder level of the topichome pages
                directoryPath = "../";
            else
                directoryPath = "";

            if (path.ToLower().IndexOf("detail") == -1)
                Session["SelectedIndicator"] = "";


            //Is this a chart page? [affects decision to format a selected indicator]
            if (!path.ToLower().Contains("detail.aspx"))
            {
                isDetailpage = false;
            }

            //**************
            //*Get Topic ID*
            //**************            
            if (ViewState["TopicID"] != null)
            {
                TopicID = ViewState["TopicID"].ToString();
            }
            else if(Request.QueryString["topic"] != null)
            {
                TopicID = Request.QueryString["topic"].ToString().Trim();
            }
            //Set this in session for access by Methods page
            Session["TopicID"] = TopicID;

            //*************
            //*Get QNumber*
            //*************            
            if (Request.QueryString["QNum"] != null)
            {
                QNum = Request.QueryString["QNum"].ToString().Trim();
            }
            //Set this in session for access by Methods page
            Session["qnum"] = QNum;

            if (string.IsNullOrEmpty(TopicID) && string.IsNullOrEmpty(QNum))
                return;

            //*Get Topics*
            if (!string.IsNullOrEmpty(TopicID))
            {
                Int32 topicID = Convert.ToInt32(TopicID);
                DataTable dt = DAL.getTopic(topicID);

                string topicText = dt.Rows[0]["TopicText"].ToString();
                Lit_IndicatorText.Text = MethodsIndicatorsTableCreation(topicID, topicText);
            }
            else
            {
                DataTable dtTopicList = getCachedTopics();
                DataTable dtDetails = DAL.getQuestionDetails(QNum);

                //*Get measures/Indicators for each topic*
                foreach (DataRow dr in dtTopicList.Rows)
                {
                    Int32 topicID = Convert.ToInt32(dr["TopicID"]);
                    if (topicID == Convert.ToInt32(dtDetails.Rows[0]["TopicID"]))
                    {
                        DataTable dt = DAL.getTopic(topicID);

                        string topicText = dt.Rows[0]["TopicText"].ToString();
                        Lit_IndicatorText.Text = MethodsIndicatorsTableCreation(topicID, topicText);
                        break;
                    }
                }

                dtTopicList.Dispose();
                dtDetails.Dispose();
            }
            // *Clean-up*
            DAL = null;
        }
        private string MethodsIndicatorsTableCreation(int TopicID, string TopicText)
        {
            StringBuilder sbTable = new StringBuilder();

            //Start table HTML
            var href = "";
            switch (TopicText) {
                case "Prevalence and Incidence":
                    href = "/TopicHome/PrevalenceIncidence.aspx?topic=1";
                    break;
                case "Awareness":
                    href = "/TopicHome/Awareness.aspx?topic=3";
                    break;
                case "Risk Factors":
                    href = "/TopicHome/BurdenOfRiskFactors.aspx?topic=4";
                    break;
                case "Health Consequences":
                    href = "/TopicHome/HealthConsequences.aspx?topic=5";
                    break;
                case "Quality of Care":
                    href = "/TopicHome/QualityOfCare.aspx?topic=6";
                    break;
                case "Social Determinants of Health and Kidney Disease":
                    href = "/TopicHome/SocialDeterminantsOfHealth.aspx?topic=24";
                    break;
                default:
                    href = "/default.aspx";
                    break;
            }
            sbTable.Append("<div class=\"navBoldHeader nav-section-home d-sm-block\" aria-multiselectable=\"true\" role=\"tabpanel\" ><span><a style=\"color:#007C91;\" href='" + href +"'/>" + TopicText +"</a></span></div>");
            sbTable.Append("<div class=\"accordion indicator-plus accordion-white \" aria-multiselectable=\"true\" role=\"tabpanel\" >");

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

                //sbTable.Append("<div class=\"card bar\">"); //begin card bar

                //sbTable.Append("<div class=\"nav-section-home navSectionLinks navlist collapsed\" id=\"accordion-4-card-" + loopcnt.ToString() + "\" data-target=\"#accordion-4-collapse-" + loopcnt.ToString() + "\" data-toggle=\"collapse\" role=\"tab\" aria-expanded=\"false\">"); //begin header measureText
                //sbTable.Append("<a tabindex=\"0\"  data-controls=\"accordion-4-collapse-" + loopcnt.ToString() + "\">" + measureText + "<i class=\"fi cdc-icon-plus nav-plus nav-expandcollapse\"  style = \"float: right;\"  >" + " </i>" + "</a>");
                if (IsSelected(measureID)) {
                    sbTable.Append("<div class=\"nav-section-home navSectionLinks navlist\" id=\"accordion-4-card-" + loopcnt.ToString() + "\" data-target=\"#accordion-4-collapse-" + loopcnt.ToString() + "\" data-toggle=\"collapse\" role=\"tab\" aria-expanded=\"true\">"); //begin header measureText
                    sbTable.Append("<a style=\"display: inline;\" tabindex=\"0\"  id=\"accordion-title-" + loopcnt.ToString() + "\" title=\" " + measureText + "\" data-controls=\"accordion-4-collapse-" + loopcnt.ToString() + "\" >" + measureText + "<i class=\"fi cdc-icon-minus nav-minus\"  style = \"float: right;\" id=\"navplusicon\"  ></i></a>");
                    sbTable.Append("</div>");

                    sbTable.Append("<div aria-labelledby=\"accordion-4-card-" + loopcnt.ToString() + "\" class=\"collapse show\" id=\"accordion-4-collapse-" + loopcnt.ToString() + "\" role=\"tabpanel\">"); //begin content panel
                    sbTable.Append("<div >"); //begin card body    // class=\"card body
                                              //*Get Measure values*
                }
                else {
                    sbTable.Append("<div class=\"card-header nav-section-home navSectionLinks navlist collapsed\" id=\"accordion-4-card-" + loopcnt.ToString() + "\" data-target=\"#accordion-4-collapse-" + loopcnt.ToString() + "\" data-toggle=\"collapse\" role=\"tab\" aria-expanded=\"false\">"); //begin header measureText
                    sbTable.Append("<a style=\"display: inline;\" tabindex=\"0\"  id=\"accordion-title-" + loopcnt.ToString() + "\" title=\" " + measureText + "\" data-controls=\"accordion-4-collapse-" + loopcnt.ToString() + "\" >" + measureText + "<i class=\"fi cdc-icon-plus nav-\"  style = \"float: right;\" id=\"navplusicon\"  ></i></a>");
                    sbTable.Append("</div>");

                    sbTable.Append("<div aria-labelledby=\"accordion-4-card-" + loopcnt.ToString() + "\" class=\"collapse\" id=\"accordion-4-collapse-" + loopcnt.ToString() + "\" role=\"tabpanel\">"); //begin content panel
                    sbTable.Append("<div >"); //begin card body    // class=\"card body
                                              //*Get Measure values*
                }

                //adding the measure string below, moved 3/3/2017, BS

                //*Add Bulleted list of Indicator Links for this Measure*
                DataTable dtIndicators = DAL.getIndicatorsByMeasureID(measureID);

                //*Cycle through all indicators*
                StringBuilder sb_indTable = new StringBuilder();


                sbTable.Append("<div><ul style=\"margin-bottom:0px;\">");
                bool containsIndi = false;
                foreach (DataRow drInd in dtIndicators.Rows)
                {
                    // Build link
                    string linkStart = ("<a href=\"../detail.aspx?Qnum=" + (drInd["QNUM"].ToString().Trim() + "&topic="+ TopicID + "#refreshPosition\">"));
                    //string linkStart = ("<a href=\"../detail.aspx?Qnum=" + (drInd["QNUM"].ToString().Trim() + "#refreshPosition\" + \"#PIdivbody\" >"));
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
                            //sb_indTable.Append("<li class=\"nav-section-home navSectionSublinks navlist\" style='margin-left:25px;'>");
                            if (drInd["QNUM"].ToString().Trim() == QNum)
                            {
                                sb_indTable.Append("<li id=\"accordionSubNav-" + loopcnt.ToString() + "-" + text + "\" class=\"nav-section-home navSectionSublinks navlist selectedLink\" style='margin-left:25px;'>");
                                sbTable.Replace("navBoldHeader", "navNormalHeader");
                            }
                            else
                                sb_indTable.Append("<li id=\"accordionSubNav-" + loopcnt.ToString() + "-" + text + "\" class=\"nav-section-home navSectionSublinks navlist\" style='margin-left:25px;'>");
                            HF_TopicText.Value = TopicText;
                            containsIndi = true;
                        }
                        else
                        {
                            if (drInd["QNUM"].ToString().Trim() == QNum)
                            {
                                sb_indTable.Append("<li id=\"accordionSubNav-" + loopcnt.ToString() + "-" + text + "\" class=\"nav-section-home navSectionSublinks navlist selectedLink\" style='margin-left:25px;'>");
                                sbTable.Replace("navBoldHeader", "navNormalHeader");
                            }
                            else
                                sb_indTable.Append("<li id=\"accordionSubNav-" + loopcnt.ToString() + "-" + text + "\" class=\"nav-section-home navSectionSublinks navlist\" style='margin-left:25px;'>");
                        }
                    }
                    else
                    {
                        if (drInd["QNUM"].ToString().Trim() == QNum) { 
                            sb_indTable.Append("<li id=\"accordionSubNav-" + loopcnt.ToString() + "-" + text + "\" class=\"nav-section-home navSectionSublinks navlist selectedLink\" style='margin-left:25px;'>");
                            sbTable.Replace("navBoldHeader", "navNormalHeader");
                            linkStart = ("<a href=\"../detail.aspx?Qnum=" + (drInd["QNUM"].ToString().Trim() + "&topic=" + TopicID + "#refreshPosition\" class=\"selectedLink\">"));
                        }
                        else
                            sb_indTable.Append("<li id=\"accordionSubNav-" + loopcnt.ToString() + "-" + text + "\" class=\"nav-section-home navSectionSublinks navlist\" style='margin-left:25px;'>");
                    }

                    sb_indTable.Append(linkStart + text + linkEnd);

                    if (drInd["LiteratureInd"].ToString() == "1")
                    {
                        sb_indTable.Append("&nbsp;<img src='../images/bookicon.PNG' alt='Published literature or one-time analysis, ongoing surveillance not available' />");
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
                //sbTable.Append("</div>"); //end card bar

            }

            //if (containsLitInd)
            //    sbTable.Append("<div><img src='images/bookicon.PNG' alt='Published literature or one-time analysis, ongoing surveillance not available'/>=<span style='font-size:10px;'>Published literature or one-time analysis, ongoing surveillance not available</span></div>");
            //Close Table HTML
            sbTable.Append("</div>");


            //*Clean-up*
            dtMeasures.Dispose();


            return sbTable.ToString();
        }

        private bool IsSelected(int measureID)
        {
            DataTable dtIndicators = DAL.getIndicatorsByMeasureID(measureID);

            foreach (DataRow drInd in dtIndicators.Rows)
            {
                if (drInd["QNUM"].ToString().Trim() == QNum)
                    return true;
            }
            return false;
        }
        //private string MethodsIndicatorsTable_Options(int TopicID, string TopicText)
        //{
        //    StringBuilder sbTable = new StringBuilder();

        //    //Start table HTML
        //    if(TopicID == 24)
        //        sbTable.Append("<div class=\"col-12 menucolumn\" style=' margin-left:25px;' >");
        //    else
        //        sbTable.Append("<div class=\"col-4 menucolumn\" style=' margin-left:25px;' >");
        //    //DataTable dtMeasures = DAL.getMeasuresByTopicID(TopicID);
        //    DataTable dtMeasures = getCachedMeasuresByTopicID(TopicID);

        //    int loopcnt = 0;
        //    int rowcnt = dtMeasures.Rows.Count;
        //    int totalloops = 1;
        //    Decimal thirdofrow = Math.Round(Convert.ToDecimal(rowcnt / 3), MidpointRounding.AwayFromZero);
        //    if (rowcnt == 4 || rowcnt == 5 || rowcnt == 6)//accounting for small counts
        //        thirdofrow = 1;
        //    if (thirdofrow == 0) //if this check isn't in place the values are added to the second column to start
        //        thirdofrow = 1;
        //    bool containsLitInd = false;


        //    // *Get all Measures for this Topic
        //    foreach (DataRow dr in dtMeasures.Rows)
        //    {

        //        if (loopcnt == thirdofrow && totalloops < 3)//if we reach the last column, then we want to add the remaining measures/indicators to it.
        //        {
        //            totalloops++;//incrementing the total number of loops
        //            loopcnt = 0; //resetting the counter
        //            sbTable.Append("</div><div class='span1 menudivider' >&nbsp;</div><div class=\"col-4 menucolumn\" style='flex:7;' >");

        //            if (thirdofrow == 1 && (rowcnt == 4 || rowcnt == 5))
        //                thirdofrow = 2;//forcing the increase to account for 'Health Care System Capacity' formatting -- HARD CODE
        //        }
        //        //*Get Measure values*
        //        string measureText = dr["MeasureText"].ToString().Trim();
        //        int measureID = ((int)(dr["MeasureID"]));
        //        //adding the measure string below, moved 3/3/2017, BS

        //        //*Add Bulleted list of Indicator Links for this Measure*
        //        //DataTable dtIndicators = DAL.getIndicatorsByMeasureID(measureID);
        //        DataTable dtIndicators = getCachedIndicatorsByMeasureID(measureID);


        //        //*Cycle through all indicators*
        //        StringBuilder sb_indTable = new StringBuilder();



        //        bool containsIndi = false;
        //        foreach (DataRow drInd in dtIndicators.Rows)
        //        {
        //            // Build link
        //            string linkStart = ("<a href=\"" + directoryPath + "detail.aspx?Qnum=" + (drInd["QNUM"].ToString().Trim() + "#refreshPosition\">"));
        //            string text = drInd["IndicatorText"].ToString().Trim();
        //            string linkEnd = "</a>";

        //            //Compare IndicatorID instead? (ML 1/20/2020)
        //            string menuSelectedIndicatorID = "";
        //            if (Session["menuSelectedIndicatorID"] != null) { menuSelectedIndicatorID = Session["menuSelectedIndicatorID"].ToString().Trim(); }
        //            string pageSelectedIndicator = drInd["IndicatorID"].ToString().Trim();


        //            if (menuSelectedIndicatorID != "")
        //            {
        //                if (menuSelectedIndicatorID == pageSelectedIndicator)
        //                {
        //                    if (isDetailpage == true)
        //                    {
        //                        sb_indTable.Append("<li class='selectedIndicator'>");
        //                    }
        //                    else
        //                    {
        //                        sb_indTable.Append("<li>");
        //                    }
        //                    HF_TopicText.Value = TopicText;
        //                    containsIndi = true;

        //                }
        //                else
        //                    sb_indTable.Append("<li>");
        //            }
        //            else
        //                sb_indTable.Append("<li>");

        //            sb_indTable.Append(linkStart + text + linkEnd);

        //            if (drInd["LiteratureInd"].ToString() == "1")
        //            {
        //                sb_indTable.Append("<img runat='server' src='" + directoryPath + "images/bookicon.PNG' alt='Published literature or one-time analysis, ongoing surveillance not available' />");
        //                containsLitInd = true;
        //            }

        //            sb_indTable.Append("</li>");
        //        }

        //        string highlightclass_measure = "";
        //        string highlightclass_indicatorgroup = "";
        //        if (containsIndi)
        //        {
        //            highlightclass_measure = " selectedBackgroundMeasure";
        //            highlightclass_indicatorgroup = "selectedBackgroundIndicatorGroup";
        //        }


        //        sbTable.Append("<div class=\"MeasureTextTD" + highlightclass_measure + "\">" + measureText + "</div>"); //adding the measure, checking to see if the indicator is in the measure and if so, then adding a class to highlight it
        //        //Open the row and list
        //        sbTable.Append("<div class=\"IndicatorTD " + highlightclass_indicatorgroup + "\"><ul class=\"siteNavUL\">");

        //        sbTable.Append(sb_indTable); //adding the indicator links
        //        sbTable.Append("</ul></div>");
        //        //*Close the list and row*

        //        // *Clean-up*
        //        dtIndicators.Dispose();
        //        loopcnt++;

        //    }

        //    if (containsLitInd)
        //        sbTable.Append("<div><img runat='server' src='" + directoryPath + "images/bookicon.PNG' alt='Published literature or one-time analysis, ongoing surveillance not available'/>=<span style='font-size:10px;'>Published literature or one-time analysis, ongoing surveillance not available</span></div>");
        //    //Close Table HTML
        //    sbTable.Append("</div>");


        //    //*Clean-up*
        //    dtMeasures.Dispose();


        //    return sbTable.ToString();
        //}

        //private string MethodsIndicatorsTableMobile_Options(int TopicID, string TopicText)
        //{
        //    StringBuilder sbTable = new StringBuilder();
        //    string cardState = "collapsed";
        //    string divState = "";
        //    sbTable.Append("<div class=\"accordion indicator-plus accordion-white \" aria-multiselectable=\"true\" role=\"tabpanel\" >");

        //    sbTable.Append("<div class=\"card bar\" style=\"padding-top:10px;\">"); //begin card bar

        //    sbTable.Append("<div class=\"card-header " + cardState + "\" style=\"background-color:#1a7aa2 !important; color:#fff !important;\" id=\"accordion-4m-card-" + TopicID.ToString() + "-mobile\" data-target=\"#accordion-4m-collapse-" + TopicID.ToString() + "-mobile\" data-toggle=\"collapse\" role=\"tab\" aria-expanded=\"false\">"); //begin header measureText
        //    sbTable.Append("<a class=\"card-title\" tabindex=\"0\"  style=\"padding-right: 0px !important;  color:#fff !important;\"  data-controls=\"accordion-4m-collapse-" + TopicID.ToString() + "-mobile\">" + TopicText + "</a>");
        //    sbTable.Append("</div>");

        //    sbTable.Append("<div aria-labelledby=\"accordion-4m-card-" + TopicID.ToString() + "-mobile\" class=\"collapse " + divState + "\" id=\"accordion-4m-collapse-" + TopicID.ToString() + "-mobile\" role=\"tabpanel\">"); //begin content panel
        //    sbTable.Append("<div class=\"card body\">"); //begin card body
        //    sbTable.Append("<div class=\"row\">"); //begin content row            
        //    sbTable.Append("<div class=\"col-12\" style=\"padding-left:20px;\">"); //begin content col 12 center

        //    //topic home page link
        //    string TopicText_NoSpaces = TopicText;
        //    TopicText_NoSpaces = TopicText_NoSpaces.Replace(" and ", ""); //hardcode for the Prevalence and Incidence page. I didn't include in word 'and' in the name of the aspx page
        //    TopicText_NoSpaces = Regex.Replace(TopicText_NoSpaces, @"\s+", "");
        //    sbTable.Append("<div class=\"row TopicHomeDiv\" >"); //adding padding right so that the text lines up with the menu text
        //    sbTable.Append("<div class=\"TopicHomeTextTD\" style=\"padding-right: 30px !important;\" data-topicid=\"" + TopicID.ToString() + "\" data-topicpage=\"" + TopicText_NoSpaces + "\"> View " + TopicText + " Summary");

        //    sbTable.Append("</div>");
        //    sbTable.Append("</div>");
        //    //end topic home page link
        //    // Holds the html for the right panel

        //    //DataTable dtMeasures = DAL.getMeasuresByTopicID(TopicID);
        //    DataTable dtMeasures = getCachedMeasuresByTopicID(TopicID);

        //    int loopcnt = 0;
        //    int rowcnt = dtMeasures.Rows.Count;
        //    int totalloops = 1;

        //    bool containsLitInd = false;
        //    // *Get all Measures for this Topic
        //    foreach (DataRow dr in dtMeasures.Rows)
        //    {
        //        string measureText = dr["MeasureText"].ToString().Trim();
        //        int measureID = ((int)(dr["MeasureID"]));

        //        sbTable.Append("<div class=\"card bar\">"); //begin card bar

        //        sbTable.Append("<div class=\"card-header collapsed\" style=\"background-color:#C8D5E4  !important; color:#000 !important;\" id=\"accordion-4-card-" + TopicID.ToString() + measureID.ToString() + "\" data-target=\"#accordion-4-collapse-" + TopicID.ToString() + measureID.ToString() + "\" data-toggle=\"collapse\" role=\"tab\" aria-expanded=\"false\">"); //begin header measureText
        //        sbTable.Append("<a class=\"card-title\" tabindex=\"0\"  style=\"padding-right: 0px !important; color:#000 !important;\" data-controls=\"accordion-4-collapse-" + TopicID.ToString() + measureID.ToString() + "\">" + measureText + "</a>");
        //        sbTable.Append("</div>");

        //        sbTable.Append("<div aria-labelledby=\"accordion-4-card-" + TopicID.ToString() + measureID.ToString() + "\" class=\"collapse\" id=\"accordion-4-collapse-" + TopicID.ToString() + measureID.ToString() + "\" role=\"tabpanel\">"); //begin content panel
        //        sbTable.Append("<div class=\"card body\">"); //begin card body


        //        //*Get Measure values*


        //        //*Add Bulleted list of Indicator Links for this Measure*
        //        //DataTable dtIndicators = DAL.getIndicatorsByMeasureID(measureID);
        //        DataTable dtIndicators = getCachedIndicatorsByMeasureID(measureID);

        //        //*Cycle through all indicators*
        //        StringBuilder sb_indTable = new StringBuilder();


        //        sbTable.Append("<div><ul>");
        //        bool containsIndi = false;
        //        foreach (DataRow drInd in dtIndicators.Rows)
        //        {
        //            // Build link
        //            string linkStart = ("<a href=\"" + directoryPath + "detail.aspx?Qnum=" + (drInd["QNUM"].ToString().Trim() + "#refreshPosition\" >"));
        //            string text = drInd["IndicatorText"].ToString().Trim();
        //            string linkEnd = "</a>";

        //            string linkIndicatorTextCompare = drInd["IndicatorText"].ToString().Trim().ToLower();

        //            if (IndicatorText != null)
        //            {
        //                IndicatorText = IndicatorText.Trim().ToLower();

        //                if (IndicatorText == linkIndicatorTextCompare)//if the text matches, then add the appropriate highlight class
        //                {
        //                    sb_indTable.Append("<li style='margin-left:25px; text-align:left; padding-top:5px;'>");
        //                    HF_TopicText.Value = TopicText;
        //                    containsIndi = true;
        //                }
        //                else
        //                    sb_indTable.Append("<li style='margin-left:25px;  text-align:left; padding-top:5px;'>");
        //            }
        //            else
        //                sb_indTable.Append("<li style='margin-left:25px;  text-align:left; padding-top:5px;'>");

        //            sb_indTable.Append(linkStart + text + linkEnd);

        //            if (drInd["LiteratureInd"].ToString() == "1")
        //            {
        //                sb_indTable.Append("&nbsp;<img src='" + directoryPath + "images/bookicon.PNG' alt='Published literature or one-time analysis, ongoing surveillance not available' />");
        //                containsLitInd = true;
        //            }

        //            sb_indTable.Append("</li>");
        //        }


        //        sbTable.Append(sb_indTable); //adding the indicator links
        //        sbTable.Append("</ul></div>");
        //        //*Close the list and row*


        //        // *Clean-up*
        //        dtIndicators.Dispose();
        //        loopcnt++;

        //        sbTable.Append("</div>"); //end card body
        //        sbTable.Append("</div>"); //end content panel
        //        sbTable.Append("</div>"); //end card bar

        //    }

        //    if (containsLitInd)
        //        sbTable.Append("<div><img src='" + directoryPath + "images/bookicon.PNG' alt='Published literature or one-time analysis, ongoing surveillance not available'/>=<span style='font-size:10px;'>Published literature or one-time analysis, ongoing surveillance not available</span></div>");


        //    //Close Table HTML
        //    sbTable.Append("</div>"); //end content col 12 center
        //    sbTable.Append("</div>"); //end content row
        //    sbTable.Append("</div>"); //end card body
        //    sbTable.Append("</div>"); //end content panel
        //    sbTable.Append("</div>"); //end card bar
        //    sbTable.Append("</div>"); //end accordion 


        //    //*Clean-up*
        //    dtMeasures.Dispose();

        //    return sbTable.ToString().Trim();
        //}

        //private void populateDivs(int id, string tbl)
        //{
        //    DataSet ds = DAL.getIndicatorsByTopicID(id);
        //    if (ds != null)
        //    {
        //        Literal litDesc = null;
        //        Literal litIndicators = null;
        //        switch (id)
        //        {
        //            case 1:
        //                // litDesc = litPrevalenceDescription;
        //                litIndicators = litPrevalenceIndicators;
        //                break;
        //            case 3:
        //                //litDesc = litAwarenessDescription;
        //                litIndicators = litAwarenessIndicators;
        //                break;
        //            case 4:
        //                //litDesc = litBurdenDescription;
        //                litIndicators = litBurdenIndicators;
        //                break;
        //            case 5:
        //                //litDesc = litHealthConsequencesDescription;
        //                litIndicators = litHealthConsequencesIndicators;
        //                break;
        //            case 6:
        //                //litDesc = litProcessDescription;
        //                litIndicators = litQualityIndicators;
        //                break;
        //            case 24:
        //                //litDesc = litHealthSystemDescription;
        //                litIndicators = litSocialDeterminants;
        //                break;
        //        }


        //        //*Limited rows to only applicable MAIN topics (only 7 currently) [ exec proc_GetAccordionTopics 0,0 ]*
        //        string td = "";
        //        if (ds.Tables[0].Rows[0]["TopicDescription"] != null)
        //        {
        //            td = ds.Tables[0].Rows[0]["TopicDescription"].ToString().Trim();
        //        }
        //        //litDesc.Text = td;
        //        if (litIndicators != null) //fortify fix added 10/14/2020 for null dereference
        //            litIndicators.Text = tbl.Trim();
        //    }
        //}


        //**********************
        //*Mange Data Retrieval* // store it in the format desired by the page
        //**********************
        private DataTable getCachedTopics()
        {
            DataTable answer;

            if (Cache["topics"] == null)
            {
                answer = DAL.getTopics(0);
                if (answer != null)
                {
                    Cache.Insert("topics", answer, null, DateTime.MaxValue, TimeSpan.FromDays(2));
                }
            }
            else
            {
                answer = (DataTable)Cache["topics"];
            }

            return answer;
        }
        private DataTable getCachedMeasuresByTopicID(int topicID)
        {
            DataTable answer = null;

            if (Cache["measures"] == null)
            {
                //Get all topics
                DataTable topicIDs = getCachedTopics();

                //Populate all measures
                if (topicIDs != null)
                {
                    int cnt = 0;
                    foreach (DataRow dr in topicIDs.Rows)
                    {
                        if (cnt == 0)
                        {
                            if (dr["TopicID"] != null)
                            {
                                answer = DAL.getMeasuresByTopicID(Convert.ToInt32(dr["TopicID"]));
                                cnt++;
                            }
                        }
                        else
                        {
                            if (dr["TopicID"] != null)
                            {
                                DataTable dtMBT = DAL.getMeasuresByTopicID(Convert.ToInt32(dr["TopicID"]));
                                if (dtMBT != null)
                                {
                                    answer.Merge(dtMBT);
                                }

                                dtMBT.Dispose();
                                dtMBT = null;
                            }
                        }
                    }
                }

                //Clean up
                topicIDs.Dispose();

                //Add it to the cache object                
                if (answer != null)
                {
                    Cache.Insert("measures", (DataTable)answer, null, DateTime.MaxValue, TimeSpan.FromDays(2));
                }
            }


            //Always find the right set of Measures (first time or not)
            DataTable tempDT = (DataTable)Cache["measures"];
            DataView dv = tempDT.DefaultView;
            dv.RowFilter = "";
            if (topicID < 9999) //9999 means provide the entire table (supports cachedindicator retrieval)
            {
                dv.RowFilter = "TopicID=" + topicID;
            }
            answer = dv.ToTable();


            //Clean up            
            tempDT.Dispose();


            return answer;
        }
        private DataTable getCachedIndicatorsByMeasureID(int measureID)
        {
            DataTable answer = null;

            if (Cache["indicators"] == null)
            {
                List<int> lstMeasureIDs = new List<int>();
                DataTable measures = getCachedMeasuresByTopicID(9999);
                if (measures != null)
                {
                    foreach (DataRow dr in measures.Rows)
                    {
                        if (!lstMeasureIDs.Contains(Convert.ToInt32(dr["measureID"])))
                        {
                            lstMeasureIDs.Add(Convert.ToInt32(dr["measureID"]));
                        }
                    }


                    //Cycle through each measureID and store the Indicators information
                    int cnt = 0;
                    foreach (int i in lstMeasureIDs)
                    {
                        DataTable dt = DAL.getIndicatorsByMeasureID(i);

                        if (dt != null)
                        {
                            DataColumn dcMeasure = new DataColumn("MeasureID", typeof(Int32));
                            dt.Columns.Add(dcMeasure);

                            foreach (DataRow dr in dt.Rows)
                            {
                                dr["MeasureID"] = i;
                            }


                            //Only perform this task once
                            if (cnt == 0)
                            {
                                answer = dt;
                                cnt++;
                            }
                            else
                            {
                                if (dt != null)
                                {
                                    answer.Merge(dt);
                                }

                                dt.Dispose();
                                dt = null;
                            }
                        }
                    }
                }

                //Clean up
                lstMeasureIDs = null;
                measures.Dispose();

                //Add it to the cache object   
                if (answer != null)
                {
                    Cache.Insert("indicators", (DataTable)answer, null, DateTime.MaxValue, TimeSpan.FromDays(2));
                }
            }

            //**************************************
            //*Find the requested set of Indicators*
            //**************************************
            DataTable tempDT = (DataTable)Cache["indicators"];
            DataView dv = tempDT.DefaultView;
            dv.RowFilter = "measureID=" + measureID.ToString();
            answer = dv.ToTable();

            //Clean up            
            tempDT.Dispose();

            //Return answer
            return answer;
        }

    }
}