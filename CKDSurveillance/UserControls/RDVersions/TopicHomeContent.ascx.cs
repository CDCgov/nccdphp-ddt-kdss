using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Text.RegularExpressions;
using ckdlibV2;

namespace CKDSurveillance_RD.UserControls.RDVersions
{
    public partial class TopicHomeContent : System.Web.UI.UserControl
    {
        public int TopicID { get; set; }

        ArborDataAccessV2 DAL = new ArborDataAccessV2();
        public string IndicatorText;
        public string indicatorName;
        public string subDesc;
        public string Qnum_1;
        public string Strat_1;
        public string ChartType_1;
        public string Qnum_2;
        public string Strat_2;
        public string ChartType_2;
        public string Year_1 = "";
        public string Year_2 = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (TopicID.ToString().Length == 0)
                Response.Redirect("../default.aspx");

            DataTable dt = DAL.getTopic(TopicID);
            indicatorName = dt.Rows[0]["TopicText"].ToString();
            subDesc = dt.Rows[0]["TopicHomeDesc"].ToString();
            Qnum_1 = dt.Rows[0]["TopicHomeChart_1"].ToString();
            Strat_1 = dt.Rows[0]["TopicHomeStrat_1"].ToString();
            ChartType_1 = dt.Rows[0]["TopicHomeChartType_1"].ToString();
            Year_1 = dt.Rows[0]["TopicHomeChartYear_1"].ToString();

            Qnum_2 = dt.Rows[0]["TopicHomeChart_2"].ToString();
            Strat_2 = dt.Rows[0]["TopicHomeStrat_2"].ToString();
            ChartType_2 = dt.Rows[0]["TopicHomeChartType_2"].ToString();
            Year_2 = dt.Rows[0]["TopicHomeChartYear_2"].ToString();

            if (TopicID == 25) {
                createAYAPageContent();
            }
            else if (TopicID != 24)
            {
                //sdohimg1.Visible = false;
                //sdohimg2.Visible = false;
                createPageContent();
            }            
            else
            {
                //sdohimg1.Visible = true;
                //sdohimg2.Visible = true;
                createStaticPageContent();
            }
        }
        private void createAYAPageContent()
        {
            ayatop.Visible = true;
            hrline.Visible = false;

            HF_SmallChart1URL.Value = "detail.aspx?Qnum=" + Qnum_1 + "&Strat=" + Strat_1 + "&Year=" + Year_1;

            DataTable dtPage = DAL.getPage(Qnum_1).Tables[0];
            int chartID = determineChartID(dtPage, Year_1, Strat_1);
            buildChart(chartID.ToString(), dtPage, Year_1, Qnum_1, "1", ChartType_1); //Also retrieves titles

            HF_SmallChart2URL.Value = "detail.aspx?Qnum=" + Qnum_2 + "&Strat=" + Strat_2 + "&Year=" + Year_2;

            dtPage = DAL.getPage(Qnum_2).Tables[0];
            chartID = determineChartID(dtPage, Year_2, Strat_2);
            buildChart(chartID.ToString(), dtPage, Year_2, Qnum_2, "2", ChartType_2); //Also retrieves titles

            string tbl = MethodsIndicatorsTableCreation(TopicID, indicatorName);
            Lit_IndicatorText.Text = tbl;
            //Lit_TopicTitle.Text = indicatorName;
            HF_Topic.Value = indicatorName;
            Lit_Desc.Text = subDesc;

            string tblBody = AYAArchiveBodyTableCreation(TopicID, indicatorName);
            Lit_IndicatorBody.Text = tblBody;
        }

        private void createStaticPageContent() 
        {
            string tbl = MethodsIndicatorsTableCreation(TopicID, indicatorName);
            Lit_IndicatorText.Text = tbl;
            Lit_TopicTitle.Text = indicatorName;
            Lit_Desc.Text = subDesc;

            string tblBody = MethodsIndicatorsBodyTableCreation(TopicID, indicatorName);
            Lit_IndicatorBody.Text = tblBody;
        }
        private void createPageContent()
        {

            //string Main_QNum = "Q636";
            //string Main_URLYear = "2012";
            //string Main_URLStrat = "Age";

            ////***************
            ////*Get Page Data*l
            ////***************
            //DataTable dtPage = DAL.getPage(Main_QNum).Tables[0];


            ////**************
            ////*Manage Title*
            ////**************                
            //string topic = dtPage.Rows[0]["Topic"].ToString().Trim().ToLower();


            //***********************
            //*Determine The ChartID*
            //***********************            
            //int chartID = determineChartID(dtPage, Main_URLYear, Main_URLStrat);

            //************************
            //*Populate the Mega Menu*
            //************************
            //SiteNavigationRD2_Options.IndicatorText = dtPage.Rows[0]["Indicator"].ToString();


            //pnlPlotly.Visible = true;


            //*************
            //*Build Table*
            //*************
            //string addedHeader = "";
            //string titleNoFN = "";
            //if (Session["TableHeader"] != null) { addedHeader = Session["TableHeader"].ToString(); }
            //if (Session["TitleNoFN"] != null) { titleNoFN = Session["TitleNoFN"].ToString(); }



            //**********
            //*Clean Up*
            //**********
            // Session["TableHeader"] = null;
           // HF_ChartURL.Value = "detail.aspx?Qnum=" + Main_QNum + "&Strat=" + Main_URLStrat + "&Year=" + Main_URLYear;

            //buildChart(chartID.ToString(), dtPage, Main_URLYear, Main_QNum, "-1"); //Also retrieves titles

            //small 1 chart setup
            //string Main_QNum = "Q89";
            //string Main_URLYear = "2012";
            //string Main_URLStrat = "CKD Stage, Gender";

            HF_SmallChart1URL.Value = "detail.aspx?Qnum=" + Qnum_1 + "&Strat=" + Strat_1 + "&Year=" + Year_1;

            DataTable dtPage = DAL.getPage(Qnum_1).Tables[0];
            int chartID = determineChartID(dtPage, Year_1, Strat_1);
            buildChart(chartID.ToString(), dtPage, Year_1, Qnum_1, "1", ChartType_1); //Also retrieves titles

            //small 2 chart setup
            //Main_QNum = "Q94";
            //Main_URLYear = "Most Recent Years";
            //Main_URLStrat = "Year, Treatment";

            HF_SmallChart2URL.Value = "detail.aspx?Qnum=" + Qnum_2 + "&Strat=" + Strat_2 + "&Year=" + Year_2;

            dtPage = DAL.getPage(Qnum_2).Tables[0];
            chartID = determineChartID(dtPage, Year_2, Strat_2);
            buildChart(chartID.ToString(), dtPage, Year_2, Qnum_2, "2", ChartType_2); //Also retrieves titles

            //small 3 chart setup
           

            string tbl = MethodsIndicatorsTableCreation(TopicID, indicatorName);
            Lit_IndicatorText.Text = tbl;
            Lit_TopicTitle.Text = indicatorName;
            Lit_Desc.Text = subDesc;

            string tblBody = MethodsIndicatorsBodyTableCreation(TopicID, indicatorName);
            Lit_IndicatorBody.Text = tblBody;
        }

