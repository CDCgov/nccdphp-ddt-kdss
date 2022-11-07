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
    public partial class FactorsOfInterestContent : System.Web.UI.UserControl
    {
        ArborDataAccessV2 DAL = new ArborDataAccessV2();

        protected void Page_Load(object sender, EventArgs e)
        {

            buildPageContent();

        }

        private void buildPageContent()
        {
           
            StringBuilder sb = new StringBuilder();

            //Get factor (e.g. age, race/ethnicity, diabetes, AKI
            string factor = Request.QueryString["type"];


            //Description
            Lit_Desc.Text = getDescription(factor);


            //*Get all Factors' topics*
            DataTable dtCategories = new DataTable("Categories");
            dtCategories = getCachedSpecialFactorTopics(factor);


            //Start the Accordion
            sb.Append("<div class=\"accordion indicator-plus accordion-white \" aria-multiselectable=\"true\" role=\"tabpanel\" >");

            int topicLoopcnt = 0;
            string topicLoopCountString = topicLoopcnt.ToString().Trim();
            int topicRowCnt = dtCategories.Rows.Count;

            foreach (DataRow dr in dtCategories.Rows)
            {
                string topicTitle = dr["QuestionText"].ToString().Trim();
                int topicID = ((int)(dr["QuestionID"]));
                string longDesc = dr["LongDesc"].ToString().Trim();

                //Get Measure and all Indicators for each Measure               
                string measureHTML = getMeasureHTML(topicID, factor, topicLoopCountString, topicTitle, longDesc);
                sb.Append(measureHTML);
               

                topicLoopcnt++;
                topicLoopCountString = topicLoopcnt.ToString().Trim();
            }

            sb.Append("</div>");

            //Populate the page
           Lit_IndicatorText.Text = sb.ToString().Trim();

        }
        private string getDescription(string factor)
        {
            DataTable dtFactors = DAL.getFactorsOfInterest(factor);
            string desc = dtFactors.Rows[0]["FactorDescription"].ToString().Trim();

            dtFactors.Dispose();
            dtFactors = null;

            return desc;
        }
        private string getMeasureHTML(int topicID, string factor, string topicLoopCountString, string topicText, string longDescription)
        {
            StringBuilder sb = new StringBuilder();


            //Get open of Title Card
            sb.Append(getOpenOfCard(topicLoopCountString, topicText, "topic"));


            //*Include Long Description*
            sb.Append("<div class='row'>");
            sb.Append("<div class='col-12' style='padding-bottom:15px; padding-top:10px; padding-left:30px; padding-right:30px;'>");
            sb.Append(longDescription);
            sb.Append("</div>");
            sb.Append("</div>");


            //Get Measures
            DataTable dtMeasures = new DataTable("Measures");
            dtMeasures = getCachedSpecialFactorsSubTopics(topicID.ToString(), factor);
            
            //sb.Append("<ul>");            
            int measureLoopCount = 0;
            string measureLoopCountString = "";

            foreach (DataRow mdr in dtMeasures.Rows)
            {
                string measureID = mdr["QuestionID"].ToString();
                string measureText = mdr["QuestionText"].ToString();

                //Build a unique ID
                measureLoopCountString = topicLoopCountString + measureLoopCount.ToString();

                //Indent the Measures slightly
                sb.Append("<div class='row'>");
                sb.Append("<div class='col-1'></div>");

                //Start new Measure
                sb.Append("<div class='col-11'>");
                sb.Append(getOpenOfCard(measureLoopCountString, measureText, "measure"));
              

                //Get Indicators for this Measure (Just returns a series of rows)
                string IndicatorHTML = getIndicatorHTML(Convert.ToInt32(measureID), factor, measureLoopCountString, measureText);
                sb.Append(IndicatorHTML);

                //Close the Topic Measure Level Card
                sb.Append(closeCard());


                //Close Measure column 
                sb.Append("</div>");
                
                //Close Measure Row
                sb.Append("</div>");
                             
                measureLoopCount++;
                measureLoopCountString = topicLoopCountString + measureLoopCount.ToString();
            }            


            //Close the Topic Level Card
            sb.Append(closeCard());            


            return sb.ToString().Trim();
        }
        private string getIndicatorHTML(Int32 measureID, string factor, string measureLoopCountString, string measureText)
        {
            StringBuilder sb = new StringBuilder();


            //*************************
            //*Loop Through Indicators*
            //*************************            
            DataTable dtIndicators = getCachedSpecialFactorsIndicators(measureID, factor);
            if(dtIndicators == null) { return ""; }
            if (dtIndicators.Rows.Count == 0) { return ""; }


            foreach (DataRow idr in dtIndicators.Rows)
            {
                //New Row
                sb.Append("<div class='row' style='padding-bottom:2px;'>");
                
                //Link to Indicator
                sb.Append("<div class='col-7' style='padding-left:20px;'>");
                sb.Append("<a href=\"" + idr["URL"].ToString().Replace("~/", "").Trim() + "\">");
                sb.Append(idr["QuestionText"].ToString().Trim());
                sb.Append("</a>");                
                sb.Append("</div>");


                //Most Recent Year
                sb.Append("<div class='col-2' style='text-align:center;'>");
                sb.Append(idr["Most Recent Year"].ToString().Trim());
                sb.Append("</div>");


                //Data Source
                sb.Append("<div class='col-3' style='text-align:center;'>");
                sb.Append(idr["DataSources"].ToString().Trim());
                sb.Append("</div>");

                //Close Row
                sb.Append("</div>");
            }            


            //Clean-up
            dtIndicators.Dispose();
            dtIndicators = null;


            return sb.ToString().Trim();
        }

        //Utilities
        private string getOpenOfCard(string LoopCountString, string Text,string cardType)
        {
            //background-color:#C8D5E4 !important;
            StringBuilder sb = new StringBuilder();


            //Begin card bar
            sb.Append("<div class=\"card bar\"");

            //Styling
            switch (cardType.ToLower().Trim())
            {
                case "topic":
                    sb.Append(" style='margin-bottom:5px;'>");
                    break;
                case "measure":
                    sb.Append(">");
                    break;
            }


            //Begin header MeasureText
            sb.Append("<div class=\"card-header collapsed\" id=\"accordion-4-card-" + LoopCountString + "\" data-target=\"#accordion-4-collapse-" + LoopCountString + "\" data-toggle=\"collapse\" role=\"tab\" aria-expanded=\"false\"");

            //Styling
            switch (cardType.ToLower().Trim())
            {
                case "topic":
                    sb.Append(" style='background-color:#C8D5E4 !important;'>");
                    break;
                case "measure":
                    sb.Append(" style='background-color:#E8EEE9 !important;'>");
                    break;                
            }            


            sb.Append("<a class=\"card-title\"  tabindex=\"0\"  data-controls=\"accordion-4-collapse-" + LoopCountString + "\">" + Text + "</a>");
            sb.Append("</div>");

            //Begin content panel
            sb.Append("<div aria-labelledby=\"accordion-4-card-" + LoopCountString + "\" class=\"collapse\" id=\"accordion-4-collapse-" + LoopCountString + "\" role=\"tabpanel\">");

            //Begin card body
            sb.Append("<div class=\"card body\"");


            //Add a left margin to indicators
            switch (cardType.ToLower().Trim())
            {
                case "topic":
                    sb.Append(" style='padding-left:20px;'>");
                    break;
                case "measure":
                sb.Append(" style='margin-bottom:5px;'>");
                    break;
            }            
            

            return sb.ToString().Trim();
        }
        private string closeCard()
        {

            StringBuilder sb = new StringBuilder();

            sb.Append("</div>"); //end card body
            sb.Append("</div>"); //end content Panel
            sb.Append("</div>"); //end card bar

            return sb.ToString().Trim();
        }

        #region Data Retrieval

        private DataTable getCachedSpecialFactorTopics(string factor)
        {
            DataTable tempAnswer = null;
            DataTable answer = null;

            if (Cache["specialFactorTopics"] == null)
            {
                //Age, Race/Ethnicity, Diabetes, Hypertension, AKI
                tempAnswer = getNewFactorTopicEntry("Age");
                tempAnswer.Merge(getNewFactorTopicEntry("Race/Ethnicity"));
                tempAnswer.Merge(getNewFactorTopicEntry("Diabetes"));
                tempAnswer.Merge(getNewFactorTopicEntry("Hypertension"));
                tempAnswer.Merge(getNewFactorTopicEntry("AKI"));
                tempAnswer.AcceptChanges();

                if (tempAnswer != null)
                {
                    Cache.Insert("specialFactorTopics", tempAnswer, null, DateTime.MaxValue, TimeSpan.FromDays(2));
                }

                tempAnswer.Dispose();
                tempAnswer = null;
            }

            //Get Existing Special Topics
            DataTable dtTemp = (DataTable)Cache["specialFactorTopics"];            
            answer = dtTemp.Select("factor='" + factor + "'").CopyToDataTable();

            //Clean-up
            dtTemp.Dispose();
            dtTemp = null;


            return answer;
        }
        private DataTable getNewFactorTopicEntry(string factor)
        {
            //Get Factor Titles from Database
            DataTable answer = null;
            answer = DAL.getAccordionSpecialFactorTopics(factor);


            //Add factor column
            DataColumn dc1 = new DataColumn("factor", typeof(string));
            answer.Columns.Add(dc1);
            answer.AcceptChanges();


            //Populate Factor Column
            foreach (DataRow dr in answer.Rows)
            {
                dr["factor"] = factor;
            }
            answer.AcceptChanges();


            //Send it back
            return answer;
        }
        private DataTable getCachedSpecialFactorsSubTopics(string categoryID, string factor)
        {
            //categoryID is topicID
            //factor is 'age', 'hypertension', etc.

            DataTable answer = null;
            DataTable tempAnswer = null;

            if (Cache["specialFactorMeasures"] == null)
            {
                tempAnswer = DAL.getSubTopicsSpecialFactors_ALL();
                Cache.Insert("specialFactorMeasures",tempAnswer, null, DateTime.MaxValue, TimeSpan.FromDays(2));
            }

            DataTable dtTemp = (DataTable)Cache["specialFactorMeasures"];
            answer = dtTemp.Select("TopicID=" + categoryID + " AND Factor='" + factor.Trim() + "'").CopyToDataTable();

            dtTemp.Dispose();
            dtTemp = null;

            return answer;
        }
        private DataTable getCachedSpecialFactorsIndicators(Int32 measureID, string factor)
        {
            DataTable answer = null;
            DataTable tempAnswer = null;

            if (Cache["specialFactorIndicators"] == null)
            {
                tempAnswer = DAL.getIndicatorsSpecialFactors(measureID, factor);


                //Add the factor column
                DataColumn col1 = new DataColumn("Factor", typeof(string));
                tempAnswer.Columns.Add(col1);
                tempAnswer.AcceptChanges();


                //Populate the new column
                foreach (DataRow dr in tempAnswer.Rows)
                {
                    dr["Factor"] = factor;
                }
                tempAnswer.AcceptChanges();

                Cache.Insert("specialFactorIndicators", tempAnswer, null, DateTime.MaxValue, TimeSpan.FromDays(2));
                answer = tempAnswer;
            }
            else
            {
                tempAnswer = (DataTable)Cache["specialFactorIndicators"];
                
                //Query for factor and measures)
                DataRow[] drFind = tempAnswer.Select("factor='" + factor + "' and ParentQuestionID=" + measureID);

                if (drFind.Length > 0)
                {
                    //Have this already
                    answer = drFind.CopyToDataTable();
                }
                else
                {
                    //Don't have - go get it
                    DataTable dtNewIndicators = DAL.getIndicatorsSpecialFactors(measureID, factor);

                    //Add the factor column
                    DataColumn col1 = new DataColumn("Factor", typeof(string));
                    dtNewIndicators.Columns.Add(col1);
                    dtNewIndicators.AcceptChanges();

                    //Populate it
                    foreach (DataRow dr in dtNewIndicators.Rows)
                    {
                        dr["Factor"] = factor;
                    }
                    dtNewIndicators.AcceptChanges();


                    //Add it the cache
                    tempAnswer.Merge(dtNewIndicators);
                    Cache["specialFactorIndicators"] = tempAnswer;

                    answer = dtNewIndicators;                    
                }

                //Clean-up
                drFind = null;
            }

            //DataTable dtTemp = (DataTable)Cache["specialFactorIndicators"];

            //DataRow[] drs = dtTemp.Select("ParentMeasureID=" + measureID + " AND Factor='" + factor.Trim() + "'");
            //if (drs.Length > 0)
            //{
            //    answer = drs.CopyToDataTable();
            //}
            //answer = dtTemp.Select("ParentMeasureID=" + measureID + " AND Factor='" + factor.Trim() + "'").CopyToDataTable();


            //Clean-up
            //drs = null;
            //dtTemp.Dispose();
            //dtTemp = null;

            tempAnswer.Dispose();
            tempAnswer = null;

            return answer;
        }
        #endregion
    }
}