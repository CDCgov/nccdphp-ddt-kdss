using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ckdlibV2;

namespace CKDSurveillance_RD.UserControls
{
    public partial class StratYearsButtons : System.Web.UI.UserControl
    {

        DataTable _dtStratyears;

        public bool showQuintileColorRanges
        {            
            set
            {
                pnlQuintileRanges.Visible = value;
            }
        }
        public string CurrentQuintileSettings
        {
            //*Options*
            // Y - this year
            // A - all years
            // F - fixed 
            get
            {
                //Default is Fixed
                if (Session["currentQuintileSettings"] == null)
                {
                    Session["currentQuintileSettings"] = "A";
                }
                return Convert.ToString(Session["currentQuintileSettings"]);
            }
            set { Session["currentQuintileSettings"] = value; }
        }

        public string CurrentStrat
        {
            get { return Convert.ToString(Session["currentStrat"]); }
            set { Session["currentStrat"] = value; }
        }

        public string CurrentYear
        {
            get { return Convert.ToString(Session["currentYear"]); }
            set { Session["currentYear"] = value; }
        }
        public int yearCount
        {
            get 
            {
                if (Session["YearCount"] != null)
                {
                    return Convert.ToInt32(Session["YearCount"]);
                }
                else
                {
                    return 0;
                }                
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //Manage the button states of the Maps Quintile range Choices
            string cqs = this.CurrentQuintileSettings;
            switch (cqs.ToLower())
            {
                case "a":
                    btnColorsOneYear.ImageUrl = "~/images/Go.png";
                    btnColorRangesAllCharts.ImageUrl = "~/images/Go_Clicked.png";
                    break;
                case "y":
                    btnColorsOneYear.ImageUrl = "~/images/Go_Clicked.png";
                    btnColorRangesAllCharts.ImageUrl = "~/images/Go.png";
                    break;
            }
        }

        private void updateYearRows(DataTable dt, string selStrat)
        {
            string qNum = Request.QueryString["QNum"].Trim();
            string url = Request.RawUrl;
            //(Example) -->  /KDSS/detailButtons.aspx?Qnum=Q380
            string chosenStrat = "";
            string chosenYear = "";

            //*Read URL for Params*
            if (url.Contains("&Strat"))
            {
                chosenStrat = Request.QueryString["Strat"].Trim().Replace("%20", " ").Trim();
                CurrentStrat = chosenStrat;
            }
            if (url.Contains("&Year"))
            {
                chosenYear = Request.QueryString["Year"].Trim().Replace("%20", " ").Trim();
                CurrentYear = chosenYear;
            }


            //*Populate Table values and set 'selected' value*
            foreach (DataRow dr in dt.Rows)
            {
                if (dr["Year"].ToString() == chosenYear)
                {
                    dr["selected"] = 1;
                    dr["Link"] = "";
                    dr["buttonLink"] = "~/images/GO_clicked.png";
                }
                else
                {
                    dr["selected"] = 0;
                    dr["buttonLink"] = "~/images/GO.png";
                    dr["Link"] = "~/detail.aspx?Qnum=" + qNum + "&Strat=" + HttpUtility.UrlEncode(dr["ViewBy"].ToString().Trim()) + "&Year=" + HttpUtility.UrlEncode(dr["Year"].ToString().Trim()) + "#refreshPosition";
                }
            }


            //*Choose Defaults if necessary*
            if (string.IsNullOrEmpty(chosenYear))
            {
                dt.Rows[0]["selected"] = 1;
                dt.Rows[0]["buttonLink"] = "~/images/GO_clicked.png";
                dt.Rows[0]["Link"] = "";

                CurrentYear = dt.Rows[0]["Year"].ToString().Trim();
            }

        }
        public void loadStratsAndYears(DataTable dt)
        {
            _dtStratyears = dt;


            //------------------
            //--==* STRATS *==--
            //------------------



            //*Populate the strats*
            DataView dvStrat = new DataView(_dtStratyears);
            DataTable stratTable = dvStrat.ToTable(true, "ViewBy");


            //*Find the Selected Strat*
            string selectedStrat = Request.QueryString["Strat"];
            if (string.IsNullOrEmpty(selectedStrat))
            {
                selectedStrat = stratTable.Rows[0]["ViewBy"].ToString().Trim();
            }


            //*Add two columns [link + selected]*
            stratTable = AddLinkSelectedColumns(stratTable);
            updateStratRows(stratTable);


            rptStratButtons.DataSource = stratTable;
            rptStratButtons.DataBind();


            //*Handle illogical URL strats*
            if ((Request.QueryString["Strat"] != null))
            {
                string stratParam = Request.QueryString["Strat"].Trim();
                DataView dvStratCheck = stratTable.DefaultView;

                dvStratCheck.RowFilter = "viewby in ('" + stratParam + "')";

                if (dvStratCheck.ToTable().Rows.Count == 0)
                {
                    manageIllogicalURLParams();
                }
            }


            //-----------------
            //--==* YEARS *==--
            //-----------------


            //*Populate the appropriate Years*
            DataView dvYear = new DataView(_dtStratyears);
            DataTable yrTable = dvYear.ToTable();

            


            //*Add needed columns & filter rows based on chosen strat*
            yrTable = AddLinkSelectedColumns(yrTable);
            DataView yrDV = yrTable.DefaultView;

            if (stratTable.Rows.Count > 0)
            {                
                yrDV.RowFilter = "viewby in ('" + selectedStrat + "')";
                yrDV.Sort = "Year Desc";
            }


            //*Populate Years table info*
            DataTable yrTableFiltered = yrDV.ToTable();
            updateYearRows(yrTableFiltered, selectedStrat);

            rptYearButtons.DataSource = yrTableFiltered;
            rptYearButtons.DataBind();


            //*populate hiddenfield of years for the jQuery slider to reference*
            string yrsCSV = "";
            yrDV.Sort = "Year Asc";
            DataTable tempYrDT = yrDV.ToTable();
            foreach (DataRow dr in tempYrDT.Rows)
            {
                yrsCSV += dr["Year"].ToString() + ",";
            }
            yrsCSV = yrsCSV.TrimEnd(',',' ');
            hfCSVYears.Value = yrsCSV;


            //Store the number of years for this strat
            Session["YearCount"] = yrTableFiltered.Rows.Count.ToString();


            //*Handle illogical URL years*
            if ((Request.QueryString["Year"] != null))
            {
                string yrParam = Request.QueryString["Year"].Trim();

                DataView dvYearCheck = yrTableFiltered.DefaultView;
                
                dvYearCheck.RowFilter = "year in('" + yrParam + "')";

                if (dvYearCheck.Count == 0)
                {
                    manageIllogicalURLYearParams();
                }
            }



            //*Set default properties first time*
            if (Session["CurrentStrat"] == null | Session["CurrentYear"] == null)
            {
                Session["CurrentStrat"] = stratTable.Rows[0]["ViewBy"].ToString().Trim();
                Session["CurrentYear"] = yrTableFiltered.Rows[0]["Year"].ToString().Trim();
            }

            if (Session["currentQuintileSettings"] == null)
            {
                Session["currentQuintileSettings"] = "A";
            }
        }
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
        private DataTable AddLinkSelectedColumns(DataTable dt)
        {

            DataTable dtAnswer = dt;

            DataColumn dcLink = new DataColumn("link", typeof(string));
            DataColumn dcSelected = new DataColumn("selected", typeof(int));
            DataColumn dcButtonLink = new DataColumn("buttonLink", typeof(string));

            dtAnswer.Columns.Add(dcLink);
            dtAnswer.Columns.Add(dcSelected);
            dtAnswer.Columns.Add(dcButtonLink);

            return dtAnswer;
        }
        private void updateStratRows(DataTable dt)
        {
            string qNum = Request.QueryString["QNum"].Trim();
            string url = Request.RawUrl;

            //(Example) -->  /KDSS/detailButtons.aspx?Qnum=Q380
            string chosenStrat = "";
            string chosenYear = "";

            if (url.Contains("&Strat"))
            {
                chosenStrat = Request.QueryString["Strat"].Trim().Replace("%20", " ").Trim();
                CurrentStrat = chosenStrat;
            }

            if (url.Contains("&Year"))
            {
                chosenYear = Request.QueryString["Year"].Trim().Replace("%20", " ").Trim();
                //chosenYear = chosenYear;
            }


            //*Populate Table values and set 'selected' value*
            foreach (DataRow dr in dt.Rows)
            {
                if (dr["ViewBy"].ToString() == chosenStrat)
                {
                    dr["selected"] = 1;
                    dr["Link"] = "";
                    dr["buttonLink"] = "~/images/GO_clicked.png";
                }
                else
                {
                    dr["selected"] = 0;
                    dr["buttonLink"] = "~/images/GO.png";
                    if (string.IsNullOrEmpty(chosenYear))
                    {
                        dr["Link"] = "~/detail.aspx?Qnum=" + qNum + "&Strat=" + HttpUtility.UrlEncode(dr["ViewBy"].ToString().Trim()) + "#refreshPosition";
                    }
                    else
                    {
                        dr["Link"] = "~/detail.aspx?Qnum=" + qNum + "&Strat=" + HttpUtility.UrlEncode(dr["ViewBy"].ToString().Trim()) + "&Year=" + HttpUtility.UrlEncode(chosenYear.Trim()) + "#refreshPosition";
                    }

                }
            }

            //*Choose Defaults if necessary*
            if (string.IsNullOrEmpty(chosenStrat))
            {
                dt.Rows[0]["selected"] = 1;
                dt.Rows[0]["buttonLink"] = "~/images/GO_clicked.png";
                dt.Rows[0]["Link"] = "";

                CurrentStrat = dt.Rows[0]["ViewBy"].ToString().Trim();
            }

        }

        protected void rptYearButtons_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item | e.Item.ItemType == ListItemType.AlternatingItem)
            {
                //*Hide the button if there is only one strat
                DataTable dt = (DataTable)((Repeater)sender).DataSource;

                if (dt.Rows.Count == 1)
                {
                    Image img = (Image)e.Item.FindControl("imgYearnav");
                    if (img != null)
                    {
                        rptYearButtons.Visible = false;
                        pnlYears.Visible = false;                        
                    }
                }
            }
        }
        protected void rptStratButtons_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item | e.Item.ItemType == ListItemType.AlternatingItem)
            {
                //*Hide the button if there is only one strat
                DataTable dt = (DataTable)((Repeater)sender).DataSource;
                ;
                if (dt.Rows.Count == 1)
                {
                    Image img = (Image)e.Item.FindControl("imgStratnav");
                    img.Visible = false;
                }
            }
        }


        //*Map color distribution*      
        protected void btnColorsOneYear_Click(object sender, ImageClickEventArgs e)
        {
            this.CurrentQuintileSettings = "Y";
            string url = Uri.EscapeUriString(getCurrentURL()); //Fortify fix
            Response.Redirect(url);
        }

        protected void btnColorRangesAllCharts_Click(object sender, ImageClickEventArgs e)
        {
            this.CurrentQuintileSettings = "A";
            string url = Uri.EscapeUriString(getCurrentURL()); //Fortify fix
            Response.Redirect(url);
        }

        private string getCurrentURL()
        {
            string answer = "";
            answer = HttpContext.Current.Request.Url.AbsoluteUri;
            return answer;
        }
    }
}