        private int determineChartID(DataTable dtPage, string yearparam, string stratparam)
        {

            int answer = 0;
            DataView dvFiltered = dtPage.DefaultView;


            //*Get values from the URL*
            string yrText = yearparam;
            string stratText = stratparam;

            //*take first row as default if empty*
            if (string.IsNullOrEmpty(yrText) && string.IsNullOrEmpty(stratText))
            {
                answer = Convert.ToInt32(dtPage.Rows[0]["chartID"]);
                return answer;
            }



            //**************
            //*Build Filter*
            //**************
            string filterText = "";
            if (!string.IsNullOrEmpty(stratText))
            {
                filterText = "ViewBy IN('" + stratText + "') ";
            }
            if (!string.IsNullOrEmpty(yrText) & !string.IsNullOrEmpty(stratText))
            {
                filterText += "AND Year IN('" + yrText + "')";
            }
            else if (!string.IsNullOrEmpty(yrText) & string.IsNullOrEmpty(stratText))
            {
                filterText = "Year IN('" + yrText + "')";
            }


            //*************
            //*FilterTable*
            //*************
            dvFiltered.RowFilter = filterText;


            //************************
            //*Grab Answer from Table*
            //************************
            DataTable dtAnswer = dvFiltered.ToTable();
            answer = Convert.ToInt32(dtAnswer.Rows[0]["chartID"]);



            //***************
            //*Return Answer*
            //***************
            return answer;

        }

        private void buildChart(string chartID, DataTable dtPage, string yearparam, string QNum, string chartdiv, string charttype)
        {
            //*Clean up*
            //Session["TableHeader"] = null;
            //*Get Page*
            ArborDataAccessV2 DAL = new ArborDataAccessV2();

            string quintileColorSetting = getQuintileColorSetting();

            //Only show the quintile range choices if this is a map
            //StratYear1.showQuintileColorRanges = false;
            //*Get ChartID*
            string yr = getYear();
            DataSet dsChart = DAL.getChart(Convert.ToInt32(chartID), yr, quintileColorSetting);
            DataTable dtChartHeader = dsChart.Tables[0];
            DataTable dtChart = dsChart.Tables[1];

            //Clean up the NA and *
            dtChart = cleanChartTable(dtChart);

            //DataView dv = dtChart.DefaultView;

            Session["TitleNoFN"] = dtChartHeader.Rows[0]["ChartHeader"].ToString();

            //added 1/22/2019 BS
            string chartShorttitleText = dsChart.Tables["Chart"].Rows[0]["IndicatorShortTitle"].ToString();
            
            string titletext = wrapText(dsChart.Tables[0].Rows[0]["ChartHeader"].ToString(), 100);
            string bypopulation = wrapText(dsChart.Tables[0].Rows[0]["ByPopulation"].ToString(), 100);
            if (bypopulation != "")
                bypopulation = "<br><b>" + bypopulation + "</b>";
            

            buildPlotlyChart(chartID.ToString(), dtPage, "<b>" + titletext + "</b>" + bypopulation, dsChart.Tables[0].Rows[0]["XAxisLabel"].ToString(), dsChart.Tables[0].Rows[0]["YAxisLabel"].ToString(), yearparam, chartdiv, charttype);

        }

