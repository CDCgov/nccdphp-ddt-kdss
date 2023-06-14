using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CKDSurveillance_RD
{
    public partial class AreYouAware : Classes.NCCDPage// 9/24 updated per Alex System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string emailDate = "June_2023";
            string monthname = "";
            string yearval = "";

            if (Request.QueryString["emailDate"] != null)
            {                
                emailDate = Request.QueryString["emailDate"].Trim();
                monthname = emailDate.Substring(0, emailDate.IndexOf("_"));
                yearval = emailDate.Substring(emailDate.Length - 4);

                int resultint;
                
                if(int.TryParse(monthname, out resultint))
                {
                    monthname = findMonthName(monthname);
                    yearval = emailDate.Substring(emailDate.Length-4);

                    //hard coded for the scenario of two email sent during March 2016
                    if (monthname == "March" && yearval == "2016")
                    {
                        string day = emailDate.Substring(emailDate.IndexOf("_") + 1);//finding the value between the two underscores
                        day = day.Substring(0, day.IndexOf("_"));

                        if (day == "23")
                            emailDate = "March_2016_2";
                        else
                            emailDate = "March_2016";
                    }
                    else
                        emailDate = monthname + "_" + yearval;//this is the value that will be used for most scenarios
                }
            }

            HF_initialdate.Value = emailDate;            

            

            //********************
            //*Populate Meta Tags* (March 2020)
            //********************            
            string mtDesc = "<meta name=\"description\" content=\"Centers for Disease Control and Prevention (CDC) : CKD Surveillance: Chronic Kidney Disease Surveillance System for " + monthname + ", " + yearval + " - Are You Aware Communication\"/>";
            Literal lit = (Literal)Master.FindControl("litMetaTagsDescription");
            lit.Text = mtDesc;
        }

        protected string findMonthName(string mval)
        {
            string monthname = "January";

            if (mval == "1") monthname = "January";
            else if (mval == "2") monthname = "February";
            else if (mval == "3") monthname = "March";
            else if (mval == "4") monthname = "April";
            else if (mval == "5") monthname = "May";
            else if (mval == "6") monthname = "June";
            else if (mval == "7") monthname = "July";
            else if (mval == "8") monthname = "August";
            else if (mval == "9") monthname = "September";
            else if (mval == "10") monthname = "October";
            else if (mval == "11") monthname = "November";
            else if (mval == "12") monthname = "December";
            if (mval == "1") monthname = "January";

            return monthname;

        }
    }
}