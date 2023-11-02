using System;
using System.Data;
using System.Web;
using System.Text;
using ckdlibV2;

namespace CKDSurveillance_RD
{
    public partial class DisparityExplorerV2 : Classes.NCCDPage// 9/24 updated per Alex System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ArborDataAccessV2 DAL = new ArborDataAccessV2();
            DataTable dtTable = new DataTable("Table");            
            string yr = "";
            int chartID = 998;


            DataSet ds = null;
            ds = DAL.getTableDisparities(chartID, yr);

            DataTable dtChart = ds.Tables[1];            

            populateTable(chartID, "Disparities Explorer", "Disparities Explorer Data");
            int sigDigits = Convert.ToInt32(ds.Tables[0].Rows[0]["SignificantDigits"]);


            //**********
            //*Clean-up*
            //**********
            dtTable.Dispose();
            if (dtChart != null) { dtChart.Dispose(); }
            ds.Dispose();
            DAL = null;
        }

        protected void createD3DataArray(DataTable dtChart)
        {            
            string current_secondary = "";
            string theData = "";

            //*************************************** Third Attempt
            current_secondary = "";
            theData = "[";
            
            for (int i = 0; i <= dtChart.Rows.Count - 1; i++)
            {
                string secondary = dtChart.Rows[i]["Adjustments"].ToString();
                string nhwhite = dtChart.Rows[i]["Non-Hispanic White"].ToString();
                string nhblack = dtChart.Rows[i]["Non-Hispanic Black"].ToString();
                string other = dtChart.Rows[i]["Other"].ToString();                

                string[] nhwhiteArray = nhwhite.Split('|');
                string[] nhblackArray = nhblack.Split('|');
                string[] otherArray = other.Split('|');

                if (current_secondary == "")
                {
                    theData = theData + "{ secondary : '" + secondary + "',";
                    theData = theData + "values: [";

                    theData = theData + "{ datapoint: " + nhwhiteArray[0] + ",lowC: " + nhwhiteArray[1] + ", highC: " + nhwhiteArray[2] + ",  series:'Non-Hispanic White'},";
                    theData = theData + "{ datapoint: " + nhblackArray[0] + ",lowC: " + nhblackArray[1] + ", highC: " + nhblackArray[2] + ", series:'Non-Hispanic Black'},";
                    theData = theData + "{ datapoint: " + otherArray[0] + ",lowC: " + otherArray[1] + ", highC: " + otherArray[2] + ", series:'Other'},";
                   
                    current_secondary = secondary;
                }
                else if (current_secondary != secondary)
                {
                    theData = theData.Substring(0, theData.Length - 1);//trimming the last comma
                    theData = theData + "]";//closing the values                    
                    theData = theData + "},{ secondary : '" + secondary + "',";//closing the secondary and adding a new one
                    theData = theData + "values: [";

                    theData = theData + "{ datapoint: " + nhwhiteArray[0] + ",lowC: " + nhwhiteArray[1] + ", highC: " + nhwhiteArray[2] + ",  series:'Non-Hispanic White'},";
                    theData = theData + "{ datapoint: " + nhblackArray[0] + ",lowC: " + nhblackArray[1] + ", highC: " + nhblackArray[2] + ", series:'Non-Hispanic Black'},";
                    theData = theData + "{ datapoint: " + otherArray[0] + ",lowC: " + otherArray[1] + ", highC: " + otherArray[2] + ", series:'Other'},";                  

                    current_secondary = secondary;
                }                

            }
            theData = theData.Substring(0, theData.Length - 1);//trimming the last comma
            theData = theData + "]";//closing the last values                    
            theData = theData + "}";//closing the last secondary 
            theData = theData + "]";//closing the entire array
            //*************************************** End Third Attempt

            HF_D3Data.Value = theData;


            //Clean-up
            dtChart.Dispose();
        }

        public static DataTable datableReSort(DataTable dt, string colName, string direction)
        {
            dt.DefaultView.Sort = colName + " " + direction;
            dt = dt.DefaultView.ToTable();
            return dt;
        }

        protected string cleanString(string pstr)
        {
            string retstr = pstr;
            retstr = retstr.Replace("-", "");
            retstr = retstr.Replace("\u2013", ""); //replacing a variations of hyphens and em dashes
            retstr = retstr.Replace("\u2014", "");
            retstr = retstr.Replace("\u2015", "");
            retstr = retstr.Replace(" ", "");// replacing
            retstr = retstr.Replace(",", "");// replacing 
            return retstr;
        }



        private void populateTable(int chartID, string headerText, string noFN)
        {
            ArborDataAccessV2 DAL = new ArborDataAccessV2();
            DataTable dtTable = new DataTable("Table");            
            string yr = "";


            DataSet ds = null;
            ds = DAL.getTableDisparities(chartID, yr);


            //*Set Header Text*
            headerText = ds.Tables[0].Rows[0]["IndicatorTitleRoot"].ToString().Trim();


            //*Clear the grid*
            gvData.Columns.Clear();


            if (ds.Tables.Count > 1)
            {
                dtTable = ds.Tables[1];
            }
            else
            {
                dtTable = ds.Tables[0];
            }

            //Format Data in Table
            int sigDigits = Convert.ToInt32(ds.Tables[0].Rows[0]["SignificantDigits"]);
            string dataFormat = ds.Tables[0].Rows[0]["format"].ToString();

            for (int i = 0; i < dtTable.Rows.Count; i++)
            {
                for (int j = 0; j < dtTable.Columns.Count; j++)
                {
                    string cellVal = dtTable.Rows[i][j].ToString();

                    if (cellVal.Contains("|"))
                    {
                        string[] splitter = cellVal.Split('|');
                        string dataValue = buildSigDigits(splitter[0].Trim(), sigDigits);

                        if (dataValue.ToLower() != "na" && dataValue != "*")
                        {
                            dataValue += dataFormat;
                        }

                        string highCI = buildSigDigits(splitter[1].Trim(), sigDigits);
                        string lowCI = buildSigDigits(splitter[2].Trim(), sigDigits);

                        StringBuilder sb = new StringBuilder();
                        sb.Append(dataValue);
                        if (highCI != "" && lowCI != "" && highCI != "0" && lowCI != "0")
                        {
                            sb.Append("\r\n");
                            sb.Append("(95% CI: ");
                            sb.Append(highCI);
                            sb.Append("-");
                            sb.Append(lowCI);
                            sb.Append(")");
                        }

                        string newValue = HttpUtility.HtmlDecode(sb.ToString());

                        dtTable.Rows[i][j] = newValue.Trim();
                    }
                }
            }

            bool colIsYear = false;
            string colName = dtTable.Columns[0].ColumnName;

            if (colName.Length >= 4)
            {
                if (Utilities.CheckForNumeric(colName.Substring(0, 4)))
                {
                    colIsYear = true;
                }
            }

            //*Only mark the row as a header if the first column Name is NOT a year*
            if (colIsYear == false)
            {
                string rowcolname = colName;
                gvData.RowHeaderColumn = rowcolname;
            }

            gvData.DataSource = dtTable;
            gvData.DataBind();

            gvData.UseAccessibleHeader = true;

          
            //**********************************
            //*Add a new Header Row to the Grid*
            //**********************************            
            gvData.Caption = headerText;

            
            //*************************************
            //*Build and add the summary attribute*
            //*************************************
            if (dtTable != null)
            {
                if (dtTable.Rows.Count > 0)
                {

                    try
                    {
                        string colCount = Convert.ToString(dtTable.Columns.Count - 1);
                        string colFirstName = dtTable.Columns[0].ColumnName.Trim();
                        string colNames = "";
                        for (int i = 1; i <= dtTable.Columns.Count - 1; i++)
                        {
                            colNames += dtTable.Columns[i].ColumnName + ", ";
                        }
                        colNames = colNames.Substring(0, colNames.Length - 2).Trim();
                        //*remove the last comma*

                        string summaryText = "This table of ";
                        summaryText += noFN.Trim();
                        summaryText += " has " + colCount + " column headings ";
                        summaryText += colNames;
                        summaryText += " for each " + colFirstName + " row heading";

                        gvData.Attributes.Add("summary", summaryText);

                    }
                    catch (Exception ex)
                    {
                        gvData.Attributes.Add("summary", "This is a table of data for the above chart");

                    }
                    finally
                    {
                        dtTable.Dispose();
                        ds.Dispose();
                        DAL = null;
                    }
                }
            }
        }

        private string buildSigDigits(string value, int digitCount)
        {
            string answer = "";

            if (value == "*" || value.ToLower() == "na" || value.ToLower() == "") { return value; }

            Double num = Convert.ToDouble(value);
            string fmt = "#,###";
            if (digitCount > 0)
            {
                fmt += ".";

                for (int i = 0; i < digitCount; i++)
                {
                    fmt += "0";
                }
            }

            answer = num.ToString(fmt);

            return answer;
        }
    }
}