        private void buildPlotlyChart(string chartID, DataTable dtPage, string chartTitle, string xaxisTitle, string yaxisTitle, string yr, string smallchart, string charttype)
        {
            string[] colorarray = new string[] { "#189BDC", "#b0e57c", "#98abc5", "#1f77b4", "#ffb456", "#7f7f7f", "#e377c2", "#8c564b", "#444444", "#ff6456", "#e4e51b", "#aa51ff", "#98CA32", "#9D0E01", "#EA3E88" };
            //*Get Page*
            ArborDataAccessV2 DAL = new ArborDataAccessV2();

            //*If this is a Map, it will have no records*
            if (dtPage.Rows.Count == 0)
                return;

            string quintileColorSetting = getQuintileColorSetting();


            //*Get ChartID*
            DataSet dsChart = DAL.getChart(Convert.ToInt32(chartID), yr, quintileColorSetting);

            DataTable dtChart_preSort = dsChart.Tables[1];
            DataTable dtChart = datableReSort(dtChart_preSort, "SeriesLabel", "ASC");

            int xaxis_cnt = 0;
            int max_xaxis_cnt = 0;
            string current_s_compare = "";
            for (int i = 0; i <= dtChart.Rows.Count - 1; i++)
            {
                string s_compare = dtChart.Rows[i]["SeriesLabel"].ToString();

                if (current_s_compare == "" || current_s_compare != s_compare)
                {
                    if (xaxis_cnt > max_xaxis_cnt)
                        max_xaxis_cnt = xaxis_cnt;

                    current_s_compare = s_compare;
                    xaxis_cnt = 1;//start the increment
                }
                else
                {
                    xaxis_cnt++;
                }
            }

            if (max_xaxis_cnt == 0) max_xaxis_cnt = xaxis_cnt; //if there is only one series, then set the max count to the xaxis count

            string hfval_x = "x:[ "; //starting the arrays and adding spaces to so that the last character parse below doesn't fail
            string hfval_y = "y:[ ";
            string high_confidence = "";
            string low_confidence = "";
            string hovertext = "";

            string plotlyGroups = "var data = [";

            StringBuilder plotlyStr = new StringBuilder();

            /*create data array logic*/

            string current_serieslabel = "";
            string theData = "";

            //*************************************** Third Attempt

            theData = "[ ";

            Regex regex = new Regex(@"[\d]");
            if (max_xaxis_cnt > 7) max_xaxis_cnt = 7;
            int wrapsize = 100 / max_xaxis_cnt;//finding the number of data points and wrapping the x-axis labels accordingly

            int colorarray_inc = 0;
            for (int i = 0; i <= dtChart.Rows.Count - 1; i++)
            {
                string secondary = dtChart.Rows[i]["Secondary"].ToString();
                secondary = wrapText(secondary, wrapsize);
                string serieslabel = dtChart.Rows[i]["SeriesLabel"].ToString();
                string datapoint = dtChart.Rows[i]["DataPoint"].ToString();
                string ehigh = dtChart.Rows[i]["HighConfidenceInterval"].ToString();
                string elow = dtChart.Rows[i]["LowConfidenceInterval"].ToString();
                serieslabel = serieslabel.Replace("&", "and"); //overridding the & so that the chart doesn't fail

                decimal high_con_diff = -1; //initial setup
                decimal low_con_diff = -1;

                datapoint = datapoint.Replace("*", "");

                if (!String.IsNullOrEmpty(datapoint))
                {
                    if (!String.IsNullOrEmpty(ehigh))
                        high_con_diff = Convert.ToDecimal(ehigh) - Convert.ToDecimal(datapoint);

                    if (!String.IsNullOrEmpty(elow))
                        low_con_diff = Convert.ToDecimal(datapoint) - Convert.ToDecimal(elow);
                }

                if (ehigh != "")
                    ehigh = ehigh.Substring(0, ehigh.IndexOf(".") + 3);
                if (elow != "")
                    elow = elow.Substring(0, elow.IndexOf(".") + 3);//showing only the two characters after the decimal

                string str_high_con_diff = ""; //setup the string variable to be displayed
                string str_low_con_diff = "";

                if (high_con_diff != -1)//if the high difference isn't -1 then display the difference, otherwise display an empty string
                    str_high_con_diff = high_con_diff.ToString();
                else
                    str_high_con_diff = "";

                if (low_con_diff != -1)//if the low difference isn't -1 then display the difference, otherwise display an empty string
                    str_low_con_diff = low_con_diff.ToString();
                else
                    str_low_con_diff = "";

                if (current_serieslabel == "" || current_serieslabel == serieslabel)
                {
                    hfval_x = hfval_x + "'" + secondary + "',"; //finding the 'column' value
                    hfval_y = hfval_y + "'" + datapoint + "',"; //finding the actual data value                  


                    high_confidence = high_confidence + "'" + str_high_con_diff + "',"; //high confidence intervals adding the string from above
                    low_confidence = low_confidence + "'" + str_low_con_diff + "',"; //low confidence intervals adding the string from above
                    hovertext = hovertext + "'High:" + ehigh + " - Low:" + elow + "',";//hovertext , adding the text value, though this maybe emptied out during the numeric check below

                    current_serieslabel = serieslabel;
                }
                else if (current_serieslabel != serieslabel)
                {
                    string xData_col = hfval_x.Substring(0, hfval_x.Length - 1) + "]";//removing the last comma
                    string yData_col = hfval_y.Substring(0, hfval_y.Length - 1) + "]";//removing the last comma

                    string hiConData_col = "";
                    string loConData_col = "";
                    string hovertextData = "";

                    if (regex.IsMatch(high_confidence) && regex.IsMatch(low_confidence)) //both have numeric values
                    {
                        hiConData_col = "array:[ " + high_confidence.Substring(0, high_confidence.Length - 1) + "]";
                        loConData_col = "arrayminus:[ " + low_confidence.Substring(0, low_confidence.Length - 1) + "]";
                        hovertextData = "text:[ " + hovertext.Substring(0, hovertext.Length - 1) + "]";
                    }
                    else
                    {
                        hiConData_col = "array:[ ]";
                        loConData_col = "arrayminus:[ ]";
                        hovertextData = "text:[ ]";
                    }



                    plotlyStr.Append(" var data" + cleanString(current_serieslabel) + " = {" + xData_col + " , " + yData_col);
                    if (!(hiConData_col == "array:[ ]" && loConData_col == "arrayminus:[ ]"))
                        plotlyStr.Append(", error_y: { visible: eval($('#hfShowCI').val()), type: 'data', color: '#222', thickness:1, symmetric: false, " + hiConData_col + " ," + loConData_col + "}," + hovertextData);

                    plotlyStr.Append(",  name: '" + current_serieslabel + "', type: '" + charttype + "', marker: {color: '" + colorarray[colorarray_inc] + "' }};"); //appending the 'row' to the data name and adding the array data

                    plotlyGroups = plotlyGroups + "data" + cleanString(current_serieslabel) + ","; //adding the above data variable to the group variable

                    hfval_x = "x:[ ";//resetting the arrays and adding spaces to so that the last character parse below doesn't fail
                    hfval_y = "y:[ ";
                    high_confidence = "";
                    low_confidence = "";
                    hovertext = "";
                    colorarray_inc++;

                    hfval_x = hfval_x + "'" + secondary + "',"; //finding the 'column' value
                    hfval_y = hfval_y + "'" + datapoint + "',"; //finding the actual data value


                    high_confidence = high_confidence + "'" + str_high_con_diff + "',"; //high confidence intervals adding the string from above
                    low_confidence = low_confidence + "'" + str_low_con_diff + "',"; //low confidence intervals adding the string from above
                    hovertext = hovertext + "'High:" + ehigh + " - Low:" + elow + "',";//hovertext , adding the text value, though this maybe emptied out during the numeric check below

                    current_serieslabel = serieslabel;
                }

            }

            string hiConData_col_final = "";//high_confidence.Substring(0, high_confidence.Length - 1) + "]";//removing the last comma
            string loConData_col_final = "";//low_confidence.Substring(0, low_confidence.Length - 1) + "]";//removing the last comma
            string hovertextData_final = "";//hovertext.Substring(0, hovertext.Length - 1) + "]";//removing the last comma


            if (regex.IsMatch(high_confidence) && regex.IsMatch(low_confidence)) //if both are numeric, then add all of the values to the array. This accounts for missing CIs
            {
                hiConData_col_final = "array:[ " + high_confidence.Substring(0, high_confidence.Length - 1) + "]";
                loConData_col_final = "arrayminus:[ " + low_confidence.Substring(0, low_confidence.Length - 1) + "]";
                hovertextData_final = "text:[ " + hovertext.Substring(0, hovertext.Length - 1) + "]";
            }
            else //otherwise don't display any values, this accounts for scenarios where there aren't CIs
            {
                hiConData_col_final = "array:[ ]";
                loConData_col_final = "arrayminus:[ ]";
                hovertextData_final = "text:[ ]";
            }

            string xData_col_final = hfval_x.Substring(0, hfval_x.Length - 1) + "]";//removing the last comma
            string yData_col_final = hfval_y.Substring(0, hfval_y.Length - 1) + "]";//removing the last comma


            plotlyStr.Append(" var data" + cleanString(current_serieslabel) + " = {" + xData_col_final + " , " + yData_col_final);
            if (hiConData_col_final != "array:[ ]" && loConData_col_final != "arrayminus:[ ]" && hovertextData_final != "text:[ ]") //if there are empty values, then don't display the hover text for the errors
                plotlyStr.Append(", error_y: {visible: eval($('#hfShowCI').val()), type: 'data', color: '#222', thickness:1, symmetric: false, " + hiConData_col_final + " ," + loConData_col_final + "}, " + hovertextData_final);

            plotlyStr.Append(", name: '" + current_serieslabel + "', type: '" + charttype + "', marker: {color: '" + colorarray[colorarray_inc] + "' }};"); //appending the 'row' to the data name and adding the array data

            plotlyGroups = plotlyGroups + "data" + cleanString(current_serieslabel) + ","; //adding the above data variable to the group variable


            //HF_D3Data.Value = theData;
            if (plotlyGroups == "var data = [")// if this variable hasn't been added to, then add the above chartdata
                plotlyGroups = plotlyGroups + "chartdata ";

            string dataGroups = plotlyGroups.Substring(0, plotlyGroups.Length - 1) + "];";//otherwise, close the array and add it to the plotly string

            plotlyStr.Append(dataGroups);
            /*end Create data array logic*/

            //if (smallchart == "-1")
            //    createPlotlyScript(plotlyStr, false, chartTitle, xaxisTitle, yaxisTitle, max_xaxis_cnt);
            //else
                createPlotlyScriptSmall(plotlyStr, false, chartTitle, xaxisTitle, yaxisTitle, max_xaxis_cnt, smallchart);

            //createPlotlyScriptSmall(plotlyStr, false, chartTitle, xaxisTitle, yaxisTitle, max_xaxis_cnt, "1");
            //createPlotlyScriptSmall(plotlyStr, false, chartTitle, xaxisTitle, yaxisTitle, max_xaxis_cnt, "2");
            //createPlotlyScriptSmall(plotlyStr, false, chartTitle, xaxisTitle, yaxisTitle, max_xaxis_cnt, "3");
        }

