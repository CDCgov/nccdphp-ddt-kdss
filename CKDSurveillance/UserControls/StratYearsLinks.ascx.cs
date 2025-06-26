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
    public partial class StratYearsLinks : System.Web.UI.UserControl
    {

        DataTable _dtStratyears;

        public bool MultiMapsChecked
        {
            get
            {
                return cbMultimaps.Checked;                
            }
        }
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

        bool boolViewDataByVisible = false;   
        public bool IsViewDataByVisible
        {
            get {
                return boolViewDataByVisible;
            }
            set {
                boolViewDataByVisible = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //Manage the button states of the Maps Quintile range Choices
            string cqs = this.CurrentQuintileSettings;
            switch (cqs.ToLower())
            {
                case "a":

                    btnOneYear.Visible = true;
                    btnAll.Visible = false;

                    litAll.Text = "<span id='spnAll' class='curMapSetting btnClicked'>Across All Charts</span>";
                    litAll.Visible = true;
                    litOneYear.Visible = false;

                    break;
                case "y":

                    btnAll.Visible = true;
                    btnOneYear.Visible = false;
                                        
                    litOneYear.Text = "<span id='spnChosenYear' class='curMapSetting'>Chosen Year</span>";
                    litOneYear.Visible = true;
                    litAll.Visible = false;

                    break;
            }

            //*Note- check the detail.aspx javascript for more page interactions
            //* Specifically how the checkbox for the show over time appears - it is triggered off the presence of the 'btnClicked' css class
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
            string qNum = Request.QueryString["QNum"].Trim();



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
            divViewDataBy.Visible = true;

            //Do not show strat name on map pages
            if (qNum.ToLower() != "q69" && qNum.ToLower() != "q96" && qNum.ToLower() != "q235" && qNum.ToLower() != "q600")
            {
                if (Request.RawUrl.ToLower().Contains("detaillhf2.aspx"))
                {
                    if (stratTable.Rows.Count > 2)
                    {
                        // populateStrats(stratTable);
                        if(!populateStratsDropDown(stratTable))
                            divViewDataBy.Visible = false;
                    }                    
                }
                else
                {
                    //populateStrats(stratTable);
                    if(!populateStratsDropDown(stratTable))
                        divViewDataBy.Visible= false;
                }
            }

            IsViewDataByVisible = divViewDataBy.Visible;

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
                yrDV.Sort = "StratificationDisplayOrder DESC";
            }


            //*Populate Years table info*
            DataTable yrTableFiltered = yrDV.ToTable();
            updateYearRows(yrTableFiltered, selectedStrat);
            //populateYearsDropDown(yrTableFiltered);


            //*populate hiddenfield of years for the jQuery slider to reference*
            string yrsCSV = "";
            yrDV.Sort = "StratificationDisplayOrder DESC";
            DataTable tempYrDT = yrDV.ToTable();
            foreach (DataRow dr in tempYrDT.Rows)
            {
                yrsCSV += dr["Year"].ToString() + ",";
            }
            yrsCSV = yrsCSV.TrimEnd(',',' ');
            hfCSVYears.Value = yrsCSV;


            //Store the number of years for this strat
            Session["YearCount"] = yrTableFiltered.Rows.Count.ToString();

            //Store the strat
            Session["Strat"] = selectedStrat.ToString();

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

        private void populateStrats(DataTable stratTable)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div class='dataSourceRBTitle'>&nbsp;&nbsp;View Data By:</div>");
            sb.Append("<ul class='stratLinks'>");

            foreach (DataRow dr in stratTable.Rows)
            {
                sb.Append("<li>");
                if (Convert.ToInt32(dr["selected"]) != 1)
                {
                    sb.Append("<a href='" + dr["link"].ToString().Replace("~/", "").Trim() + "'>");
                    sb.Append(dr["ViewBy"].ToString().Trim());
                    sb.Append("</a>");
                }
                else if(Convert.ToInt32(dr["selected"]) == 1)
                {
                    sb.Append("<strong>" + dr["ViewBy"].ToString().Trim() + "</strong>"); //adding boldness to the selected data
                }
                
                sb.Append("</li>");
            }
            sb.Append("</ul>");

            litStratText.Text = sb.ToString().Trim();

        }

        private bool populateStratsDropDown(DataTable stratTable)
        {
            string qnum = Request.QueryString["QNum"].Trim();

            StringBuilder sbInst = new StringBuilder();
            StringBuilder sb = new StringBuilder();
            if (qnum == "Q700") {
                sb.Append("<div class=\"viewDataByLabel\">Select Data Source</div>");
                sb.Append("<select id=\"cbViewDataBy\" class=\"form-control\"  style=\"appearance:auto\" onchange=\"openViewDataBy(this.value);\" aria-label=\"Select Data Source\" >");
            }
            else
            {
                sb.Append("<div class=\"viewDataByLabel\">Select Risk Category</div>");
                sb.Append("<select id=\"cbViewDataBy\" class=\"form-control\" style=\"appearance:auto\" onchange=\"openViewDataBy(this.value);\" aria-label=\"Select Risk Category\" >");
            }

            int i = 0;

            foreach (DataRow dr in stratTable.Rows)
            {
                i++;
                if (Convert.ToInt32(dr["selected"]) != 1)
                {
                    sb.Append("<option value='" + dr["link"].ToString().Replace("~/", "").Trim() + "'>");
                    sb.Append(dr["ViewBy"].ToString().Trim());
                    sb.Append("</option>");

                }
                else if (Convert.ToInt32(dr["selected"]) == 1)
                {
                    sb.Append("<option selected>" + dr["ViewBy"].ToString().Trim() + "</option>");
                }

                if(i< stratTable.Rows.Count)
                    sbInst.Append("<span class=\"spnRiskCategory\">" + dr["ViewBy"].ToString().Trim() + "</span>, ");
                else
                    sbInst.Append("and <span class=\"spnRiskCategory\">" + dr["ViewBy"].ToString().Trim() + "</span>.");
            }

            sb.Append("</select>");

            litStratText.Text = sb.ToString().Trim();

            return (stratTable.Rows.Count > 1);
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
            string newURL = "~/" + pn + "?QNum=" + qnum; //added ~/ 5/5/2020 - BS
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

            string newURL = "~/" + completeURL.Replace(completeYearParam, "").Trim(); //added ~/ 5/5/2020 - BS
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
            string topic = "";

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

            if (url.Contains("&topic"))
            {
                topic = Request.QueryString["topic"].Trim().Replace("%20", " ").Trim();
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
                    var qNumTopic = qNum;
                    if (!string.IsNullOrEmpty(topic))
                    {
                        qNumTopic = qNum + "&topic=" + topic;
                    }

                    if (string.IsNullOrEmpty(chosenYear))
                    {
                        dr["Link"] = "~/detail.aspx?Qnum=" + qNumTopic + "&Strat=" + HttpUtility.UrlEncode(dr["ViewBy"].ToString().Trim()) + "#refreshPosition";
                    }
                    else
                    {
                        dr["Link"] = "~/detail.aspx?Qnum=" + qNumTopic + "&Strat=" + HttpUtility.UrlEncode(dr["ViewBy"].ToString().Trim()) + "&Year=" + HttpUtility.UrlEncode(chosenYear.Trim()) + "#refreshPosition";
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
       


        //*Map color distribution*      
        protected void btnColorRangesAllCharts_Click(object sender, EventArgs e)
        {
            this.CurrentQuintileSettings = "A";
            string url = Uri.EscapeUriString(getCurrentURL()); //Fortify fix
            Response.Redirect(url);
        }
        protected void btnColorsOneYear_Click(object sender, EventArgs e)
        {
            this.CurrentQuintileSettings = "Y";
            string url = Uri.EscapeUriString(getCurrentURL()); //Fortify fix
            Response.Redirect(url);
        }


        private string getCurrentURL()
        {
            string answer = "";
            answer = HttpContext.Current.Request.Url.AbsoluteUri;
            return answer;
        }

        protected void cbMultimaps_CheckedChanged(object sender, EventArgs e)
        {

        }

              
    }
}