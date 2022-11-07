using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using ckdlibV2;

namespace CKDSurveillance_RD.UserControls
{
    public partial class DetailCategoryControl : System.Web.UI.UserControl
    {
        #region Properties

        public string QNum
        {
            get
            {
                object o = null;
                o = ViewState["QNum"];
                if (o != null)
                {
                    return Convert.ToString(o);
                }
                else
                {
                    return "";
                }
            }
            set { ViewState["QNum"] = value; }
        }
        public int IndicatorId
        {

            get
            {
                if (ViewState["IndicatorId"] != null)
                {
                    return (int)ViewState["IndicatorId"];
                }
                else
                {
                    return 0;
                }

            }
            set { ViewState["IndicatorId"] = value; }
        }
        public int CategoryId
        {

            get
            {
                if (ViewState["CategoryId"] != null)
                {
                    return (int)ViewState["CategoryId"];
                }
                else
                {
                    return 0;
                }

            }
            set { ViewState["CategoryId"] = value; }
        }
        private string splashScreen
        {
            get
            {
                object o = null;
                o = ViewState["splashscreen"];
                if ((o != null))
                {
                    return Convert.ToString(o);
                }
                else
                {
                    ViewState["splashscreen"] = "H";
                    return "H";
                }
            }
            set { ViewState["splashscreen"] = value; }
        }
        public Unit CategoriesComboBoxWidth
        {
            get
            {
                object o = null;
                o = ViewState["CategoriesComboBoxWidth"];
                if (o != null)
                {
                    return (Unit)o;
                }
                else
                {
                    return new Unit("60%");
                }
            }
            set { ViewState["CategoriesComboBoxWidth"] = value; }
        }
        public Unit IndicatorsComboBoxWidth
        {
            get
            {
                object o = null;
                o = ViewState["IndicatorsComboBoxWidth"];
                if (o != null)
                {
                    return (Unit)o;
                }
                else
                {
                    return new Unit("60%");
                }
            }
            set { ViewState["IndicatorsComboBoxWidth"] = value; }
        }
        public bool CategoryOnlyChange
        {
            get
            {
                object o = null;
                o = ViewState["CategoryOnlyChange"];
                if (o != null)
                {
                    return Convert.ToBoolean(o);
                }
                else
                {
                    return false;
                }
            }
            set { ViewState["CategoryOnlyChange"] = value; }
        }
        
        #endregion


        protected void Page_Load(object sender, EventArgs e)
        {


        }

        #region DropDownEvents

        protected void RadComboBoxIndicators_DataBound(object sender, EventArgs e)
        {
            DropDownList s = (DropDownList)sender;
            if (s.Items.Count > 1)
            {
                s.Enabled = true;
            }
            else
            {
                s.Enabled = false;
            }
        }        
        protected void RadComboBoxIndicators_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            //*Indicate that the indicator has changed also*
            CategoryOnlyChange = false;

            //************************************
            //*Handle the selection splash screen*
            //************************************
            if (Page.GetType().BaseType.Name.ToLower() == "detail")
            {
                switch (splashScreen)
                {
                    case "H":
                        //*Put up the splash screen to indicate the selection doesn't match the displayed data
                        //ToggleScreen("S");

                        //*Indicate which control was changed*
                        if (Convert.ToString(Session["ddlChanged"]) != "Category")
                        {
                            Session["ddlChanged"] = "Indicator";
                        }
                        break;
                    //case "S":
                        //Ensure the screen is showing
                        //ToggleScreen("S");
                      //  break;

                }
            }