        protected string wrapText(string p_str, int startsize)
        {
            string retstr = "";
            int maxloop = 3;

            if (p_str.Length > startsize && p_str.IndexOf(' ') > -1)
            {
                //retstr = p_title.Substring(0, 80) + "<br>" + p_title.Substring(80, p_title.Length - 80);
                string startString = p_str.Substring(0, startsize);
                int index = startString.LastIndexOf(' ');

                string remainingstr = p_str.Substring(index, p_str.Length - index).Trim();
                retstr = startString.Substring(0, index);
                if (remainingstr.Length > startsize)
                {
                    int whileloopcnt = 0;
                    while (remainingstr.Length > startsize)
                    {
                        whileloopcnt++;
                        if (maxloop == whileloopcnt)
                            break;

                        string str = remainingstr.Substring(0, startsize);
                        int sindex = str.LastIndexOf(' ');
                        if (sindex == -1)//no more spaces in the string limited by size
                        {
                            if (remainingstr.LastIndexOf(' ') != -1)//check to make sure that there aren't any more spaces at all
                            {
                                sindex = remainingstr.LastIndexOf(' ');
                                str = remainingstr;
                            }
                            else
                                break;
                        }
                        retstr = retstr + "<br>" + str.Substring(0, sindex).Trim();
                        remainingstr = remainingstr.Substring(sindex); //starting the remaining string off at the last space determined above
                    }

                    retstr = retstr + "<br>" + remainingstr.Trim();
                }
                else
                {
                    retstr = retstr + "<br>" + p_str.Substring(index, p_str.Length - index).Trim();
                }

            }
            else
                retstr = p_str;
            return retstr;
        }

