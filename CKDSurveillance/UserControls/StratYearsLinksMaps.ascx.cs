using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using ckdlibV2;

namespace CKDSurveillance_RD.UserControls
{
    public partial class StratYearsLinksMaps : System.Web.UI.UserControl
    {

        /* September 2017
         * This was built for the V5.8 release for November 2017
         * 
         * In an effort to offer greater clarity for what the color changes signify,
         * this left-bar nav was added as a means to seperate the logic from the usual chart nav.
         * 
         * Changes were also required in the detail.aspx page:
         *  > adding this user control
         *  > JQuery items at bottom on detail.aspx
         *  > ShowSlider hidden field
         *  
         */


        public void loadYears(DataTable dt, string qnum)
        {
            //*Populate the appropriate Years*
            DataView dvYear = new DataView(dt);



            //What year, if any was selected?
            string yrParam = "";
            if (Request.QueryString["Year"] != null)
            {
                yrParam = Request.QueryString["Year"].Trim();


                //*Handle illogical URL years*
                dvYear.RowFilter = "year in('" + yrParam + "')";
                if (dvYear.Count == 0)
                {
                    manageIllogicalURLYearParams();
                }
            }
                        
            


            //Build Year List
            string yr = "";
            string liEntryAllYears = "";
            string liEntrySelectedYear = "";
            string yrsCSV = "";
            string whatNavToShow = "s";
            StringBuilder sbSelectedYear = new StringBuilder();
            StringBuilder sbAcrossAllYears = new StringBuilder();



            //What Nav to show?
            if (Request.QueryString["colors"] != null)
            {
                if (Request.QueryString["colors"].ToString().Trim() == "all")
                {
                    whatNavToShow = "a";
                }
            }
            hfMapWhatNavToShow.Value = whatNavToShow;


            //Start Lists
            sbSelectedYear.Append("<ul class='unstyled'>");
            sbAcrossAllYears.Append("<ul class='unstyled'>");
            


            //Manage All Year Link state for Across-all-years section            
            string showSlider = "0";
            if (Request.QueryString["showMapSlider"] != null)
            {
                showSlider = Request.QueryString["showMapSlider"].ToString().Trim();
            }

           
            if (showSlider == "1")
            {
                sbAcrossAllYears.Append("<li><span class='selectedItemFormat'>All Years</span></li>");
                hfMapWhatNavToShow.Value = "a";
            }
            else if (showSlider != "1")
            {
                sbAcrossAllYears.Append("<li><span class='spnAllYearsLink' onclick=\"adjustForAllYears();\">All Years</span></li>");
            }
            

            
            //Determine a chosen Year
            string chosenYear = "";
            if (Request.QueryString["Year"] != null)
            {
                chosenYear = Request.QueryString["Year"].ToString().Trim();
            }
            else if (showSlider == "1")
            {
                chosenYear = "0"; // will never match anything
            }
            else if(string.IsNullOrEmpty(chosenYear))
            {
                chosenYear = dt.Rows[dt.Rows.Count - 1]["Year"].ToString().Trim();
            }



            //Add all years to both boxes
            for (int i = dt.Rows.Count-1 ; i >= 0; i--)
            {
                yr = dt.Rows[i]["year"].ToString();
                if (yr == chosenYear)
                {
                    //Matching years should show  as clickable in the other group (all years or selected year)
                    if (whatNavToShow == "a")
                    {                        
                        liEntryAllYears = "<li class='selectedItemFormat'>" + yr + "</li>";
                        liEntrySelectedYear = "<li><a href='./Detail.aspx?QNum=" + qnum + "&Year=" + yr + "&colors=selected#refreshPosition'>" + yr + "</a></li>";
                    }
                    else
                    {
                        liEntrySelectedYear = "<li class='selectedItemFormat'>" + yr + "</li>";
                        liEntryAllYears = "<li><a href='./Detail.aspx?QNum=" + qnum + "&Year=" + yr + "&colors=all#refreshPosition'>" + yr + "</a></li>";
                    }                                        
                }
                else
                {
                    liEntryAllYears = "<li><a href='./Detail.aspx?QNum=" + qnum + "&Year=" + yr + "&colors=all#refreshPosition'>" + yr + "</a></li>";
                    liEntrySelectedYear = "<li><a href='./Detail.aspx?QNum=" + qnum + "&Year=" + yr + "&colors=selected#refreshPosition'>" + yr + "</a></li>";
                }


                sbSelectedYear.Append(liEntrySelectedYear);
                sbAcrossAllYears.Append(liEntryAllYears);

                yrsCSV += yr + ",";
            }



            //Remove extra comma from the list of years
            yrsCSV = yrsCSV.Substring(0, yrsCSV.Length - 1);


            //Reverse the (C)omma (S)eperated (V)alues array of years so the slider shows them in the correct order (low to high, left to right)
            string[] array = yrsCSV.Split(',');
            Array.Reverse(array);
            yrsCSV = string.Join(",", array);

            //*Populate hiddenfield of years for the jQuery slider to reference*            
            hfCSVYears.Value = yrsCSV;




            //Close the list
            sbSelectedYear.Append("</ul>");
            sbAcrossAllYears.Append("</ul>");



            //Place it on the page
            litAllYears.Text = sbAcrossAllYears.ToString();
            litSelectedYear.Text = sbSelectedYear.ToString();

        }


        #region Utilities

        private void manageIllogicalURLParams()
        {
            //**********************************
            //*Strip url params and reload page*
            //**********************************
            string qnum = Request.QueryString["QNum"].Trim();
            string[] parser = Request.RawUrl.Split('?')[0].Split('/');
            //Example: /KDSS/detailButtons.aspx?Qnum=Q380
            string pn = parser[parser.Length - 1].Trim();
            string newURL = pn + "?QNum=" + qnum;
            string url = Uri.EscapeUriString(newURL); //Fortify fix
            Response.Redirect(url);

        }
        private void manageIllogicalURLYearParams()
        {
            //***************************************
            //*Strip url year params and reload page*
            //***************************************                        
            string completeURL = Request.RawUrl;
            int yrLocation = completeURL.ToLower().LastIndexOf("&year");
            string completeYearParam = completeURL.Substring(yrLocation, 10);

            string newURL = completeURL.Replace(completeYearParam, "").Trim();
            string url = Uri.EscapeUriString(newURL); //Fortify fix
            Response.Redirect(url);

        }

        #endregion

    }
}