            //***********************************
            //*Send the Visitor to the new Chart*
            //***********************************
            if (RadComboBoxIndicators.SelectedValue != "-1")
            {
                QNum = RadComboBoxIndicators.SelectedValue;


                //clearSessionVariables()


                ToggleGoButton(true);


                hfIndicatorsDirty.Value = "1";


                //*Ensure that the Go button has the focus*
                cmdFindHealthData.Focus();


                //RaiseEvent Selected(Integer.Parse(CategoryId), QNum)
            }

        }
        protected void RadComboBoxCategories_SelectedIndexChanged(object sender, EventArgs e)
        {
            //*Indicate that only the category has changed*
            CategoryOnlyChange = true;

            this.CategoryId = Convert.ToInt32(RadComboBoxCategories.SelectedValue);


            //************************************
            //*Handle the selection splash screen*
            //************************************            
            if (Page.GetType().BaseType.Name.ToLower() == "detail")
            {
                switch (splashScreen)
                {
                    case "H":
                        //*Put up the splash screen to indicate the selection doesn't match the displayed data
                        //ToggleScreen("S");

                        //*Indicate which drop down changed*
                        Session["ddlChanged"] = "Category";
                        break;
                }
            }

            Populate_IndicatorDropDown();


            //Always disable the submit button after having chosen the category
            ToggleGoButton(false);

            hfTopicsDirty.Value = "1";

            //*Ensure the Indicators now has the focus*
            RadComboBoxIndicators.Focus();


        }
        #endregion

        #region Populate

        private void Populate_IndicatorDropDown(bool revert = false)
        {
            //*Current Value before reloading*
            string cur_Value = RadComboBoxIndicators.SelectedValue;


            //*Clear*        
            RadComboBoxIndicators.ClearSelection();
            RadComboBoxIndicators.Items.Clear();
            RadComboBoxIndicators.Text = string.Empty;



            //**************************************
            //*Get the Indicator Values from the DB*
            //**************************************
            DataTable dt = null;
            ArborDataAccessV2 DAL = null;
            string measureID = this.RadComboBoxCategories.SelectedValue;

            DAL = new ArborDataAccessV2();
            dt = DAL.getIndicatorsFromMeasureID(measureID);



            //**************************************************
            //*Populate and Format The Dropdown Indicator Items*
            //**************************************************
            ListItem liD = new ListItem("Please select an indicator to continue ...", "-1");
            if (!RadComboBoxIndicators.Items.Contains(liD))
            {
                RadComboBoxIndicators.Items.Add(liD);
            }

            foreach (DataRow dr in dt.Rows)
            {
                ListItem liIndicator = new ListItem();
                //New RadComboBoxItem

                liIndicator.Text = dr["IndicatorText"].ToString();
                liIndicator.Value = dr["IndicatorCode"].ToString();
                liIndicator.Attributes.Add("style", "color:black;");
                liIndicator.Attributes.Add("title", dr["IndicatorText"].ToString());

                RadComboBoxIndicators.Items.Add(liIndicator);
            }

            //*Enable the indicators*
            RadComboBoxIndicators.Enabled = true;


            //**********************************************************
            //*If this is a revert request, find the selected indicator*
            //**********************************************************        
            if (revert == true)
            {
                QNum = Convert.ToString(Request.QueryString["QNum"]);
                RadComboBoxIndicators.Items.RemoveAt(0);
                RadComboBoxIndicators.SelectedValue = QNum;
                //*This is set above in this event*
                return;
            }

            //*If we have only changed the category ddl, don't select any indicator, etc*
            if (CategoryOnlyChange == true)
            {
                return;
            }


            //*********************************************
            //*Locate and select the appropriate Indicator*
            //********************************************* 

            //*Default to selecting first item*
            if (RadComboBoxIndicators.Items.Count > 0)
            {
                RadComboBoxIndicators.SelectedIndex = 0;
            }


            string queryString_QNum = "";
            if (Request.QueryString["QNum"] != null)
            {
                queryString_QNum = Request.QueryString["QNum"];
            }


            //*If this is not a redirect, first time through (again)*
            if (!string.IsNullOrEmpty(cur_Value) && cur_Value != "-1")
            {
                foreach (ListItem li in RadComboBoxIndicators.Items)
                {
                    if (li.Value == cur_Value)
                    {
                        li.Selected = true;
                        break; // TODO: might not be correct. Was : Exit For
                    }
                }
                RadComboBoxIndicators.Items.RemoveAt(0);
                //*Try the Viewstate*
            }
            else if (QNum != null)
            {

                if (!string.IsNullOrEmpty(QNum))
                {
                    bool found = false;
                    foreach (ListItem liTemp in RadComboBoxIndicators.Items)
                    {
                        if (liTemp.Value == QNum)
                        {
                            found = true;
                            break; // TODO: might not be correct. Was : Exit For
                        }
                    }

                    if (found == true)
                    {
                        RadComboBoxIndicators.Items.RemoveAt(0);
                        RadComboBoxIndicators.SelectedValue = QNum;
                    }
                    else
                    {
                        //*Try to select by text (in case this is a page/chart with dual datasources)
                        selectIndicatorByText();
                    }
                }
                //*Try the Query string
            }
            else if (!string.IsNullOrEmpty(queryString_QNum))
            {
                RadComboBoxIndicators.Items.RemoveAt(0);
                RadComboBoxIndicators.SelectedValue = queryString_QNum;
            }
            else
            {
                //*Try to select by text (in case this is a page/chart with dual datasources)
                selectIndicatorByText();
            }
        }
        private void Populate_CategoryDropDown()
        {
            DataTable categoriesAndSubcategories = null;
            ListItem liCategory = null;
            string strHP2020 = ConfigurationManager.AppSettings["HP2020"];
           

            //**************
            //*Get the Data*
            //**************
            if (Cache["TopicsDDL"] != null)
            {
                //From Cache
                categoriesAndSubcategories = (DataTable)Cache["TopicsDDL"];
            }
            else
            {
                //From DB
                ArborDataAccessV2 DAL = new ArborDataAccessV2();
                try
                {
                    categoriesAndSubcategories = DAL.getTopicsAndMeasures();

                    if (categoriesAndSubcategories.Rows.Count > 1)
                    {
                        Cache["TopicsDDL"] = categoriesAndSubcategories;
                    }
                }
                catch (Exception ex)
                {
                    Response.Redirect("~/Error.aspx");
                }
            }



            //********************
            //*Clean and Populate*
            //********************
            RadComboBoxCategories.Items.Clear();

            liCategory = new ListItem("Select Topic", "-1");
            RadComboBoxCategories.Items.Add(liCategory);

            string groupText = "";

            foreach (DataRow dr in categoriesAndSubcategories.Rows)
            {
                //
                if (dr["Level"].ToString() == "1")
                {
                    groupText = dr["Text"].ToString();
                }
                else
                {
                    liCategory = new ListItem(dr["Text"].ToString(), dr["ID"].ToString());

                    liCategory.Attributes.Add("OptionGroup", groupText);
                    liCategory.Attributes.Add("title", dr["Text"].ToString());

                    RadComboBoxCategories.Items.Add(liCategory);
                }
            }


        }

