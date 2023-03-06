using System;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;
using ckdlibV2;

namespace CKDRD4.Handlers
{
    /// <summary>
    /// Summary description for MapData_Handler
    /// </summary>
    public class MapData_Handler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                if (context.Request.Form["selectedstate"] != null)
                {
                    string datastr = context.Request.Form["selectedstate"].ToString();
                    string selectedstatestr = datastr.Substring(0, datastr.IndexOf("^valMin="));
                    string valMin = datastr.Substring(datastr.IndexOf("^valMin=") + 8, datastr.IndexOf("^valMax=") - (datastr.IndexOf("^valMin=") + 8));
                    string valMax = datastr.Substring(datastr.IndexOf("^valMax=") + 8, datastr.IndexOf("^sortvalue=") - (datastr.IndexOf("^valMax=") + 8));
                    string sortval = datastr.Substring(datastr.IndexOf("^sortvalue=") + 11, datastr.IndexOf("^yr=") - (datastr.IndexOf("^sortvalue=") + 11));
                    string selectedyear = datastr.Substring(datastr.IndexOf("^yr=") + 4, datastr.IndexOf("^chartid=") - (datastr.IndexOf("^yr=") + 4));
                    string chartID = datastr.Substring(datastr.IndexOf("^chartid=") + 9);

                    if (sortval == "select")
                        sortval = "County DESC, year";
                    int fipsstate_int = Convert.ToInt16(selectedstatestr);

                    //DataTable csvdata = ReadCsvFile();
                    ArborDataAccessV2 DAL = new ArborDataAccessV2();
                    DataSet dsAllYearsChart = DAL.getChartForMaps_AllYearsOneState(Convert.ToInt32(chartID), selectedstatestr);
                    //DataSet dsChart = DAL.getChartForMaps(Convert.ToInt32(chartID), selectedyear, "y"); //hard coding for a single year
                    DataTable dsAllYearsTable = dsAllYearsChart.Tables[0];
                    DataView dvyeardata = dsAllYearsTable.DefaultView;
                    dvyeardata.RowFilter = "fipsstate = " + fipsstate_int.ToString() + " AND year = " + selectedyear;
                    

                    //DataView csvview = new DataView(ReadCsvFile("~/Data/prev_county_oneyear.csv"));
                    //csvview.RowFilter = "fipsstate = " + fipsstate_int.ToString();
                    DataTable csvdata_afterfilter = dvyeardata.ToTable();

                    //csvdata_afterfilter.Columns.Add("AnyCKD_rate_decimal", typeof(System.Decimal));
                    //foreach (DataRow dr in csvdata_afterfilter.Rows)
                    //{
                    //    string dataval = dr["AnyCKD_rate"].ToString();
                    //    decimal outdecimal;
                    //    //find the dataval and determine if it is a decimal or not
                    //    if (decimal.TryParse(dataval, out outdecimal))
                    //        outdecimal = decimal.Parse(dataval);
                    //    else
                    //        outdecimal = -1;

                    //    dr["AnyCKD_rate_decimal"] = outdecimal;   // or set it to some other value 
                    //}

                    csvdata_afterfilter.DefaultView.Sort = "DatapointDecimal ASC, County DESC";
                    DataTable csv_postsort = csvdata_afterfilter.DefaultView.ToTable();
                    string stateinfo = findStateAbbr(selectedstatestr);
                    string statename = stateinfo.Substring(stateinfo.IndexOf("-") + 1);
                    StringBuilder return_sb_barchart = buildPlotlyChart(csv_postsort, "<b>Any CKD Rate per 100 for " + statename + " (" + selectedyear + ") <br>CMS-Medicare</b>", "Data", "Counties", 1, statename, double.Parse(valMin), double.Parse(valMax), fipsstate_int);


                    //begin heatmap creation


