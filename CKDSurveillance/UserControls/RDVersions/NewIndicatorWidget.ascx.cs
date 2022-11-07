using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using ckdlibV2;
using System.Web.UI.WebControls;
using System.Text;

namespace CKDSurveillance_RD.UserControls.RDVersions
{
    public partial class NewIndicatorWidget : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            //Get list of new Indicators
            DataTable dt = null;
            StringBuilder sb = new StringBuilder();
            ArborDataAccessV2 DAL = new ArborDataAccessV2();
            try
            {
                //Get the list
                dt = DAL.getNewIndicatorList();
                

                //Open the list
                sb.Append("<ul class='list-bullet'>");


                //Iterate through the table, build a string (HTML) for the placeholder
                foreach (DataRow dr in dt.Rows)
                {
                    //Start the bulleted entry
                    sb.Append("<li>");

                    //Start link
                    sb.Append("<a href='");
                    sb.Append(correctURL(dr["ChartURL"].ToString().Trim())); //URL encode
                    sb.Append("' target='_blank'");
                    sb.Append(" >");

                    //Text
                    sb.Append(dr["Indicator"].ToString().Trim());

                    //Close link
                    sb.Append("</a>");

                    //Close bulleted entry
                    sb.Append("</li>");
                }

                //Close the list
                sb.Append("</ul>");

                litNewIndicatorList.Text = sb.ToString().Trim();

                //Set the title
                string cnt_str = NumberToWords(dt.Rows.Count);
                litNewIndicatorsTitle.Text = char.ToUpper(cnt_str[0]) + cnt_str.Substring(1).ToLower() + " new indicators of CKD have been added to the resources on this site.";

            }
            catch (SqlException sqlEx)
            {
                litNewIndicatorList.Text = "";
                litNewIndicatorsTitle.Text = "";

            }
            catch (Exception ex)
            {
                litNewIndicatorList.Text = "";
                litNewIndicatorsTitle.Text = "";
            }
            finally
            {
                dt.Dispose();
                sb = null;
            }

        }

        private string correctURL(string url)
        {
            string answer = "";
            string[] splitter = url.Split('&');

            answer = splitter[0].Replace("~/", "").Trim();

            for (int i = 1; i <= splitter.Length-1; i++)
            {
                //answer += "&" + Server.UrlEncode(splitter[i].Trim()); //Causes problems with stratyear widgets
                answer += "&" + splitter[i].Trim().Replace(" ", "%20").Trim();
            }

            return answer;
        }

        private string NumberToWords(int number)
        {
            //Convert ain integer to words - for building the title of this widget
            if (number == 0)
                return "zero";

            if (number < 0)
                return "minus " + NumberToWords(Math.Abs(number));

            string words = "";

            if ((number / 1000000) > 0)
            {
                words += NumberToWords(number / 1000000) + " million ";
                number %= 1000000;
            }

            if ((number / 1000) > 0)
            {
                words += NumberToWords(number / 1000) + " thousand ";
                number %= 1000;
            }

            if ((number / 100) > 0)
            {
                words += NumberToWords(number / 100) + " hundred ";
                number %= 100;
            }

            if (number > 0)
            {
                if (words != "")
                    words += "and ";

                var unitsMap = new[] { "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen" };
                var tensMap = new[] { "zero", "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety" };

                if (number < 20)
                    words += unitsMap[number];
                else
                {
                    words += tensMap[number / 10];
                    if ((number % 10) > 0)
                        words += "-" + unitsMap[number % 10];
                }
            }

            return words;
        }
    }
}