        #endregion

        #region utilities

        private void clearSessionVariables()
        {
            Session["ddlChanged"] = null;
            Session["selIndValue"] = null;
            Session["chartID"] = null;
            Session["strats"] = null;            //* Controls previously selected item in Strat RadioButton List (Detail.aspx.vb)
            Session["yrs"] = null;               //* Controls previously selected item in  Year RadioButton List (Detail.aspx.vb)
            Session["KPStayOpen"] = null;        //* Exists on the detail(2).aspx page for maintaining the KeyPoints visibility*
        }
        private bool manageDropDownStates()
        {
            bool answer = false;

            if (!string.IsNullOrEmpty(RadComboBoxCategories.SelectedValue))
            {
                string newCategorySelection = RadComboBoxCategories.SelectedValue;
                string orig_CategorySelection = Request.QueryString["CategoryID"];


                //*********************
                //*New Chosen Category*
                //*********************
                if (orig_CategorySelection != newCategorySelection)
                {
                    //Populate_IndicatorDropDown()
                    answer = true;
                }
            }

            return answer;

        }
        private void checkForCategoryAndIndicator()
        {
            bool isOldBookMark = false;

            if (Request.QueryString["categoryID"] != null)
            {
                isOldBookMark = true;
            }
            else if (Request.QueryString["IndicatorID"] != null)
            {
                isOldBookMark = true;
            }


            //*If the URL contains a Category/Indicator - send them to the Main Page*
            if (isOldBookMark == true)
            {
                Response.Redirect("~/Default.aspx");
            }

        }
        private int determineCategoryIDFromQNum(string q)
        {

            int answer = 0;
            ArborDataAccessV2 DAL;

            try
            {
                DAL = new ArborDataAccessV2();
                answer = Convert.ToInt32(DAL.getMethodIDFromQNum(QNum));
            }
            catch (Exception ex)
            {
                //Dim err As String = ex.Message
                //If Not ex.InnerException Is Nothing Then
                //    err += ": " & ex.InnerException.Message
                //End If
                throw ex;

            }
            finally
            {
                DAL = null;
            }

            return answer;
        }
        private void ToggleGoButton(bool enable)
        {
            switch (enable)
            {
                case true:
                    cmdFindHealthData.Enabled = true;
                    cmdFindHealthData.ToolTip = "Get Chart";
                    cmdFindHealthData.AlternateText = "Get Chart";
                    cmdFindHealthData.ImageUrl = "~/images/go.gif";
                    cmdFindHealthData.CssClass = "EnabledGoButton";

                    break;
                case false:
                    cmdFindHealthData.Enabled = false;
                    cmdFindHealthData.CssClass = "DisabledGoButton";
                    cmdFindHealthData.ImageUrl = "~/images/disabled_go.gif";
                    cmdFindHealthData.AlternateText = "Make a selection";
                    cmdFindHealthData.ToolTip = "Make a selection";
                    break;
            }
        }
        private void ToggleScreen(string Show_or_Hide)
        {
            string screen = splashScreen;

            switch (Show_or_Hide.ToUpper())
            {
                case "S":
                    //if (screen != "S")
                    //{
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "selectionInProgressCats", "Toggle('S');", true);
                        splashScreen = "S";
                    //}
                    break;
                case "H":
                    if (screen != "H")
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "selectionInProgressCats", "Toggle('H');", true);
                        splashScreen = "H";
                    }
                    break;
            }

        }
        private void setComboBoxWidth()
        {
            RadComboBoxCategories.Width = CategoriesComboBoxWidth;
            RadComboBoxIndicators.Width = IndicatorsComboBoxWidth;
        }
        private void selectIndicatorByText()
        {
            string q = Request.QueryString["QNum"];
            ArborDataAccessV2 DAL = new ArborDataAccessV2();
            DataTable dt = DAL.getQuestionDetails(q);
            string textToFind = dt.Rows[0]["IndicatorText"].ToString().Trim();

            //*Locate the text in the existing Indicator dropdown*
            foreach (ListItem li in RadComboBoxIndicators.Items)
            {
                if (li.Text.Trim() == textToFind)
                {
                    li.Selected = true;
                    RadComboBoxIndicators.Items.RemoveAt(0);
                    break;
                }
            }

            DAL = null;
        }
        public void SetToPreviousChoices()
        {

            //Determine which drop down changed
            string ddlChanged = Convert.ToString(Session["ddlChanged"]);

            //*Get the ComboBoxes*
            DropDownList radComboBoxCategories = (DropDownList)this.FindControl("RadComboBoxCategories");
            DropDownList radComboBoxIndicators = (DropDownList)this.FindControl("RadComboBoxIndicators");


            switch (ddlChanged)
            {
                case "Category":

                    //******************************
                    //*Select the previous category*
                    //******************************
                    setCategoryIDFromQNum();
                    radComboBoxCategories.SelectedValue = CategoryId.ToString();

                    //*Reload the Indicators*                
                    QNum = Convert.ToString(Request.QueryString["QNum"]);
                    Populate_IndicatorDropDown(true);
                    //True means to revert the indicator to original
                    break;

                case "Indicator":
                    //*****************************************
                    //*Reset the Indicators to previous choice*
                    //*****************************************
                    Populate_IndicatorDropDown(true);

                    break;
            }


            //*Hide the splash screen and Disable Go button*
            ToggleScreen("H");
            ToggleGoButton(false);


            //*Reset the source*
            Session["ddlChanged"] = null;


            //Redirect because IE has repaint issues with the chart - as in, it doesn't
            //string url = Server.UrlDecode(Request.Url.AbsoluteUri);
            string url = Uri.EscapeUriString(Server.UrlDecode(Request.Url.AbsoluteUri)); //Fortify fix
            Response.Redirect(url);
        }
        private void setCategoryIDFromQNum()
        {
            if (string.IsNullOrEmpty(QNum))
            {
                return;
            }

            //*Get Qnum from URL since it is a revert request*
            string oldQNum = Convert.ToString(Request.QueryString["QNum"]);

            ArborDataAccessV2 DAL = new ArborDataAccessV2();
            CategoryId = Convert.ToInt32(DAL.getMethodIDFromQNum(oldQNum));
        }
        public override void DataBind()
        {
            //*Redirect old BookMarks*
            checkForCategoryAndIndicator();


            //*The drop downs have already been populated, but a new selection has been made
            if (Session["ddlChanged"] != null)
            {
                if (Session["ddlChanged"].ToString().ToUpper() == "INDICATOR")
                {
                    //No need to rebind if everything is already on the page
                    if (RadComboBoxCategories.Items.Count > 0 && RadComboBoxIndicators.Items.Count > 1)
                    {                        
                        return;
                    }
                }
            }


            //********************************************
            //*Check for drop down changes on Detail.aspx*
            //********************************************
            if (Page.GetType().BaseType.Name.ToUpper() == "DETAIL")
            {
                if (manageDropDownStates() == true)
                {
                    return;
                }
            }



            //****************
            //*Get Categories*
            //****************
            //setComboBoxWidth()
            Populate_CategoryDropDown();

            if (Request.QueryString["QNum"] != null)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["QNum"].ToString()))
                {
                    QNum = Request.QueryString["QNum"].ToString();

                    //*Populate the categoryID*
                    setCategoryIDFromQNum();
                }
            }



            if (CategoryId > 0)
            {
                if (RadComboBoxCategories.Items[0].Value == "-1" & RadComboBoxCategories.Items.Count > 0)
                {
                    RadComboBoxCategories.Items.RemoveAt(0);
                }


                //Dim strHP2020 As String = ConfigurationManager.AppSettings("HP2020")
                if ((Request.QueryString["hp2020"] != null) && Convert.ToBoolean(Request.QueryString["hp2020"]) == true)
                {

                }
                else if ((Request.QueryString["relatedIndicator"] != null) && Convert.ToBoolean(Request.QueryString["relatedIndicator"]) == true)
                {

                }
                else
                {
                    RadComboBoxCategories.SelectedValue = this.CategoryId.ToString();
                }


                //****************
                //*Get Indicators*
                //****************
                Populate_IndicatorDropDown();
            }



            //Disable the indicator dropdown if topic dropdown has "Select a Topic" (-1) selected.
            if (RadComboBoxCategories.SelectedValue == "-1")
            {
                RadComboBoxIndicators.Enabled = false;
            }
            else
            {
                RadComboBoxIndicators.Enabled = true;
            }

        }

        #endregion

        #region Button Events

        protected void btnClose_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            SetToPreviousChoices();
        }        
        protected void cmdFindHealthData_Click1(object sender, ImageClickEventArgs e)
        {
            clearSessionVariables();

            string url = Uri.EscapeUriString(HttpRuntime.AppDomainAppVirtualPath.TrimEnd('/') + ("/detail.aspx") + "?QNum=" + QNum.ToString()); //Fortify fix
            Response.Redirect(url);

            //Raise event
            //Selected(Convert.ToInt32(CategoryId), QNum);

        }
        
        #endregion

 



        //public override void DataBind()
        //{            
        //    //this.SelectIndicatorControl1.CategoryId = this.CategoryId;
        //    //this.SelectIndicatorControl1.IndicatorId = this.IndicatorId;

        //    base.DataBind();
        //}
    }
}