        private void createPlotlyScriptSmall(StringBuilder dataSb, bool isMapChart, string title, string xaxistitle, string yaxistitle, int xaxiscnt, string smallpnl)
        {
            string xtickfontsize = "10";
            string tickangle = "0";

            if (xaxiscnt >= 7)
            {
                xtickfontsize = "9";
                tickangle = "10";
            }

            StringBuilder sb = new StringBuilder();
            sb.Append("<script>");
            sb.Append(" $(function() { createPlotlyChart" + smallpnl + "(); });");
            sb.Append(" function createPlotlyChart" + smallpnl + "()  {");
            sb.Append(" var d3_small" + smallpnl + " = Plotly.d3;");
            // sb.Append(" var img_jpg= d3.select('#jpg-export');");
            sb.Append(" var WIDTH_IN_PERCENT_OF_PARENT = 100, HEIGHT_IN_PERCENT_OF_PARENT = 150;");
            //sb.Append(" var hfdata = {" + xData + " , " + yData + ", name: 'Data', type: 'bar'};");
            //sb.Append(" var data = [hfdata];");
            sb.Append(dataSb);
            sb.Append(" var img_png= d3_small" + smallpnl + ".select('#png-export" + smallpnl + "'); ");

            sb.Append(" var layout = {autosize:true,showlegend: false, width:400, height: 400,  margin: {l: 40,r: 40,b: 60,t: 60} ");
            //sb.Append(" ,images: [{  x: 0.17, y: 1.09, sizex: 0.3, sizey: 0.3, 'opacity': 0.6,");
            //sb.Append(" source: 'images/graphic_identifier.png', ");
            //sb.Append(" xanchor: 'right', xref: '0', yanchor: 'bottom', yref: '0' }] ");

            if (isMapChart)
            {

                sb.Append(" , annotations: [{ x: 0, y: 1.1, sizex: 1, sizey: 1, yref: 'paper', xref: 'paper', align: 'left', text: '" + title + "',showarrow: false }], geo: { scope: 'usa'}};");
            }
            else
            {
                sb.Append(" ,annotations: [{ x: 0.2, y: 1.1, xshift: -70, yref: 'paper', xref: 'paper', align: 'left', text: '" + title + "',showarrow: false,  font: { size: 10 }}],");
                sb.Append("  barmode: 'group', hovermode: 'closest',hoverinfo: 'none', xaxis: { type:'category', tickangle:" + tickangle + ", tickfont: { size: 6 }, linecolor:'#bdbdbd', title:'<b>" + xaxistitle + "</b>', titlefont: { size: 6 }},yaxis: {xshift: -70, linecolor:'#bdbdbd', tickfont: { size: 6 }, title:'<b>" + yaxistitle + "</b>', titlefont: { size: 6 } }};");
            }
            sb.Append(" var gd4" + smallpnl + " = d3_small" + smallpnl + ".select('#svgchart_small" + smallpnl + "');");
            //    .style({");
            //sb.Append(" width: WIDTH_IN_PERCENT_OF_PARENT + '%', 'margin-left': (100 - WIDTH_IN_PERCENT_OF_PARENT) / 2 + '%',");
            //sb.Append(" height: HEIGHT_IN_PERCENT_OF_PARENT + 'vh' ");
            //sb.Append("});");
            sb.Append("var graphdiv_small" + smallpnl + " = gd4" + smallpnl + ".node();");

            String titleNoFN = "chartimage";
            //if (Session["TitleNoFN"] != null)
            //{
            //    titleNoFN = "Chart_" + Session["TitleNoFN"].ToString().Replace(" ", "_").Trim();
            //}

            //if (isIEorEdge)
            //    sb.Append("Plotly.newPlot(graphdiv_small" + smallpnl + ", data, layout,{staticPlot:true, responsive:true, displayModeBar: true, modeBarButtonsToRemove: ['toImage','sendDataToCloud', 'lasso2d', 'select2d', 'toggleSpikelines'] , modeBarButtonsToAdd: [{ name: 'Download Chart as SVG', icon: Plotly.Icons.camera, click: function(gd) { Plotly.downloadImage(gd,{format:'svg',height:700,width:900, filename: '" + titleNoFN + "'}) }}]");//sb.Append("Plotly.newPlot(graphdiv, data, layout,{displayModeBar: true, modeBarButtonsToRemove: ['sendDataToCloud']");
            //else
                sb.Append("Plotly.newPlot(graphdiv_small" + smallpnl + ", data, layout,{staticPlot:true, responsive:true, displayModeBar: false, modeBarButtonsToRemove: ['toImage','sendDataToCloud', 'lasso2d', 'select2d', 'toggleSpikelines'] , modeBarButtonsToAdd: [{ name: 'Download Chart as PNG', icon: Plotly.Icons.camera, click: function(gd) { Plotly.downloadImage(gd,{format:'png',height:700,width:900, filename: '" + titleNoFN + "'}) }}]");
            //sb.Append("Plotly.newPlot(graphdiv, data, layout,{displayModeBar: true, modeBarButtonsToRemove: ['toImage','sendDataToCloud'] , modeBarButtonsToAdd: [{ name: 'Download Chart as PNG', icon: Plotly.Icons.camera, click: function(gd) { Plotly.downloadImage(gd,{format:'png',height:650,width:800, filename: '" + titleNoFN + "'}) }}]");
            //sb.Append("Plotly.newPlot(graphdiv, data, layout,{displayModeBar: true, modeBarButtonsToRemove: ['toImage','sendDataToCloud'] , modeBarButtonsToAdd: [{ name: 'Download Chart as PNG', icon: Plotly.Icons.camera, click: function(gd) {  Plotly.toImage(gd,{height:700,width:900}).then(function(url) { img_png.attr('src', url); return Plotly.toImage(gd,{format:'png',height:650,width:800}); }) }}]");


            //sb.Append(" modeBarButtonsToAdd: [{ name: 'Download chart', icon: Plotly.Icons.camera, ");
            //if (isIEorEdge)
            //    sb.Append(" click: function () { exportforIE();}");
            //else
            //    sb.Append(" click: function (gd) { Plotly.downloadImage(graphdiv, { format: 'png', width: gd._fullLayout.width, height: gd._fullLayout.height }) }");
            sb.Append(" });");//}]



            //,modeBarButtonsToRemove: ['toImage', 'sendDataToCloud'], modeBarButtonsToAdd: [{ name: 'Download chart as a png', icon: Plotly.Icons.camera,");
            //sb.Append("click: function (gd) {Plotly.downloadImage(graphdiv, { format: 'png', width: gd._fullLayout.width, height: gd._fullLayout.height })}");
            //sb.Append("}]});");

            sb.Append("");
            sb.Append("window.onresize = function(){ Plotly.Plots.resize(graphdiv_small" + smallpnl + "); }");
            sb.Append("}");
            sb.Append("</script>");

            title = title.Replace("<br>", ", ").Replace("<b>", "").Replace("</b>", "");

            if (smallpnl == "1")
            {
                //this.Lit_Plotly_small1.Text = sb.ToString();
                HF_SmallChart1Hover.Value = title;
            }
            else if (smallpnl == "2")
            {
                //this.Lit_Plotly_small2.Text = sb.ToString();
                HF_SmallChart2Hover.Value = title;
            }
        }