                    // DataView csvview_heatmap = new DataView(ReadCsvFile("~/Data/prev_county.csv"));
                    //csvview_heatmap.RowFilter = "fipsstate = " + fipsstate_int.ToString() + " AND County <> 'STATEWIDE'";
                    DataTable csvdata_heatmap_afterfilter = dsAllYearsTable;

                    csvdata_heatmap_afterfilter.Columns.Add("DatapointDecimal_Final", typeof(System.Decimal));

                    bool containsnegativevalues = false;
                    foreach (DataRow dr in csvdata_heatmap_afterfilter.Rows)
                    {
                        string dataval = dr["DatapointDecimal"].ToString();
                        decimal outdecimal;
                        //find the dataval and determine if it is a decimal or not
                        if (decimal.TryParse(dataval, out outdecimal))
                            outdecimal = decimal.Parse(dataval);
                        else
                        {
                            outdecimal = -1;
                            containsnegativevalues = true;
                        }

                        dr["DatapointDecimal_Final"] = outdecimal;   // or set it to some other value 
                    }
                    
                    //fix for heatmap sort by data
                    int maxyear = 2019;
                    DataView dviewMaxYear = csvdata_heatmap_afterfilter.DefaultView;
                    dviewMaxYear.RowFilter = "year = " + maxyear.ToString(); //filtering the most recent year worth of data
                    dviewMaxYear.Sort = "DatapointDecimal desc"; //sorting by the data value
                    DataTable dtableMaxYear = dviewMaxYear.ToTable();
                    dtableMaxYear.Columns.Add("CountyOrder", typeof(System.Int16)); //converting back to datatable and adding a new column on
                    int countyorderinc = 0;
                    foreach (DataRow dr in dtableMaxYear.Rows)//filling the new column with an incremented value to be used later
                    {
                        countyorderinc++;
                        dr["CountyOrder"] = countyorderinc;
                    }


                    /* EXAMPLE HERE: https://stackoverflow.com/questions/31464677/merging-two-datatables-into-one-c-sharp*/
                    DataTable myNewDataTable = new DataTable(); //creating a new table so that the user can sort on the order of the county
                    myNewDataTable.Columns.Add("County", typeof(string));
                    myNewDataTable.Columns.Add("CountyOrder", typeof(Int16));
                    myNewDataTable.Columns.Add("DatapointDecimal", typeof(Decimal));
                    myNewDataTable.Columns.Add("Year", typeof(string));
                    var results = (from d1 in csvdata_heatmap_afterfilter.AsEnumerable() //joining the heatmap data with the 'CountyOrder' table above using Linq
                                   join d2 in dtableMaxYear.AsEnumerable()
                                         on d1.Field<string>("County") equals d2.Field<string>("County")
                                   select myNewDataTable.LoadDataRow(new object[] { d1.Field<string>("County"), d2.Field<Int16>("CountyOrder"), d1.Field<Decimal>("DatapointDecimal_Final"), d1.Field<string>("Year") }, true));// 
                    myNewDataTable = results.CopyToDataTable<DataRow>();// placing back into a table
                    // */
                    //results.

                    //fix for heatmap sort by data

                    myNewDataTable.DefaultView.Sort = sortval;
                    DataTable csv_heatmap_postsort = myNewDataTable.DefaultView.ToTable();
                    StringBuilder return_sb_heatmap = buildPlotlyHeatMap(csv_heatmap_postsort, "<b>Any CKD Rate heatmap per 100 for " + statename + ": 2005 - 2019 <br>CMS-Medicare</b>", containsnegativevalues, fipsstate_int);


