using System;
using System.Data;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CKDSurveillance_RD.UserControls.RDVersions
{
    public partial class ChooseStratLong : System.Web.UI.UserControl
    {

        public List<string> YearList
        {
            get
            {
                if (Session["listYears"] == null)
                {
                    //*Create a list of included years*
                    List<string> listYears = new List<string>();
                    foreach (Control ctrl in pnlYearsCBs.Controls)
                    {
                        if (ctrl.GetType() == typeof(CheckBox))
                        {
                            CheckBox cb = (CheckBox)ctrl;

                            string yr = cb.Attributes["dbField"].ToString().Trim();
                            if (!listYears.Contains(yr) && cb.Checked == true)
                            {
                                listYears.Add(yr);
                            }
                        }
                    }

                    Session["listYears"] = listYears;
                    return listYears;
                }
                else
                {
                    return (List<string>)Session["listYears"];
                }
            }
        }
        public List<string> StratList
        {
            get
            {
                if (Session["listStrats"] == null)
                {

                    //*Create a list of included Strats*
                    List<string> listStrats = new List<string>();
                    foreach (Control ctrl in pnlStrats.Controls)
                    {
                        if (ctrl.GetType() == typeof(CheckBox))
                        {
                            CheckBox cb = (CheckBox)ctrl;

                            string strat = cb.Attributes["dbField"].ToString().Trim();
                            if (!listStrats.Contains(strat) && cb.Checked == true)
                            {
                                listStrats.Add(strat);
                            }
                        }
                    }
                    Session["listStrats"] = listStrats;

                    return listStrats;
                }
                else
                {
                    return (List<string>)Session["listStrats"];
                }
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    checkAllChosenStrats();
                    checkAllChosenYears();
                }
                catch (Exception ex)
                {
                    string err = ex.Message;
                    //Don't fail - just keep going.
                }
            }
        }

        protected void btnSubmitStratChoices_Click(object sender, EventArgs e)
        {
            //Put the lists into the ViewState
            Session["listYears"] = null;
            Session["listStrats"] = null;


            //*Create a list of included years*
            List<string> listYears = new List<string>();            
            foreach (Control ctrl in pnlYearsCBs.Controls)
            {
                if (ctrl.GetType() == typeof(CheckBox))
                {
                    CheckBox cb = (CheckBox)ctrl;

                    string yr = cb.Attributes["dbField"].ToString().Trim();
                    if(!listYears.Contains(yr) && yr.ToLower() != "all years" && cb.Checked == true)
                    {
                        listYears.Add(yr);
                    }
                }
            }


            //*Create a list of included Strats*
            List<string> listStrats = new List<string>();
            foreach (Control ctrl in pnlStrats.Controls)
            {
                if (ctrl.GetType() == typeof(CheckBox))
                {
                    CheckBox cb = (CheckBox)ctrl;

                    string strat = cb.Attributes["dbField"].ToString().Trim();
                    if (!listStrats.Contains(strat) && strat.ToLower() != "all strats"  && cb.Checked == true)
                    {
                        listStrats.Add(strat);
                    }
                }
            }


            //Handle empty years/Strats
            if (listStrats.Count == 0)
            {
                listStrats.Add("unmeasured");
            }
            if (listYears.Count == 0)
            {
                listYears.Add("2011");
            }


            //Put the lists into the ViewState
            Session["listYears"] = listYears;
            Session["listStrats"] = listStrats;


            


            string curqnum = Request.QueryString["Qnum"].ToString();
            string url = Uri.EscapeUriString("~/detailCYOS.aspx?Qnum=" + curqnum + "#refreshPosition"); //Fortify fix
            Response.Redirect(url);
        }

        private void checkAllChosenStrats()
        {
            if (StratList != null)
            {
                //prevent unecessary cycles
                List<string> sl = StratList;


                //Iterate and check necessary Strats
                foreach (Control ctrl in pnlStrats.Controls)
                {
                    if (ctrl.GetType() == typeof(CheckBox))
                    {
                        CheckBox cb = (CheckBox)ctrl;

                        string strat = cb.Attributes["dbField"].ToString();
                        if (sl.Contains(strat))
                        {
                            cb.Checked = true;
                        }
                    }
                }                
            }
        }
        private void checkAllChosenYears()
        {
            if (YearList != null)
            {
                //prevent unecessary cycles
                List<string> yl = YearList;


                //Iterate and check necessary Years
                foreach (Control ctrl in pnlYearsCBs.Controls)
                {
                    if (ctrl.GetType() == typeof(CheckBox))
                    {
                        CheckBox cb = (CheckBox)ctrl;

                        string strat = cb.Attributes["dbField"].ToString();
                        if (yl.Contains(strat))
                        {
                            cb.Checked = true;
                        }
                    }
                }
            }
        }

        /*
        public void loadChoices(DataTable dt, DataTable dtpage)
        {
            List<string> strats1 = new List<string>();
            List<string> strats2 = new List<string>();
            List<string> stratsYears = new List<string>();

            foreach (DataRow dr in dt.Rows)
            {
                //fill strats2 - if available
                if (!string.IsNullOrWhiteSpace(dr["Tertiary"].ToString()))
                {
                    string s1 = dr["Tertiary"].ToString().Trim();
                    if (!strats1.Contains(s1))
                    {
                        strats1.Add(s1);
                    }
                }

                //fill strats1
                string s2 = dr["Secondary"].ToString().Trim();
                if (!strats2.Contains(s2))
                {
                    strats2.Add(s2);
                }
            }

            foreach(DataRow dr in dtpage.Rows)
            {
                //fill Years
                string sy = dr["Year"].ToString().Trim();
                if (!stratsYears.Contains(sy))
                {
                    stratsYears.Add(sy);
                }
            }

            //rptStratHeaders.DataSource = strats2;
            //rptStratHeaders.DataBind();
            rptChooseStrats.DataSource = strats2;
            rptChooseStrats.DataBind();


            //rptYearHeader.DataSource = stratsYears;
            //rptYearHeader.DataBind();
            rptChooseYears.DataSource = stratsYears;
            rptChooseYears.DataBind();

        }
         * */

        

    }
}