        protected string cleanString(string pstr)
        {
            string retstr = pstr;
            //retstr = retstr.Replace("-", "");
            //retstr = retstr.Replace("/", "");
            //retstr = retstr.Replace("\u2013", ""); //replacing a variations of hyphens and em dashes
            //retstr = retstr.Replace("\u2014", "");
            //retstr = retstr.Replace("\u2015", "");
            //retstr = retstr.Replace(" ", "");// replacing 
            Regex rgx = new Regex("[^a-zA-Z0-9]");
            retstr = rgx.Replace(retstr, "");
            return retstr;
        }

        private DataTable cleanChartTable(DataTable dtCharts)
        {
            DataTable answer = null;

            foreach (DataRow dr in dtCharts.Rows)
            {
                if (dr["DataPoint"].ToString().ToLower() == "na" || dr["DataPoint"].ToString().ToLower() == "*")
                {
                    dr["DataPoint"] = 0;
                }
            }

            answer = dtCharts;

            return answer;
        }

        private string MethodsIndicatorsTableCreation(int TopicID, string TopicText)
        {
            StringBuilder sbTable = new StringBuilder();

            // Holds the html for the right panel


            //<div class="span8 col-xs-4 col-sm-4">Awareness 1 with very long text that hopefully will wrap around within the div tags</div>
            //      <div class="span8 col-xs-4 col-sm-4">Awareness 2 and additionally long text which is still going to wrap around the div I hope</div>
            //      <div class="span8 col-xs-4 col-sm-4">Awareness 3, the final component of text that wraps around again with much hope!!!!!!!!</div>

            //Start table HTML
            sbTable.Append("<div class=\"accordion indicator-plus accordion-white \" role=\"tabpanel\" >");
            
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

                //sbTable.Append("<div class=\"nav-section-home PInavSectionLinks navlist collapsed\" id=\"accordion-4-card-" + loopcnt.ToString() + "\" data-target=\"#accordion-4-collapse-" + loopcnt.ToString() + "\" data-toggle=\"collapse\" role=\"tab\" aria-expanded=\"false\">"); //begin header measureText
                //sbTable.Append("<a tabindex=\"0\"  data-controls=\"accordion-4-collapse-" + loopcnt.ToString() + "\">" + measureText + "<i class=\"fi cdc-icon-plus nav-plus nav-expandcollapse\"  style = \"float: right;\"  >" + " </i>" + "</a>");    

                sbTable.Append("<div  onclick =\"navClick()\" class=\"nav-section-home PInavSectionLinks navlist collapsed\" id=\"accordion-4-card-" + loopcnt.ToString() + "\" data-target=\"#accordion-4-collapse-" + loopcnt.ToString() + "\" data-toggle=\"collapse\" role=\"tab\" aria-expanded=\"false\">"); //begin header measureText
                sbTable.Append("<a tabindex=\"0\"  id=\"accordion-title-" + loopcnt.ToString() + "\" title=\" " + measureText + "\" data-controls=\"accordion-4-collapse-" + loopcnt.ToString() + "\" >" + measureText + "<i class=\"fi cdc-icon-plus nav-plus nav-expandcollapse\"  style = \"float: right;\" id=\"th-navplusicon\"  > " + " </i>" + "</a>");
                sbTable.Append("</div>");

                sbTable.Append("<div aria-labelledby=\"accordion-4-card-" + loopcnt.ToString() + "\" class=\"collapse\" id=\"accordion-4-collapse-" + loopcnt.ToString() + "\" role=\"tabpanel\">"); //begin content panel
                sbTable.Append("<div >"); //begin card body    // class=\"card body
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
                    //string linkStart = ("<a href=\"../detail.aspx?Qnum=" + (drInd["QNUM"].ToString().Trim() + "#refreshPosition\">"));
                    string linkStart = ("<a href=\"../detail.aspx?Qnum=" + (drInd["QNUM"].ToString().Trim() + "#refreshPosition\" + \"#PIdivbody\" >"));
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
                            //sb_indTable.Append("<li class=\"nav-section-home PInavSectionSublinks navlist\" style='margin-left:25px;'>");
                            sb_indTable.Append("<li id=\"accordionSubNav-" + loopcnt.ToString() + "-" + text + "\" class=\"nav-section-home PInavSectionSublinks navlist\" style='margin-left:25px;'>");
                            HF_HC_TopicText.Value = TopicText;
                            containsIndi = true;
                        }
                        else
                            //sb_indTable.Append("<li class=\"nav-section-home PInavSectionSublinks navlist\" style='margin-left:25px;'>");
                            sb_indTable.Append("<li id=\"accordionSubNav-" + loopcnt.ToString() + "-" + text + "\" class=\"nav-section-home PInavSectionSublinks navlist\" style='margin-left:25px;'>");
                    }
                    else
                        //sb_indTable.Append("<li class=\"nav-section-home PInavSectionSublinks navlist\" style='margin-left:25px;'>");
                        sb_indTable.Append("<li id=\"accordionSubNav-" + loopcnt.ToString() + "-" + text + "\" class=\"nav-section-home PInavSectionSublinks navlist\" style='margin-left:25px;'>");

                    sb_indTable.Append(linkStart + text + linkEnd);

                    if (drInd["LiteratureInd"].ToString() == "1")
                    {
                        sb_indTable.Append("&nbsp;<img src='/ckd/images/bookicon.PNG' alt='Published literature or one-time analysis, ongoing surveillance not available' />");
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

        private string AYAArchiveBodyTableCreation(int TopicID, string TopicText)
        {
            StringBuilder sbBodyTable = new StringBuilder();
            StringBuilder sbTables = new StringBuilder();

            sbTables.Append("<div class=\"div-table\" >");
            DataTable dtAYA = DAL.get_AYA_Entries_for_FP_Widget();

            int rowNum = 1;
            // *Get all active AYA archives
           
            StringBuilder sb_indTable = new StringBuilder();

            foreach (DataRow drAYA in dtAYA.Rows)
            {
                string title = drAYA["Title"].ToString().Trim();
                string date = drAYA["tickerDate"].ToString().Trim();
                string desc = drAYA["ShortDescription"].ToString().Trim();
                string topicText = drAYA["TopicText"].ToString().Trim();
                string ayaLink = drAYA["AYALink"].ToString().Trim();
                string topicHomePageURL = drAYA["TopicHomePageURL"].ToString().Trim();
                string linkStart = ("<a style=\"text-align: left; font-family: Open Sans; font-size: 24px; letter-spacing: 0px; color: #007C91; opacity: 1; text-decoration:none; \" target=\"_blank\" aria-label=\"Go to " + date + " article: " + title + "\"  href=" + ayaLink + ">");
                string linkEnd = "</a>";
                string topicURL = ("<a style=\"text-align: left; font-family: Open Sans; font-size: 16px; letter-spacing: 0px; opacity: 1; padding-left:5px;padding-right:5px;border-radius: 18px; border: 1px solid #D3D3D3 ; text-decoration:none; color: #000000 !important;background-color: #E5E4E2; \"  target=\"_blank\" href=" + topicHomePageURL + ">");

                if (rowNum == 1)
                {                    
                    string ayaCurrentImg = drAYA["AYACurrentImg"].ToString().Trim();
                    string ayaCurrentImg1 = "CurrentAYA-a.png";
                    string ayaCurrentImg2 = "CurrentAYA-b.png";
                    sbBodyTable.Append("<div class=\"div-table-row\" style=\"background-color: #EBF5F6;\">");
                    sbBodyTable.Append("<div style=\"font-size: 26px;font-weight: 400; padding-left: 5%; padding-top:20px; \">Latest Spotlight</div>");
                    if (date.IndexOf("June 2024") >= 0)
                    {
                        sbBodyTable.Append("<div style=\"padding-left: 10px; padding-bottom: 10px; display: grid;\">");
                        sbBodyTable.Append("<img src=\"../AYA/images/" + ayaCurrentImg + "\" style=\"margin-left:5%; width:80%; margin-top:5%; \"/>");
                    }
                    else if (date.IndexOf("August 2024") >= 0)
                    {
                        //sbBodyTable.Append("<div style=\"padding-left: 10px; padding-bottom: 10px; display: grid;\">");
                        //sbBodyTable.Append("<img src=\"../AYA/images/" + ayaCurrentImg + "\" style=\"margin-left:5%; margin-top:5%; \" alt=\"Chart: Adults with Recommended Potassium Intake (%); \"/>");
                        sbBodyTable.Append("<div style=\"padding-left: 10px; padding-bottom: 10px; \">");
                        sbBodyTable.Append("<img src=\"../AYA/images/" + ayaCurrentImg1 + "\" style=\"margin-left:5%; margin-top:5%; \" alt=\"Chart: Adults with Recommended Sodium Intake (%); \" /> <img src =\"../AYA/images/" + ayaCurrentImg2 + "\" style=\"margin-left:1%; margin-top:5%; \" alt=\"Chart: Adults with Recommended Potassium Intake (%); \" />");
                    }
                    else if (date.IndexOf("October 2024") >= 0)
                    {
                        //sbBodyTable.Append("<div style=\"padding-left: 10px; padding-bottom: 10px; display: grid;\">");
                        //sbBodyTable.Append("<img src=\"../AYA/images/" + ayaCurrentImg + "\" style=\"margin-left:5%; margin-top:5%; \" alt=\"Chart: Adults with Recommended Potassium Intake (%); \"/>");
                        sbBodyTable.Append("<div style=\"padding-left: 10px; padding-bottom: 10px; \">");
                        sbBodyTable.Append("<img src=\"../AYA/images/" + ayaCurrentImg1 + "\" style=\"margin-left:5%; margin-top:5%; \" alt=\"Chart: Trends in Prevalence of PKD Among Medicare Beneficiaries ≥65 Years, by Sex; \" /> <img src =\"../AYA/images/" + ayaCurrentImg2 + "\" style=\"margin-left:1%; margin-top:5%; \" alt=\"Chart: Trends in Prevalence of PKD Among Medicare Beneficiaries ≥65 Years, by Race and Ethnicity; \" />");
                    }
                    else
                    {
                        sbBodyTable.Append("<div style=\"padding-left: 10px; padding-bottom: 10px; float: left;display: grid;\">");
                        sbBodyTable.Append("<img src=\"../AYA/images/" + ayaCurrentImg + "\" style=\"margin-left:5%; width:80%; margin-top:5%; margin-bottom:5% \"/>");
                    }
                    
                    sbBodyTable.Append("</div>");
                    if (date.IndexOf("June 2024") >= 0 || date.IndexOf("August 2024") >= 0)
                    {
                        sbBodyTable.Append("<div style=\"padding-right: 5%; padding-bottom: 3%; padding-left:5%\">");
                    }
                    else
                    {
                        sbBodyTable.Append("<div style=\"padding-right: 3%; padding-bottom: 3%;\">");
                    }
                    
                    sbBodyTable.Append("<div class=\"div-table-row dateformat\">" + date + "</div>");
                    sbBodyTable.Append("<div class=\"div-table-row ayaTitle\">" + linkStart + title + linkEnd + "</div>");
                    sbBodyTable.Append("<div class=\"div-table-row\">" + linkStart + linkEnd + "</div>");
                    sbBodyTable.Append("<div class=\"div-table-row\">" + desc + "</div>");
                    sbBodyTable.Append("<div class=\"div-table-row\">" + topicURL + topicText + linkEnd + "</div>");
                    sbBodyTable.Append("</div>");
                    sbBodyTable.Append("</div>");
                }
                else
                {
                    if (rowNum == 2) {                        
                        sbBodyTable.Append("<div class=\"div-table-row\">&nbsp;</div><div class=\"div-table-row\" style=\"font-size: 26px;font-weight: 400;\">Are You Aware Archive</div>");
                    }
                    sbBodyTable.Append("<div class=\"div-table-row dateformat\">" + date + "</div>");
                    sbBodyTable.Append("<div class=\"div-table-row ayaTitle\">" + linkStart + title + linkEnd + "</div>");
                    sbBodyTable.Append("<div class=\"div-table-row\">" + linkStart + linkEnd + "</div>");
                    sbBodyTable.Append("<div class=\"div-table-row\">" + desc + "</div>");
                    sbBodyTable.Append("<div class=\"div-table-row\">" + topicURL + topicText + linkEnd + "</div>");
                    sbBodyTable.Append("<hr style=\"border: 1px solid #707070; opacity: 0.39;\" />");
                }
                rowNum++;
            }

            // *Clean-up*
            dtAYA.Dispose();

            sbTables.Append(sbBodyTable.ToString());
            sbTables.Append("</div>");

            //*Clean-up*
            dtAYA.Dispose();

            return sbTables.ToString();
        }

        private string MethodsIndicatorsBodyTableCreation(int TopicID, string TopicText)
        {
            StringBuilder sbBodyTable = new StringBuilder();
            StringBuilder sbTables = new StringBuilder();

            sbTables.Append("<div class=\"div-table\" >");
            DataTable dtMeasures = DAL.getMeasuresByTopicID(TopicID);

            int loopcnt = 0;
            int rowcnt = dtMeasures.Rows.Count;
            int totalloops = 1;
            bool containsLitInd = false;

            int colnum = 0;
            // *Get all Measures for this Topic
            foreach (DataRow dr in dtMeasures.Rows)
            {

                colnum = colnum + 1;
                //Start table HTML
                if (dtMeasures.Rows.Count > 1)
                {
                    sbBodyTable.Append("<div class=\"div-table-col div-table-col-width\" >");
                }
                else {
                    sbBodyTable.Append("<div class=\"div-table-col\" >");
                }
                sbBodyTable.Append("<div class=\"div-table-row\">");

                string measureText = dr["MeasureText"].ToString().Trim();
                int measureID = ((int)(dr["MeasureID"]));

                sbBodyTable.Append("<div  onclick =\"navClick()\" class=\"nav-section-home PInavSectionLinks navlist \" id=\"body-4-card-" + loopcnt.ToString() + "\" data-target=\"#body-4-collapse-" + loopcnt.ToString() + ">"); //begin header measureText
                sbBodyTable.Append("<a tabindex=\"0\"  id=\"body-title-" + loopcnt.ToString() + "\" title=\" " + measureText + "\" data-controls=\"body-4-collapse-" + loopcnt.ToString() + "\"  style=\"text-align: left; font-family: Open Sans; font-size: 22px; letter-spacing: -0.22px; color: #000000; opacity: 1;  \"  >" +  measureText + "</a>");
                sbBodyTable.Append("</div>"); 
                sbBodyTable.Append("</div>"); //col

                //*Add Bulleted list of Indicator Links for this Measure*
                DataTable dtIndicators = DAL.getIndicatorsByMeasureID(measureID);

                //*Cycle through all indicators*
                StringBuilder sb_indTable = new StringBuilder();
                                
                bool containsIndi = false;
                foreach (DataRow drInd in dtIndicators.Rows)
                {
                    sbBodyTable.Append("<div class=\"div-table-row nav-section-home\">");
                    // Build link
                    string linkStart = ("<a style=\"text-align: left; font-family: Open Sans; font-size: 18px; letter-spacing: 0px; color: #007C91; opacity: 1; text-decoration:none; \"  href=\"../detail.aspx?Qnum=" + (drInd["QNUM"].ToString().Trim() + "#refreshPosition\" + \"#PIdivbody\" >"));
                    string text = drInd["IndicatorText"].ToString().Trim();
                    string linkEnd = "</a>";

                    sbBodyTable.Append(linkStart + text + linkEnd);
                    sbBodyTable.Append("</div>"); //col
                }

                // *Clean-up*
                dtIndicators.Dispose();
                loopcnt++;

                
                sbBodyTable.Append("</div>"); //table
                sbTables.Append(sbBodyTable.ToString());

                sbBodyTable = new StringBuilder();
            }

            sbTables.Append("</div>");

            //*Clean-up*
            dtMeasures.Dispose();

            return sbTables.ToString();
        }



        private string getQuintileColorSetting()
        {
            string answer = "y";
            string quintileSetting = "";
            if (Request.QueryString["colors"] != null)
            {
                quintileSetting = Request.QueryString["colors"].ToString().ToLower();

                switch (quintileSetting)
                {
                    case "all":
                        answer = "a";
                        break;
                    case "selected":
                        answer = "y";
                        break;
                }
            }
            else if (Request.QueryString["showMapSlider"] != null)
            {

                //*If this is the slider - it is always all years*
                if (Request.QueryString["showMapSlider"] == "1")
                {
                    answer = "a";
                }
            }

            return answer;
        }

        public static DataTable datableReSort(DataTable dt, string colName, string direction)
        {
            dt.DefaultView.Sort = colName + " " + direction;
            dt = dt.DefaultView.ToTable();
            return dt;
        }

        private string getYear()
        {
            string answer = "";
            string cy = "";
            string qsYear = "";


            if ((Request.QueryString["Year"] != null))
            {
                qsYear = Request.QueryString["Year"];
            }

            //if (StratYear1.CurrentYear != null)
            //{
            //    cy = StratYear1.CurrentYear;
            //}


            answer = qsYear;
            if (string.IsNullOrEmpty(answer))
            {
                answer = cy;
            }


            return answer;
        }


    }
}