                    string final_return = return_sb_barchart.ToString() + " " + return_sb_heatmap.ToString();
                    System.Web.HttpContext.Current.Response.Write(final_return);
                }
            }
            catch (Exception ex)
            {
                System.Web.HttpContext.Current.Response.Write("error|9999|Could not retrieve submitted values|0");
            }


        }

        public StringBuilder buildPlotlyChart(DataTable dtChart, string title, string xaxistitle, string yaxistitle, int xaxiscnt, string statename, double valMin, double valMax, int fipsstate_int)
        {
            int xaxis_cnt = 1;
            int max_xaxis_cnt = 0;

            if (fipsstate_int == 2)
                yaxistitle = "Boroughs";
            else if (fipsstate_int == 22)
                yaxistitle = "Parishes";

            if (max_xaxis_cnt == 0) max_xaxis_cnt = xaxis_cnt; //if there is only one series, then set the max count to the xaxis count

            string hfval_x = "x:[ "; //starting the arrays and adding spaces to so that the last character parse below doesn't fail
            string hfval_y = "y:[ ";


            string plotlyGroups = "var data = [";

            StringBuilder plotlyStr = new StringBuilder();

            /*create data array logic*/

            string current_serieslabel = "";
            string theData = "";

            //*************************************** Third Attempt

            theData = "[ ";

            if (max_xaxis_cnt > 7) max_xaxis_cnt = 7;
            int wrapsize = 100 / max_xaxis_cnt;//finding the number of data points and wrapping the x-axis labels accordingly

            int colorarray_inc = 0;
            string[] colorarray = { "#D6EAF8", "#AED6F1", "#85C1E9", "#59B1EC", "#2E86C1" };
            double minmaxDiff = valMax - valMin;
            for (int i = 0; i <= dtChart.Rows.Count - 1; i++)
            {
                string secondary = dtChart.Rows[i]["County"].ToString();
                //secondary = wrapText(secondary, wrapsize);
                string serieslabel = secondary.ToString(); //stateabbrev
                string datapoint = dtChart.Rows[i]["DatapointDecimal"].ToString();

                string colorval = "#fff"; //default value is white which is used for NA cases
                double outdouble;
                if (double.TryParse(datapoint, out outdouble))
                    outdouble = double.Parse(datapoint);

                //if (datapoint == "NA")
                //    colorval = "#fff";
                if (datapoint == "MIA")
                    colorval = "#ddd";
                else if (outdouble >= valMin + (minmaxDiff * .8)) // > 80th percentile
                    colorval = colorarray[4];
                else if (outdouble >= (valMin + (minmaxDiff * .6)) && outdouble < (valMin + (minmaxDiff * .8))) //60th - 80th percentile
                    colorval = colorarray[3];
                else if (outdouble >= (valMin + (minmaxDiff * .4)) && outdouble < (valMin + (minmaxDiff * .6))) //40th - 60th percentile
                    colorval = colorarray[2];
                else if (outdouble >= (valMin + (minmaxDiff * .2)) && outdouble < (valMin + (minmaxDiff * .4))) //20th - 40th percentile
                    colorval = colorarray[1];
                else if (outdouble < (valMin + (minmaxDiff * .2))) // < 20th percentile
                    colorval = colorarray[0];

                //colorval = "#ddd";// dtChart.Rows[i]["Color"].ToString();
                //serieslabel = serieslabel.Replace("&", "and"); //overridding the & so that the chart doesn't fail

                //datapoint = datapoint.Replace("*", "");


                hfval_x = "x:[ '" + outdouble + "']"; //finding the 'column' value and only adding numeric data
                hfval_y = "y:['" + secondary + "']"; //finding the actual data value

                string xData_col = hfval_x;//removing the last comma
                string yData_col = hfval_y;//removing the last comma

                plotlyStr.Append(" var data" + cleanString(serieslabel) + " = {" + xData_col + " , " + yData_col );

                //changing the orientation to horizontal
                plotlyStr.Append(",  name: '" + serieslabel + "',  orientation:'h', type: 'bar', marker: {color: '" + colorval + "', line: { color: 'rgb(90,90,90)', width: .5} }};"); //appending the 'row' to the data name and adding the array data

                plotlyGroups = plotlyGroups + "data" + cleanString(serieslabel) + ","; //adding the above data variable to the group variable

            }


            //HF_D3Data.Value = theData;
            if (plotlyGroups == "var data = [")// if this variable hasn't been added to, then add the above chartdata
                plotlyGroups = plotlyGroups + "chartdata ";

            string dataGroups = plotlyGroups.Substring(0, plotlyGroups.Length - 1) + "];";//otherwise, close the array and add it to the plotly string

            plotlyStr.Append(dataGroups);

            return createPlotlyScript(plotlyStr, title, xaxistitle, yaxistitle, xaxis_cnt, dtChart.Rows.Count);
        }

        private StringBuilder createPlotlyScript(StringBuilder dataSb, string title, string xaxistitle, string yaxistitle, int xaxiscnt, int datarowcnt)
        {
            string xtickfontsize = "10";
            string tickangle = "0";

            if (xaxiscnt >= 7)
            {
                xtickfontsize = "9";
                tickangle = "10";
            }

            int chartheight = (datarowcnt * 10) + 100;
            double titleposition = 1.08;
            if (datarowcnt < 50)
            {
                chartheight = chartheight + 120;
                if (datarowcnt < 10)
                    titleposition = 1.5;
                else
                    titleposition = 1.2;
            }
            else if (datarowcnt > 100)
                titleposition = 1.03;

            StringBuilder sb = new StringBuilder();

            sb.Append(" $(function() { createPlotlyChart(); });");

            sb.Append(" function createPlotlyChart()  {");
            //sb.Append("  var colors = $('#hfChartColor').val(); var colors_split = colors.split(','); "); //4/21/20 adding the color arry parsing here so that it is at the top of the script
            sb.Append(" var d3 = Plotly.d3;");
            sb.Append(" var WIDTH_IN_PERCENT_OF_PARENT = 100, HEIGHT_IN_PERCENT_OF_PARENT = 120;");

            sb.Append(dataSb);
            sb.Append(" var img_png= d3.select('#png-export'); ");

            sb.Append(" var layout = {autosize:false, height: " + chartheight);



            sb.Append(" ,annotations: [{ x: 0, y: 0, xshift: -70, yshift: -80, sizex: 0.3, sizey: 0.3, yref: 'paper', xref: 'paper', align: 'left', text: 'Centers for Disease Control and Prevention. Chronic Kidney Disease Surveillance System—United States. website. https://nccd.cdc.gov/ckd ', showarrow: false, font: { size: 9 } },{ x: 0, y: " + titleposition + ", xshift: -70, yref: 'paper', xref: 'paper', align: 'left', text: '" + title + "',showarrow: false }],"); //, font: { size: 20 }

            ////The Y axis label if being moved to the far left of the chart within the client side  $(function () 
            sb.Append("showlegend:false, barmode:  'bar', hovermode: 'closest',hoverinfo: 'none', xaxis: { tickangle:" + tickangle + ", tickfont: { size: " + xtickfontsize + " }, linecolor:'#bdbdbd', title:'<b>" + xaxistitle + "</b>', titlefont: { size: 12 }},yaxis: {automargin: true, dtick: 1, xshift: -200, linecolor:'#bdbdbd', tickfont: { size: 10 }, title:'<b>" + yaxistitle + "</b>', titlefont: { size: 12 } }};");

            sb.Append(" var gd4 = d3.select('#bar_chart');");

            sb.Append("var graphdiv = gd4.node();");

            String titleNoFN = "chartimage";


            sb.Append("Plotly.newPlot(graphdiv, data, layout,{responsive:true, displayModeBar: false, modeBarButtonsToRemove: ['toImage','sendDataToCloud', 'lasso2d', 'select2d', 'toggleSpikelines'] , modeBarButtonsToAdd: [{ name: 'Download Chart as PNG', icon: Plotly.Icons.camera, click: function(gd) { Plotly.downloadImage(gd,{format:'png',height:700,width:900, filename: '" + titleNoFN + "'}) }}]");

            sb.Append(" });");//}]

            sb.Append(" var gd4tiny = d3.select('#tinybarchart');");
            //sb.Append(".style({ width: 200,  height: 200 });");
            sb.Append("var graphdivtiny = gd4tiny.node();");
            sb.Append(" var layouttiny = {width:200, height: 200, showlegend:false,  ");
            sb.Append(" margin: { l: 5, r: 10, b: 0, t: 5, pad: 4} , ");
            sb.Append(" xaxis: {autorange: true, showgrid: false, zeroline: false, showline: false, autotick: true, ticks: '', showticklabels: false }, ");
            sb.Append(" yaxis: {automargin:true, autorange: true, showgrid: false, zeroline: false, showline: false, autotick: true, ticks: '', showticklabels: false} ");
            sb.Append("};"); //close layout
            sb.Append("Plotly.newPlot(graphdivtiny, data, layouttiny, {staticPlot: true});");

            sb.Append("");
            sb.Append("window.onresize = function(){ Plotly.Plots.resize(graphdiv); }");
            sb.Append("}");


            return sb;
        }

        public StringBuilder buildPlotlyHeatMap(DataTable dtChart, string charttitle, bool containsnegativevalues, int fipsstate)
        {
            string current_s_compare = "";

            string hfval_x = "x:[ "; //'years
            string hfval_y = "y:[ ";//'counties
            string hfval_z = "z:[ "; //'data


            string hovertext = "";

            StringBuilder plotlyStr = new StringBuilder();

            //'/*create data array logic*/

            string current_county = "";
            string theData = "";

            theData = "[ ";

            int current_year = DateTime.Today.Year;

            int maxcount = 1;
            bool yearsfilled = false;
            string zdata = "";
            int counties_cnt = 0;
            int year_cnt = 0;
            int basestartyear = 2005;
            int startyear = basestartyear;

            for (int i = 0; i < dtChart.Rows.Count; i++)
            {
                string county = dtChart.Rows[i]["County"].ToString(); //'4 digit code

                string d_year = dtChart.Rows[i]["year"].ToString(); //'year value
                string datavar = dtChart.Rows[i]["DatapointDecimal"].ToString(); //'data value
                if (datavar == "NA") datavar = "'NA'";

                

                if (current_county == "") //'first time through
                {
                    current_county = county;
                    hfval_y = hfval_y + "'" + county + "',";// ' adding the center to the y array
                    zdata = "["; // 'start data array
                    counties_cnt = counties_cnt + 1;
                }
                else if (current_county != county) //everytime a cneter changes
                {
                    yearsfilled = true; //'set this boolean so no more years are added
                    current_county = county;
                    hfval_y = hfval_y + "'" + county + "',"; //' adding the center to the y array
                    hfval_z = hfval_z + zdata.Substring(0, zdata.Length - 1) + "],";// 'close the array and add it to the overall array
                    zdata = "[";// 'restart data array
                    counties_cnt = counties_cnt + 1;
                    startyear = basestartyear;//reseting the startyear variable
                }

                if (!yearsfilled)
                {
                    hfval_x = hfval_x + "'" + d_year + "',"; //' //finding the 'x - axis' value with all of the years
                    year_cnt++;
                }

                if (Int16.Parse(d_year) != startyear)//if there is a missing year of data
                {
                    while (Int16.Parse(d_year) > startyear) //increment the 'startyear' until there is a match
                    {
                        zdata = zdata + "null,";//add empty data
                        startyear++;//increment the 'startyear' value
                    }

                }


                if (datavar == "")
                    datavar = "null";

                zdata = zdata + datavar + ",";
                startyear++; //set the startyear equal to the upcoming year in the data so that it is always in sync
            }

            //'adding the last zdata value
            hfval_z = hfval_z + zdata.Substring(0, zdata.Length - 1) + "],";

            string xData_col_final = hfval_x.Substring(0, hfval_x.Length - 1) + "]"; //'//removing the last comma
            string yData_col_final = hfval_y.Substring(0, hfval_y.Length - 1) + "]"; // '//removing the last comma
            string zData_col_final = hfval_z.Substring(0, hfval_z.Length - 1) + "]"; // '//removing the last comma


            plotlyStr.Append(" var data  = [");

            plotlyStr.Append("{ " + zData_col_final + " , " + xData_col_final + " , " + yData_col_final);
            //plotlyStr.Append(",  colorscale: [ ['0.0', 'rgb(214,234,248)'],['0.25', 'rgb(174,214,241)'], ['0.5', 'rgb(133,193,233)'], ['0.7', 'rgb(52,152,219)'], ['1.0', 'rgb(46,134,193)'] ] , type:'heatmap', hoverongaps:false");// ' //appending the 'row' to the data name and adding the array data

            if (containsnegativevalues)//if there are negative values then we want them to display as light grey
                plotlyStr.Append(",  colorscale: [ ['0.0', 'rgb(225,225,225)'],['0.01', 'rgb(214,234,248)'],['0.25', 'rgb(174,214,241)'], ['0.5', 'rgb(133,193,233)'], ['0.7', 'rgb(52,152,219)'], ['1.0', 'rgb(46,134,193)'] ] , type:'heatmap', hoverongaps:false, colorbar:{ title:'Any CKD Rate Percentage', titleside: 'top',  titlefont: {color: 'white'} }");// ' //appending the 'row' to the data name and adding the array data
            else //if not, then display the colors without light grey, otherwise the smallest value will be displayed as light grey
                plotlyStr.Append(",  colorscale: [ ['0.0', 'rgb(214,234,248)'],['0.25', 'rgb(174,214,241)'], ['0.5', 'rgb(133,193,233)'], ['0.7', 'rgb(52,152,219)'], ['1.0', 'rgb(46,134,193)'] ] , type:'heatmap', hoverongaps:false, colorbar:{ title: 'Any CKD Rate Percentage', titleside: 'top',  titlefont: {color: 'white'}  }");// ' //appending the 'row' to the data name and adding the array data
            plotlyStr.Append(" }");

            plotlyStr.Append("]; ");

            return createPlotlyScript_HeatMap(plotlyStr, charttitle, counties_cnt, year_cnt, fipsstate);

        }
        protected StringBuilder createPlotlyScript_HeatMap(StringBuilder dataSb, string charttitle, int counties_cnt, int years, int fipsstate_int)
        {
            string xtickfontsize = "10";
            string tickangle = "0";

            string yaxistitle = "Counties";
            if (fipsstate_int == 2)
                yaxistitle = "Boroughs";
            else if (fipsstate_int == 22)
                yaxistitle = "Parishes";

            if (years >= 7)
            {
                xtickfontsize = "9";
                tickangle = "10";
            }

            int chartheight = (counties_cnt * 10) + 100;
            double titleposition = 1.08;
            if (counties_cnt < 50)
            {
                chartheight = chartheight + 120;
                if (counties_cnt < 10)
                    titleposition = 1.5;
                else
                    titleposition = 1.2;
            }
            else if (counties_cnt > 100)
                titleposition = 1.03;
            
            StringBuilder sb = new StringBuilder();
            // sb.Append("<script>");
            sb.Append(" $(function() {");
            sb.Append(" var d3 = Plotly.d3;");
            sb.Append(" var WIDTH_IN_PERCENT_OF_PARENT = 100, HEIGHT_IN_PERCENT_OF_PARENT = 80;");
            sb.Append(dataSb);


            // sb.Append(" var layout = {title: '" + charttitle + "',yaxis: {autotick:false,  showticklabels: false, ticks: '',  title: 'Counties - (n=" + counties_cnt.ToString() + ")', titlefont: {family: 'Arial', size: 18, color:'black'}}, xaxis: {autotick:false,tickangle: -45}}; ");

            sb.Append(" var layout = {autosize:true, height: " + chartheight);
            sb.Append(" ,annotations: [{ x: 0, y: 0, xshift: -70, yshift: -80, sizex: 0.3, sizey: 0.3, yref: 'paper', xref: 'paper', align: 'left', text: 'Centers for Disease Control and Prevention. Chronic Kidney Disease Surveillance System—United States. website. https://nccd.cdc.gov/ckd ', showarrow: false, font: { size: 9 } },{ x: 0, y: " + titleposition + ", xshift: -70, yref: 'paper', xref: 'paper', align: 'left', text: '" + charttitle + "',showarrow: false }],"); //, font: { size: 20 }

            ////The Y axis label if being moved to the far left of the chart within the client side  $(function () 
            sb.Append("showlegend:false, barmode:  'bar', hovermode: 'closest',hoverinfo: 'none', xaxis: { autotick:false, tickangle:" + tickangle + ", tickfont: { size: " + xtickfontsize + " }, linecolor:'#bdbdbd', title:'<b>Years</b>', titlefont: { size: 12 }},yaxis: {automargin: true, dtick: 1, xshift: -200, linecolor:'#bdbdbd', tickfont: { size: 10 }, title:'<b>" + yaxistitle + "</b>', titlefont: { size: 12 } }};");


            sb.Append(" var gd4 = d3.select('#heatmapchart');");
            //sb.Append(".style({ width: WIDTH_IN_PERCENT_OF_PARENT + '%', 'margin-left': (100 - WIDTH_IN_PERCENT_OF_PARENT) / 2 + '%', height: HEIGHT_IN_PERCENT_OF_PARENT + 'vh' });");

            sb.Append("var graphdiv = gd4.node();");

            sb.Append("Plotly.newPlot(graphdiv, data, layout);");

            sb.Append(" var gd4tiny = d3.select('#tinyheatmap');");
            //sb.Append(".style({ width: 200,  height: 200 });");
            sb.Append("var graphdivtiny = gd4tiny.node();");
            sb.Append(" var layouttiny = {width:200, height: 200, showlegend:false, ");
            sb.Append(" margin: { l: 5, r: 10, b: 0, t: 5, pad: 4} , ");
            sb.Append(" xaxis: {autorange: true, showgrid: false, zeroline: false, showline: false, autotick: true, ticks: '', showticklabels: false }, ");
            sb.Append(" yaxis: {autorange: true, showgrid: false, zeroline: false, showline: false, autotick: true, ticks: '', showticklabels: false} ");
            sb.Append("};"); //close layout

            sb.Append("Plotly.newPlot(graphdivtiny, data, layouttiny, {staticPlot: true});");


            // sb.Append(" });");

            sb.Append("");
            sb.Append("window.onresize = function(){ Plotly.Plots.resize(graphdiv); };");
            sb.Append("})");
            //sb.Append("</script>");

            return sb;
        }



        protected string cleanString(string pstr)
        {
            string retstr = pstr;
            Regex rgx = new Regex("[^a-zA-Z0-9]");
            retstr = rgx.Replace(retstr, "");
            return retstr;
        }

        public string findStateAbbr(string statecode)
        {
            string retstr = "";

            if (statecode == "01") retstr = "AL-Alabama";
            else if (statecode == "02") retstr = "AK-Alaska";
            else if (statecode == "04") retstr = "AZ-Arizona";
            else if (statecode == "05") retstr = "AR-Arkansas";
            else if (statecode == "06") retstr = "CA-California";
            else if (statecode == "08") retstr = "CO-Colorado";
            else if (statecode == "09") retstr = "CT-Connecticut";
            else if (statecode == "10") retstr = "DE-Delaware";
            else if (statecode == "11") retstr = "DC-District of Columbia";
            else if (statecode == "12") retstr = "FL-Florida";
            else if (statecode == "13") retstr = "GA-Georgia";
            else if (statecode == "15") retstr = "HI-Hawaii";
            else if (statecode == "16") retstr = "ID-Idaho";
            else if (statecode == "17") retstr = "IL-Illinois";
            else if (statecode == "18") retstr = "IN-Indiana";
            else if (statecode == "19") retstr = "IA-Iowa";
            else if (statecode == "20") retstr = "KS-Kansas";
            else if (statecode == "21") retstr = "KY-Kentucky";
            else if (statecode == "22") retstr = "LA-Louisiana";
            else if (statecode == "23") retstr = "ME-Maine";
            else if (statecode == "24") retstr = "MD-Maryland";
            else if (statecode == "25") retstr = "MA-Massachusetts";
            else if (statecode == "26") retstr = "MI-Michigan";
            else if (statecode == "27") retstr = "MN-Minnesota";
            else if (statecode == "28") retstr = "MS-Mississippi";
            else if (statecode == "29") retstr = "MO-Missouri";
            else if (statecode == "30") retstr = "MT-Montana";
            else if (statecode == "31") retstr = "NE-Nebraska";
            else if (statecode == "32") retstr = "NV-Nevada";
            else if (statecode == "33") retstr = "NH-New Hampshire";
            else if (statecode == "34") retstr = "NJ-New Jersey";
            else if (statecode == "35") retstr = "NM-New Mexico";
            else if (statecode == "36") retstr = "NY-New York";
            else if (statecode == "37") retstr = "NC-North Carolina";
            else if (statecode == "38") retstr = "ND-North Dakota";
            else if (statecode == "39") retstr = "OH-Ohio";
            else if (statecode == "40") retstr = "OK-Oklahoma";
            else if (statecode == "41") retstr = "OR-Oregon";
            else if (statecode == "42") retstr = "PA-Pennsylvania";
            else if (statecode == "44") retstr = "RI-Rhode Island";
            else if (statecode == "45") retstr = "SC-South Carolina";
            else if (statecode == "46") retstr = "SD-South Dakota";
            else if (statecode == "47") retstr = "TN-Tennessee";
            else if (statecode == "48") retstr = "TX-Texas";
            else if (statecode == "49") retstr = "UT-Utah";
            else if (statecode == "50") retstr = "VT-Vermont";
            else if (statecode == "51") retstr = "VA-Virginia";
            else if (statecode == "53") retstr = "WA-Washington";
            else if (statecode == "54") retstr = "WV-West Virginia";
            else if (statecode == "55") retstr = "WI-Wisconsin";
            else if (statecode == "56") retstr = "WY-Wyoming";

            return retstr;
        }

        public DataTable ReadCsvFile(string filepath)
        {

            DataTable dtCsv = new DataTable();
            string Fulltext;

            string FileSaveWithPath = HttpContext.Current.Server.MapPath(filepath);

            using (StreamReader sr = new StreamReader(FileSaveWithPath))
            {
                while (!sr.EndOfStream)
                {
                    Fulltext = sr.ReadToEnd().ToString(); //read full file text  
                    string[] rows = Fulltext.Split('\n'); //split full file text into rows  
                    for (int i = 0; i < rows.Count() - 1; i++)
                    {
                        string[] rowValues = rows[i].Split(','); //split each row with comma to get individual values  
                        {
                            if (i == 0)
                            {
                                for (int j = 0; j < rowValues.Count(); j++)
                                {
                                    dtCsv.Columns.Add(rowValues[j]); //add headers  
                                }
                            }
                            else
                            {
                                DataRow dr = dtCsv.NewRow();
                                for (int k = 0; k < rowValues.Count(); k++)
                                {
                                    dr[k] = rowValues[k].ToString();
                                }
                                dtCsv.Rows.Add(dr); //add other rows  
                            }
                        }
                    }
                }
            }

            return dtCsv;
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