using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace CKDSurveillance_RD.UserControls.RDVersions
{
    public partial class StratYearsRD : System.Web.UI.UserControl
    {
        DataTable _dtStratyears;

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
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void updateYearRows(DataTable dt, string selStrat)
        {
            string qNum = Request.QueryString["QNum"].Trim();
            string url = Request.RawUrl;//(Example) -->  /ckd/detailButtons.aspx?Qnum=Q380            
            
            
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
                    hfCurrentYear.Value = chosenYear;
                }
                else
                {
                    dr["selected"] = 0;
                    dr["buttonLink"] = "~/images/GO.png";
                    dr["Link"] = "~/detail.aspx?Qnum=" + qNum + "&Strat=" + dr["ViewBy"].ToString().Trim() + "&Year=" + dr["Year"].ToString().Trim() + "#refreshPosition";
                }
            }


            //*Choose Defaults if necessary*
            if (string.IsNullOrEmpty(chosenYear))
            {
                dt.Rows[0]["selected"] = 1;
                dt.Rows[0]["buttonLink"] = "~/images/GO_clicked.png";
                dt.Rows[0]["Link"] = "";

                CurrentYear = dt.Rows[0]["Year"].ToString().Trim();
                hfCurrentYear.Value = CurrentYear;
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


            rptViewDataBy.DataSource = stratTable;
            rptViewDataBy.DataBind();


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

            //if (stratTable.Rows.Count < 2)
            //{
            //    rptViewDataBy.Visible = false;
            //}



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

            if (yrTableFiltered.Rows.Count > 1)
            {
                rptViewDataFor.DataSource = yrTableFiltered;
                rptViewDataFor.DataBind();
            }
            else
            {
                rptViewDataFor.Visible = false;
            }


            //*Handle illogical URL years*
            if ((Request.QueryString["Year"] != null))
            {
                string yrParam = Request.QueryString["Year"].Trim();

                DataView dvYearCheck = yrTableFiltered.DefaultView;
                
                dvYearCheck.RowFilter = "year in('" + yrParam + "')";

                if (dvYearCheck.ToTable().Rows.Count == 0)
                {
                    manageIllogicalURLParams();
                }
            }


            //*Set default properties first time*
            if (Session["CurrentStrat"] == null | Session["CurrentYear"] == null)
            {
                Session["CurrentStrat"] = stratTable.Rows[0]["ViewBy"].ToString().Trim();
                Session["CurrentYear"] = yrTableFiltered.Rows[0]["Year"].ToString().Trim();
            }
        }
        private void manageIllogicalURLParams()
        {
            //**********************************
            //*Strip url params and reload page*
            //**********************************
            string qnum = Request.QueryString["QNum"].Trim();
            string[] parser = Request.RawUrl.Split('?')[0].Split('/');
           
            //Example: /ckd/detailButtons.aspx?Qnum=Q380
            string pn = parser[parser.Length - 1].Trim();
            string newURL = "~/" + pn + "?QNum=" + qnum; //added ~/ 5/5/2020 - BS

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
            string url = Server.UrlDecode(Request.RawUrl); 
            
            //(Example) -->  /ckd/detailButtons.aspx?Qnum=Q380
            string chosenStrat = "";
            string chosenYear = "";

            if (url.Contains("&Strat"))
            {
                chosenStrat = Request.QueryString["Strat"].Trim().Replace("%2c+", ", ");//.Replace("%20", " ").Trim();
                CurrentStrat = chosenStrat;
            }

            if (url.Contains("&Year"))
            {
                chosenYear = Request.QueryString["Year"].Trim();//.Replace("%20", " ").Trim();
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
                    hfCurrentStrat.Value = chosenStrat;
                }
                else
                {
                    dr["selected"] = 0;
                    dr["buttonLink"] = "~/images/GO.png";
                    if (string.IsNullOrEmpty(chosenYear))
                    {
                        dr["Link"] = "~/detail.aspx?Qnum=" + qNum + "&Strat=" + dr["ViewBy"].ToString().Trim() + "#refreshPosition";
                    }
                    else
                    {
                        dr["Link"] = "~/detail.aspx?Qnum=" + qNum + "&Strat=" + dr["ViewBy"].ToString().Trim() + "&Year=" + chosenYear.Trim() + "#refreshPosition";
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
                hfCurrentStrat.Value = CurrentStrat;
            }

        }
    }
}