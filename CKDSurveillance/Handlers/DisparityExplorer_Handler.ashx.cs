using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using ckdlibV2;
using System.Text;

namespace CKDSurveillance_RD.Handlers
{
    /// <summary>
    /// Summary description for DisparityExplorer_Handler
    /// </summary>
    public class DisparityExplorer_Handler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
             try
            {
                if (context.Request.Form["firststrat"] != null)
                {
                    ArborDataAccessV2 DAL = new ArborDataAccessV2();
                    DataTable dtTable = new DataTable("Table");
                    //string yr = getYear();
                    string yr = "";
                    int chartID = 998;


                    DataSet ds = null;
                    ds = DAL.getTableDisparities(chartID, yr);

                    int sigDigits = Convert.ToInt32(ds.Tables[0].Rows[0]["SignificantDigits"]);

                    DataTable dtChart = ds.Tables[1];

                    string formdatastr = context.Request.Form["firststrat"].ToString();
                    string firststrat = formdatastr.Substring(0, formdatastr.IndexOf("^secondstrat="));
                    string secondstrat = formdatastr.Substring(formdatastr.IndexOf("^secondstrat=") + 13, formdatastr.IndexOf("^thirdstrat=") - (formdatastr.IndexOf("^secondstrat=") + 13));
                    string thirdstrat = formdatastr.Substring(formdatastr.IndexOf("^thirdstrat=") + 12, formdatastr.IndexOf("^fourthstrat=") - (formdatastr.IndexOf("^thirdstrat=") + 12));
                    string fourthstrat = formdatastr.Substring(formdatastr.IndexOf("^fourthstrat=") + 13, formdatastr.IndexOf("^textfirststrat=") - (formdatastr.IndexOf("^fourthstrat=") + 13));
                    string firststrattext = formdatastr.Substring(formdatastr.IndexOf("^textfirststrat=") + 16, formdatastr.IndexOf("^textsecondstrat=") - (formdatastr.IndexOf("^textfirststrat=") + 16));
                    string secondstrattext = formdatastr.Substring(formdatastr.IndexOf("^textsecondstrat=") + 17, formdatastr.IndexOf("^textthirdstrat=") - (formdatastr.IndexOf("^textsecondstrat=") + 17));
                    string thirdstrattext = formdatastr.Substring(formdatastr.IndexOf("^textthirdstrat=") + 16, formdatastr.IndexOf("^textfourthstrat=") - (formdatastr.IndexOf("^textthirdstrat=") + 16));
                    string fourthstrattext = formdatastr.Substring(formdatastr.IndexOf("^textfourthstrat=") + 17, formdatastr.IndexOf("^colorselection=") - (formdatastr.IndexOf("^textfourthstrat=") + 17));
                    string colorselection = formdatastr.Substring(formdatastr.IndexOf("^colorselection=") + 16);

                    //if (fourthstrat != "")
                    //{
                    //    fourthstrat = firststrat + ", " + secondstrat + ", " + thirdstrat + ", " + fourthstrat;
                    //    thirdstrat = firststrat + ", " + secondstrat + ", " + thirdstrat;
                    //    secondstrat = firststrat + ", " + secondstrat;                           
                    //}
                    //else if (thirdstrat != "")
                    //{
                    //    thirdstrat = firststrat + ", " + secondstrat + ", " + thirdstrat;
                    //    secondstrat = firststrat + ", " + secondstrat;                           
                    //}
                    //else if (secondstrat != "")
                    //{
                    //    secondstrat = firststrat + ", " + secondstrat;  
                    //}

                    StringBuilder return_sb = buildPlotlyChart(dtChart, "", "", "Percentage per 100 population (percentage prevalence)", sigDigits, firststrat, secondstrat, thirdstrat, fourthstrat, firststrattext, secondstrattext, thirdstrattext, fourthstrattext, colorselection);
                    System.Web.HttpContext.Current.Response.Write(return_sb);
                }

            }
            catch (Exception ex)
            {
                System.Web.HttpContext.Current.Response.Write("error|9999|Could not retrieve submitted values|0");
            }            
        
        }

        private StringBuilder buildPlotlyChart(DataTable dtChart, string chartTitle, string xaxisTitle, string yaxisTitle, int sdig, string firststrat, string secondstrat, string thirdstrat, string fourthstrat, string firststrattext, string secondstrattext, string thirdstrattext, string fourthstrattext, string colortype)
        {

            //DataSet dsChart = DAL.getChart(Convert.ToInt32(chartID), yr, StratYear1.CurrentQuintileSettings);
            // DataSet dsChart = DAL.getChart(Convert.ToInt32(chartID), yr, quintileColorSetting);
            //DataTable dtChartHeader = dsChart.Tables[0];
            // DataTable dtChart_preSort = p_dtChart;
            // DataTable dtChart = datableReSort(dtChart_preSort, "Adjustments", "ASC");

            string color1 = "rgb(152,171,197)";
            string color2 = "rgb(176,229,124)";
            string color3 = "rgb(86,186,236)";

            if (colortype == "2")
            {
                color1 = "rgb(202,235,242)";
                color2 = "rgb(169,169,169)";
                color3 = "rgb(178,0,0)"; 
            }
            else if (colortype == "3")
            {
                color1 = "rgb(229,148,0)";
                color2 = "rgb(255,192,76)";
                color3 = "rgb(255,217,147)";
            }
            else if (colortype == "4")
            {
                color1 = "rgb(14,11,22)";
                color2 = "rgb(162,57,202)";
                color3 = "rgb(71,23,246)";
            }

            string hfval_x_nhw = "x:[";
            string hfval_y_nhw = "y:[";
            string hfval_x_nhw_empty = "x:[";
            string hfval_y_nhw_empty = "y:[";
            string high_confidence_nhw = "array:[";
            string low_confidence_nhw = "arrayminus:[";
            string hovertext_nhw = "text:[";

            string hfval_x_nhb = "x:[";
            string hfval_y_nhb = "y:[";
            string hfval_x_nhb_empty = "x:[";
            string hfval_y_nhb_empty = "y:[";
            string high_confidence_nhb = "array:[";
            string low_confidence_nhb = "arrayminus:[";
            string hovertext_nhb = "text:[";

            string hfval_x_oth = "x:[";
            string hfval_y_oth = "y:[";
            string hfval_x_oth_empty = "x:[";
            string hfval_y_oth_empty = "y:[";
            string high_confidence_oth = "array:[";
            string low_confidence_oth = "arrayminus:[";
            string hovertext_oth = "text:[";

            string plotlyGroups = "var data = [";

            StringBuilder plotlyStr = new StringBuilder();

            /*create data array logic*/

            string current_serieslabel = "";
            string theData = "";
            string charttype = "bar";

            //*************************************** Third Attempt

            theData = "[";
            int itemcount = 0;
            for (int i = 0; i <= dtChart.Rows.Count - 1; i++)
            {
                //string secondary = dtChart.Rows[i]["Secondary"].ToString();
                //string serieslabel = dtChart.Rows[i]["SeriesLabel"].ToString();
                string datapoint = "";
                string ehigh = "";
                string elow = "";

                current_serieslabel = dtChart.Rows[i]["Adjustments"].ToString();
                

                if (current_serieslabel == "Unadjusted" || current_serieslabel == firststrat || current_serieslabel == secondstrat || current_serieslabel == thirdstrat || current_serieslabel == fourthstrat)
                {
                    //current_serieslabel = current_serieslabel.Replace(",", "^");
                    string nhwhite = dtChart.Rows[i]["Non-Hispanic White"].ToString();
                    string nhblack = dtChart.Rows[i]["Non-Hispanic Black"].ToString();
                    string other = dtChart.Rows[i]["Other"].ToString();

                    string[] nhwhiteArray = nhwhite.Split('|');
                    string[] nhblackArray = nhblack.Split('|');
                    string[] otherArray = other.Split('|');

                    decimal nhwhite_high_con_diff = 0;
                    decimal nhwhite_low_con_diff = 0;
                    decimal nhblack_high_con_diff = 0;
                    decimal nhblack_low_con_diff = 0;
                    decimal other_high_con_diff = 0;
                    decimal other_low_con_diff = 0;

                    //decimals for drawing the error bars
                    nhwhite_high_con_diff = Convert.ToDecimal(nhwhiteArray[2]) - Convert.ToDecimal(nhwhiteArray[0]);
                    nhblack_high_con_diff = Convert.ToDecimal(nhblackArray[2]) - Convert.ToDecimal(nhblackArray[0]);
                    other_high_con_diff = Convert.ToDecimal(otherArray[2]) - Convert.ToDecimal(otherArray[0]);

                    nhwhite_low_con_diff = Convert.ToDecimal(nhwhiteArray[0]) - Convert.ToDecimal(nhwhiteArray[1]);
                    nhblack_low_con_diff = Convert.ToDecimal(nhblackArray[0]) - Convert.ToDecimal(nhblackArray[1]);
                    other_low_con_diff = Convert.ToDecimal(otherArray[0]) - Convert.ToDecimal(otherArray[1]);

                    //strings for the actual confidence values
                    string nhwhite_high_con_str = Convert.ToString(nhwhiteArray[2]);
                    string nhblack_high_con_str = Convert.ToString(nhblackArray[2]);
                    string other_high_con_str = Convert.ToString(otherArray[2]);

                    nhwhite_high_con_str = nhwhite_high_con_str.Substring(0, nhwhite_high_con_str.IndexOf(".") + 3);
                    nhblack_high_con_str = nhblack_high_con_str.Substring(0, nhblack_high_con_str.IndexOf(".") + 3);
                    other_high_con_str = other_high_con_str.Substring(0, other_high_con_str.IndexOf(".") + 3);

                    string nhwhite_low_con_str = Convert.ToString(nhwhiteArray[1]).Substring(0, 4);
                    string nhblack_low_con_str = Convert.ToString(nhblackArray[1]).Substring(0, 4);
                    string other_low_con_str = Convert.ToString(otherArray[1]).Substring(0, 4);

                    nhwhite_low_con_str = nhwhite_low_con_str.Substring(0, nhwhite_low_con_str.IndexOf(".") + 3);
                    nhblack_low_con_str = nhblack_low_con_str.Substring(0, nhblack_low_con_str.IndexOf(".") + 3);
                    other_low_con_str = other_low_con_str.Substring(0, other_low_con_str.IndexOf(".") + 3);

                    string adjustedseries = "";
                    if (current_serieslabel != "Unadjusted") 
                    {
                        if (fourthstrat != "" && current_serieslabel == fourthstrat)
                            adjustedseries = "Adjusted for " + firststrat + "," + secondstrattext + "," + thirdstrattext + "," + fourthstrattext;
                        else if (thirdstrat != "" && current_serieslabel == thirdstrat)
                            adjustedseries = "Adjusted for " + firststrat + "," + secondstrattext + "," + thirdstrattext;
                        else if (secondstrat != "" && current_serieslabel == secondstrat)
                            adjustedseries = "Adjusted for " + firststrat + "," + secondstrattext;
                        else if(current_serieslabel == firststrat)
                            adjustedseries = "Adjusted for " + firststrat;
                    }
                    else adjustedseries = current_serieslabel;

                    hfval_x_nhw = hfval_x_nhw + "'" + adjustedseries + "',"; //finding the 'column' value
                    hfval_y_nhw = hfval_y_nhw + "'" + nhwhiteArray[0] + "',"; //finding the actual data value
                    //hfval_x_nhw_empty = hfval_x_nhw_empty + "'" + adjustedseries + "',"; //finding the 'column' value for the empty
                    //hfval_y_nhw_empty = hfval_y_nhw_empty + "'0',"; //finding the actual data value for the empty
                    high_confidence_nhw = high_confidence_nhw + "'" + nhwhite_high_con_diff + "',"; //high confidence intervals
                    low_confidence_nhw = low_confidence_nhw + "'" + nhwhite_low_con_diff + "',"; //low confidence intervals
                    hovertext_nhw = hovertext_nhw + "'High:" + nhwhite_high_con_str + " - Low:" + nhwhite_low_con_str + "',";//hovertext 

                    hfval_x_nhb = hfval_x_nhb + "'" + adjustedseries + "',"; //finding the 'column' value
                    hfval_y_nhb = hfval_y_nhb + "'" + nhblackArray[0] + "',"; //finding the actual data value
                    //hfval_x_nhb_empty = hfval_x_nhb_empty + "'" + adjustedseries + "',"; //finding the 'column' value for the empty
                    //hfval_y_nhb_empty = hfval_y_nhb_empty + "'0',"; //finding the actual data value for the empty
                    high_confidence_nhb = high_confidence_nhb + "'" + nhblack_high_con_diff + "',"; //high confidence intervals
                    low_confidence_nhb = low_confidence_nhb + "'" + nhblack_low_con_diff + "',"; //low confidence intervals
                    hovertext_nhb = hovertext_nhb + "'High:" + nhblack_high_con_str + " - Low:" + nhblack_low_con_str + "',";//hovertext 

                    hfval_x_oth = hfval_x_oth + "'" + adjustedseries + "',"; //finding the 'column' value
                    hfval_y_oth = hfval_y_oth + "'" + otherArray[0] + "',"; //finding the actual data value
                    //hfval_x_oth_empty = hfval_x_oth_empty + "'" + adjustedseries + "',"; //finding the 'column' value for the empty
                    //hfval_y_oth_empty = hfval_y_oth_empty + "'0',"; //finding the actual data value for the empty
                    high_confidence_oth = high_confidence_oth + "'" + other_high_con_diff + "',"; //high confidence intervals
                    low_confidence_oth = low_confidence_oth + "'" + other_low_con_diff + "',"; //low confidence intervals
                    hovertext_oth = hovertext_oth + "'High:" + other_high_con_str + " - Low:" + other_low_con_str + "',";//hovertext 

                    itemcount++;
                }
            }


            while (itemcount < 5) //accounting for empty values so that the initial chart isn't so large
            {
                hfval_x_nhw = hfval_x_nhw + "'',"; 
                hfval_y_nhw = hfval_y_nhw + "'',"; 
                
                hfval_x_nhb = hfval_x_nhb + "'',"; 
                hfval_y_nhb = hfval_y_nhb + "'',"; 
                
                hfval_x_oth = hfval_x_oth + "'',"; 
                hfval_y_oth = hfval_y_oth + "'',";

                //hfval_x_nhw_empty = hfval_x_nhw_empty + "'',";
                //hfval_y_nhw_empty = hfval_y_nhw_empty + "'',";

                //hfval_x_nhb_empty = hfval_x_nhb_empty + "'',";
                //hfval_y_nhb_empty = hfval_y_nhb_empty + "'',";

                //hfval_x_oth_empty = hfval_x_oth_empty + "'',";
                //hfval_y_oth_empty = hfval_y_oth_empty + "'',"; 
                
                itemcount++;
            }

            string xData_col_final_nhw = hfval_x_nhw.Substring(0, hfval_x_nhw.Length - 1) + "]";//removing the last comma
            string yData_col_final_nhw = hfval_y_nhw.Substring(0, hfval_y_nhw.Length - 1) + "]";//removing the last comma
            //string xData_col_final_nhw_empty = hfval_x_nhw_empty.Substring(0, hfval_x_nhw_empty.Length - 1) + "]";//removing the last comma for the empty
            //string yData_col_final_nhw_empty = hfval_y_nhw_empty.Substring(0, hfval_y_nhw_empty.Length - 1) + "]";//removing the last comma for the empty
            string hiConData_col_final_nhw = high_confidence_nhw.Substring(0, high_confidence_nhw.Length - 1) + "]";//removing the last comma
            string loConData_col_final_nhw = low_confidence_nhw.Substring(0, low_confidence_nhw.Length - 1) + "]";//removing the last comma
            string hovertextData_final_nhw = hovertext_nhw.Substring(0, hovertext_nhw.Length - 1) + "]";//removing the last comma
            string finalDataString_nhw = " var dataNHW = {" + xData_col_final_nhw + " , " + yData_col_final_nhw + ", error_y: {type: 'data', symmetric: false, " + hiConData_col_final_nhw + " ," + loConData_col_final_nhw + "}, " + hovertextData_final_nhw + ", name: 'Non-Hispanic White', type: '" + charttype + "',marker: {color: '" + color1 + "' }};";
            //string finalDataString_nhw_empty = " var dataNHW_empty = {" + xData_col_final_nhw_empty + " , " + yData_col_final_nhw_empty + ", name: 'NHW_empty', type: '" + charttype + "',marker: {color: '" + color1 + "' }};";
            plotlyStr.Append(finalDataString_nhw); //appending the 'row' to the data name and adding the array data
            //plotlyStr.Append(finalDataString_nhw_empty); //appending the 'row' to the data name and adding the array data for the empty            


            string xData_col_final_nhb = hfval_x_nhb.Substring(0, hfval_x_nhb.Length - 1) + "]";//removing the last comma
            string yData_col_final_nhb = hfval_y_nhb.Substring(0, hfval_y_nhb.Length - 1) + "]";//removing the last comma
            //string xData_col_final_nhb_empty = hfval_x_nhb_empty.Substring(0, hfval_x_nhb_empty.Length - 1) + "]";//removing the last comma for the empty
            //string yData_col_final_nhb_empty = hfval_y_nhb_empty.Substring(0, hfval_y_nhb_empty.Length - 1) + "]";//removing the last comma for the empty
            string hiConData_col_final_nhb = high_confidence_nhb.Substring(0, high_confidence_nhb.Length - 1) + "]";//removing the last comma
            string loConData_col_final_nhb = low_confidence_nhb.Substring(0, low_confidence_nhb.Length - 1) + "]";//removing the last comma
            string hovertextData_final_nhb = hovertext_nhb.Substring(0, hovertext_nhb.Length - 1) + "]";//removing the last comma
            string finalDataString_nhb = " var dataNHB = {" + xData_col_final_nhb + " , " + yData_col_final_nhb + ", error_y: {type: 'data', symmetric: false, " + hiConData_col_final_nhb + " ," + loConData_col_final_nhb + "}, " + hovertextData_final_nhb + ", name: 'Non-Hispanic Black', type: '" + charttype + "',marker: {color: '" + color2 + "' }};";
            //string finalDataString_nhb_empty = " var dataNHB_empty = {" + xData_col_final_nhb_empty + " , " + yData_col_final_nhb_empty + ", name: 'NHB_empty', type: '" + charttype + "',marker: {color: '" + color2 + "' }};";
            plotlyStr.Append(finalDataString_nhb); //appending the 'row' to the data name and adding the array data
           // plotlyStr.Append(finalDataString_nhb_empty); //appending the 'row' to the data name and adding the array data for the empty            



            string xData_col_final_oth = hfval_x_oth.Substring(0, hfval_x_oth.Length - 1) + "]";//removing the last comma
            string yData_col_final_oth = hfval_y_oth.Substring(0, hfval_y_oth.Length - 1) + "]";//removing the last comma
            //string xData_col_final_oth_empty = hfval_x_oth_empty.Substring(0, hfval_x_oth_empty.Length - 1) + "]";//removing the last comma for the empty
            //string yData_col_final_oth_empty = hfval_y_oth_empty.Substring(0, hfval_y_oth_empty.Length - 1) + "]";//removing the last comma for the empty
            string hiConData_col_final_oth = high_confidence_oth.Substring(0, high_confidence_oth.Length - 1) + "]";//removing the last comma
            string loConData_col_final_oth = low_confidence_oth.Substring(0, low_confidence_oth.Length - 1) + "]";//removing the last comma
            string hovertextData_final_oth = hovertext_oth.Substring(0, hovertext_oth.Length - 1) + "]";//removing the last comma
            string finalDataString_oth = " var dataOTH = {" + xData_col_final_oth + " , " + yData_col_final_oth + ", error_y: {type: 'data', symmetric: false, " + hiConData_col_final_oth + " ," + loConData_col_final_oth + "}, " + hovertextData_final_oth + ", name: 'Other', type: '" + charttype + "',marker: {color: '" + color3 + "' }};"; //appending the 'row' to the data name and adding the array data
            //string finalDataString_oth_empty = " var dataOTH_empty = {" + xData_col_final_oth_empty + " , " + yData_col_final_oth_empty + ", name: 'OTH_empty', type: '" + charttype + "',marker: {color: '" + color3 + "' }};"; //appending the 'row' to the data name and adding the array data
            plotlyStr.Append(finalDataString_oth); //appending the 'row' to the data name and adding the array data
            //plotlyStr.Append(finalDataString_oth_empty); //appending the 'row' to the data name and adding the array data for the empty
            
            // plotlyGroups = plotlyGroups + "data" + cleanString(current_serieslabel) + ","; //adding the above data variable to the group variable


            //HF_D3Data.Value = theData;
            plotlyGroups = "var dataitems = [dataNHW, dataNHB, dataOTH];";
            //plotlyGroups = plotlyGroups + " var dataitems_empty = [dataNHW_empty, dataNHB_empty, dataOTH_empty];";

            plotlyStr.Append(plotlyGroups);
            return plotlyStr;
            /*end Create data array logic*/

            //createPlotlyScript(plotlyStr, chartTitle, xaxisTitle, yaxisTitle);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}