using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;
using ClosedXML.Excel;
using ckdlibV2;
using CKDSurveillance_RD.UserControls;
using System.Web.Security.AntiXss;
using DocumentFormat.OpenXml.Spreadsheet;


namespace CKDSurveillance_RD.MasterPages
{
    public partial class Detail : Classes.NCCDPage// 9/24 updated per Alex System.Web.UI.Page
    {

        MemoryStream ms = new MemoryStream();
        bool istriplestrat = false;
        bool isIEorEdge = false;
        ArborDataAccessV2 DAL = new ArborDataAccessV2();
        //public string directoryPath;
        public bool isDetailpage = true;
        private int datasourceCount = 0;
        private int viewdatabyCount = 0;
        private bool isDefaultStd = true;
        DataTable _dtStratyears;

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
        public int Revert
        {
            get
            {
                if (ViewState["revert"] != null)
                {
                    return (int)ViewState["revert"];
                }
                else
                {
                    return 0;
                }
            }
            set { ViewState["revert"] = value; }
        }
        public int SourceId
        {
            get
            {
                if (ViewState["SourceId"] != null)
                {
                    return (int)ViewState["SourceId"];
                }
                else
                {
                    return 0;
                }

            }
            set { ViewState["SourceId"] = value; }
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
        public string URLStrat
        {

            get
            {
                string _urlStrat = "";
                if ((Request.QueryString["Strat"] != null))
                {
                    _urlStrat = Request.QueryString["Strat"];
                    Session["strats"] = _urlStrat;
                }

                return _urlStrat;
            }
        }
        public string URLYear
        {

            get
            {
                string _urlYear = "";
                if ((Request.QueryString["Year"] != null))
                {
                    _urlYear = Request.QueryString["Year"];
                    Session["yrs"] = _urlYear;
                }

                return _urlYear;
            }
        }

        public bool showCI
        {
            get
            {
                object o = null;
                o = ViewState["showCI"];
                if (o != null)
                {
                    return (bool)ViewState["showCI"];
                }
                else
                {
                    return false;
                }
            }
            set { ViewState["showCI"] = value; }
        }

        public string CurrentYear
        {
            get { return Convert.ToString(Session["currentYear"]); }
            set { Session["currentYear"] = value; }
        }

        #endregion


        //**********
        //*Start Up*
        //**********
        protected void Page_Load(object sender, EventArgs e)
        {
            //buildPageScripts();

            string browser = "";
            if (Request.Browser != null) browser = Request.Browser.Browser.ToString().ToLower();
            if (browser == "internetexplorer")
                isIEorEdge = true;
            else if (browser == "chrome")
            {
                string userAgent = Request.UserAgent.ToString();

                if (userAgent.IndexOf("Edge") > -1)
                {
                    isIEorEdge = true;
                }
            }

            if (Request.QueryString["showCI"] != null)
            {
                string t_showci = Request.QueryString["showCI"].ToString().Trim();
                if (t_showci == "1")
                {
                    showCI = true;
                    CB_ChartCI.Checked = true;
                    hfShowCI.Value = "true";
                }
                else
                    showCI = false;
            }
            else
                showCI = false;


            //resetting the Title to avoid duplicate text on postback
            litTopic.Text = "";
            litTopicMobile.Text = "";

            if (hasParamErrors() == true)
            {
                Response.Redirect("Default.aspx");
            }

            //*****************
            //*Get the QNumber*
            //*****************            
            if (ViewState["QNum"] != null)
            {
                QNum = ViewState["QNum"].ToString().ToUpper();
            }
            else
            {
                QNum = Request.QueryString["QNum"].ToString().Trim().ToUpper();
            }
            //Set this in session for access by Methods page
            Session["qnum"] = QNum;

            isDefaultStd = true;

            if (!Page.IsPostBack)
            {
                string chartType = "'bar'";
                string chartMode = "'group'";
                RB_ChartType.SelectedValue = chartType;
                hfChartType.Value = chartType;
                hfChartMode.Value = chartMode;
                if (!showCI)
                {
                    hfShowCI.Value = "false";
                    CB_ChartCI.Checked = false;
                }

                //*Header Info*            
                DataTable dtHeader = getHeaderInfo();

                if (dtHeader != null && dtHeader.Rows.Count > 0)
                {
                    string href = "";
                    string topicText = dtHeader.Rows[0]["Topic"].ToString();
                    string measureText = dtHeader.Rows[0]["Measure"].ToString();
                    string indicatorText = dtHeader.Rows[0]["Indicator"].ToString();
                    string topicID = dtHeader.Rows[0]["TopicID"].ToString();

                    Session["TopicID"] = topicID;

                    switch (topicID)
                    {
                        case "1":
                            href = "TopicHome/PrevalenceIncidence.aspx?topic=1";
                            break;
                        case "3":
                            href = "TopicHome/Awareness.aspx?topic=3";
                            break;
                        case "4":
                            href = "TopicHome/BurdenOfRiskFactors.aspx?topic=4";
                            break;
                        case "5":
                            href = "TopicHome/HealthConsequences.aspx?topic=5";
                            break;
                        case "6":
                            href = "TopicHome/QualityOfCare.aspx?topic=6";
                            break;
                        case "24":
                            href = "TopicHome/SocialDeterminantsOfHealth.aspx?topic=24";
                            break;
                        default:
                            href = "default.aspx";
                            break;
                    }

                    bcTopicLink.HRef = href;
                    bcTopicLink.InnerText = topicText;
                    bcMeasure.InnerText = measureText + " > ";
                    bcIndicator.InnerText = indicatorText;
                }

                ArborDataAccessV2 DAL = new ArborDataAccessV2();
                staticimg.Visible = false;
                btnViewAsTable.Visible = true;
                csvDownload.Visible = true;
                lnkCSV.Visible = false;

                //*Load the page*
                if (QNum.ToUpper() != "Q760" && QNum.ToUpper() != "Q761" && QNum.ToUpper() != "Q783" && QNum.ToUpper() != "Q802")
                {
                    StratYear1.Visible = true;
                    litChartInstruction.Visible = true;
                    divChartInstruction.Visible = true;
                    StratYearsLinksMaps.Visible = true;
                    chartFormatOptions.Visible = true;
                    chartColorOptions.Visible = false;
                    chartFormatControls.Visible = false;
                    chartColorControls.Visible = false;
                    divRightContainer.Visible = true;
                    //litSourceTabs.Visible = true;
                    //StratYear1.Visible = true;
                    if ((QNum.ToUpper() == "Q705") || (QNum.ToUpper() == "Q372"))
                        CB_ChartCI.Visible = false;
                    else
                        CB_ChartCI.Visible = true;

                    divStaticLeft.Visible = false;
                    pnlMap.Style.Remove("overflow-x");
                    pnlMap.Style.Add("overflow-x", "auto");

                    staticDownloadButton.Visible = false;

                    map1.Visible = false;
                    map2.Visible = false;

                    createPageContent();

                    if (DAL.proc_IsRelatedToAgeSTD(QNum, Request.QueryString["Strat"]))
                    {
                        isDefaultStd = false;
                        var currentQNum = QNum;
                        QNum = QNum.ToUpper().Replace("Q", "S");
                        createPageContent();
                        QNum = currentQNum;
                        isDefaultStd = true;
                    }
                }
                else
                {
                    StratYear1.Visible = false;
                    litChartInstruction.Visible = false;
                    divChartInstruction.Visible = false;
                    StratYearsLinksMaps.Visible = false;
                    chartFormatOptions.Visible = false;
                    chartColorOptions.Visible = false;
                    chartFormatControls.Visible = false;
                    chartColorControls.Visible = false;
                    divRightContainer.Visible = false;
                    //litSourceTabs.Visible = false;
                    //StratYear1.Visible = false;
                    CB_ChartCI.Visible = false;
                    divMapMenu.Visible = false;

                    divStaticLeft.Visible = true;
                    pnlMap.Style.Remove("overflow-x");
                    pnlMap.Style.Add("overflow-x", "hidden");

                    staticDownloadButton.Visible = true;
                    staticDownloadButton.HRef = AntiXssEncoder.HtmlEncode(SanitizeHtml("./Documents/" + QNum.ToUpper() + ".xlsx"), false);
                    exportButton.Visible = false;
                    lnkDownload.Visible = false;
                    btnDownloadChart.Visible = false;
                    
                    

                    if (QNum.ToUpper() == "Q760")
                    {
                        map1.Visible = false;
                        map2.Visible = true;
                        map3.Visible = false;
                        
                    }
                    else if (QNum.ToUpper() == "Q761")
                    {
                        map1.Visible = true;
                        map2.Visible = false;
                        map3.Visible = false;
                    }
                    else if (QNum.ToUpper() == "Q783")
                    {
                        map1.Visible = false;
                        map2.Visible = false;
                        map3.Visible = true;
                    }
                    else if (QNum.ToUpper() == "Q802")
                    {
                        map1.Visible = false;
                        map2.Visible = false;
                        map3.Visible = false;

                        staticimg.Visible = true;
                        btnViewAsTable.Visible = false;
                        csvDownload.Visible = false;
                        lnkCSV.Visible = true;
                        lnkCSV.HRef =  AntiXssEncoder.HtmlEncode(SanitizeHtml("./Documents/" + QNum + ".xlsx"), false);
                    }

                    //createStaticPageContent("Q705");
                    createStaticPageContent(QNum);
                }

                DataTable dtAppsSettings = DAL.getApplicationSettings();
                string PPTs = "";

                foreach (DataRow row in dtAppsSettings.Rows)
                {
                    if (row["NAme"].ToString() == "PPTQNums")
                    {
                        PPTs = row["Value"].ToString();
                        break;
                    }
                }

                if (PPTs.IndexOf(QNum) < 0)
                {
                    lnkPPT.Visible = false;
                }
                else
                {
                    lnkPPT.Visible = true;
                    lnkPPT.HRef = AntiXssEncoder.HtmlEncode(SanitizeHtml("./PPT/" + QNum.ToUpper() + ".pptx"), false);
                }

                if (!DAL.proc_IsRelatedToAgeSTD(QNum.ToUpper(), Request.QueryString["Strat"]))
                {
                    divRBSTD.Visible = false;                  
                }
                else
                {
                    divRBSTD.Visible = true;
                    var labels = DAL.proc_GetAgeSTDLabel();

                    if (labels.Rows.Count > 1 && labels.Columns.Count > 1)
                    {
                        lblrbstd1.InnerText = labels.Rows[0][1].ToString();
                        lblrbstd2.InnerText = labels.Rows[1][1].ToString();
                    }
                    else {
                        lblrbstd1.InnerText = "Crude";
                        lblrbstd2.InnerText = "Age-Standardized";
                    }
                }
            }
        }

        private void createStaticPageContent(string _qNum)
        {
            ArborDataAccessV2 DAL = new ArborDataAccessV2();

            if (QNum.ToUpper() == "Q761")
            {
                litTopic.Text = litTopic.Text + "U.S. Population Below the Poverty Threshold Level and CKD in the U.S. Medicare Population, by County";
                litTopicMobile.Text = litTopic.Text;
                litTopicDesc.Text += "The bivariate map shows the combination of the percentage of the population below the poverty threshold and the percentage of diagnosed CKD patients among the Medicare population across counties in the United States. Geographic variation was observed in the percentage of the population below the poverty threshold (mean=15.4, SD=6.9, n=3,095) and the percentage of diagnosed CKD patients among the Medicare population (mean=22.1, SD=6.5, n=3,097). The percentage of the population under the poverty level and the prevalence of CKD are high in counties in the Southern region. Further investigation into poverty and CKD prevalence in some of these hotspot areas is crucial.";
            }
            else if (QNum.ToUpper() == "Q760")
            {
                litTopic.Text = litTopic.Text + "Average Daily PM2.5 Air Pollution and CKD in the U.S. Medicare Population, by County";
                litTopicMobile.Text = litTopic.Text;
                litTopicDesc.Text += "The bivariate map shows the combination of the average daily PM2.5 and the percentage of diagnosed CKD patients among the Medicare population across counties in the United States. The average daily PM2.5 and the percentage of diagnosed CKD patients varied across counties (PM2.5 mean=8.7 μg/m3, SD=1.9 μg/m3, n=3,043; CKD mean=22.1, SD=6.5, n=3,097). The average daily PM2.5 and the prevalence of CKD are high in counties in California, the rust-belt area, and the Southern region. Further investigation into air pollution and CKD prevalence in some of these hotspot areas is crucial.";
            }
            else if (QNum.ToUpper() == "Q783")
            {
                litTopic.Text = litTopic.Text + "County-Level Residential Segregation (Black/White) and Prevalence of Diagnosed CKD, U.S. Medicare Population 2019";
                litTopicMobile.Text = litTopic.Text;
                litTopicDesc.Text += "The bivariate map shows the combination of the Racial residential segregation and CKD prevalence bivariate map.";
            }
            else if (QNum.ToUpper() == "Q802")
            {
                litTopic.Text = litTopic.Text + "Awareness of CKD by KDIGO Risk Categories";
                litTopicMobile.Text = litTopic.Text;
            }


            //***************
            //*Get Page Data*
            //***************
            //DataTable dtPage = DAL.getPage(QNum).Tables[0];
            DataTable dtPage = getCachedPageData(QNum);

            //************
            //*Foot Notes*
            //************
            populateFootNotes();

            //************
            //*Key points*
            //************
            populateKeyPointsMethods();

            //************************
            //*References and Sources*
            //************************
            DataTable dtReferences = DAL.getReferences(QNum); //Todo: caching
            if (dtReferences.Rows.Count > 0)
            {
                rptrReferences.DataSource = dtReferences;
                rptrReferences.DataBind();
                pnlReferences.Visible = true;
            }
            else
            {
                pnlReferences.Visible = false;
            }

            //litSourceTabs.Text = createSDOHSourceLinks();

            //*************
            //*Build Table*
            //*************
            string addedHeader = "";
            string titleNoFN = "";
            if (QNum.ToUpper() == "Q760")
            {
                addedHeader = "Geographic Distribution of Average Daily PM2.5 Air Pollution and CKD in the US Medicare Population, by County";
                titleNoFN = addedHeader;
            }
            else if (QNum.ToUpper() == "Q761")
            {
                addedHeader = "Geographic Distribution of Population below Poverty Threshold Level and CKD in the US Medicare Population, by County";
                titleNoFN = addedHeader;
            }
            else if (QNum.ToUpper() == "Q783")
            {
                addedHeader = "County-Level Residential Segregation (Black/White) and Prevalence of Diagnosed CKD, U.S. Medicare Population 2019";
                titleNoFN = addedHeader;
            }
            else if (QNum.ToUpper() == "Q802")
            {
                addedHeader = "Prevalence of Awareness of CKD among U.S. Adults by Kidney Disease Improving Global Outcome (KDIGO) CKD Risk Categories";
                titleNoFN = addedHeader;
            }

            divDataSource.Visible = false;

            //*populate the table (and summary attribute)*
            if (QNum.ToUpper() == "Q760")
            {
                populateTable(-1, addedHeader, titleNoFN, true);
                divDataSource.Visible = true;
                litDataSource.Text = "CMS & EPA";
            }
            else if (QNum.ToUpper() == "Q761")
            {
                populateTable(-2, addedHeader, titleNoFN, true);
                divDataSource.Visible = true;
                litDataSource.Text = "CMS & ACS";
            }
            else if (QNum.ToUpper() == "Q783")
            {
                populateTable(-3, addedHeader, titleNoFN, true);
                divDataSource.Visible = true;
                litDataSource.Text = "CMS & CHR";
            }
            else if (QNum.ToUpper() == "Q802")
            {
                populateTable(-4, addedHeader, titleNoFN, true);
                divDataSource.Visible = true;
                litDataSource.Text = "NHANES";
            }
            //**********************
            //*Methods & Spec Sheet*
            //**********************
            loadMethodsAndSpecSheet(DAL, _qNum, 1); //TODO: SQL cleanup/caching
        }
        private void createPageContent()
        {

            //Check QNUM legitimacy and active status
            if (isQNumEnabled() == false)
            {
                Response.Redirect("Default.aspx");
            }


            //Data Access Object
            ArborDataAccessV2 DAL = new ArborDataAccessV2();



            //*****************
            //*Get DataSources*
            //*****************            
            DataTable dtDataSources = getCachedDataSourcesFromIndicatorCode(QNum);
            createDataSourceLinksDropDown(dtDataSources, QNum);

            //if (dtDataSources != null && dtDataSources.Rows.Count > 0 && dtDataSources.Rows[0]["DataSourceDescription"] != null)
            //    lblExplanationBody.Text = dtDataSources.Rows[0]["DataSourceDescription"].ToString();

            //Now the phone only DDL version of the Data Source Tab




            //***************
            //*Get Page Data*
            //***************
            //DataTable dtPage = DAL.getPage(QNum).Tables[0];
            DataTable dtPage = getCachedPageData(QNum);


            //**************
            //*Manage Title*
            //**************                
            string topic = dtPage.Rows[0]["Topic"].ToString().Trim().ToLower();

            if (topic.Contains("emerging topics") ||
                topic.Contains("children and adolescents") ||
                topic.Contains("solid organ transplant population") ||
                topic.Contains("native americans") ||
                topic.Contains("polycystic kidney disease population"))
            {
                litTopic.Text = dtPage.Rows[0]["Topic"].ToString().Trim();
                litTopicMobile.Text = litTopic.Text;
                litDDLMeasInd.Text = createNavDropDown(QNum);
            }

            //***************************
            //*Display Lit Indi Footnote*
            //***************************
            if (dtPage.Rows[0]["LiteratureInd"].ToString() == "1")
            {
                LiteratureIndicatorFootnote.Text = "<img src='images/bookicon.PNG' alt='Published literature or one-time analysis, ongoing surveillance not available' /> Published literature or one-time analysis, ongoing surveillance not available<br /><br />";
                LiteratureIndicatorFootnote.Visible = true;
            }

            //***************************
            //*Populate Strats and Years*
            //***************************
            string chartStyle = dtPage.Rows[0]["ChartStyleID"].ToString();
            bool onStateMapPage = (chartStyle == "5");
            bool onCountyMapPage = (chartStyle == "6");
            divMapMenu.Visible = true;
            if (onStateMapPage == false)
            {
                if (QNum.ToUpper().StartsWith("Q")) { 
                    StratYear1.loadStratsAndYears(dtPage); 
                }
                
                divChartInstruction.Visible = StratYear1.IsViewDataByVisible;
                
                if (QNum.ToUpper().StartsWith("Q"))
                {
                    loadStratsAndYears(dtPage);
                }

                StratYearsLinksMaps.Visible = false;
                btnDownloadChart.Visible = true;
                if (!onCountyMapPage)
                    divMapMenu.Visible = false;
            }
            else
            {
                StratYearsLinksMaps.loadYears(dtPage, QNum);
                StratYear1.Visible = false;
                litChartInstruction.Visible = false;
                divChartInstruction.Visible = false;
                btnDownloadChart.Visible = false;
            }



            //These are the years and strats, but viewable only by smaller screens
            //StratYearsRD1.loadStratsAndYears(dtPage);



            //***********************************
            //*Populate the kp and Methods links*
            //***********************************
            populateKeyPointsMethods();



            //***********************
            //*Determine The ChartID*
            //***********************            
            int chartID = determineChartID(dtPage);
            hfChartID.Value = chartID.ToString();


            //*************
            //*Cache Maps?*
            //*************  
            bool showSlider = false;
            if (Request.QueryString["showMapSlider"] != null)
            {
                if (Request.QueryString["showMapSlider"] == "1")
                {
                    showSlider = true;
                    tableHeaderBar.Visible = false; //hiding the view data table
                }
            }

            //*****************
            //*Build The Chart*
            //*****************
            if (QNum.ToUpper() != "Q712" && QNum.ToUpper() != "Q675" && QNum.ToUpper() != "Q239" && QNum.ToUpper() != "Q242") RB_ChartType.Items[2].Enabled = false;
            buildChart(chartID.ToString(), dtPage, showSlider, onStateMapPage, onCountyMapPage); //Also retrieves titles            

            //************************
            //*Populate the Mega Menu*
            //************************            
            Session["menuSelectedIndicatorID"] = dtPage.Rows[0]["IndicatorID"].ToString();



            //****************************
            //*Manage the TMI breadcrumbs*
            //****************************
            string ec = buildTMICrumbs(dtPage);
            CKDSurveillance_RD.MasterPages.ResponsiveContentLeftNavNew mp = (ResponsiveContentLeftNavNew)Page.Master;
            //mp.ExtraCrumbs = ec;



            if (showSlider == true)
            {
                //Show the slider
                sliderWrapper.Visible = true;

                //Hide the chart
                pnlChart.Visible = false;
                pnlPlotly.Visible = false;

                //Hide table
                gvData.Visible = false;
                gvDataRel.Visible = false;
            }
            else
            {
                //Show the slider
                sliderWrapper.Visible = false;

                //Show the chart
                if (istriplestrat)
                {
                    pnlChart.Visible = false;
                    pnlPlotly.Visible = true;
                }
                else
                {
                    pnlChart.Visible = false;
                    pnlPlotly.Visible = true;
                }

                //Show table
                gvData.Visible = true;
                gvDataRel.Visible = true;
            }



            //*************
            //*Build Table*
            //*************
            string addedHeader = "";
            string titleNoFN = "";
            if (Session["TableHeader"] != null) { addedHeader = Session["TableHeader"].ToString(); }
            if (Session["TitleNoFN"] != null) { titleNoFN = Session["TitleNoFN"].ToString(); }


            //*populate the table (and summary attribute)*           
            populateTable(chartID, addedHeader, titleNoFN, onCountyMapPage);



            //************
            //*Foot Notes*
            //************
            populateFootNotes();

            //************
            //*Finding the current year and setting it*
            //************
            string yr = getYear();
            hfCurrentYear.Value = yr;

            //********************
            //*Related Indicators*
            //********************            
            //DataSet dsRI = DAL.getRelatedIndicators(QNum); //Todo: SQL cleanup/caching
            //DataTable dtRI = dsRI.Tables[0];
            //if (dtRI.Rows.Count > 0)
            //{
            //    rptrRelated.DataSource = dtRI;
            //    rptrRelated.DataBind();
            //    pnlRelated.Visible = false;
            //}
            //else
            //{
            //    pnlRelated.Visible = false;
            //}

            //************
            //*Related AYA
            //************
            //if (dsRI.Tables.Count > 1)
            //{
            //    DataTable dtRAYA = dsRI.Tables[1];
            //    if (dtRAYA.Rows.Count > 0)
            //    {
            //        rptrAYA.DataSource = dtRAYA;
            //        rptrAYA.DataBind();
            //        pnlAYA.Visible = false;
            //    }
            //    else
            //    {
            //        pnlAYA.Visible = false;
            //    }
            //}



            //************************
            //*References and Sources*
            //************************
            DataTable dtReferences = DAL.getReferences(QNum); //Todo: caching
            if (dtReferences.Rows.Count > 0)
            {
                rptrReferences.DataSource = dtReferences;
                rptrReferences.DataBind();
                pnlReferences.Visible = true;
            }
            else
            {
                pnlReferences.Visible = false;
            }



            //**********************
            //*Methods & Spec Sheet*
            //**********************
            loadMethodsAndSpecSheet(DAL, QNum, 1); //TODO: SQL cleanup/caching


            //***********************
            //*Most Recently Visited*
            //***********************
            //            getMostRecentlyVisited();


            //************************************
            //*Remember that we visited this page*
            //************************************
            rememberRecentlyVisited(Request.Url.AbsoluteUri, litChartTitleText.Text);


            //**********
            //*Clean Up*
            //**********
            Session["TableHeader"] = null;

        }


        private void buildPageScripts()
        {
            if (System.Web.HttpContext.Current.Cache["detailCSS"] != null)
            {
                //get it from cache
                litCSS.Text = System.Web.HttpContext.Current.Cache["detailCSS"].ToString().Trim();
            }
            else
            {

                string starting = "<link href='";
                string ending = "' rel='stylesheet' type='text/css' />";

                StringBuilder sb = new StringBuilder();
                sb.Append(starting + Page.ResolveUrl("~/css/DetailCSS.css") + addUniqueParameter() + ending);

                litCSS.Text = sb.ToString().Trim();

                //Add to cache
                System.Web.HttpContext.Current.Cache["detailCSS"] = sb.ToString().Trim();
            }
        }

        private string addUniqueParameter()
        {
            string answer = "";

            StringBuilder sb = new StringBuilder();
            sb.Append("?v=");
            sb.Append(DateTime.Now.ToString("yyyyMMddHHmm"));
            answer = sb.ToString().Trim();

            return answer;
        }


        //*******
        //*Table*
        //*******
        private DataTable cleanChartTable(DataTable dtCharts)
        {
            DataTable answer = null;

            foreach (DataRow dr in dtCharts.Rows)
            {
                if (dr["DataPoint"].ToString().ToLower() == "na" || dr["DataPoint"].ToString().ToLower() == "*")
                {
                    dr["DataPoint"] = 0;
                }
            }

            answer = dtCharts;

            return answer;
        }
        private void populateTable(int chartID, string headerText, string noFN, bool onCountyMapPage)
        {
            ArborDataAccessV2 DAL = new ArborDataAccessV2();
            DataTable dtTable = new DataTable("Table");
            string yr = getYear();

            DataSet ds = null;
            Int32 sw = 1000; //Default to wide table
            if (Session["screenwidth"] != null) //Session["screenwidth"] is set in JSHandler.ashx || Responsive Left master page makes .js call to set the screen width
            {
                Int32 swOut = 0;
                bool isNum = Int32.TryParse(Session["screenwidth"].ToString(), out swOut);
                if (isNum == true) { sw = Convert.ToInt32(Session["screenwidth"].ToString()); }
            }

            if (onCountyMapPage)
            {
                ds = DAL.getTableForMaps(chartID, yr);
            }
            else if (sw <= 962)
            {
                ds = DAL.getTableLinear(chartID, yr);
            }
            else
            {
                ds = DAL.getTable(chartID, yr);
            }



            gvData.Columns.Clear();
            gvDataRel.Columns.Clear();
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


            //bool colIsYear = false;
            //string colName = dtTable.Columns[0].ColumnName;

            //if (colName.Length >= 4)
            //{
            //    if (Utilities.CheckForNumeric(colName.Substring(0, 4)))
            //    {
            //        colIsYear = true;
            //    }
            //}

            //*Only mark the row as a header if the first column Name is NOT a year*
            //if (colIsYear == false)
            //{
            //    string rowcolname = colName;
            //    gvData.RowHeaderColumn = rowcolname;
            //}

            if (isDefaultStd)
            {
                gvData.DataSource = dtTable;
                gvData.DataBind();

                gvData.UseAccessibleHeader = true;
            }
            else
            {
                gvDataRel.DataSource = dtTable;
                gvDataRel.DataBind();

                gvDataRel.UseAccessibleHeader = true;
            }

            DAL = null;


            //**********************************
            //*Add a new Header Row to the Grid*
            //**********************************            
            GridViewRow hRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
            TableHeaderCell hCell = new TableHeaderCell();
            hCell.Text = headerText;
            hCell.ColumnSpan = dtTable.Columns.Count;
            hRow.Cells.Add(hCell);
            if (isDefaultStd)
                gvData.Controls[0].Controls.AddAt(0, hRow);
            else
                gvDataRel.Controls[0].Controls.AddAt(0, hRow);


            //*************************************
            //*Build and add the summary attribute*
            //*************************************
            if ((dtTable != null))
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

                        if (isDefaultStd)
                            gvData.Attributes.Add("summary", summaryText);
                        else
                            gvDataRel.Attributes.Add("summary", summaryText);
                    }
                    catch (Exception ex)
                    {
                        if (isDefaultStd)
                            gvData.Attributes.Add("summary", "This is a table of data for the above chart");
                        else
                            gvDataRel.Attributes.Add("summary", "This is a table of data for the above chart");
                    }
                    finally
                    {
                    }
                }
            }
        }
        protected void gvData_DataRowBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                //*****************************************************************************************
                //*Add a Line Break and ensure that we are NOT HTML encoding so the <br /> forms correctly*
                //*****************************************************************************************
                int cnt = 0;
                cnt = e.Row.Cells.Count;

                for (int i = 0; i <= cnt - 1; i++)
                {
                    string cellval = e.Row.Cells[i].Text;
                    e.Row.Cells[i].Text = HttpUtility.HtmlDecode(e.Row.Cells[i].Text);
                }
            }
        }

        //*Page Features and Content*
        private void populateFootNotes()
        {
            ArborDataAccessV2 DAL = new ArborDataAccessV2();
            string fnString = "";

            DataTable dtFootnotes = DAL.getFootNotes(QNum);


            if (dtFootnotes.Rows.Count > 0)
            {
                foreach (DataRow dr in dtFootnotes.Rows)
                {
                    fnString += dr["FootnoteText"].ToString() + "<br /><br />";
                }

                if (fnString.Length > 12)
                {
                    fnString = fnString.Substring(0, fnString.Length - 12);
                    //Remove the last set of <br />s
                }

                //pnlFootnotes.Visible = true;
                fnString = fnString.Replace("<sup><strong>a</strong></sup>", "");

                if (litChartTitleText.Text.IndexOf("CKD Stage") < 0)
                    fnString = fnString.Replace("<p>*CKD stage 5 data from 2001&ndash;2004 was suppressed due to a large standard error.</p>", "");

                litFootNotesText.Text = fnString;
            }
            //else if (dtFootnotes.Rows.Count == 0)
            //{
            //    pnlFootnotes.Visible = false;
            //}
        }
        private void populateKeyPointsMethods()
        {
            string methodsPath = HttpContext.Current.Request.Url.AbsoluteUri.Replace("detail.aspx", "Methods.aspx").Replace("Detail.aspx", "Methods.aspx").Replace("detail2.aspx", "Methods.aspx").Replace("Detail2.aspx", "Methods.aspx").Replace("#", "");

            ArborDataAccessV2 DAL = null;
            DataTable dtKP = null;
            DataTable dtMeth = null;

            try
            {
                DAL = new ArborDataAccessV2();
                dtKP = new DataTable("KPs");
                dtMeth = new DataTable("Meths");

                dtKP = DAL.getKeypoints(QNum);
                dtMeth = DAL.getMethods(QNum);


                int kpCount = 0;
                string kp = "";
                foreach (DataRow drKP in dtKP.Rows)
                {
                    if (string.IsNullOrEmpty(drKP["KeyPointText"].ToString()) == false)
                    {
                        kp += drKP["KeyPointText"] + "<br /><br />";
                        kpCount += 1;
                    }
                }
                if (kp.Length > 6)
                {
                    kp = kp.Substring(0, kp.Length - 12);
                    //Remove the last <br />
                }


                int methCount = 0;
                string meth = "";
                foreach (DataRow drMeth in dtMeth.Rows)
                {
                    if (string.IsNullOrEmpty(drMeth["Methodtext"].ToString()) == false)
                    {
                        meth += drMeth["Methodtext"] + "<br /><br />";
                        methCount += 1;
                    }
                }
                if (meth.Length > 12)
                {
                    meth = meth.Substring(0, meth.Length - 12);
                    //Remove the last two <br />
                }


                if (kpCount > 0)
                {
                    litTopicDesc.Text = kp;
                }
                else
                {
                    litTopicDesc.Text = "";
                    //"No Key Point data to view."
                }
            }
            catch (SqlException sqlEx)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw;
            }
            finally
            {
                DAL = null;
                dtKP.Dispose();
                dtMeth.Dispose();
            }

        }
        private void buildSpectSheetTable(DataTable dt, string indicatorText)
        {
            //*Header*
            StringBuilder sb = new StringBuilder();
            sb.Append("<table class=\"table\" summary=\"This table provides the specification sheet's entry and value for the indicator " + indicatorText + "\" style=\"border:solid 1px #bfbfbf;\" cellpadding=\"2px\" width=\"100%\">");
            sb.Append("<thead>");
            sb.Append("<tr>");
            sb.Append("<th scope=\"col\" style=\"background-color:#c1ded5; color:#084239; border-right:solid 1px #bfbfbf;\">Field</th>");
            sb.Append("<th scope=\"col\" style=\"background-color:#c1ded5; color:#084239; border-right:solid 1px #bfbfbf;\">Data</th>");
            sb.Append("<tr>");
            sb.Append("</thead>");
            sb.Append("<tbody>");


            //*Loop through the rows and get rows*
            string th1 = "<th scope=\"row\" align=\"left\" valign=\"top\" style=\"border-right:solid 1px silver; border-top:solid 1px silver; padding:3px 3px 3px 3px; background-color:#C1DED5;\">";
            string td2 = "<td align=\"left\" valign=\"top\" style=\"border-right:solid 1px silver; border-top:solid 1px silver; padding:3px 3px 3px 3px;\">";
            foreach (DataRow dr in dt.Rows)
            {

                sb.Append("<tr>");
                sb.Append(th1 + dr["Field"].ToString() + "</th>");
                sb.Append(td2 + dr["Data"].ToString() + "</td>");
                sb.Append("</tr>");
            }

            sb.Append("</tbody>");
            sb.Append("</table>");


            //*Put it on the form*
            this.litSpecSheetGrid.Text = sb.ToString();


            //*Clean up*
            sb = null;

        }
        private string createDataSourceLinks(DataTable dtSources, string qnum)
        {
            string answer = "";
            string eString = "";
            StringBuilder sb = new StringBuilder();


            sb.Append("<div class='dataSourceRBTitle'>&nbsp;&nbsp;Source</div>");
            sb.Append("<ul class='ulNoIndent'>");
            foreach (DataRow dr in dtSources.Rows)
            {
                string curQnum = dr["QNum"].ToString().Trim();

                sb.Append("<li>");
                if (curQnum == qnum)
                {
                    sb.Append("<strong>" + dr["DataSourceShortName"].ToString().Trim() + "</strong>");
                }
                else
                {
                    sb.Append("<a href='./detail.aspx?Qnum=" + curQnum + "#refreshPosition'>");
                    sb.Append(dr["DataSourceShortName"].ToString().Trim());
                    sb.Append("</a>");
                }

                sb.Append("</li>");
            }
            sb.Append("</ul>");

            sb.Append("<br />");

            eString = sb.ToString();

            if (eString.Length > 0)
            {
                answer = eString;
            }

            return answer;
        }

        private string createDataSourceLinksDropDown(DataTable dtSources, string qnum)
        {
            string answer = "";
            string eString = "";
            StringBuilder sb = new StringBuilder();
            datasourceCount = 0; //reset the count

            sb.Append("<div class=\"chartMenuLabel\">Data Sources</div>");
            sb.Append("<select class=\"form-control\" onchange=\"openDataSource(this.value);\">");
            foreach (DataRow dr in dtSources.Rows)
            {
                string curQnum = dr["QNum"].ToString().Trim();

                //sb.Append("<option>");
                if (curQnum == qnum)
                {
                    sb.Append("<option selected>" + dr["DataSourceShortName"].ToString().Trim() + "</option>");
                    litDataSource.Text = dr["DataSourceShortName"].ToString().Trim();
                    datasourceCount = datasourceCount + 1;
                }
                else
                {
                    sb.Append("<option value='" + curQnum + "'>");
                    sb.Append(dr["DataSourceShortName"].ToString().Trim());
                    sb.Append("</option>");
                }
            }

            if (string.IsNullOrEmpty(litDataSource.Text))
                divDataSource.Visible = false;

            if (qnum.ToUpper() == "Q700")
            {
                litDataSource.Text = "NHANES & Clinformatics Commercial";
            }

            sb.Append("</select>");

            sb.Append("<br />");

            eString = sb.ToString();

            if (eString.Length > 0)
            {
                answer = eString;
            }

            return answer;
        }

        private string createSDOHSourceLinks()
        {
            string answer = "";
            string eString = "";
            StringBuilder sb = new StringBuilder();


            sb.Append("<div class='dataSourceRBTitle'>&nbsp;&nbsp;Related to SDOH</div>");
            sb.Append("<ul class='ulNoIndent'><li>");
            sb.Append("<a href='detail.aspx?QNum=Q705'>Prevalence of CKD by U.S. State and County</a>");
            sb.Append("</li>");
            sb.Append("</ul>");

            sb.Append("<br />");

            eString = sb.ToString();

            if (eString.Length > 0)
            {
                answer = eString;
            }

            return answer;
        }

        protected void loadMethodsAndSpecSheet(ArborDataAccessV2 DAL, string qnum, byte showSpecSheet)
        {
            DataSet ds = DAL.getMethodText(qnum, showSpecSheet); //1 means include the spec sheet                
            DataTable dtMethodText = ds.Tables[0];
            DataTable dtSpecSheet = ds.Tables[1];



            //***************************
            //*Populate the Methods Text*
            //***************************
            for (int i = 0; i <= dtMethodText.Rows.Count - 1; i++)
            {
                if (!string.IsNullOrEmpty(dtMethodText.Rows[i]["MethodText"].ToString()))
                {
                    //*Add the text*
                    litMethodsDesc.Text += dtMethodText.Rows[i]["MethodText"].ToString();

                    //*Add some space*
                    //if (i != dtMethodText.Rows.Count - 1)
                    //{
                    //    litMethodsDesc.Text += "<br /><br />";
                    //}
                }
            }

            if (qnum.ToUpper() == "Q760" || qnum.ToUpper() == "Q761") //SDOH
            {
                ds = DAL.getMethodText("Q705", showSpecSheet); //1 means include the spec sheet                
                dtMethodText = ds.Tables[0];
                dtSpecSheet = ds.Tables[1];
            }

            //**************
            //*Header Label*
            //**************
            DataTable dtHeader = DAL.getQuestionDetails(QNum);


            //************************
            //*Populate the specsheet*
            //************************
            buildSpectSheetTable(dtSpecSheet, dtHeader.Rows[0]["IndicatorText"].ToString());

        }



        //***********
        //*Downloads*
        //***********
        protected DataTable getHeaderInfo()
        {

            DataTable answer = new DataTable("Data Source");

            DataTable dt = new DataTable("TitleInfo");
            DataColumn dc1 = new DataColumn("URL", typeof(string));
            DataColumn dc2 = new DataColumn("Topic", typeof(string));
            DataColumn dc3 = new DataColumn("Measure", typeof(string));
            DataColumn dc4 = new DataColumn("Stratification", typeof(string));
            DataColumn dc5 = new DataColumn("Year", typeof(string));
            DataColumn dc6 = new DataColumn("Title", typeof(string));
            DataColumn dc7 = new DataColumn("Data Source", typeof(string));
            DataColumn dc8 = new DataColumn("Indicator", typeof(string));
            DataColumn dc9 = new DataColumn("TopicID", typeof(int));
            DataColumn[] cols = { dc1, dc2, dc3, dc4, dc5, dc6, dc7, dc8, dc9 };
            dt.Columns.AddRange(cols);



            string title = "";
            if (Session["TitleNoFN"] != null)
                title = Session["TitleNoFN"].ToString();

            // Placed in Session in buildchart()
            string chartTitle = title;

            ArborDataAccessV2 DAL = new ArborDataAccessV2();
            DataTable dtDetails = DAL.getQuestionDetails(QNum);

            int topicID = int.Parse(dtDetails.Rows[0]["TopicID"].ToString());
            string topic = dtDetails.Rows[0]["TopicText"].ToString();
            string measure = dtDetails.Rows[0]["MeasureText"].ToString();
            string indicator = dtDetails.Rows[0]["IndicatorText"].ToString();
            string url = Request.Url.AbsoluteUri;
            string strat = StratYear1.CurrentStrat;
            string year = StratYear1.CurrentYear;

            DataRow dr = dt.NewRow();
            dr["URL"] = url;
            dr["TopicID"] = topicID;
            dr["Topic"] = topic;
            dr["Measure"] = measure;
            dr["Indicator"] = indicator;
            dr["Stratification"] = strat;
            if (!string.IsNullOrEmpty(year))
            {
                dr["Year"] = year;
            }
            else
            {
                dr["Year"] = "";
            }
            dr["Title"] = title;
            dr["Data Source"] = litChartSubTitleText.Text.Trim();

            dt.Rows.Add(dr);

            return dt;
        }
        protected DataTable getReferencesForExcel()
        {
            ArborDataAccessV2 DAL = new ArborDataAccessV2();
            DataTable dtR = DAL.getReferences(QNum);
            dtR.Columns.Remove("ReferenceID");
            dtR.Columns["ReferenceText"].Caption = "Reference";

            foreach (DataRow dr in dtR.Rows)
            {
                dr["ReferenceText"] = dr["ReferenceText"].ToString().Replace("<em>", "").Replace("</em>", "");
            }

            return dtR;
        }
        protected DataTable getSuggestedCitationForExcel()
        {
            DataTable dt = new DataTable("SC");
            DataColumn col1 = new DataColumn("Suggested Citation", typeof(string));
            dt.Columns.Add(col1);

            DataRow dr = dt.NewRow();
            dr["Suggested Citation"] = "Centers for Disease Control and Prevention. Chronic Kidney Disease Surveillance System—United States. website. http://www.cdc.gov/ckd";
            dt.Rows.Add(dr);

            return dt;
        }
        protected DataTable getOtherDataForDownload()
        {

            DataTable dt = new DataTable("FootNotes");
            DataColumn dc1 = new DataColumn("Info", typeof(string));
            DataColumn dc2 = new DataColumn("Text", typeof(string));
            dt.Columns.Add(dc1);
            dt.Columns.Add(dc2);

            //NO GLOBALS
            //*Globals*
            //if (!string.IsNullOrEmpty(litNotes.Text))
            //{
            //DataRow drNotes = dt.NewRow();
            //drNotes["Info"] = "Notes:";
            //drNotes["Text"] = litNotes.Text;
            //drNotes["Text"] = "<ul><li>* Indicates that the result for this cell was suppressed because of imprecision due to a sample size that was too small or the standard error of the result being too large (&gt;30% of the estimate).</li><li>95% confidence intervals, when available, are shown in parentheses.</li></ul>";
            //dt.Rows.Add(drNotes);
            //}


            //*Footnotes*
            ArborDataAccessV2 DAL = new ArborDataAccessV2();
            DataTable dtFN = DAL.getFootNotes(QNum);
            dtFN.Columns.Remove("FootNoteText");
            foreach (DataRow drw in dtFN.Rows)
            {
                drw["FootnoteTextNoHTML"] = Regex.Replace(drw["FootnoteTextNoHTML"].ToString(), "<.*?>", "");
                //*Need Footnotes without html footnote characters in them*

                drw["FootnoteTextNoHTML"] = drw["FootnoteTextNoHTML"].ToString().Replace("&ge;", ">=").Replace("&le;", "<=").Replace("&gt;", ">").Replace("&lt;", "<").Replace("&sup2;", "^2").Replace("&Sup2;", "^2").Replace("&sup3;", "^3").Replace("&Sup3;", "^3"); ;

            }
            dtFN.Columns["FootnoteTextNoHTML"].ColumnName = "Footnotes:";

            DAL = null;

            return dtFN;
        }
        protected DataSet getChartDataForExcel(string maptype)
        {
            ArborDataAccessV2 DAL = new ArborDataAccessV2();
            DataTable dtPage = DAL.getPage(QNum).Tables[0];
            int chartID = determineChartID(dtPage);

            if (QNum.ToUpper() == "Q760")
                chartID = -1;
            else if (QNum.ToUpper() == "Q761")
                chartID = -2;
            else if (QNum.ToUpper() == "Q783")
                chartID = -3;
            else if (QNum.ToUpper() == "Q802")
                chartID = -4;

            string yr = getYear();
            DataSet ds;

            if (maptype == "6" && chartID > 0)
            {
                ds = DAL.getExcelDownloadForMaps(chartID, yr);
                DataTable dsTableZero = ds.Tables[0];
                //adding the header row for the data
                DataRow newRowZero = dsTableZero.NewRow();

                newRowZero[0] = "Main Value";
                newRowZero[1] = "County";
                newRowZero[2] = "State";
                dsTableZero.Rows.InsertAt(newRowZero, 0);

                DataTable dsTableOne = ds.Tables[1];
                //adding the header row for the data
                DataRow newRowOne = dsTableOne.NewRow();
                newRowOne[0] = "Main Value";
                newRowOne[1] = "County";
                newRowOne[2] = "State";
                newRowOne[3] = "Year";
                dsTableOne.Rows.InsertAt(newRowOne, 0);

            }
            else if (chartID == -1)
            {
                ds = DAL.getExcelDownloadForMaps(chartID, yr);
                DataTable dsTableZero = ds.Tables[0];
                //adding the header row for the data
                DataRow newRowZero = dsTableZero.NewRow();

                newRowZero[0] = "Percentage of Diagnosed CKD Patients";
                newRowZero[1] = "STATE";
                newRowZero[2] = "County";
                newRowZero[3] = "Average Daily PM2.5";
                dsTableZero.Rows.InsertAt(newRowZero, 0);

                DataTable dsTableOne = ds.Tables[1];
                //adding the header row for the data
                DataRow newRowOne = dsTableOne.NewRow();
                newRowOne[0] = "Percentage of Diagnosed CKD Patients";
                newRowOne[1] = "STATE";
                newRowOne[2] = "County";
                newRowOne[3] = "Average Daily PM2.5";
                dsTableOne.Rows.InsertAt(newRowOne, 0);
            }
            else if (chartID == -2)
            {
                ds = DAL.getExcelDownloadForMaps(chartID, yr);
                DataTable dsTableZero = ds.Tables[0];
                //adding the header row for the data
                DataRow newRowZero = dsTableZero.NewRow();

                newRowZero[0] = "Percentage of Diagnosed CKD Patients";
                newRowZero[1] = "Percentage of the Population Below the Poverty Threshold";
                newRowZero[2] = "STATE";
                newRowZero[3] = "COUNTY";
                dsTableZero.Rows.InsertAt(newRowZero, 0);

                DataTable dsTableOne = ds.Tables[1];
                //adding the header row for the data
                DataRow newRowOne = dsTableOne.NewRow();
                newRowOne[0] = "Percentage of Diagnosed CKD Patients";
                newRowOne[1] = "Percentage of the Population Below the Poverty Threshold";
                newRowOne[2] = "STATE";
                newRowOne[3] = "COUNTY";
                dsTableOne.Rows.InsertAt(newRowOne, 0);
            }
            else
            {
                ds = DAL.getExcelDownload(chartID, yr);
            }

            //*********
            //*Cleanup*
            //*********
            dtPage.Dispose();
            DAL = null;

            return ds;
        }
        private MemoryStream GetStream(XLWorkbook excelWorkbook)
        {
            MemoryStream fs = new MemoryStream();
            excelWorkbook.SaveAs(fs);
            fs.Position = 0;
            return fs;
        }
        protected void lnkDownload_Click(object sender, EventArgs e)
        {
            lnkDownloadBottom_Click(this, null);
        }
        protected void lnkDownloadBottom_Click(object sender, EventArgs e)
        {
            //****************************
            //*Get the Gridviews to Export*
            //****************************

            //*Build the Title from strats and years*
            string titleRoot = litChartTitleText.Text.Trim();
            string strat = StratYear1.CurrentStrat.Trim().Replace(", ", "_").Trim().Replace(",", "_").Replace("/", "_").Trim();
            string year = StratYear1.CurrentYear.Trim().Replace(" - ", "_").Trim().Replace("-", "_").Trim();
            string title = titleRoot.Replace(" ", "_").Trim() + "_by_" + strat + "_" + year;
            //if (DAL.proc_IsRelatedToAgeSTD(QNum, Request.QueryString["Strat"]) && rbstd2.Checked)
            //{
            //    QNum = QNum.Replace("Q", "S");
            //}

            if (QNum.ToUpper() == "Q760")
                title = "CKD_PM25";
            else if (QNum.ToUpper() == "Q761")
                title = "CKD_poverty";
            else if (QNum.ToUpper() == "Q783")
                title = "CKD_segregation";
            else if (QNum.ToUpper() == "Q802")
                title = "CKD_aya";

            int loc = title.IndexOf("<sup>");
            if (loc > 0)
            {
                title = title.Substring(0, loc);
            }


            //*Header Info*            
            DataTable dtHeader = getHeaderInfo();

            //*Get Excel tables*
            DataSet dsExcels;
            DataSet dsExcelsForS;
            Boolean isStatic = false;

            if (QNum.ToUpper() == "Q761" || QNum.ToUpper() == "Q760" || QNum.ToUpper() == "Q783" || QNum.ToUpper() == "Q802")
            {
                dsExcels = getChartDataForExcel("6");
                isStatic = true;
            }
            else
            {
                dsExcels = getChartDataForExcel(hfMapType.Value);
            }
            //*Specific Data*
            DataTable dtData = dsExcels.Tables[0];

            //*ALL data for this indicator*
            DataTable dtAllData = dsExcels.Tables[1];

            //*Globals and footnotes*
            DataTable gvOther = getOtherDataForDownload();

            //*References*
            DataTable gvReferences = getReferencesForExcel();

            //*Suggested Citation*
            DataTable dtSC = getSuggestedCitationForExcel();

            DataTable dtDataForS = new DataTable();

            DataTable dtAllDataForS = new DataTable();

            if (!isStatic && QNum.ToUpper().StartsWith("Q") && DAL.proc_IsRelatedToAgeSTD(QNum, Request.QueryString["Strat"]))
            {
                QNum = QNum.ToUpper().Replace("Q", "S");

                dsExcelsForS = getChartDataForExcel(hfMapType.Value);

                QNum = QNum.ToUpper().Replace("S", "Q");

                //*Specific Data*
                dtDataForS = dsExcelsForS.Tables[0];

                //*ALL data for this indicator*
                dtAllDataForS = dsExcelsForS.Tables[1];
            }

            DataTable[] dtArray;
            //*Put tables in an Array
            if (DAL.proc_IsRelatedToAgeSTD(QNum, Request.QueryString["Strat"]))
            {
                dtArray = new [] {
                    dtHeader,
                    dtData,
                    dtDataForS,
                    dtAllData,
                    dtAllDataForS,
                    gvOther,
                    gvReferences,
                    dtSC
                };
            }
            else
            {
                dtArray = new[] {
                    dtHeader,
                    dtData,
                    dtAllData,
                    gvOther,
                    gvReferences,
                    dtSC
                };
            }


            //*Save them to Excel and show them to the user*
            doMultiGridExcel(dtArray, title);

            //QNum = QNum.Replace("S", "Q");
        }
        protected void btnDownloadChart_Click(object sender, EventArgs e)
        {
            //*********************************
            //*Get the chart from memorystream* - previously saved in session (end of buildChart() ~ line 1126)
            //*********************************

            String titleNoFN = "chartimage";
            if (Session["TitleNoFN"] != null)
            {
                titleNoFN = "Chart_" + Session["TitleNoFN"].ToString().Replace(" ", "_").Trim();
            }


            MemoryStream memStr = new MemoryStream();
            memStr = (MemoryStream)Session["ms"];

            Response.Clear();
            Response.ContentType = "Image/png";
            Response.AddHeader("Content-disposition", "attachment;filename=\"" + titleNoFN + ".png\""); //*See note below**
            Response.AddHeader("Content-Length", memStr.Length.ToString());
            Response.BinaryWrite(memStr.ToArray());
        }
        private IXLWorksheet getFilledWorkSheet(DataTable dt, IXLWorksheet ws, bool buildHeader)//, XLWorkbook wb)
        {
            IXLWorksheet answer = ws;

            if (buildHeader == true)
            {
                //***********************
                //*Format the Header Row*
                //***********************
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    ws.Cell(1, i + 1).Value = dt.Columns[i].ColumnName;

                    ws.Cell(1, i + 1).Style.Border.LeftBorder = XLBorderStyleValues.Thin;
                    ws.Cell(1, i + 1).Style.Border.LeftBorderColor = XLColor.Black;

                    ws.Cell(1, i + 1).Style.Border.BottomBorder = XLBorderStyleValues.Thin;
                    ws.Cell(1, i + 1).Style.Border.BottomBorderColor = XLColor.Black;

                    ws.Cell(1, i + 1).Style.Border.TopBorder = XLBorderStyleValues.Thin;
                    ws.Cell(1, i + 1).Style.Border.TopBorderColor = XLColor.Black;

                    ws.Cell(1, i + 1).Style.Border.RightBorder = XLBorderStyleValues.Thin;
                    ws.Cell(1, i + 1).Style.Border.RightBorderColor = XLColor.Black;


                    ws.Cell(1, i + 1).Style.Fill.BackgroundColor = XLColor.Silver;
                    ws.Cell(1, i + 1).Style.Font.FontColor = XLColor.Maroon;
                    ws.Cell(1, i + 1).Style.Font.Bold = true;

                    ws.Cell(1, i + 1).Style.Alignment.WrapText = true;
                }


                //**********
                //*Add Data*
                //**********
                ws.Cell(2, 1).InsertData(dt.AsEnumerable());


                //*********************************************
                //Wrap the texts for each of the cells of data*
                //*********************************************
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    for (int j = 0; j < dt.Rows.Count; j++)
                    {
                        ws.Cell(j + 2, i + 1).Style.Alignment.WrapText = true;
                    }
                }
            }
            else
            {
                //**********
                //*Add Data*
                //**********
                ws.Cell(1, 1).InsertData(dt.AsEnumerable());

                //***********************
                //*Format the Header Row*
                //***********************
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    ws.Cell(1, i + 1).Style.Border.LeftBorder = XLBorderStyleValues.Thin;
                    ws.Cell(1, i + 1).Style.Border.LeftBorderColor = XLColor.Black;

                    ws.Cell(1, i + 1).Style.Border.BottomBorder = XLBorderStyleValues.Thin;
                    ws.Cell(1, i + 1).Style.Border.BottomBorderColor = XLColor.Black;

                    ws.Cell(1, i + 1).Style.Border.TopBorder = XLBorderStyleValues.Thin;
                    ws.Cell(1, i + 1).Style.Border.TopBorderColor = XLColor.Black;

                    ws.Cell(1, i + 1).Style.Border.RightBorder = XLBorderStyleValues.Thin;
                    ws.Cell(1, i + 1).Style.Border.RightBorderColor = XLColor.Black;

                    ws.Cell(1, i + 1).Style.Fill.BackgroundColor = XLColor.Silver;
                    ws.Cell(1, i + 1).Style.Font.FontColor = XLColor.Maroon;
                    ws.Cell(1, i + 1).Style.Font.Bold = true;
                }
            }

            return answer;
        }
        public void doMultiGridExcel(DataTable[] dt, string title)
        {

            XLWorkbook wb = new XLWorkbook();

            //***************************
            //*Data Source / Header Info*
            //***************************
            string wsDSName = "Data Source";
            wb.Worksheets.Add(wsDSName);
            IXLWorksheet hdr = wb.Worksheets.Worksheet(wsDSName);
            hdr = getFilledWorkSheet(dt[0], hdr, true);
            hdr.Columns(1, 100).Width = 50;


            int tabIndex = 1;


            if (dt.Length >= 8)
            {
                //*********************
                //*Data for this Chart*
                //*********************
                string wsCurrentChartData = "Crude Data For Current Chart";
                wb.Worksheets.Add(wsCurrentChartData);
                IXLWorksheet curChartData = wb.Worksheets.Worksheet(wsCurrentChartData);
                curChartData = getFilledWorkSheet(dt[tabIndex++], curChartData, false);

                //*********************
                //*Data for this Chart*
                //*********************
                string wsCurrentChartDataSTD = "Age STD Data For Current Chart";
                wb.Worksheets.Add(wsCurrentChartDataSTD);
                IXLWorksheet curChartDataSTD = wb.Worksheets.Worksheet(wsCurrentChartDataSTD);
                curChartDataSTD = getFilledWorkSheet(dt[tabIndex++], curChartDataSTD, false);

                //*********************
                //*Data for ALL Charts*
                //*********************
                string wsAllChartData = "Crude Data For Entire Data";
                wb.Worksheets.Add(wsAllChartData);
                IXLWorksheet allChartData = wb.Worksheets.Worksheet(wsAllChartData);
                allChartData = getFilledWorkSheet(dt[tabIndex++], allChartData, false);

                //*********************
                //*Data for ALL Charts*
                //*********************
                string wsAllChartDataSTD = "Age STD Data For Entire Data";
                wb.Worksheets.Add(wsAllChartDataSTD);
                IXLWorksheet allChartDataSTD = wb.Worksheets.Worksheet(wsAllChartDataSTD);
                allChartDataSTD = getFilledWorkSheet(dt[tabIndex++], allChartDataSTD, false);
            }
            else {
                //*********************
                //*Data for this Chart*
                //*********************
                string wsCurrentChartData = "Data For Current Chart";
                wb.Worksheets.Add(wsCurrentChartData);
                IXLWorksheet curChartData = wb.Worksheets.Worksheet(wsCurrentChartData);
                curChartData = getFilledWorkSheet(dt[tabIndex++], curChartData, false);

                //*********************
                //*Data for ALL Charts*
                //*********************
                string wsAllChartData = "Data For Entire Data";
                wb.Worksheets.Add(wsAllChartData);
                IXLWorksheet allChartData = wb.Worksheets.Worksheet(wsAllChartData);
                allChartData = getFilledWorkSheet(dt[tabIndex++], allChartData, false);
            }

            //*********************
            //*FootNotes for Chart*
            //*********************
            string wsFN = "Footnotes";
            wb.Worksheets.Add(wsFN);
            IXLWorksheet fn = wb.Worksheets.Worksheet(wsFN);
            fn = getFilledWorkSheet(dt[tabIndex++], fn, true);
            fn.Columns(1, 50).Width = 60;


            //************
            //*References*
            //************
            string wsRef = "References";
            wb.Worksheets.Add(wsRef);
            IXLWorksheet refs = wb.Worksheets.Worksheet(wsRef);
            refs = getFilledWorkSheet(dt[tabIndex++], refs, true);
            refs.Columns(1, 50).Width = 60;


            //*******************
            //Suggested Citation*
            //*******************
            string wsSC = "Suggested Citation";
            wb.Worksheets.Add(wsSC);
            IXLWorksheet sc = wb.Worksheets.Worksheet(wsSC);
            sc = getFilledWorkSheet(dt[tabIndex++], sc, true);
            sc.Columns(1, 50).Width = 100;



            //*Get title of Excel spreadsheet*
            title = title.Trim().Replace(",", "").Replace(" ", "_").Replace(".", "").Replace("†", "");

            //*If the name is too long, it will not open*
            if (title.Length > 100)
            {
                title = title.Substring(0, 100);
            }
            string myName = Server.UrlEncode(title + ".xlsx");

            MemoryStream mstream = GetStream(wb);


            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment; filename=" + myName);
            Response.ContentType = "application/vnd.ms-excel";
            Response.BinaryWrite(mstream.ToArray());
            Response.End();

            return;
        }



        //***********************
        //*Most Recently Visited*
        //***********************
        protected void getMostRecentlyVisited()
        {
            DataTable answer = null;

            //Limited to 4 (per CKD discussion 
            if (Session["mrv"] != null)
            {
                answer = (DataTable)Session["mrv"];
            }

            if (answer == null)
            {
                return;
            }


            //Build the HTML unordered list
            if (answer.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("<span class='gutterHeaders'>Most Recently Viewed</span>");
                sb.Append("<ul>");

                for (int i = answer.Rows.Count - 1; i >= 0; i--)
                {
                    sb.Append("<li>");
                    sb.Append("<a href='" + answer.Rows[i]["url"].ToString() + "#refreshPosition'>");
                    sb.Append(answer.Rows[i]["title"].ToString());
                    sb.Append("</a>");
                    sb.Append("</li>");
                }

                sb.Append("</ul>");


                //Add the list to the page
                Literal litMRV = new Literal();
                litMRV.Text = sb.ToString().Trim();

                phMRV.Controls.Add(litMRV);
            }

        }
        protected void rememberRecentlyVisited(string url, string title)
        {
            DataTable answer = null;


            //Limited to 4 (per CKD discussion 
            if (Session["mrv"] != null)
            {
                answer = (DataTable)Session["mrv"];
            }
            else
            {
                //create the table                
                DataColumn col1 = new DataColumn("title", typeof(string));
                DataColumn col2 = new DataColumn("url", typeof(string));
                DataColumn[] cols = { col1, col2 };
                answer = new DataTable("mrv");
                answer.Columns.AddRange(cols);
            }


            //*Have we already saved this page recently?*
            bool isNew = true;
            foreach (DataRow dr in answer.Rows)
            {
                if (dr["url"].ToString().Trim() == url || dr["title"].ToString().Trim() == title)
                {
                    isNew = false;
                    break;
                }
            }

            //*Add the row*
            if (isNew == true)
            {
                DataRow dr = answer.NewRow();
                dr["title"] = title.Split(new string[] { "<sup>" }, StringSplitOptions.None)[0].ToString();
                dr["url"] = url;
                answer.Rows.Add(dr);
            }


            //*Delete From the Bottom*
            while (answer.Rows.Count > 4)
            {
                answer.Rows[0].Delete();
                answer.AcceptChanges();
            }

            Session["mrv"] = answer;
        }


        //********
        //*PLOTLY*
        //********        
        private void buildChart(string chartID, DataTable dtPage, bool showMapSlider, bool onStateMapPage, bool onCountyMapPage)
        {

            //*Clean up*
            Session["TableHeader"] = null;


            //*Get Page*
            ArborDataAccessV2 DAL = new ArborDataAccessV2();

            //*If this is a Map, it will have no records*
            if (dtPage.Rows.Count == 0) { return; }


            string quintileColorSetting = getQuintileColorSetting();


            //*Get ChartID*
            string yr = getYear();
            DataSet dsChart;
            if (onCountyMapPage)
            {
                dsChart = DAL.getChartForMaps(Convert.ToInt32(chartID), yr, quintileColorSetting);
            }
            else
            {
                dsChart = DAL.getChart(Convert.ToInt32(chartID), yr, quintileColorSetting);
            }

            DataTable dtChartHeader = dsChart.Tables[0];
            DataTable dtChart = dsChart.Tables[1];


            //Clean up the NA and *
            dtChart = cleanChartTable(dtChart);


            DataView dv = dtChart.DefaultView;

            bool isMap = onStateMapPage;// false;            
            if (!String.IsNullOrEmpty(dv.Table.Rows[0]["Tertiary"].ToString())) istriplestrat = true;


            DataSet dsSVG = new DataSet();

            //Only show the quintile range choices if this is a map
            StratYear1.showQuintileColorRanges = isMap;
            Session["TitleNoFN"] = dtChartHeader.Rows[0]["ChartHeader"].ToString();

            //Populate measure text (6/13/2017)
            string chartMeasureTitle = dtPage.Rows[0]["Measure"].ToString().Trim() + "<br />";

            //*Populate the Chart/Table header and DataSource Long Title*
            string chartTitleText = dsChart.Tables["Chart"].Rows[0]["PageTitleWithSuperscripts"].ToString();

            //was ChartHeaderWithSuperscripts
            string chartSubTitleText = dsChart.Tables["Chart"].Rows[0]["DataSourceFullName"].ToString();
            string tableTitleText = dsChart.Tables["Chart"].Rows[0]["ChartHeaderWithSuperscripts"].ToString(); // use below within the session ["TableHeader"] value
            string tableSubtitleText = dsChart.Tables["Chart"].Rows[0]["DataSourceFullName"].ToString();
            //added 1/22/2019 BS
            string chartShorttitleText = dsChart.Tables["Chart"].Rows[0]["IndicatorShortTitle"].ToString();
            //if (datasourceCount > 1) //if more then 1 datasource is listed then display the chart title 
            //{
            litChartTitleText.Text = chartShorttitleText;
            //}
            if ((bool)dtChartHeader.Rows[0]["HP2020Logo"] == true)
            {
                imgHP2020.Visible = true;
            }
            else
            {
                imgHP2020.Visible = false;
            }

            string tableByPopulation = wrapText(dsChart.Tables["Chart"].Rows[0]["ByPopulation"].ToString(), 100);
            if (tableByPopulation != "")
            {
                tableByPopulation = "<br>" + tableByPopulation;
                viewdatabyCount = viewdatabyCount + 1;
            }
            else
            {
                tableByPopulation = "";
            }

            if (QNum.ToUpper() == "Q372" ||
                QNum.ToUpper() == "Q702" ||
                QNum.ToUpper() == "Q762" ||
                QNum.ToUpper() == "Q763" ||
                QNum.ToUpper() == "Q764" ||
                QNum.ToUpper() == "Q185" ||
                QNum.ToUpper() == "Q364" ||
                QNum.ToUpper() == "Q703" ||
                QNum.ToUpper() == "Q700" ||
                QNum.ToUpper() == "Q719" ||
                QNum.ToUpper() == "Q730")
                litChartTitleText.Visible = false;
            else
            {
                litChartTitleText.Visible = true;

                var subTitlePrefix = "";

                subTitlePrefix = dsChart.Tables["Chart"].Rows[0]["SubTitlePrefix"].ToString();

                if (QNum.ToUpper().Replace("Q", "").Replace("S", "") == "9" || QNum.ToUpper() == "Q756")
                {
                    subTitlePrefix = "CKD (%), ";
                }
                else if (QNum.ToUpper() == "Q98" || QNum.ToUpper() == "Q759")
                {
                    subTitlePrefix = "Aware of CKD (%), ";
                }
                else if (QNum.ToUpper() == "Q605")
                {
                    subTitlePrefix = "ACEi/ARB Use (%), ";
                }
                else if (QNum.ToUpper() == "Q640")
                {
                    subTitlePrefix = "Albuminuria Testing (%), ";
                }
                else if (QNum.ToUpper() == "Q705")
                {
                    if (Request.QueryString["Strat"] == null || Request.QueryString["Strat"] == "County")
                        subTitlePrefix = "Overall";
                    else if (Request.QueryString["Strat"] != null && Request.QueryString["Strat"].ToString().IndexOf("Diabetes") >= 0)
                        subTitlePrefix = "Diabetes";
                    else if (Request.QueryString["Strat"] != null && Request.QueryString["Strat"].ToString().IndexOf("Hypertension") >= 0)
                        subTitlePrefix = "Hypertension";
                }

                if (QNum.ToUpper() == "Q705")
                    litChartTitleText.Text = subTitlePrefix;
                else if (QNum.ToUpper() == "Q781")
                {
                    litChartTitleText.Text = "";
                }
                else
                {
                    if (Request.QueryString["Strat"] == null || Request.QueryString["Strat"] == "Overall")
                    {
                        litChartTitleText.Text = subTitlePrefix + "Overall";
                    }
                    else if (Request.QueryString["Strat"] != null)
                    {
                        litChartTitleText.Text = subTitlePrefix + "by " + Request.QueryString["Strat"].ToString();
                    }
                }
            }

            //litChartTitleText.Text = tableByPopulation.Replace("Year and ", "") ;
            //litChartTitleText.Text = litChartTitleText.Text.Replace("<br>", "");
            //litChartTitleText.Text = litChartTitleText.Text.Replace("/Ethnicity", "");
            //litChartTitleText.Text = litChartTitleText.Text.Replace("For 2019", "");

            //if ((QNum == "Q9") || (QNum == "Q756"))
            //{
            //    if (litChartTitleText.Text == "by Year")
            //    {
            //        litChartTitleText.Text = "CKD (%)";  //Overall
            //    }
            //    else if (litChartTitleText.Text == "by Age")
            //    {
            //        litChartTitleText.Text = "CKD (%), " + litChartTitleText.Text + " Category";
            //    }
            //    else
            //    {
            //        litChartTitleText.Text = "CKD (%), " + litChartTitleText.Text;
            //    }
            //}
            //else if ((QNum == "Q98") || (QNum == "Q759"))
            //{
            //    if (litChartTitleText.Text == "by Year")
            //    {
            //        litChartTitleText.Text = "Aware of CKD (%)";  //Overall
            //    }
            //    else if (litChartTitleText.Text == "by Age")
            //    {
            //        litChartTitleText.Text = "Aware of CKD (%), " + litChartTitleText.Text + " Category";
            //    }
            //    else
            //    {
            //        litChartTitleText.Text = "Aware of CKD (%), " + litChartTitleText.Text;
            //    }
            //}
            //else if (QNum == "Q605")
            //{
            //    if (litChartTitleText.Text == "by Year")
            //    {
            //        litChartTitleText.Text = "ACEi/ARB Use (%)";  //Overall
            //    }
            //    else if (litChartTitleText.Text == "by Age")
            //    {
            //        litChartTitleText.Text = "ACEi/ARB Use (%), " + litChartTitleText.Text + " Category";
            //    }
            //    else
            //    {
            //        litChartTitleText.Text = "ACEi/ARB Use (%), " + litChartTitleText.Text;
            //    }
            //}
            //else if (QNum == "Q640")
            //{
            //    if (litChartTitleText.Text == "by Year")
            //    {
            //        litChartTitleText.Text = "Albuminuria Testing (%)";  //Overall
            //    }
            //    else if (litChartTitleText.Text == "by Age")
            //    {
            //        litChartTitleText.Text = "Albuminuria Testing (%), " + litChartTitleText.Text + " Category";
            //    }
            //    else
            //    {
            //        litChartTitleText.Text = "Albuminuria Testing (%), " + litChartTitleText.Text;
            //    }
            //}
            //else if ((QNum == "Q364") || (QNum == "Q700") || (QNum == "Q703"))  //subtitle is not needed since it's only one view
            //{
            //    litChartTitleText.Text = "";
            //}

            //if ((datasourceCount > 1) && (viewdatabyCount > 1)) //if more then 1 datasource is listed then display the chart title 
            //{
            //if (!string.IsNullOrEmpty(tableByPopulation))
            //{
            //    if ((litChartTitleText.Text).Length > 0)
            //    {
            //        litChartTitleText.Text = litChartTitleText.Text + " - " + tableByPopulation;
            //    }
            //    else
            //    {
            //        litChartTitleText.Text = tableByPopulation.Replace("by ", "By ");
            //    }
            //}
            //}


            //*Store the Header Text and Title for the Gridview*
            if (QNum.ToUpper() != "Q89" && QNum.ToUpper() != "Q185" && QNum.ToUpper() != "Q773")
            {
                Session["TableHeader"] = "<div class=\"addedTableHeader\">" + dsChart.Tables["Chart"].Rows[0]["ChartHeaderWithSuperscripts"].ToString() + tableByPopulation + " (%)</div> <div class=\"addedTableHeaderDataSource\">" + dsChart.Tables["Chart"].Rows[0]["DataSourceFullName"].ToString() + "</div>";
            }
            else
            {
                Session["TableHeader"] = "<div class=\"addedTableHeader\">" + dsChart.Tables["Chart"].Rows[0]["ChartHeaderWithSuperscripts"].ToString() + tableByPopulation + "</div> <div class=\"addedTableHeaderDataSource\">" + dsChart.Tables["Chart"].Rows[0]["DataSourceFullName"].ToString() + "</div>";
            }

            litTopic.Text = litTopic.Text + dtChartHeader.Rows[0]["PageTitleWithSuperscripts"].ToString();// 7/7/2017 - temporary fix until the title is able to be broken out into 3 lines
            litTopic.Text = litTopic.Text.Replace("<sup><strong>a</strong></sup>", "");  //remove the superscript
            litTopic.Text = litTopic.Text.Replace("<sup><strong>a,b</strong></sup>", "");
            litTopicMobile.Text = litTopic.Text;

            //change in what is to be displayed 3/19/2020
            this.Title = "CDC Surveillance System: " + chartShorttitleText;// +" - QNum:" + Session["qnum"].ToString();//updating the page title dynamically to optimize SEO //removed QNUM 11/20
            this.MetaDescription = Session["TitleNoFN"].ToString();//updating the page meta description dynamically to optimize SEO

            //Remove anything created in the masterpage for this Meta tag so as not to have duplicate description tags (3/20/2020)
            Literal lit = (Literal)Master.FindControl("litMetaTagsDescription");
            lit.Text = "";
            lit.Dispose();


            //**************************
            //*Populate the Explanation*
            //**************************
            string exp = dtChartHeader.Rows[0]["Explanation"].ToString();
            //lblExplanationBody.Text +=  exp;//dtChartHeader.Rows[0]["Explanation"].ToString();
            //litTopicDesc.Text = exp;
            litChartInstruction.Text = exp;

            if (isMap || istriplestrat || onCountyMapPage)
            {

                //*if we should not show the chart...*
                bool tableOnly = Convert.ToBoolean(dtChartHeader.Rows[0]["ShowTableOnly"]);
                if (tableOnly == true)
                {
                    pnlChart.Visible = false;
                    litNoChart.Text = "<br /><strong>No chart currently available</strong><br />";

                    //*Manage the buttons for chart download*
                    btnDownloadChart.Visible = false;

                    //*Hide the color range choices*
                    StratYear1.showQuintileColorRanges = false;

                    //Hide the map too
                    pnlMap.Visible = false;

                    return;
                }
                else
                {
                    //Clear the message
                    litNoChart.Text = "";
                    pnlChart.Visible = true;

                    //*Enable download chart button*
                    btnDownloadChart.Enabled = true;
                }


                //pnlD3Maps                
                if (isMap == true)
                {
                    //eventually this functionality will be added once Plotly/D3 triple strats are used
                    chartFormatOptions.Visible = false;
                    RB_ChartType.Visible = false;
                    CB_ChartCI.Visible = false;
                    chartColorOptions.Visible = false;
                    RB_ChartColor.Visible = false;

                    //*Do not use superscripts, as this leaves extra HTML lying around when used in the alt tag.
                    string title = dsChart.Tables["Chart"].Rows[0]["ChartHeader"].ToString().Trim();


                    //*(Change 5/29/14) - Show the chart, but make it a bar chart, and sort desc*
                    pnlChart.Visible = true;
                    pnlMap.Visible = true;
                    dv.Sort = "DataPointSort  Asc";

                    DataTable dtTemp = dv.ToTable();

                    dtChart = null;
                    dtChart = dtTemp.Copy();

                    //Clean-up            
                    dtTemp.Dispose();

                    dsSVG.Tables.Add(dsChart.Tables[2].Copy());
                    dsSVG.Tables.Add(dsChart.Tables[3].Copy());

                    //added 1/21/2019 BS, temporary fix for the maps
                    string titletext = wrapText(dsChart.Tables[0].Rows[0]["ChartHeader"].ToString(), 100);
                    string bypopulation = wrapText(dsChart.Tables[0].Rows[0]["ByPopulation"].ToString(), 100);
                    if (bypopulation != "")
                        bypopulation = "<br><b>" + bypopulation + "</b>";

                    if (showMapSlider == true) //loading all of the maps data
                    {
                        DataSet dsAllMaps = DAL.getMapDataAllYears(Convert.ToInt32(chartID));
                        string d3jsCode = getD3MapJSCode(dsAllMaps, "map", chartTitleText, chartSubTitleText, title, true);
                        litD3Map.Text = d3jsCode;
                    }
                    else //loading single year map data
                    {
                        //creating the D3 js code
                        string d3jsCode = getD3MapJSCode(dsSVG, "map", chartTitleText, chartSubTitleText, title, false);
                        litD3Map.Text = d3jsCode;
                    }


                    //showing a plotly chart at the bottom of the map, and flipping the axis values around
                    buildPlotlyBarChartForMaps(chartID.ToString(), dtPage, "<b>" + titletext + "</b>" + bypopulation + " - " + dsChart.Tables["Chart"].Rows[0]["DataSourceFullName"].ToString(), dsChart.Tables[0].Rows[0]["YAxisLabel"].ToString(), dsChart.Tables[0].Rows[0]["XAxisLabel"].ToString(), true);
                    hfMapType.Value = "5";
                }
                else if (onCountyMapPage)
                {
                    //*Do not use superscripts, as this leaves extra HTML lying around when used in the alt tag.
                    string title = dsChart.Tables["Chart"].Rows[0]["ChartHeader"].ToString().Trim();
                    dsSVG.Tables.Add(dsChart.Tables[1].Copy()); //data
                    //still need to add the legend

                    string d3MapJsCode = getD3MapTabsJSCode(dsSVG, "map", chartTitleText, chartSubTitleText, title, false, yr);
                    litD3MapTabs.Text = d3MapJsCode;
                    hfMapType.Value = "6";
                }
                else
                {
                    string titletext = wrapText(dsChart.Tables[0].Rows[0]["ChartHeader"].ToString(), 100);
                    string bypopulation = wrapText(dsChart.Tables[0].Rows[0]["ByPopulation"].ToString(), 100);
                    if (bypopulation != "")
                    {
                        bypopulation = "<br><b>" + bypopulation + "</b>";
                    }


                    chartFormatOptions.Visible = true;
                    RB_ChartType.Visible = true;
                    CB_ChartCI.Visible = true;

                    if (QNum.ToUpper() == "Q372")
                    {
                        CB_ChartCI.Visible = false;
                    }

                    chartColorOptions.Visible = false;
                    RB_ChartColor.Visible = false;

                    pnlMap.Visible = false;
                    btnDownloadChart.Enabled = false;
                    btnDownloadChart.Visible = false;

                    buildPlotlyTripleStratChart(chartID.ToString(), dtPage, "<b>" + titletext + "</b>" + bypopulation + "<br>" + dsChart.Tables["Chart"].Rows[0]["DataSourceFullName"].ToString(), dsChart.Tables[0].Rows[0]["XAxisLabel"].ToString(), dsChart.Tables[0].Rows[0]["YAxisLabel"].ToString(), dv);


                }
            }
            else
            {
                chartFormatOptions.Visible = true;
                RB_ChartType.Visible = true;
                CB_ChartCI.Visible = true;

                if (QNum.ToUpper() == "Q372")
                {
                    CB_ChartCI.Visible = false;
                }

                pnlMap.Visible = false;
                btnDownloadChart.Enabled = false;
                btnDownloadChart.Visible = false;
                string titletext = wrapText(dsChart.Tables[0].Rows[0]["ChartHeader"].ToString(), 100);
                string bypopulation = wrapText(dsChart.Tables[0].Rows[0]["ByPopulation"].ToString(), 100);
                if (bypopulation != "")
                    bypopulation = "<br><b>" + bypopulation + "</b>";
                buildPlotlyChart(chartID.ToString(), dtPage, "<b>" + titletext + "</b>" + bypopulation + "<br>" + dsChart.Tables["Chart"].Rows[0]["DataSourceFullName"].ToString(), dsChart.Tables[0].Rows[0]["XAxisLabel"].ToString(), dsChart.Tables[0].Rows[0]["YAxisLabel"].ToString(), false);

            }


            //********
            //*Legend*
            //********            
            Legend mainLegend = new Legend("Main");

            mainLegend.Docking = Docking.Bottom;
            mainLegend.LegendStyle = LegendStyle.Table;
            mainLegend.Alignment = System.Drawing.StringAlignment.Center;
            mainLegend.BorderDashStyle = ChartDashStyle.NotSet;
            mainLegend.Font = new System.Drawing.Font("Verdana", (float)10, FontStyle.Regular);



            //**************************
            //*General Chart Properties*
            //**************************
            string link = "http://nccd.cdc.gov/CKD.";
            string configCitation = ConfigurationManager.AppSettings["chartboilerplate"].ToString();
            string citationLine1 = configCitation.Replace("@DT@", DateTime.Now.Year.ToString()).Replace("|", "/").Replace("-", "—").Replace("Web site. http://nccd.cdc.gov/CKD.", "").Trim();
            string citationLine2 = "website. " + link;
        }
        private void buildPlotlyBarChartForMaps(string chartID, DataTable dtPage, string chartTitle, string xaxisTitle, string yaxisTitle, bool isMapPage)
        {
            //*Get Page*
            ArborDataAccessV2 DAL = new ArborDataAccessV2();

            string quintileColorSetting = getQuintileColorSetting();


            //*Get ChartID*
            string yr = getYear();
            DataSet dsChart = DAL.getChart(Convert.ToInt32(chartID), yr, quintileColorSetting);
            DataTable dtChartHeader = dsChart.Tables[0];
            DataTable dtChart_preSort = dsChart.Tables[3];

            dtChart_preSort.Columns.Add("IntegerValue", typeof(System.Int32));
            foreach (DataRow row in dtChart_preSort.Rows)
            {
                Int16 valueint = 0;
                string valuestring = row["MainValueAdjustedForDigitsRightOfDecimal"].ToString().Replace(",", "");
                if (Int16.TryParse(valuestring, out valueint))
                {
                    valueint = Int16.Parse(valuestring);
                }

                row["IntegerValue"] = valueint;
            }

            DataTable dtChart = datableReSort(dtChart_preSort, "IntegerValue", "ASC");

            int xaxis_cnt = 1;
            int max_xaxis_cnt = 0;


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
            string colorval = "";
            for (int i = 0; i <= dtChart.Rows.Count - 1; i++)
            {
                string secondary = dtChart.Rows[i]["MainValueAdjustedForDigitsRightOfDecimal"].ToString();
                secondary = wrapText(secondary, wrapsize);
                string serieslabel = dtChart.Rows[i]["MainValueAdjustedForDigitsRightOfDecimal"].ToString() + " - " + dtChart.Rows[i]["StateAbbrev"].ToString(); //stateabbrev
                string datapoint = dtChart.Rows[i]["State"].ToString();
                colorval = dtChart.Rows[i]["Color"].ToString();
                serieslabel = serieslabel.Replace("&", "and"); //overridding the & so that the chart doesn't fail

                datapoint = datapoint.Replace("*", "");


                hfval_x = "x:[ '" + secondary + "']"; //finding the 'column' value
                hfval_y = "y:['" + datapoint + "']"; //finding the actual data value

                string xData_col = hfval_x;//removing the last comma
                string yData_col = hfval_y;//removing the last comma

                //9/28/2020 - BS - added the increment value of 'i' to the data variable string so that it is unique
                plotlyStr.Append(" var data" + cleanString(serieslabel) + i.ToString() + " = {" + xData_col + " , " + yData_col);

                plotlyStr.Append(",  name: '" + serieslabel + "',  orientation:'h', type: eval($('#hfChartType').val()), marker: {color: '" + colorval + "', line: { color: 'rgb(90,90,90)', width: .5} }};"); //appending the 'row' to the data name and adding the array data
                //9/28/2020 - BS - added the increment value of 'i' to the data variable string so that it is unique
                plotlyGroups = plotlyGroups + "data" + cleanString(serieslabel) + i.ToString() + ","; //adding the above data variable to the group variable

            }


            //HF_D3Data.Value = theData;
            if (plotlyGroups == "var data = [")// if this variable hasn't been added to, then add the above chartdata
                plotlyGroups = plotlyGroups + "chartdata ";

            string dataGroups = plotlyGroups.Substring(0, plotlyGroups.Length - 1) + "];";//otherwise, close the array and add it to the plotly string

            plotlyStr.Append(dataGroups);
            /*end Create data array logic*/


            CB_ChartCI.Visible = false;

            createPlotlyScript(plotlyStr, chartTitle, xaxisTitle, yaxisTitle, max_xaxis_cnt, isMapPage);
        }
        private void buildPlotlyChart(string chartID, DataTable dtPage, string chartTitle, string xaxisTitle, string yaxisTitle, bool isMapPage)
        {
            string hovertemplate = "hovertemplate: '%{text}'";
            RB_ChartColor.SelectedIndex = 0; //default value is selected here (Contrast)
            if (QNum.ToUpper() == "Q712")//reset the charts for the March 2020 AYA
            {
                RB_ChartColor.SelectedIndex = 1;//colorarray = new string[] { "#949494", "#08a3b4", "#4169e1", "#00008b", "#ffb456", "#7f7f7f", "#e377c2", "#8c564b", "#444444", "#ff6456", "#e4e51b", "#aa51ff", "#98CA32", "#9D0E01", "#EA3E88" };
            }

            //*Get Page*
            ArborDataAccessV2 DAL = new ArborDataAccessV2();

            //*If this is a Map, it will have no records*
            if (dtPage.Rows.Count == 0) { return; }


            string quintileColorSetting = getQuintileColorSetting();


            //*Get ChartID*
            string yr = getYear();
            DataSet dsChart = DAL.getChart(Convert.ToInt32(chartID), yr, quintileColorSetting);

            DataTable dtChartHeader = dsChart.Tables[0];
            string chartFormatType = dtChartHeader.Rows[0]["DotNetChartStyleID"].ToString();
            if (chartFormatType == "3" || QNum.ToUpper() == "Q756") //if the chart has been setup to display as a line, then default to this value. This value comes from t_chart and t_chartStyle
            {
                RB_ChartType.SelectedValue = "'line'";
                hfChartType.Value = "'line'";
                hfChartMode.Value = "'group'";
            }
            else if (chartFormatType == "11")
            {
                RB_ChartType.SelectedValue = "'stacked'";
                hfChartType.Value = "'bar'";
                hfChartMode.Value = "'stack'";
            }
            double max_width = 0.4;

            //4/21/20 - the hidden field is filled with the initial radio button selections
            hfChartColor.Value = RB_ChartColor.SelectedValue;

            DataTable dtChart_preSort = dsChart.Tables[1];
            DataTable dtChart_maxHeight = dsChart.Tables[1];

            //BEGIN the finding the max value for a stacked bar chart
            dtChart_maxHeight = datableReSort(dtChart_maxHeight, "Tertiary, Secondary", "ASC");

            decimal max_stacked_yval = -1;
            decimal current_stacked_yval = -1;
            string current_stacked_secondary = "";
            for (int i = 0; i <= dtChart_maxHeight.Rows.Count - 1; i++)
            {
                string secondary = dtChart_maxHeight.Rows[i]["Secondary"].ToString();

                string datapoint = dtChart_maxHeight.Rows[i]["DataPoint"].ToString();
                if (current_stacked_secondary != secondary)
                {
                    current_stacked_secondary = secondary;//moving on to the next secondary grouping
                    if (current_stacked_yval > max_stacked_yval) //if the combined total of the values is larger than the current max, reset the current max with the current value
                    {
                        max_stacked_yval = current_stacked_yval;
                    }
                    decimal outdec;
                    if (decimal.TryParse(datapoint, out outdec))//reseting the current stacked value
                        current_stacked_yval = Decimal.Parse(datapoint);
                    else
                        current_stacked_yval = -1;
                }
                else
                {
                    decimal outdec;
                    if (decimal.TryParse(datapoint, out outdec))
                        current_stacked_yval = current_stacked_yval + Decimal.Parse(datapoint);

                }
            }
            hfMaxStackedYVal.Value = Math.Ceiling((max_stacked_yval * Decimal.Parse("1.1"))).ToString();
            //END the finding the max value for a stacked bar chart

            DataTable dtChart = new DataTable();
            if (QNum.ToUpper() == "Q226")
            {
                dtChart = datableReSort(dtChart_preSort, "SeriesLabel", "DESC"); //hardcoded as of 11/2, 2006 data is missing for some strats, changed the order because the 'Other' strat has 2006 data which will resolve the display issue
            }
            else
                dtChart = dtChart_preSort; // No longer sorting by SeriesLabel, let the proc handle the sorting. 

            int xaxis_cnt = 0;
            int max_xaxis_cnt = 0;
            string current_s_compare = "";
            for (int i = 0; i <= dtChart.Rows.Count - 1; i++)
            {
                string s_compare = dtChart.Rows[i]["SeriesLabel"].ToString();

                if (current_s_compare == "" || current_s_compare != s_compare)
                {
                    if (xaxis_cnt > max_xaxis_cnt)
                        max_xaxis_cnt = xaxis_cnt;

                    current_s_compare = s_compare;
                    xaxis_cnt = 1;//start the increment
                }
                else
                {
                    xaxis_cnt++;
                }
            }

            if (max_xaxis_cnt == 0) max_xaxis_cnt = xaxis_cnt; //if there is only one series, then set the max count to the xaxis count
            if (max_xaxis_cnt <= 7) max_width = (max_xaxis_cnt * 0.1) / 2;

            string hfval_x = "x:[ "; //starting the arrays and adding spaces to so that the last character parse below doesn't fail
            string hfval_y = "y:[ ";
            string hfval_w = "width:[ ";
            //string hfval_x_basedata = "x:[ "; //starting the basedata arrays and adding spaces to so that the last character parse below doesn't fail
            string hfval_y_basedata = "y:[ ";
            //string xaxisdatacount = "";
            string high_confidence = "";
            string low_confidence = "";
            string hovertext = "";

            string plotlyGroups = "var data = [";
            string plotlyBaseGroups = "var basedata = ["; //this will consist of all '0' values for the baseline aspect of the animated portion
            decimal max_yval = -1; //this will be used to determine the height of the plot for the animated portion
            decimal max_confidence = -1; //this will be used to determine the height of the plot for the animated portion with confidence intervals

            StringBuilder plotlyStr = new StringBuilder();

            /*create data array logic*/

            string current_serieslabel = "";
            string theData = "";

            //*************************************** Third Attempt

            theData = "[ ";

            Regex regex = new Regex(@"[\d]");
            if (max_xaxis_cnt > 7) max_xaxis_cnt = 7;
            int wrapsize = 100 / max_xaxis_cnt;//finding the number of data points and wrapping the x-axis labels accordingly

            int colorarray_inc = 0;
            var refXPos = "";

            for (int i = 0; i <= dtChart.Rows.Count - 1; i++)
            {
                string secondary = dtChart.Rows[i]["Secondary"].ToString();
                secondary = wrapText(secondary, wrapsize);
                string serieslabel = dtChart.Rows[i]["SeriesLabel"].ToString();
                string datapoint = dtChart.Rows[i]["DataPoint"].ToString();
                string ehigh = dtChart.Rows[i]["HighConfidenceInterval"].ToString();
                string elow = dtChart.Rows[i]["LowConfidenceInterval"].ToString();
                serieslabel = serieslabel.Replace("&", "and"); //overridding the & so that the chart doesn't fail
                var refXPosNum = 0.0;
                if (QNum.ToUpper() == "Q751" && Double.TryParse(secondary, out refXPosNum))
                    refXPos = (refXPosNum - 1).ToString();
                else
                    refXPos = secondary;

                decimal high_con_diff = -1; //initial setup
                decimal low_con_diff = -1;

                datapoint = datapoint.Replace("*", "null");

                Decimal outdec = 0;
                //finding the maxiumum value for the y-axis so the graph can be displayed properly
                if (Decimal.TryParse(datapoint, out outdec))
                {
                    Decimal minmaxchk_datapoint = Decimal.Parse(datapoint);

                    if (max_yval == -1) max_yval = minmaxchk_datapoint;
                    else if (minmaxchk_datapoint > max_yval) max_yval = minmaxchk_datapoint;
                }

                //finding the maxiumum value for the confidence intervals so the graph can be displayed properly
                if (Decimal.TryParse(ehigh, out outdec))
                {
                    Decimal minmaxchk_ehigh = Decimal.Parse(ehigh);

                    if (max_confidence == -1) max_confidence = minmaxchk_ehigh;
                    else if (minmaxchk_ehigh > max_confidence) max_confidence = minmaxchk_ehigh;
                }


                if (!String.IsNullOrEmpty(datapoint))
                {
                    if (!String.IsNullOrEmpty(ehigh))
                        high_con_diff = Convert.ToDecimal(ehigh) - Convert.ToDecimal(datapoint);

                    if (!String.IsNullOrEmpty(elow))
                        low_con_diff = Convert.ToDecimal(datapoint) - Convert.ToDecimal(elow);
                }

                if (QNum.ToUpper() == "Q372")
                {
                    if (ehigh != "")
                        ehigh = ehigh.Substring(0, ehigh.IndexOf(".") + 3);
                    if (elow != "")
                        elow = elow.Substring(0, elow.IndexOf(".") + 3);//showing only the two characters after the decimal
                }
                else
                {
                    if (ehigh != "")
                        ehigh = ehigh.Substring(0, ehigh.IndexOf(".") + 2);
                    if (elow != "")
                        elow = elow.Substring(0, elow.IndexOf(".") + 2);//showing only the two characters after the decimal
                }

                string str_high_con_diff = ""; //setup the string variable to be displayed
                string str_low_con_diff = "";

                if (high_con_diff != -1)//if the high difference isn't -1 then display the difference, otherwise display an empty string
                    str_high_con_diff = high_con_diff.ToString();
                else
                    str_high_con_diff = "";

                if (low_con_diff != -1)//if the low difference isn't -1 then display the difference, otherwise display an empty string
                    str_low_con_diff = low_con_diff.ToString();
                else
                    str_low_con_diff = "";

                if (current_serieslabel == "" || current_serieslabel == serieslabel)
                {
                    hfval_x = hfval_x + "'" + secondary + "',"; //finding the 'column' value
                    hfval_y = hfval_y + "'" + datapoint + "',"; //finding the actual data value                  
                    hfval_w = hfval_w + max_width + ",";
                    hfval_y_basedata = hfval_y_basedata + "'0',"; //adding the base data value        

                    high_confidence = high_confidence + "'" + str_high_con_diff + "',"; //high confidence intervals adding the string from above
                    low_confidence = low_confidence + "'" + str_low_con_diff + "',"; //low confidence intervals adding the string from above
                    hovertext = hovertext + "'" + datapoint + " (95% CI: " + elow + "-" + ehigh + ")" + "',";
                    //hovertext = hovertext + "'High:" + ehigh + " - Low:" + elow + "',";//hovertext , adding the text value, though this maybe emptied out during the numeric check below

                    current_serieslabel = serieslabel;
                }
                else if (current_serieslabel != serieslabel)
                {
                    string xData_col = hfval_x.Substring(0, hfval_x.Length - 1) + "]";//removing the last comma
                    string yData_col = hfval_y.Substring(0, hfval_y.Length - 1) + "]";//removing the last comma                    
                    string wData_col = hfval_w.Substring(0, hfval_w.Length - 1) + "]";//removing the last comma
                    string yData_col_basedata = hfval_y_basedata.Substring(0, hfval_y_basedata.Length - 1) + "]";//removing the last comma                    

                    string hiConData_col = "";
                    string loConData_col = "";
                    string hovertextData = "";

                    if (regex.IsMatch(high_confidence) && regex.IsMatch(low_confidence)) //both have numeric values
                    {
                        hiConData_col = "array:[ " + high_confidence.Substring(0, high_confidence.Length - 1) + "]";
                        loConData_col = "arrayminus:[ " + low_confidence.Substring(0, low_confidence.Length - 1) + "]";
                        hovertextData = "text:[ " + hovertext.Substring(0, hovertext.Length - 1) + "]";
                    }
                    else
                    {
                        hiConData_col = "array:[ ]";
                        loConData_col = "arrayminus:[ ]";
                        hovertextData = "text:[ ]";
                    }


                    //9/28/2020 - BS - added the increment value of 'i' to the data variable string so that it is unique
                    plotlyStr.Append(" var data" + cleanString(current_serieslabel) + i.ToString() + " = {" + xData_col + " , " + yData_col);

                    if (!(hiConData_col == "array:[ ]" && loConData_col == "arrayminus:[ ]"))
                        plotlyStr.Append(", error_y: { visible: eval($('#hfShowCI').val()), type: 'data', color: '#222', thickness:1, symmetric: false, " + hiConData_col + " ," + loConData_col + "}," + hovertextData + "," + hovertemplate);

                    //2/8/2021 - BS - adding the 'line: { simplify: false }' parameter to help smooth the line animation, without it only the first three data points animate
                    if (current_serieslabel == "Total")
                        plotlyStr.Append(",  name: '" + current_serieslabel + "', type: " + hfChartType.Value + ", connectgaps: true, line: { simplify: false, width:3, dash:'dot'}, marker: {color: '#000000'}};"); //appending the 'row' to the data name and adding the array data
                    else if (current_serieslabel == "Overall")
                        plotlyStr.Append(",  name: '" + current_serieslabel + "', type: " + hfChartType.Value + ", connectgaps: true, line: { simplify: false, width:3, dash:'dot'}, marker: {color: '#000000'}};"); //appending the 'row' to the data name and adding the array data
                    else
                        plotlyStr.Append(",  name: '" + current_serieslabel + "', type: " + hfChartType.Value + ", connectgaps: true, line: { simplify: false, width:3}, marker: {color: eval(colors_split[" + colorarray_inc + "]) }};"); //appending the 'row' to the data name and adding the array data

                    //1/12/2021 - BS - added the basedata necessary for animation
                    plotlyStr.Append(" var basedata" + cleanString(current_serieslabel) + i.ToString() + " = {" + xData_col + " , " + yData_col_basedata);
                    //2/8/2021 - BS - adding the 'line: { simplify: false }' parameter to help smooth the line animation, without it only the first three data points animate
                    if (current_serieslabel == "Total")
                        plotlyStr.Append(",  name: '" + current_serieslabel + "', type: " + hfChartType.Value + ",connectgaps: true, line: { simplify: false, width:3, dash:'dot'}, marker: {color: '#000000' }};"); //appending the 'row' to the data name and adding the array data
                    else if (current_serieslabel == "Overall")
                        plotlyStr.Append(",  name: '" + current_serieslabel + "', type: " + hfChartType.Value + ",connectgaps: true, line: { simplify: false, width:3, dash:'dot'}, marker: {color: '#000000' }};"); //appending the 'row' to the data name and adding the array data
                    else
                        plotlyStr.Append(",  name: '" + current_serieslabel + "', type: " + hfChartType.Value + ",connectgaps: true, line: { simplify: false, width:3}, marker: {color: eval(colors_split[" + colorarray_inc + "]) }};"); //appending the 'row' to the data name and adding the array data

                    //9/28/2020 - BS - added the increment value of 'i' to the data variable string so that it is unique
                    plotlyGroups = plotlyGroups + "data" + cleanString(current_serieslabel) + i.ToString() + ","; //adding the above data variable to the group variable
                    //1/12/2021 - BS - added the basedata necessary for animation
                    plotlyBaseGroups = plotlyBaseGroups + "basedata" + cleanString(current_serieslabel) + i.ToString() + ","; //adding the above basedata variable to the group variable

                    hfval_x = "x:[ ";//resetting the arrays and adding spaces to so that the last character parse below doesn't fail
                    hfval_y = "y:[ ";
                    hfval_w = "width:[ ";
                    hfval_y_basedata = "y:[ ";
                    high_confidence = "";
                    low_confidence = "";
                    hovertext = "";
                    colorarray_inc++;

                    hfval_x = hfval_x + "'" + secondary + "',"; //finding the 'column' value
                    hfval_y = hfval_y + "'" + datapoint + "',"; //finding the actual data value
                    hfval_w = hfval_w + max_width + ",";
                    hfval_y_basedata = hfval_y_basedata + "'0',"; //adding the base data value        

                    high_confidence = high_confidence + "'" + str_high_con_diff + "',"; //high confidence intervals adding the string from above
                    low_confidence = low_confidence + "'" + str_low_con_diff + "',"; //low confidence intervals adding the string from above
                    hovertext = hovertext + "'" + datapoint + " (95% CI: " + elow + "-" + ehigh + ")" + "',";
                    //hovertext = hovertext + "'High:" + ehigh + " - Low:" + elow + "',";//hovertext , adding the text value, though this maybe emptied out during the numeric check below

                    current_serieslabel = serieslabel;
                }
            }

            string hiConData_col_final = "";//high_confidence.Substring(0, high_confidence.Length - 1) + "]";//removing the last comma
            string loConData_col_final = "";//low_confidence.Substring(0, low_confidence.Length - 1) + "]";//removing the last comma
            string hovertextData_final = "";//hovertext.Substring(0, hovertext.Length - 1) + "]";//removing the last comma

            if (regex.IsMatch(high_confidence) && regex.IsMatch(low_confidence)) //if both are numeric, then add all of the values to the array. This accounts for missing CIs
            {
                hiConData_col_final = "array:[ " + high_confidence.Substring(0, high_confidence.Length - 1) + "]";
                loConData_col_final = "arrayminus:[ " + low_confidence.Substring(0, low_confidence.Length - 1) + "]";
                hovertextData_final = "text:[ " + hovertext.Substring(0, hovertext.Length - 1) + "]";
            }
            else //otherwise don't display any values, this accounts for scenarios where there aren't CIs
            {
                hiConData_col_final = "array:[ ]";
                loConData_col_final = "arrayminus:[ ]";
                hovertextData_final = "text:[ ]";
            }

            string xData_col_final = hfval_x.Substring(0, hfval_x.Length - 1) + "]";//removing the last comma
            string yData_col_final = hfval_y.Substring(0, hfval_y.Length - 1) + "]";//removing the last comma
            string wData_col_final = hfval_w.Substring(0, hfval_w.Length - 1) + "]";//removing the last comma
            string yData_col_final_basedata = hfval_y_basedata.Substring(0, hfval_y_basedata.Length - 1) + "]";//removing the last comma

            //9/28/2020 - BS - added the increment value of 'i' to the data variable string so that it is unique
            if (QNum.ToUpper() == "Q372")
                plotlyStr.Append(" var data" + cleanString(current_serieslabel) + "final = {" + xData_col_final + " , " + yData_col_final);
            else
                plotlyStr.Append(" var data" + cleanString(current_serieslabel) + "final = {" + xData_col_final + " , " + yData_col_final + ", " + wData_col_final);

            if (hiConData_col_final != "array:[ ]" && loConData_col_final != "arrayminus:[ ]" && hovertextData_final != "text:[ ]") //if there are empty values, then don't display the hover text for the errors
                plotlyStr.Append(", error_y: {visible: eval($('#hfShowCI').val()), type: 'data', color: '#222', thickness:1, symmetric: false, " + hiConData_col_final + " ," + loConData_col_final + "}, " + hovertextData_final + "," + hovertemplate);

            //2/8/2021 - BS - adding the 'line: { simplify: false }' parameter to help smooth the line animation, without it only the first three data points animate
            if (current_serieslabel == "Total")
                plotlyStr.Append(", connectgaps: true, name: '" + current_serieslabel + "', type: " + hfChartType.Value + ", line: { simplify: false, width:3, dash:'dot'}, marker: {color: '#000000' }};"); //appending the 'row' to the data name and adding the array data
            else if (current_serieslabel == "Overall")
                plotlyStr.Append(", connectgaps: true, name: '" + current_serieslabel + "', type: " + hfChartType.Value + ", line: { simplify: false, width:3, dash:'dot'}, marker: {color: '#000000' }};"); //appending the 'row' to the data name and adding the array data
            else
                plotlyStr.Append(", connectgaps: true, name: '" + current_serieslabel + "', type: " + hfChartType.Value + ", line: { simplify: false, width:3}, marker: {color: eval(colors_split[" + colorarray_inc + "]) }};"); //appending the 'row' to the data name and adding the array data

            //1/12/2021 - BS - added the basedata necessary for animation
            if (QNum.ToUpper() == "Q372")
                plotlyStr.Append(" var basedata" + cleanString(current_serieslabel) + "final = {" + xData_col_final + " , " + yData_col_final_basedata);
            else
                plotlyStr.Append(" var basedata" + cleanString(current_serieslabel) + "final = {" + xData_col_final + " , " + yData_col_final_basedata + ", " + wData_col_final);

            if (current_serieslabel == "Total")
                //2/8/2021 - BS - adding the 'line: { simplify: false }' parameter to help smooth the line animation, without it only the first three data points animate
                plotlyStr.Append(", connectgaps: true, name: '" + current_serieslabel + "', type: " + hfChartType.Value + ", line: { simplify: false, width:3, dash:'dot'}, marker: {color: '#000000' }};"); //appending the 'row' to the data name and adding the array data
            else if (current_serieslabel == "Overall")
                plotlyStr.Append(", connectgaps: true, name: '" + current_serieslabel + "', type: " + hfChartType.Value + ", line: { simplify: false, width:3, dash:'dot'}, marker: {color: '#000000' }};"); //appending the 'row' to the data name and adding the array data
            else
                plotlyStr.Append(", connectgaps: true, name: '" + current_serieslabel + "', type: " + hfChartType.Value + ", line: { simplify: false, width:3}, marker: {color: eval(colors_split[" + colorarray_inc + "]) }};"); //appending the 'row' to the data name and adding the array data

            /*** 10/7/2022 Add reference line ***/
            var refVal = RefValue(QNum);
            if (refVal > 0)
            {
                if (QNum.ToUpper() != "Q754")
                    plotlyStr.Append(" var refLine = {x: ['" + refXPos + "'],  y:[" + (refVal * 1.04) + "], textfont:{color: '#000000', size:'12px'}, mode: 'text', text:['<b>HP 2030 Target=" + refVal + "%</b>'],showlegend: false};");
                else
                    plotlyStr.Append(" var refLine = {x: ['" + refXPos + "'],  y:[" + (refVal * 1.04) + "], textfont:{color: '#000000', size:'12px'}, mode: 'text', text:['<b>HP 2030 Target=" + refVal + "</b>'],showlegend: false};");
            }
            //9/28/2020 - BS - added the increment value of 'i' to the data variable string so that it is unique                                                                                                                                                                                 
            plotlyGroups = plotlyGroups + "data" + cleanString(current_serieslabel) + "final ,"; //adding the above data variable to the group variable
            plotlyBaseGroups = plotlyBaseGroups + "basedata" + cleanString(current_serieslabel) + "final ,"; //adding the above data variable to the group variable

            //HF_D3Data.Value = theData;
            if (plotlyGroups == "var data = [")// if this variable hasn't been added to, then add the above chartdata
                plotlyGroups = plotlyGroups + "chartdata ";
            if (plotlyBaseGroups == "var basedata = [")// if this variable hasn't been added to, then add the above chartdata
                plotlyBaseGroups = plotlyBaseGroups + "basechartdata ";

            string dataGroups = plotlyGroups.Substring(0, plotlyGroups.Length - 1) + "];";//otherwise, close the array and add it to the plotly string

            /*** 10/7/2022 Add reference line ***/
            //adding the base group data
            //dataGroups = dataGroups + plotlyBaseGroups.Substring(0, plotlyBaseGroups.Length - 1) + "];";//otherwise, close the array and add it to the plotly string
            dataGroups = dataGroups + plotlyBaseGroups.Substring(0, plotlyBaseGroups.Length - 1);//otherwise, close the array and add it to the plotly string
            if (refVal > 0)
            {
                dataGroups = dataGroups + ",refLine ];";
            }
            else
            {
                dataGroups = dataGroups + "];";
            }

            plotlyStr.Append(dataGroups);
            /*end Create data array logic*/

            if (!plotlyStr.ToString().Contains("error_y")) //if confidence intervals aren't in the plotly string, then hide the checkbox
                CB_ChartCI.Visible = false;

            //adding the max values to the hiddenfields to be referenced in the markup, commented out 4/9/2021
            //hfMaxYVal.Value = Math.Ceiling(max_yval).ToString();
            //hfMaxConfidence.Value = Math.Ceiling(max_confidence).ToString();
            //adding the max values to the hiddenfields to be referenced in the markup, adding a cushion to the top of the chart to account for the title that has been added for the triple strat
            if (QNum.ToUpper() == "Q751") /*** 10/7/2022 Display y axis up to 71 to display target ***/
                hfMaxYVal.Value = (Math.Ceiling((max_yval * Decimal.Parse("1.1"))) + 7).ToString();
            else
                hfMaxYVal.Value = Math.Ceiling((max_yval * Decimal.Parse("1.1"))).ToString();
            hfMaxConfidence.Value = Math.Ceiling((max_confidence * Decimal.Parse("1.1"))).ToString();

            if (chartFormatType == "11")
            { //if the default chart type is stacked, then use the maxstacked y value
                if (string.IsNullOrEmpty(hfChartYValToUse.Value))
                    hfChartYValToUse.Value = hfMaxStackedYVal.Value;
                else
                {
                    double y1;
                    double y2;

                    double.TryParse(hfChartYValToUse.Value, out y1);
                    double.TryParse(hfMaxStackedYVal.Value, out y2);
                    hfChartYValToUse.Value = Math.Max(y1, y2).ToString();
                }
            }
            else if (CB_ChartCI.Checked)
            { //if the confidence intervals checkbox is checked, then use the max confidence value
                if (string.IsNullOrEmpty(hfChartYValToUse.Value))
                    hfChartYValToUse.Value = hfMaxConfidence.Value;
                else
                {
                    double y1;
                    double y2;

                    double.TryParse(hfChartYValToUse.Value, out y1);
                    double.TryParse(hfMaxConfidence.Value, out y2);
                    hfChartYValToUse.Value = Math.Max(y1, y2).ToString();
                }
            }
            else
            { //otherwise use the max Y value
                if (string.IsNullOrEmpty(hfChartYValToUse.Value))
                    hfChartYValToUse.Value = hfMaxYVal.Value;
                else
                {
                    double y1;
                    double y2;

                    double.TryParse(hfChartYValToUse.Value, out y1);
                    double.TryParse(hfMaxYVal.Value, out y2);
                    hfChartYValToUse.Value = Math.Max(y1, y2).ToString();
                }
            }

            createPlotlyScript(plotlyStr, chartTitle, xaxisTitle, yaxisTitle, max_xaxis_cnt, isMapPage);
        }

        private void buildPlotlyTripleStratChart(string chartID, DataTable dtPage, string chartTitle, string xaxisTitle, string yaxisTitle, DataView vData)
        {
            string hovertemplate = "hovertemplate: '%{text}'";
            RB_ChartColor.SelectedIndex = 0; //default value is selected here (Contrast)
            if (QNum.ToUpper() == "Q712")//reset the charts for the March 2020 AYA
                RB_ChartColor.SelectedIndex = 1;//colorarray = new string[] { "#949494", "#08a3b4", "#4169e1", "#00008b", "#ffb456", "#7f7f7f", "#e377c2", "#8c564b", "#444444", "#ff6456", "#e4e51b", "#aa51ff", "#98CA32", "#9D0E01", "#EA3E88" };

            //*Get Page*
            ArborDataAccessV2 DAL = new ArborDataAccessV2();

            //*If this is a Map, it will have no records*
            if (dtPage.Rows.Count == 0) { return; }


            string quintileColorSetting = getQuintileColorSetting();


            //*Get ChartID*
            string yr = getYear();
            DataSet dsChart = DAL.getChart(Convert.ToInt32(chartID), yr, quintileColorSetting);

            DataTable dtChartHeader = dsChart.Tables[0];
            string chartFormatType = dtChartHeader.Rows[0]["DotNetChartStyleID"].ToString();
            if (chartFormatType == "3") //if the chart has been setup to display as a line, then default to this value. This value comes from t_chart and t_chartStyle
            {
                RB_ChartType.SelectedValue = "'line'";
                hfChartType.Value = "'line'";
                hfChartMode.Value = "'group'";
            }
            else if (chartFormatType == "11")
            {
                RB_ChartType.SelectedValue = "'stacked'";
                hfChartType.Value = "'bar'";
                hfChartMode.Value = "'stack'";
            }

            //4/21/20 - the hidden field is filled with the initial radio button selections
            hfChartColor.Value = RB_ChartColor.SelectedValue;

            DataTable dtChart_preSort = dsChart.Tables[1];

            DataTable dtChart_maxHeight = dsChart.Tables[1];

            //BEGIN the finding the max value for a stacked bar chart
            dtChart_maxHeight = datableReSort(dtChart_maxHeight, "Tertiary, Secondary", "ASC");

            decimal max_stacked_yval = -1;
            decimal current_stacked_yval = -1;
            string current_stacked_secondary = "";
            for (int i = 0; i <= dtChart_maxHeight.Rows.Count - 1; i++)
            {
                string secondary = dtChart_maxHeight.Rows[i]["Secondary"].ToString();

                string datapoint = dtChart_maxHeight.Rows[i]["DataPoint"].ToString();
                if (current_stacked_secondary != secondary)
                {
                    current_stacked_secondary = secondary;//moving on to the next secondary grouping
                    if (current_stacked_yval > max_stacked_yval) //if the combined total of the values is larger than the current max, reset the current max with the current value
                    {
                        max_stacked_yval = current_stacked_yval;
                    }
                    decimal outdec;
                    if (decimal.TryParse(datapoint, out outdec))//reseting the current stacked value
                        current_stacked_yval = Decimal.Parse(datapoint);
                    else
                        current_stacked_yval = -1;
                }
                else
                {
                    decimal outdec;
                    if (decimal.TryParse(datapoint, out outdec))
                        current_stacked_yval = current_stacked_yval + Decimal.Parse(datapoint);

                }
            }
            hfMaxStackedYVal.Value = Math.Ceiling((max_stacked_yval * Decimal.Parse("1.1"))).ToString();
            //END the finding the max value for a stacked bar chart

            //finding the distinct years
            DataView tertiaryView = new DataView(dtChart_preSort);
            DataTable distinctTertiary = tertiaryView.ToTable(true, "Tertiary");
            DataTable distinctSecondary = tertiaryView.ToTable(true, "Secondary");

            int totalxaxiscnt = distinctTertiary.Rows.Count * distinctSecondary.Rows.Count;
            string tickangle = "0";

            if (QNum.ToUpper() == "Q700")
            {
                tickangle = "10";
            }

            // if (totalxaxiscnt > 12) tickangle = "20";
            //tickangle = "25";



            string plotlyGroups = "";
            string plotlyBaseGroups = ""; //this will consist of all '0' values for the baseline aspect of the animated portion

            StringBuilder plotlyStr = new StringBuilder();
            int max_xaxis_cnt = 0;
            int tert_cnt = 0;
            double max_width = 0.4;
            string subplots = "";
            string subplots_xaxis = "";
            string legendbool = "true";
            string titleannontations = "";
            List<string> xaxisArray = new List<string>();
            decimal max_yval = -1; //this will be used to determine the height of the plot for the animated portion
            decimal max_confidence = -1; //this will be used to determine the height of the plot for the animated portion with confidence intervals


            for (int t = 0; t <= distinctTertiary.Rows.Count - 1; t++)
            {
                tert_cnt = t + 1;

                string tertiary_var = distinctTertiary.Rows[t]["Tertiary"].ToString();
                DataTable dtChart2 = dtChart_preSort.Select("Tertiary = '" + tertiary_var + "'").CopyToDataTable();
                //DataTable dtChart = datableReSort(dtChart2, "SeriesLabel", "ASC");   //commented out 4/21/21              
                DataTable dtChart = dtChart2;

                int xaxis_cnt = 0;

                string current_s_compare = "";
                for (int i = 0; i <= dtChart.Rows.Count - 1; i++)
                {
                    string s_compare = dtChart.Rows[i]["SeriesLabel"].ToString();

                    if (current_s_compare == "" || current_s_compare != s_compare)
                    {
                        if (xaxis_cnt > max_xaxis_cnt)
                            max_xaxis_cnt = xaxis_cnt;

                        current_s_compare = s_compare;
                        xaxis_cnt = 1;//start the increment
                    }
                    else
                    {
                        xaxis_cnt++;
                    }
                }

                if (max_xaxis_cnt == 0) max_xaxis_cnt = xaxis_cnt; //if there is only one series, then set the max count to the xaxis count

                string hfval_x = "x:[ "; //starting the arrays and adding spaces to so that the last character parse below doesn't fail
                string hfval_y = "y:[ ";
                string hfval_w = "width:[ ";
                string hfval_y_basedata = "y:[ ";
                string high_confidence = "";
                string low_confidence = "";
                string hovertext = "";



                /*create data array logic*/

                string current_serieslabel = "";
                string theData = "";

                //*************************************** Third Attempt

                theData = "[ ";

                //Regex regex = new Regex(@"^\d+");//if there are digits anywhere in the data, then display the CI
                Regex regex = new Regex(@"[\d]");
                if (max_xaxis_cnt > 7) max_xaxis_cnt = 7;
                else max_width = (max_xaxis_cnt * 0.1) / 2;

                int wrapsize = 100 / max_xaxis_cnt;//finding the number of data points and wrapping the x-axis labels accordingly

                int colorarray_inc = 0;
                for (int i = 0; i <= dtChart.Rows.Count - 1; i++)
                {
                    string secondary = dtChart.Rows[i]["Secondary"].ToString();
                    secondary = wrapText(secondary, wrapsize);
                    string serieslabel = dtChart.Rows[i]["SeriesLabel"].ToString();
                    string datapoint = dtChart.Rows[i]["DataPoint"].ToString();
                    string ehigh = dtChart.Rows[i]["HighConfidenceInterval"].ToString();
                    string elow = dtChart.Rows[i]["LowConfidenceInterval"].ToString();
                    serieslabel = serieslabel.Replace("&", "and"); //overridding the & so that the chart doesn't fail

                    decimal high_con_diff = -1; //initial setup
                    decimal low_con_diff = -1;

                    datapoint = datapoint.Replace("*", "null");

                    Decimal outdec = 0;
                    //finding the maxiumum value for the y-axis so the graph can be displayed properly
                    if (Decimal.TryParse(datapoint, out outdec))
                    {
                        Decimal minmaxchk_datapoint = Decimal.Parse(datapoint);

                        if (max_yval == -1) max_yval = minmaxchk_datapoint;
                        else if (minmaxchk_datapoint > max_yval) max_yval = minmaxchk_datapoint;
                    }

                    //finding the maxiumum value for the confidence intervals so the graph can be displayed properly
                    if (Decimal.TryParse(ehigh, out outdec))
                    {
                        Decimal minmaxchk_ehigh = Decimal.Parse(ehigh);

                        if (max_confidence == -1) max_confidence = minmaxchk_ehigh;
                        else if (minmaxchk_ehigh > max_confidence) max_confidence = minmaxchk_ehigh;
                    }

                    if (!String.IsNullOrEmpty(datapoint))
                    {
                        if (!String.IsNullOrEmpty(ehigh))
                            high_con_diff = Convert.ToDecimal(ehigh) - Convert.ToDecimal(datapoint);

                        if (!String.IsNullOrEmpty(elow))
                            low_con_diff = Convert.ToDecimal(datapoint) - Convert.ToDecimal(elow);
                    }

                    if (ehigh != "")
                        ehigh = ehigh.Substring(0, ehigh.IndexOf(".") + 2);
                    if (elow != "")
                        elow = elow.Substring(0, elow.IndexOf(".") + 2);//showing only the two characters after the decimal

                    string str_high_con_diff = ""; //setup the string variable to be displayed
                    string str_low_con_diff = "";

                    if (high_con_diff != -1)//if the high difference isn't -1 then display the difference, otherwise display an empty string
                        str_high_con_diff = high_con_diff.ToString();
                    else
                        str_high_con_diff = "";

                    if (low_con_diff != -1)//if the low difference isn't -1 then display the difference, otherwise display an empty string
                        str_low_con_diff = low_con_diff.ToString();
                    else
                        str_low_con_diff = "";

                    if (current_serieslabel == "" || current_serieslabel == serieslabel)
                    {
                        hfval_x = hfval_x + "'" + secondary + "',"; //finding the 'column' value
                        hfval_y = hfval_y + "'" + datapoint + "',"; //finding the actual data value                  
                        hfval_w = hfval_w + max_width + ",";
                        hfval_y_basedata = hfval_y_basedata + "'0',"; //adding the base data value  

                        high_confidence = high_confidence + "'" + str_high_con_diff + "',"; //high confidence intervals adding the string from above
                        low_confidence = low_confidence + "'" + str_low_con_diff + "',"; //low confidence intervals adding the string from above
                        hovertext = hovertext + "'" + secondary + ": " + datapoint + " (95% CI: " + elow + "-" + ehigh + ")" + "',";
                        //hovertext = hovertext + "'High:" + ehigh + " - Low:" + elow + "',";//hovertext , adding the text value, though this maybe emptied out during the numeric check below

                        current_serieslabel = serieslabel;
                    }
                    else if (current_serieslabel != serieslabel)
                    {
                        string xData_col = hfval_x.Substring(0, hfval_x.Length - 1) + "]";//removing the last comma
                        string yData_col = hfval_y.Substring(0, hfval_y.Length - 1) + "]";//removing the last comma
                        string wData_col = hfval_w.Substring(0, hfval_w.Length - 1) + "]";//removing the last comma
                        string yData_col_basedata = hfval_y_basedata.Substring(0, hfval_y_basedata.Length - 1) + "]";//removing the last comma                    

                        string hiConData_col = "";
                        string loConData_col = "";
                        string hovertextData = "";

                        if (regex.IsMatch(high_confidence) && regex.IsMatch(low_confidence)) //both have numeric values
                        {
                            hiConData_col = "array:[ " + high_confidence.Substring(0, high_confidence.Length - 1) + "]";
                            loConData_col = "arrayminus:[ " + low_confidence.Substring(0, low_confidence.Length - 1) + "]";
                            hovertextData = "text:[ " + hovertext.Substring(0, hovertext.Length - 1) + "]";
                        }
                        else
                        {
                            hiConData_col = "array:[ ]";
                            loConData_col = "arrayminus:[ ]";
                            hovertextData = "text:[ ]";
                        }

                        //9/28/2020 - BS - added the increment value of 'i' to the data variable string so that it is unique
                        plotlyStr.Append(" var data" + cleanString(tertiary_var) + cleanString(current_serieslabel) + i.ToString() + " = {" + xData_col + " , " + yData_col + "," + wData_col);
                        if (!(hiConData_col == "array:[ ]" && loConData_col == "arrayminus:[ ]"))
                            plotlyStr.Append(", error_y: { visible: eval($('#hfShowCI').val()), type: 'data', color: '#222', thickness:1, symmetric: false, " + hiConData_col + " ," + loConData_col + "}," + hovertextData + "," + hovertemplate);

                        //9/28/2020 - BS - added the increment value of 'i' to the data variable string so that it is unique
                        plotlyStr.Append(",  name: '" + current_serieslabel + "', legendgroup: '" + cleanString(current_serieslabel) + i.ToString() + "', showlegend: " + legendbool + ", type: " + hfChartType.Value + ", connectgaps: true,line: { simplify: false}, marker: {color: eval(colors_split[" + colorarray_inc + "]) }, xaxis:'x" + tert_cnt + "'};"); //appending the 'row' to the data name and adding the array data

                        //1/12/2021 - BS - added the basedata necessary for animation
                        plotlyStr.Append(" var basedata" + cleanString(tertiary_var) + cleanString(current_serieslabel) + i.ToString() + " = {" + xData_col + " , " + yData_col_basedata + ", " + wData_col);
                        //2/8/2021 - BS - adding the 'line: { simplify: false }' parameter to help smooth the line animation, without it only the first three data points animate
                        plotlyStr.Append(",  name: '" + current_serieslabel + "', legendgroup: '" + cleanString(current_serieslabel) + i.ToString() + "', showlegend: " + legendbool + ", type: " + hfChartType.Value + ",connectgaps: true, line: { simplify: false}, marker: {color: eval(colors_split[" + colorarray_inc + "]) }, xaxis:'x" + tert_cnt + "'};"); //appending the 'row' to the data name and adding the array data

                        //9/28/2020 - BS - added the increment value of 'i' to the data variable string so that it is unique
                        plotlyGroups = plotlyGroups + "data" + cleanString(tertiary_var) + cleanString(current_serieslabel) + i.ToString() + ","; //adding the above data variable to the group variable

                        //1/12/2021 - BS - added the basedata necessary for animation
                        plotlyBaseGroups = plotlyBaseGroups + "basedata" + cleanString(tertiary_var) + cleanString(current_serieslabel) + i.ToString() + ","; //adding the above basedata variable to the group variable

                        xaxisArray.Add(hfval_x);
                        hfval_x = "x:[ ";//resetting the arrays and adding spaces to so that the last character parse below doesn't fail
                        hfval_y = "y:[ ";
                        hfval_w = "width:[ ";
                        hfval_y_basedata = "y:[ ";
                        high_confidence = "";
                        low_confidence = "";
                        hovertext = "";
                        colorarray_inc++;

                        hfval_x = hfval_x + "'" + secondary + "',"; //finding the 'column' value
                        hfval_y = hfval_y + "'" + datapoint + "',"; //finding the actual data value
                        hfval_w = hfval_w + max_width + ",";

                        hfval_y_basedata = hfval_y_basedata + "'0',"; //adding the base data value   

                        high_confidence = high_confidence + "'" + str_high_con_diff + "',"; //high confidence intervals adding the string from above
                        low_confidence = low_confidence + "'" + str_low_con_diff + "',"; //low confidence intervals adding the string from above
                        hovertext = hovertext + "'" + secondary + ": " + datapoint + " (95% CI: " + elow + "-" + ehigh + ")" + "',";
                        //hovertext = hovertext + "'High:" + ehigh + " - Low:" + elow + "',";//hovertext , adding the text value, though this maybe emptied out during the numeric check below

                        current_serieslabel = serieslabel;
                    }

                }

                float xtextloc_float = tert_cnt / (float)distinctTertiary.Rows.Count;


                int tripChartCnt = distinctTertiary.Rows.Count;

                switch (tripChartCnt)
                {
                    //setting the position of the text on the triple strat backgrounds based on the number of strats and the length of each strat name  
                    case 1:

                        if (tert_cnt == 1) xtextloc_float = .5F;
                        else xtextloc_float = .5F;
                        break;
                    case 2:
                        string tertStr_c2 = distinctTertiary.Rows[tert_cnt - 1][0].ToString();
                        int tertCharLen_c2 = tertStr_c2.Length;
                        if (tert_cnt == 1) if (tertCharLen_c2 > 12) xtextloc_float = .18F; else xtextloc_float = .21F;
                        else if (tert_cnt == 2) if (tertCharLen_c2 > 12) xtextloc_float = .82F; else xtextloc_float = .79F;
                        break;
                    case 3:
                        string tertStr_c3 = distinctTertiary.Rows[tert_cnt - 1][0].ToString();
                        int tertCharLen_c3 = tertStr_c3.Length;
                        if (tert_cnt == 1) { if (tertCharLen_c3 > 12) xtextloc_float = .05F; else if (tertCharLen_c3 > 6) xtextloc_float = .1F; else xtextloc_float = .13F; }
                        else if (tert_cnt == 2) xtextloc_float = .5F;
                        else if (tert_cnt == 3) { if (tertCharLen_c3 > 12) xtextloc_float = .92F; else if (tertCharLen_c3 > 6) xtextloc_float = .9F; else xtextloc_float = .87F; }
                        else xtextloc_float = .87F;
                        break;
                    case 4:
                        string tertStr_c4 = distinctTertiary.Rows[tert_cnt - 1][0].ToString();
                        int tertCharLen_c4 = tertStr_c4.Length;
                        if (tert_cnt == 1) { if (tertCharLen_c4 > 12) xtextloc_float = .05F; else if (tertCharLen_c4 > 6) xtextloc_float = .07F; else xtextloc_float = .1F; }
                        else if (tert_cnt == 2) { if (tertCharLen_c4 > 12) xtextloc_float = .3F; else if (tertCharLen_c4 > 6) xtextloc_float = .38F; else xtextloc_float = .37F; }
                        else if (tert_cnt == 3) { if (tertCharLen_c4 > 12) xtextloc_float = .65F; else if (tertCharLen_c4 > 6) xtextloc_float = .63F; else xtextloc_float = .63F; }
                        else if (tert_cnt == 4) { if (tertCharLen_c4 > 12) xtextloc_float = .92F; else if (tertCharLen_c4 > 6) xtextloc_float = .93F; else xtextloc_float = .9F; }
                        else xtextloc_float = .95F;
                        break;
                    case 5: //Q156 - race, Q664
                        string tertStr_c5 = distinctTertiary.Rows[tert_cnt - 1][0].ToString();
                        int tertCharLen_c5 = tertStr_c5.Length;
                        if (tert_cnt == 1) { if (tertCharLen_c5 > 12) xtextloc_float = .01F; else if (tertCharLen_c5 > 6) xtextloc_float = .05F; else xtextloc_float = .13F; }
                        else if (tert_cnt == 2) { if (tertCharLen_c5 > 12) xtextloc_float = .22F; else if (tertCharLen_c5 > 6) xtextloc_float = .25F; else xtextloc_float = .35F; }
                        else if (tert_cnt == 3) xtextloc_float = .5F;
                        else if (tert_cnt == 4) { if (tertCharLen_c5 > 12) xtextloc_float = .8F; else if (tertCharLen_c5 > 6) xtextloc_float = .75F; else xtextloc_float = .73F; }
                        else if (tert_cnt == 5) { if (tertCharLen_c5 > 12) xtextloc_float = .98F; else if (tertCharLen_c5 > 6) xtextloc_float = .9F; else xtextloc_float = .93F; }
                        else xtextloc_float = .92F;
                        break;
                    case 6: //Q711 - year (no longer for Q711), now Q272 stage, gender, year, Q706 year-hypertension
                        string tertStr_c6 = distinctTertiary.Rows[tert_cnt - 1][0].ToString();
                        int tertCharLen_c6 = tertStr_c6.Length;
                        if (tert_cnt == 1) { if (tertCharLen_c6 > 12) xtextloc_float = .01F; else if (tertCharLen_c6 > 6) xtextloc_float = .04F; else if (tertCharLen_c6 > 3) xtextloc_float = .06F; else xtextloc_float = .03F; }
                        else if (tert_cnt == 2) { if (tertCharLen_c6 > 12) xtextloc_float = .20F; else if (tertCharLen_c6 > 6) xtextloc_float = .21F; else if (tertCharLen_c6 > 3) xtextloc_float = .22F; else xtextloc_float = .23F; }
                        else if (tert_cnt == 3) { if (tertCharLen_c6 > 12) xtextloc_float = .35F; else if (tertCharLen_c6 > 6) xtextloc_float = .42F; else if (tertCharLen_c6 > 3) xtextloc_float = .41F; else xtextloc_float = .45F; }
                        else if (tert_cnt == 4) { if (tertCharLen_c6 > 12) xtextloc_float = .55F; else if (tertCharLen_c6 > 6) xtextloc_float = .59F; else if (tertCharLen_c6 > 3) xtextloc_float = .57F; else xtextloc_float = .65F; }
                        else if (tert_cnt == 5) { if (tertCharLen_c6 > 12) xtextloc_float = .75F; else if (tertCharLen_c6 > 6) xtextloc_float = .8F; else if (tertCharLen_c6 > 3) xtextloc_float = .77F; else xtextloc_float = .82F; }
                        else if (tert_cnt == 6) { if (tertCharLen_c6 > 12) xtextloc_float = .87F; else if (tertCharLen_c6 > 6) xtextloc_float = .96F; else if (tertCharLen_c6 > 3) xtextloc_float = .94F; else xtextloc_float = .98F; }
                        else xtextloc_float = .92F;
                        break;
                    case 7: //Q272 - hypertension, year, ckd stage
                        string tertStr_c7 = distinctTertiary.Rows[tert_cnt - 1][0].ToString();
                        int tertCharLen_c7 = tertStr_c7.Length;
                        if (tert_cnt == 1) { if (tertCharLen_c7 > 12) xtextloc_float = .01F; else if (tertCharLen_c7 > 6) xtextloc_float = .02F; else xtextloc_float = .06F; }
                        else if (tert_cnt == 2) { if (tertCharLen_c7 > 12) xtextloc_float = .22F; else if (tertCharLen_c7 > 6) xtextloc_float = .18F; else xtextloc_float = .23F; }
                        else if (tert_cnt == 3) { if (tertCharLen_c7 > 12) xtextloc_float = .7F; else if (tertCharLen_c7 > 6) xtextloc_float = .36F; else xtextloc_float = .42F; }
                        else if (tert_cnt == 4) { if (tertCharLen_c7 > 12) xtextloc_float = .7F; else if (tertCharLen_c7 > 6) xtextloc_float = .5F; else xtextloc_float = .59F; }
                        else if (tert_cnt == 5) { if (tertCharLen_c7 > 12) xtextloc_float = .8F; else if (tertCharLen_c7 > 6) xtextloc_float = .69F; else xtextloc_float = .78F; }
                        else if (tert_cnt == 6) { if (tertCharLen_c7 > 12) xtextloc_float = .85F; else if (tertCharLen_c7 > 6) xtextloc_float = .84F; else xtextloc_float = .8F; }
                        else if (tert_cnt == 7) { if (tertCharLen_c7 > 12) xtextloc_float = .9F; else if (tertCharLen_c7 > 6) xtextloc_float = .9F; else xtextloc_float = .96F; }
                        else xtextloc_float = .92F;
                        break;
                    case 9: //Q272 - age, year, stage, all text is between 6 and 12 characters in length
                        string tertStr_c8 = distinctTertiary.Rows[tert_cnt - 1][0].ToString();
                        int tertCharLen_c8 = tertStr_c8.Length;
                        if (tert_cnt == 1) { if (tertCharLen_c8 > 12) xtextloc_float = .01F; else if (tertCharLen_c8 > 6) xtextloc_float = .005F; else xtextloc_float = .06F; }
                        else if (tert_cnt == 2) { if (tertCharLen_c8 > 12) xtextloc_float = .22F; else if (tertCharLen_c8 > 6) xtextloc_float = .13F; else xtextloc_float = .23F; }
                        else if (tert_cnt == 3) { if (tertCharLen_c8 > 12) xtextloc_float = .7F; else if (tertCharLen_c8 > 6) xtextloc_float = .24F; else xtextloc_float = .42F; }
                        else if (tert_cnt == 4) { if (tertCharLen_c8 > 12) xtextloc_float = .7F; else if (tertCharLen_c8 > 6) xtextloc_float = .39F; else xtextloc_float = .59F; }
                        else if (tert_cnt == 5) { if (tertCharLen_c8 > 12) xtextloc_float = .8F; else if (tertCharLen_c8 > 6) xtextloc_float = .5F; else xtextloc_float = .78F; }
                        else if (tert_cnt == 6) { if (tertCharLen_c8 > 12) xtextloc_float = .85F; else if (tertCharLen_c8 > 6) xtextloc_float = .61F; else xtextloc_float = .95F; }
                        else if (tert_cnt == 7) { if (tertCharLen_c8 > 12) xtextloc_float = .85F; else if (tertCharLen_c8 > 6) xtextloc_float = .75F; else xtextloc_float = .95F; }
                        else if (tert_cnt == 8) { if (tertCharLen_c8 > 12) xtextloc_float = .85F; else if (tertCharLen_c8 > 6) xtextloc_float = .88F; else xtextloc_float = .95F; }
                        else if (tert_cnt == 9) { if (tertCharLen_c8 > 12) xtextloc_float = .85F; else if (tertCharLen_c8 > 6) xtextloc_float = .95F; else xtextloc_float = .97F; }
                        else xtextloc_float = .92F;
                        break;
                    case 14: //Q651 - years
                        string tertStr_c14 = distinctTertiary.Rows[tert_cnt - 1][0].ToString();
                        int tertCharLen_c14 = tertStr_c14.Length;
                        if (tert_cnt == 1) { if (tertCharLen_c14 > 12) xtextloc_float = .01F; else if (tertCharLen_c14 > 6) xtextloc_float = .05F; else xtextloc_float = .01F; }//05
                        else if (tert_cnt == 2) { if (tertCharLen_c14 > 12) xtextloc_float = .22F; else if (tertCharLen_c14 > 6) xtextloc_float = .27F; else xtextloc_float = .08F; }//06
                        else if (tert_cnt == 3) { if (tertCharLen_c14 > 12) xtextloc_float = .7F; else if (tertCharLen_c14 > 6) xtextloc_float = .65F; else xtextloc_float = .15F; }//07
                        else if (tert_cnt == 4) { if (tertCharLen_c14 > 12) xtextloc_float = .7F; else if (tertCharLen_c14 > 6) xtextloc_float = .65F; else xtextloc_float = .23F; }//08
                        else if (tert_cnt == 5) { if (tertCharLen_c14 > 12) xtextloc_float = .8F; else if (tertCharLen_c14 > 6) xtextloc_float = .85F; else xtextloc_float = .30F; }//09
                        else if (tert_cnt == 6) { if (tertCharLen_c14 > 12) xtextloc_float = .85F; else if (tertCharLen_c14 > 6) xtextloc_float = .9F; else xtextloc_float = .39F; }//10
                        else if (tert_cnt == 7) { if (tertCharLen_c14 > 12) xtextloc_float = .22F; else if (tertCharLen_c14 > 6) xtextloc_float = .27F; else xtextloc_float = .46F; }//11
                        else if (tert_cnt == 8) { if (tertCharLen_c14 > 12) xtextloc_float = .7F; else if (tertCharLen_c14 > 6) xtextloc_float = .65F; else xtextloc_float = .54F; }//12
                        else if (tert_cnt == 9) { if (tertCharLen_c14 > 12) xtextloc_float = .7F; else if (tertCharLen_c14 > 6) xtextloc_float = .65F; else xtextloc_float = .61F; }//13
                        else if (tert_cnt == 10) { if (tertCharLen_c14 > 12) xtextloc_float = .8F; else if (tertCharLen_c14 > 6) xtextloc_float = .85F; else xtextloc_float = .70F; }//14
                        else if (tert_cnt == 11) { if (tertCharLen_c14 > 12) xtextloc_float = .85F; else if (tertCharLen_c14 > 6) xtextloc_float = .9F; else xtextloc_float = .77F; }//15
                        else if (tert_cnt == 12) { if (tertCharLen_c14 > 12) xtextloc_float = .22F; else if (tertCharLen_c14 > 6) xtextloc_float = .27F; else xtextloc_float = .85F; }//16
                        else if (tert_cnt == 13) { if (tertCharLen_c14 > 12) xtextloc_float = .7F; else if (tertCharLen_c14 > 6) xtextloc_float = .65F; else xtextloc_float = .92F; }//17
                        else if (tert_cnt == 14) { if (tertCharLen_c14 > 12) xtextloc_float = .7F; else if (tertCharLen_c14 > 6) xtextloc_float = .65F; else xtextloc_float = .99F; }//18
                        else xtextloc_float = .92F;
                        break;
                }

                string triplestratfontsize = "17";// 06/17/2021 REMOVE THIS LINE
                tickangle = "0";
                if (QNum.ToUpper() == "Q700")
                {
                    tickangle = "10";
                }

                titleannontations = titleannontations + " {text: '" + tertiary_var + "',font: {size: " + triplestratfontsize + "},showarrow: false,align: 'center',x: " + xtextloc_float.ToString() + ",y: 1.0,xref: 'paper',yref: 'paper'},";


                string hiConData_col_final = "";//high_confidence.Substring(0, high_confidence.Length - 1) + "]";//removing the last comma
                string loConData_col_final = "";//low_confidence.Substring(0, low_confidence.Length - 1) + "]";//removing the last comma
                string hovertextData_final = "";//hovertext.Substring(0, hovertext.Length - 1) + "]";//removing the last comma                

                if (regex.IsMatch(high_confidence) && regex.IsMatch(low_confidence)) //if both are numeric, then add all of the values to the array. This accounts for missing CIs
                {
                    hiConData_col_final = "array:[ " + high_confidence.Substring(0, high_confidence.Length - 1) + "]";
                    loConData_col_final = "arrayminus:[ " + low_confidence.Substring(0, low_confidence.Length - 1) + "]";
                    hovertextData_final = "text:[ " + hovertext.Substring(0, hovertext.Length - 1) + "]";
                }
                else //otherwise don't display any values, this accounts for scenarios where there aren't CIs
                {
                    hiConData_col_final = "array:[ ]";
                    loConData_col_final = "arrayminus:[ ]";
                    hovertextData_final = "text:[ ]";
                }

                //creating an array of [1,2,3,etc] based on the number of items on the xaxis. this loop increments through them to create the array
                string xaxistickarray = "";
                for (int i = 0; i < max_xaxis_cnt; i++)
                {
                    xaxistickarray = xaxistickarray + i.ToString() + ",";
                }
                xaxistickarray = xaxistickarray.Substring(0, xaxistickarray.Length - 1);

                string longest = "";
                int longestindex = -1;
                xaxisArray.Add(hfval_x); //adding the final hfval_x to this array so that it can be compared
                for (int ind = 0; ind < xaxisArray.Count; ind++) //loop through the array and find the longest value, this accounts for strats that are missing data
                {
                    if (xaxisArray[ind].Length > longest.Length)
                    {
                        longest = xaxisArray[ind];
                        longestindex = ind;
                    };
                }




                string hfval_x_ticks = xaxisArray[longestindex]; //once found, set it to the hfval_x so that it can be used


                subplots = subplots + "'x" + tert_cnt + "',";
                subplots_xaxis = subplots_xaxis + "xaxis" + tert_cnt + ": { dtick:1, linewidth: 0, showgrid: false, type: 'category', tickmode:'array', tickangle:" + tickangle + ", tickfont: {size: " + triplestratfontsize + " }, tickvals:[" + hfval_x_ticks.Substring(3, hfval_x_ticks.Length - 4) + "], ticktext:[" + hfval_x_ticks.Substring(3, hfval_x_ticks.Length - 4) + "]}, "; //removing the x:[ from the front of the string

                string xData_col_final = hfval_x.Substring(0, hfval_x.Length - 1) + "]";//removing the last comma
                string yData_col_final = hfval_y.Substring(0, hfval_y.Length - 1) + "]";//removing the last comma
                string wData_col_final = hfval_w.Substring(0, hfval_w.Length - 1) + "]";//removing the last comma
                string yData_col_final_basedata = hfval_y_basedata.Substring(0, hfval_y_basedata.Length - 1) + "]";//removing the last comma



                //9/28/2020 - BS - added the increment value of 'final' to the data variable string so that it is unique
                plotlyStr.Append(" var data" + cleanString(tertiary_var) + cleanString(current_serieslabel) + "final = {" + xData_col_final + " , " + yData_col_final + "," + wData_col_final);
                if (hiConData_col_final != "array:[ ]" && loConData_col_final != "arrayminus:[ ]" && hovertextData_final != "text:[ ]") //if there are empty values, then don't display the hover text for the errors
                    plotlyStr.Append(", error_y: {visible: eval($('#hfShowCI').val()), type: 'data', color: '#222', thickness:1, symmetric: false, " + hiConData_col_final + " ," + loConData_col_final + "}, " + hovertextData_final + "," + hovertemplate);

                //9/28/2020 - BS - added the increment value of 'i' to the data variable string so that it is unique
                plotlyStr.Append(", name: '" + current_serieslabel + "', legendgroup: '" + cleanString(current_serieslabel) + "final', showlegend: " + legendbool + ", type: " + hfChartType.Value + ", connectgaps: true,line: { simplify: false}, marker: {color: eval(colors_split[" + colorarray_inc + "]) }, xaxis:'x" + tert_cnt + "'};"); //appending the 'row' to the data name and adding the array data

                //1/12/2021 - BS - added the basedata necessary for animation
                plotlyStr.Append(" var basedata" + cleanString(tertiary_var) + cleanString(current_serieslabel) + "final = {" + xData_col_final + " , " + yData_col_final_basedata + "," + wData_col_final);
                plotlyStr.Append(", name: '" + current_serieslabel + "', legendgroup: '" + cleanString(current_serieslabel) + "final', showlegend: " + legendbool + ", type: " + hfChartType.Value + ", connectgaps: true,line: { simplify: false}, marker: {color: eval(colors_split[" + colorarray_inc + "]) }, xaxis:'x" + tert_cnt + "'};"); //appending the 'row' to the data name and adding the array data

                //9/28/2020 - BS - added the increment value of 'final' to the data variable string so that it is unique
                plotlyGroups = plotlyGroups + "data" + cleanString(tertiary_var) + cleanString(current_serieslabel) + "final ,"; //adding the above data variable to the group variable

                plotlyBaseGroups = plotlyBaseGroups + "basedata" + cleanString(tertiary_var) + cleanString(current_serieslabel) + "final ,"; //adding the above data variable to the group variable

                /*end Create data array logic*/

                if (!plotlyStr.ToString().Contains("error_y")) //if confidence intervals aren't in the plotly string, then hide the checkbox
                    CB_ChartCI.Visible = false;

                legendbool = "false"; //resetting this variable so that only the first legend is showing
            }

            plotlyGroups = "var data = [" + plotlyGroups;
            plotlyBaseGroups = "var basedata = [" + plotlyBaseGroups; //this will consist of all '0' values for the baseline aspect of the animated portion

            string dataGroups = plotlyGroups.Substring(0, plotlyGroups.Length - 1) + "];";//otherwise, close the array and add it to the plotly string

            //adding the base group data
            dataGroups = dataGroups + plotlyBaseGroups.Substring(0, plotlyBaseGroups.Length - 1) + "];";//otherwise, close the array and add it to the plotly string

            plotlyStr.Append(dataGroups);

            subplots = subplots.Substring(0, subplots.Length - 1);

            //adding the max values to the hiddenfields to be referenced in the markup, adding a cushion to the top of the chart to account for the title that has been added for the triple strat
            hfMaxYVal.Value = Math.Ceiling((max_yval * Decimal.Parse("1.1"))).ToString();
            hfMaxConfidence.Value = Math.Ceiling((max_confidence * Decimal.Parse("1.1"))).ToString();

            if (CB_ChartCI.Checked) //if the confidence intervals checkbox is checked, then use the max confidence value
                hfChartYValToUse.Value = hfMaxConfidence.Value;
            else //otherwise use the max Y value
                hfChartYValToUse.Value = hfMaxYVal.Value;

            createTripleStratPlotlyScript(plotlyStr, chartTitle, xaxisTitle, yaxisTitle, max_xaxis_cnt, tert_cnt, subplots, subplots_xaxis, titleannontations);
        }
        private void createTripleStratPlotlyScript(StringBuilder dataSb, string title, string xaxistitle, string yaxistitle, int xaxiscnt, int tert_cnt, string subplots, string subplots_xaxis, string titleannontations)
        {
            string xtickfontsize = "19";  //"17";
            string tickangle = "0";
            string yaxistitlefontsize = "21";

            if (xaxiscnt >= 7 || QNum.ToUpper() == "Q700")
            {
                xtickfontsize = "19";  //"16";
                tickangle = "10";
            }

            string yaxisfontsize = "19";  //"17";
            string legendfontsize = "17";

            StringBuilder sb = new StringBuilder();
            sb.Append("<script>");
            if (isDefaultStd)
            {
                sb.Append(" $(function() { createPlotlyChart(); });");
                sb.Append(" function createPlotlyChart()  {");
            }
            else {
                sb.Append(" $(function() { createPlotlyChartRel(); });");
                sb.Append(" function createPlotlyChartRel()  {");
            }
            
            sb.Append("  var colors = $('#hfChartColor').val(); var colors_split = colors.split(','); "); //4/21/20 adding the color arry parsing here so that it is at the top of the script
            sb.Append(" var d3 = Plotly.d3;");
            sb.Append(" var WIDTH_IN_PERCENT_OF_PARENT = 100, HEIGHT_IN_PERCENT_OF_PARENT = 120;");
            sb.Append(dataSb);
            sb.Append(" var img_png= d3.select('#png-export'); ");

            sb.Append(" var layout = {autosize:true, width:1000, height: 750");
            sb.Append(" ,grid: { rows: 1, columns: " + tert_cnt + ", subplots: [" + subplots + "], pattern: 'coupled' }");
            sb.Append(" ,plot_bgcolor: '#FFFFFF' ");
            ////comment out the three lines below to hide the graphic identifier
            sb.Append(" ,images: [{ x: 0.20, y: 1.18, sizex: 0.3, sizey: 0.3, 'opacity': 0.6");
            //sb.Append(" ,source: 'images/graphic_identifier.png' ");
            sb.Append(" ,xanchor: 'right', xref: '0', yanchor: 'bottom', yref: '0'}] ");

            //sb.Append(" ,annotations: [" + titleannontations + " { x: 0, y: 0, xshift: -70, yshift: -80, sizex: 0.3, sizey: 0.3, yref: 'paper', xref: 'paper', align: 'left', text: 'Centers for Disease Control and Prevention. Chronic Kidney Disease Surveillance System—United States. website. https://nccd.cdc.gov/ckd ', showarrow: false, font: { size: 9 } },{ x: 0, y: 1.2, xshift: -70, yref: 'paper', xref: 'paper', align: 'left', text: '" + title + "',showarrow: false }, {text: '<b>" + xaxistitle + "</b>',font: {size: " + yaxisfontsize + "},showarrow: false,align: 'center',x: 0.6, y: 0.0, xref: 'paper',yref: 'paper',xshift: -70,yshift: -60}],"); //, font: { size: 20 }
            sb.Append(" ,annotations: [" + titleannontations + " { x: 0, y: 0, xshift: -70, yshift: -80, sizex: 0.3, sizey: 0.3, yref: 'paper', xref: 'paper', align: 'left', text: '', showarrow: false, font: { size: 9 } },{ x: 0, y: 1.2, xshift: -70, yref: 'paper', xref: 'paper', align: 'left', text: '',showarrow: false }, {text: '<b></b>',font: {size: " + yaxisfontsize + "},showarrow: false,align: 'center',x: 0.6, y: 0.0, xref: 'paper',yref: 'paper',xshift: -70,yshift: -60}],"); //, font: { size: 20 }
            sb.Append(" legend: {orientation: 'h',  y: -0.1, font:{size: " + legendfontsize + "}, traceorder:'normal'}," + subplots_xaxis + " barmode: eval($('#hfChartMode').val()), hovermode: 'closest',hoverinfo: 'none', yaxis: {showgrid: true, zeroline:false, range: [0, eval($('#hfChartYValToUse').val())], xshift: -70, linecolor:'#bdbdbd', tickfont: { size: " + yaxisfontsize + " }, title:'<b>" + yaxistitle + "</b>', titlefont: { size:  " + yaxistitlefontsize + " } }, margin: {t: 50}};");

            if (isDefaultStd)
                sb.Append(" var gd4 = d3.select('#svgchart');");
            else
                sb.Append(" var gd4 = d3.select('#svgchartRel');");

            sb.Append("var graphdiv = gd4.node();");

            String titleNoFN = "chartimage";
            if (Session["TitleNoFN"] != null)
            {
                titleNoFN = "Chart_" + Session["TitleNoFN"].ToString().Replace(" ", "_").Trim();
            }

            if (isIEorEdge)
            {
                sb.Append("Plotly.newPlot(graphdiv, basedata, layout,{responsive:true, displayModeBar: false, modeBarButtonsToRemove: ['toImage','sendDataToCloud', 'lasso2d', 'select2d', 'toggleSpikelines'] , modeBarButtonsToAdd: [{ name: 'Download Chart as SVG', icon: Plotly.Icons.camera, click: function(gd) { Plotly.downloadImage(gd,{format:'svg',height:700,width:920, filename: '" + titleNoFN + "'}) }}]");//sb.Append("Plotly.newPlot(graphdiv, data, layout,{displayModeBar: true, modeBarButtonsToRemove: ['sendDataToCloud']");
            }
            else
            {
                sb.Append("Plotly.newPlot(graphdiv, basedata, layout,{responsive:true, displayModeBar: false, modeBarButtonsToRemove: ['toImage','sendDataToCloud', 'lasso2d', 'select2d', 'toggleSpikelines'] , modeBarButtonsToAdd: [{ name: 'Download Chart as PNG', icon: Plotly.Icons.camera, click: function(gd) { Plotly.downloadImage(gd,{format:'png',height:700,width:920, filename: '" + titleNoFN + "'}) }}]");
            }

            //sb.Append(" });");//}]

            sb.Append(" })"); //this line and the one below are for the animation
            //add the animation line here, this will need to be dynamic based on load. Animation can be turned on/off
            sb.Append(".then(function () {Plotly.animate(graphdiv, {data: data, layout: layout}, { transition: {duration: 0, easing: 'cubic-in-out'},  frame: { duration: 1000 } }) });");

            sb.Append("");
            //2/9/2021 = BS- calling the auto scale so that the graph is redrawn with the remaining data taking up the entire chart (this is necessary for the animation to work properly), it must be above the window.resize or an error is caused
            sb.Append(" graphdiv.on('plotly_legendclick', function(data) {legendAutoScaleClick(); }); ");

            sb.Append("window.onresize = function(){ Plotly.Plots.resize(graphdiv); }");
            sb.Append("}");
            sb.Append("</script>");

            if (isDefaultStd)
                this.Lit_Plotly.Text = sb.ToString();
            else
                this.Lit_PlotlyRel.Text = sb.ToString();
        }
        private void createPlotlyScript(StringBuilder dataSb, string title, string xaxistitle, string yaxistitle, int xaxiscnt, bool isMapPage)
        {
            string xtickfontsize = "19";  //"17";
            string tickangle = "0";
            string yaxisfontsize = "19"; //"17";
            string yaxistitlefontsize = "21";
            string legendfontsize = "17";

            if (xaxiscnt >= 7)
            {
                xtickfontsize = "19";  //"16";
                tickangle = "10";
            }

            //xtickfontsize = "17"; /*** 9/30/2022 Change font sizes in data visualizations ***/ // 06/17/2021 REMOVE THIS LINE 
            //tickangle = "15"; // 06/17/2021 REMOVE THIS LINE

            if (QNum.ToUpper() == "Q632" || QNum.ToUpper() == "Q631")//hardcoding due to last minute request
            {
                if (Request.QueryString["Strat"] != null)
                {
                    if (Request.QueryString["Strat"].ToLower().IndexOf("age") != 0)//age has to be on an angle due to the large number of bars
                        tickangle = "0";
                }
            }

            StringBuilder sb = new StringBuilder();
            sb.Append("<script>");
            if (isDefaultStd)
            {
                if (isMapPage == false)
                    sb.Append(" $(function() { createPlotlyChart(); });");
                else
                    sb.Append(" $(function() { createPlotlyChart(); document.getElementsByClassName('ytitle')[0].y.baseVal[0].value *= 0.92; });"); //if this is a map, add a modification to the y-axis by moving it as far to the left as possible
                sb.Append(" function createPlotlyChart()  {");
            }
            else
            {
                if (isMapPage == false)
                    sb.Append(" $(function() { createPlotlyChartRel(); });");
                else
                    sb.Append(" $(function() { createPlotlyChartRel(); document.getElementsByClassName('ytitle')[0].y.baseVal[0].value *= 0.92; });"); //if this is a map, add a modification to the y-axis by moving it as far to the left as possible
                sb.Append(" function createPlotlyChartRel()  {");
            }

            sb.Append("  var colors = $('#hfChartColor').val(); var colors_split = colors.split(','); "); //4/21/20 adding the color arry parsing here so that it is at the top of the script
            sb.Append(" var d3 = Plotly.d3;");
            sb.Append(" var WIDTH_IN_PERCENT_OF_PARENT = 100, HEIGHT_IN_PERCENT_OF_PARENT = 120;");
            sb.Append(dataSb);
            sb.Append(" var img_png= d3.select('#png-export'); ");
            //sb.Append(" var baselayout =  {yaxis: { range: [0, 45]}}; ");//need values to be passed into this function and used here

            if (QNum.ToUpper() == "Q729" || QNum.ToUpper() == "Q731" || QNum.ToUpper() == "Q751")
                sb.Append(" var layout = {autosize:true, showlegend: false, height: 700, margin: {  t: 50}"); //setting margins so that the graphic identifier and title can fit correctly
            else
                sb.Append(" var layout = {autosize:true, height: 700, margin: {  t: 50}"); //setting margins so that the graphic identifier and title can fit correctly
            //look at automargin parameter on yaxis/xaxis so label isn't overwritten by ticks


            ////comment out the three lines below to hide the graphic identifier (used to pull images for the AYA)
            sb.Append(" ,images: [{  x: 0.20, y: 1.1, sizex: 0.3, sizey: 0.3, 'opacity': 0.6,");
            //sb.Append(" source: 'images/graphic_identifier.png', ");
            sb.Append(" xanchor: 'right', xref: '0', yanchor: 'bottom', yref: '0' }] ");

            //}

            /*** 10/7/2022 Add target to the chart ***/
            var refVal = RefValue(QNum);
            if (refVal > 0)
            {
                sb.Append(" ,shapes: [ { type:'line', xref: 'paper', x0:0, y0:" + refVal + ", x1:1, y1:" + refVal + ", line:{ color: 'rgb(0, 128, 0 )',  width: 5, dash: 'dot' }}]");
            }

            //sb.Append(" ,annotations: [{ x: 0, y: 0, xshift: -70, yshift: -80, sizex: 0.3, sizey: 0.3, yref: 'paper', xref: 'paper', align: 'left', text: 'Centers for Disease Control and Prevention. Chronic Kidney Disease Surveillance System—United States. website. https://nccd.cdc.gov/ckd ', showarrow: false, font: { size: 12 } },{ x: 0, y: 1.12, xshift: -70, yref: 'paper', xref: 'paper', align: 'left', text: '" + title + "', font: { size: 14 } ,showarrow: false }],"); //, font: { size: 20 }
            //sb.Append(" ,annotations: [{ x: 0, y: 0, xshift: -70, yshift: -80, sizex: 0.3, sizey: 0.3, yref: 'paper', xref: 'paper', align: 'left', text: '', showarrow: false, font: { size: 12 } },{ x: 0, y: 1.12, xshift: -70, yref: 'paper', xref: 'paper', align: 'left', text: '" + title + "', font: { size: 14 } ,showarrow: false }],"); //, font: { size: 20 }
            sb.Append(" ,annotations: [{ x: 0, y: 0, xshift: -70, yshift: -80, sizex: 0.3, sizey: 0.3, yref: 'paper', xref: 'paper', align: 'left', text: '', showarrow: false, font: { size: 12 } },{ x: 0, y: 1.12, xshift: -70, yref: 'paper', xref: 'paper', align: 'left', text: '', font: { size: 14 } ,showarrow: false }],"); //, font: { size: 20 }

            ////The Y axis label if being moved to the far left of the chart within the client side  $(function () 
            if (isMapPage == true)
            {
                //modify the x axis ticks/values for maps, dtick=1 shows all labels, automargin: true displays all labels and doesn't cut off text
                sb.Append("showlegend:false, barmode:  eval($('#hfChartMode').val()), hovermode: 'closest',hoverinfo: 'none', xaxis: {dtick:1, tickangle:" + tickangle + ", showgrid: false, tickfont: { size: " + xtickfontsize + " }, linewidth: 0, titlefont: { size: " + xtickfontsize + " }},yaxis: {range: [0, eval($('#hfChartYValToUse').val())],showgrid: true,automargin: true, dtick: 1, xshift: -200, linewidth: 0, tickfont: { size: " + yaxisfontsize + " }, title:'<b>" + yaxistitle + "</b>', titlefont: { size: " + yaxistitlefontsize + " } }};");
            }
            else
            {
                //type = category so all values are displayed, not just a group
                if (QNum.ToUpper() == "Q372")
                    sb.Append(" legend: {'orientation': 'h', font: { size: " + legendfontsize + " }, traceorder:'normal'},  barmode:  eval($('#hfChartMode').val()), hovermode: 'closest',hoverinfo: 'none', xaxis: {dtick:1, type:'category', showgrid: false, zeroline: false, tickangle:" + tickangle + ", tickfont: { size: " + xtickfontsize + ", color:'black' }, linewidth: 0, title:'<b></b>', titlefont: { size: " + xtickfontsize + " }},yaxis: {range: [0, eval($('#hfChartYValToUse').val())],showgrid: true, zeroline: false, xshift: -70, linewidth: 0, tickfont: { size: " + yaxisfontsize + " , color:'black'}, title:'<b>" + yaxistitle + "</b>', titlefont: { size: " + yaxistitlefontsize + " } }};");
                else
                    sb.Append(" legend: {'orientation': 'h', font: { size: " + legendfontsize + " }}, barmode:  eval($('#hfChartMode').val()), hovermode: 'closest',hoverinfo: 'none', xaxis: {dtick:1, type:'category', showgrid: false, zeroline: false, tickangle:" + tickangle + ", tickfont: { size: " + xtickfontsize + ", color:'black' }, linewidth: 0, title:'<b></b>', titlefont: { size: " + xtickfontsize + " }},yaxis: {range: [0, eval($('#hfChartYValToUse').val())],showgrid: true, zeroline: false, xshift: -70, linewidth: 0, tickfont: { size: " + yaxisfontsize + " , color:'black'}, title:'<b>" + yaxistitle + "</b>', titlefont: { size: " + yaxistitlefontsize + " } }};");
            }

            if (isDefaultStd)
                sb.Append(" var gd4 = d3.select('#svgchart');");
            else
                sb.Append(" var gd4 = d3.select('#svgchartRel');");

            sb.Append("var graphdiv = gd4.node();");

            String titleNoFN = "chartimage";
            if (Session["TitleNoFN"] != null)
            {
                titleNoFN = "Chart_" + Session["TitleNoFN"].ToString().Replace(" ", "_").Trim();
            }

            if (isMapPage) //4/8/2021, if it is a map, then we don't need to animate the bar chart below the map, just show the data
            {
                sb.Append("Plotly.newPlot(graphdiv, data, layout,{responsive:true, displayModeBar: false, modeBarButtonsToRemove: ['toImage','sendDataToCloud', 'lasso2d', 'select2d', 'toggleSpikelines'] , modeBarButtonsToAdd: [{ name: 'Download Chart as SVG', icon: Plotly.Icons.camera, click: function(gd) { Plotly.downloadImage(gd,{format:'svg',height:700,width:920, filename: '" + titleNoFN + "'}) }}]");//sb.Append("Plotly.newPlot(graphdiv, data, layout,{displayModeBar: true, modeBarButtonsToRemove: ['sendDataToCloud']");
            }
            else
            {
                sb.Append("Plotly.newPlot(graphdiv, basedata, layout,{responsive:true, displayModeBar: false, modeBarButtonsToRemove: ['toImage','sendDataToCloud', 'lasso2d', 'select2d', 'toggleSpikelines'] , modeBarButtonsToAdd: [{ name: 'Download Chart as PNG', icon: Plotly.Icons.camera, click: function(gd) { Plotly.downloadImage(gd,{format:'png',height:700,width:920, filename: '" + titleNoFN + "'}) }}]");
            }
            //sb.Append(" });"); //uncomment this to remove the animation

            if (isMapPage)
            {
                sb.Append(" });");
            }
            else //only animate if it is a map page
            {
                sb.Append(" })"); //this line and the one below are for the animation
                                  //add the animation line here, this will need to be dynamic based on load. Animation can be turned on/off
                sb.Append(".then(function () {Plotly.animate(graphdiv, {data: data, layout: layout}, { transition: {duration: 0, easing: 'cubic-in-out'},  frame: { duration: 1000 } }) });");
            }

            //max and min y value is needed to draw the chart initially



            sb.Append("");
            //2/9/2021 = BS- calling the auto scale so that the graph is redrawn with the remaining data taking up the entire chart (this is necessary for the animation to work properly), it must be above the window.resize or an error is caused
            sb.Append(" graphdiv.on('plotly_legendclick', function(data) {legendAutoScaleClick(); }); ");

            sb.Append("window.onresize = function(){ Plotly.Plots.resize(graphdiv); }");

            //sb.Append(" graphdiv.on('plotly_legendclick', function(data) {legendAutoScaleClick(); });");


            sb.Append("}");
            sb.Append("</script>");

            if (isDefaultStd)
                this.Lit_Plotly.Text = sb.ToString();
            else
                this.Lit_PlotlyRel.Text = sb.ToString();
        }



        //******
        //*MAPS*
        //******
        private string getD3MapJSCode(DataSet ds, string divTitle, string mapTitleLine1, string mapTitleLine2, string chartTitle, bool allyears)
        {
            string retstr = "";
            retstr += "<script type='text/javascript'>";
            retstr += "var width = 870, ";
            retstr += "height = 500; ";
            retstr += "var actualwidth = 870, ";
            retstr += "actualheight = 500; ";
            retstr += "const scaleval = [1000];";
            retstr += "var g_con; ";
            retstr += "var g_text; ";

            retstr += "var stateData = [];";

            string legendcolors = "";
            string legenddisplaytext = "";
            string legendtext = "";
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                string l_color = dr["LegendColor"].ToString();
                string l_text = dr["LegendDisplay"].ToString();
                legendtext = dr["LegendTitle"].ToString();

                legendcolors = legendcolors + "'" + l_color + "',";
                legenddisplaytext = legenddisplaytext + "'" + l_text + "',";
            }

            legendcolors = legendcolors.Substring(0, legendcolors.Length - 1);
            legenddisplaytext = legenddisplaytext.Substring(0, legenddisplaytext.Length - 1);

            retstr += "const legendtext = '" + legendtext + "';";
            retstr += "const colorarray = [ " + legendcolors + " ];";
            retstr += "const displaytextarray = [ " + legenddisplaytext + " ];";

            retstr += "var hovertooltipdiv = d3.select('body').append('div').attr('class', 'hovertooltip');";

            retstr += "var zoom = d3.zoom().scaleExtent([1, 8]).on('zoom', zoomed);";

            retstr += "var svg = d3.select('#map').append('svg')";
            retstr += ".attr('class', 'usmapsvg')";
            retstr += ".attr('width', width)";
            retstr += ".attr('height', height)";
            retstr += ".call(zoom);";


            int tempMinVal = -1;
            int tempMaxVal = -1; ;
            string yearval = getYear();
            retstr += " var yearselected = " + yearval + ";";

            DataTable dtable_legend = ds.Tables[1];
            dtable_legend.Columns.Add("IntegerValue", typeof(System.Int32));//adding an integer value
            foreach (DataRow row in dtable_legend.Rows)
            {
                Int16 valueint = 0;
                string valuestring = row["MainValueAdjustedForDigitsRightOfDecimal"].ToString().Replace(",", "");
                if (Int16.TryParse(valuestring, out valueint))
                {
                    valueint = Int16.Parse(valuestring);
                }

                row["IntegerValue"] = valueint;
            }

            foreach (DataRow dr in dtable_legend.Rows)
            {
                string dataval = dr["IntegerValue"].ToString(); //using the integer value created above
                int parseint;
                bool parseresult = Int32.TryParse(dataval, out parseint);
                if (parseresult)
                {
                    int parse_dataval = Int32.Parse(dataval);
                    if (tempMinVal == -1 || tempMinVal > parse_dataval)
                        tempMinVal = parse_dataval;


                    if (tempMaxVal == -1 || tempMaxVal < parse_dataval)
                        tempMaxVal = parse_dataval;
                }

                if (allyears) //if this is all year data, then use the years included in the database
                    yearval = dr["Year"].ToString();

                retstr += " stateData.push({'name': '" + dr["State"] + "', 'value': '" + dr["MainValueAdjustedForDigitsRightOfDecimal"] + "', 'year': " + yearval + ",'color':'" + dr["color"] + "', 'abbr':'" + dr["stateabbrev"] + "' });";
            }

            retstr += " valMin = " + tempMinVal + ";";
            retstr += " valMax = " + tempMaxVal + ";";
            retstr += " minmaxDiff = " + (tempMaxVal - tempMinVal) + ";";

            retstr += "  fillTheMap(0);";
            retstr += " fillTheLegend();";

            retstr += " var mapcharttitle = '" + chartTitle + " - " + mapTitleLine2 + "';";
            retstr += " var mapchartfooter = 'Centers for Disease Control and Prevention. Chronic Kidney Disease Surveillance System—United States.';";
            retstr += " fillTheTitleFooter(mapcharttitle, mapchartfooter);";


            retstr += "</script>";
            return retstr;
        }
        private string getD3MapTabsJSCode(DataSet ds, string divTitle, string mapTitleLine1, string mapTitleLine2, string chartTitle, bool allyears, string yr)
        {
            string countydataarray = "var countyDataArray = [";
            //looping through the data
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                string countyfips = dr["Secondary"].ToString();
                string statefips = dr["FIPSState"].ToString();
                string countyname = dr["CountyName"].ToString();
                string statename = dr["StateName"].ToString();
                string dataval = dr["DataPointDecimal"].ToString();
                if (countyfips.Length == 4) countyfips = "0" + countyfips; //appending leading zeros for the states that are less than 9000
                if (dataval.Length == 0) dataval = "NA";//if values are missing then add a NA which will make the background white
                countydataarray += "{'fipscounty':'" + countyfips + "','fipsstate': '" + statefips + "','county': '" + countyname + "' ,'state': '" + statename + "' ,'countydatavalue': '" + dataval + "'},";
            }

            countydataarray = countydataarray.Substring(0, countydataarray.Length - 1);//removing the last comma
            countydataarray += "];";

            string retstr = "";

            retstr += "<script type='text/javascript'>";
            retstr += countydataarray;//adding the county level data
            //begin drawTinyStateLevelMap
            retstr += "function drawTinyStateLevelMap(statecode) ";
            retstr += "{";
            retstr += "console.log('inside drawtiny');";
            retstr += "var stateData = [];";
            retstr += "const colorarrayv2 = ['#D6EAF8', '#AED6F1', '#85C1E9', '#59B1EC', '#2E86C1'];";
            retstr += "const statearray = ['Alabama', 'Alaska', 'Arkansas', 'Arizona', 'California', 'Colorado', 'Connecticut', 'District of Columbia', 'Delaware', 'Florida', 'Georgia', 'Hawaii', 'Iowa', 'Idaho', 'Illinois', 'Indiana', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland',";
            retstr += "'Massachusetts', 'Michigan', 'Minnesota', 'Missouri', 'Mississippi', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota',";
            retstr += "'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington', 'Wisconsin', 'West Virginia', 'Wyoming'];";
            retstr += " const abbrarray = ['AL', 'AK', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'ME', 'MD',";
            retstr += "'MA', 'MI', 'MN', 'MO', 'MS', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND',";
            retstr += "'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WI', 'WV', 'WY'];";

            retstr += "const fipsarray = ['01', '02', '05', '04', '06', '08', '09', '11', '10', '12', '13', '15', '19', '16', '17', '18', '20', '21', '22', '23', '24',";
            retstr += "'25', '26', '27', '29', '28', '30', '31', '32', '33', '34', '35', '36', '37', '38',";
            retstr += "'39', '40', '41', '42', '44', '45', '46', '47', '48', '49', '50', '51', '53', '55', '54', '56'];";

            retstr += "statearray.forEach(function(statename, index) {";
            retstr += "stateData.push({ 'name': statename, 'abbr': abbrarray[index], 'fips': fipsarray[index] });";
            retstr += " });";

            //reducing the width and height
            retstr += "var width = 190;";
            retstr += "var height = 190;";

            retstr += "var zoom = d3.zoom().on('zoom', zoomed);"; //zoom

            retstr += "d3.select('#tinystatemap').selectAll('svg').remove();";//remove the existing state
            retstr += "var svg = d3.select('#tinystatemap').append('svg')";//add a new svg and draw a new state
            retstr += ".attr('width', width)";
            retstr += ".attr('height', height)";
            retstr += ".attr('class', 'countymapsvgtiny')";

            retstr += ".call(zoom);"; //zoom

            retstr += "d3.select('#zoom_in').on('click', function() { zoom.scaleBy(svg.transition().duration(750), 1.2);});d3.select('#zoom_out').on('click', function() { zoom.scaleBy(svg.transition().duration(750), 0.8);});"; //zoom
            //retstr += "function zoomed() { g.attr('transform', d3.event.transform);}";//zoom

            retstr += "var path = d3.geoPath();";

            retstr += "d3.queue()";//starting the queue
            retstr += ".defer(d3.json, 'Scripts/D3MapFiles/Coordinates/us-10m.v1.json')"; //using this json file            
            retstr += ".await(countyMapReady);"; //calling the 'ready' function

            retstr += " var valMin, valMax, minmaxDiff;"; //public variables to be used for legend and the color fill of the counties

            retstr += "function countyMapReady(error, us) ";
            retstr += "{ ";
            retstr += "if (error) throw error; ";
            retstr += "var csvdata = countyDataArray; ";
            retstr += "var featurestate = topojson.feature(us, us.objects.states)";
            retstr += ".features";
            retstr += ".filter(function(d) { return d.id == statecode; })[0];"; // filtering out the state by FIPS code, which is passed in above. get a geojson object (not an array of objects)

            retstr += "var projection = d3.geoIdentity().fitSize([width, height], featurestate); ";// scale and translate the map so the feature is centered

            retstr += "path.projection(projection);";

            retstr += "valMin = d3.min(csvdata, function (d) { return +d.countydatavalue; });";//finding the minimum value in the csv data
            retstr += "valMax = d3.max(csvdata, function (d) { return +d.countydatavalue; });";//finding the maximum value in the csv data
            retstr += "console.log('valMin=' + valMin);";
            retstr += "minmaxDiff = valMax - valMin; ";//finding the difference/range
            retstr += "fillTheLegend_tabs();"; // filling the legend with the quintiles
            retstr += " var mapcharttitle = '" + chartTitle + " - " + mapTitleLine2 + "';";
            retstr += " var mapchartfooter = 'Centers for Disease Control and Prevention. Chronic Kidney Disease Surveillance System—United States.';";

            retstr += "fillChartTitle_tabs(mapcharttitle,mapchartfooter);"; // filling the legend with the quintiles

            retstr += "var allCounties = topojson.feature(us, us.objects.counties).features;"; //finding all counties
            retstr += "var counties = [];";
            retstr += "allCounties.forEach(function (c) { ";//then loop through all of the counties and filter out based on the first two characters (which is the state)
            retstr += "var sid = statecode;";
            retstr += "var cid = c.id + ''; ";
            retstr += "if (cid.slice(0, sid.length) === sid && cid.length - sid.length == 3) counties.push(c);";
            retstr += "});";


            retstr += "counties = svg.append('g').attr('class', 'countiestiny').selectAll('path')";
            retstr += ".data(counties)";
            retstr += ".enter()";
            retstr += ".append('path').attr('d', path).attr('id', function (d) { return d.id; })";
            retstr += ".style('fill', function (cdata) { "; //loading the csvdata in the queue
            retstr += "var filtercountyrow = csvdata.filter(function(d, i) {";
            retstr += "return d.fipscounty == cdata.id;"; //just match on the countyid from the countiesarray and match it with the fipscounty columns fro mthe excel file and then return the whole row of data
            retstr += "});";

            retstr += "if (filtercountyrow.length === 0)";
            retstr += "dataval = 'MIA';";
            retstr += "else ";
            retstr += "dataval = filtercountyrow[0]['countydatavalue'];";

            retstr += "var colorval;";

            retstr += "colorval = findColorVal(dataval);";

            retstr += "return colorval;";
            retstr += "})";

            retstr += ".style('stroke', '#444')";//has to be added here so that the save image function holds onto the style.
            retstr += ".style('stroke -width', '.5px');";

            retstr += "svg.append('path')";
            retstr += ".datum(featurestate)";
            retstr += ".attr('class', 'state-boundary')";
            retstr += ".style('stroke', '#000')";//has to be added here so that the save image function holds onto the style.
            retstr += ".style('stroke-width', '2px')"; //adding thicker state borders
            retstr += ".style('fill', 'none')";
            retstr += ".attr('d', path);"; // draw the path.

            retstr += "}";
            retstr += "}";
            //end drawTinyStateLevelMap

            //begin createUSMapChart
            retstr += "function createUSMapChart(width, height)"; //datavals, scopeval, xaxis_title, title_var //creating the chart with the data sent back from the proc
            retstr += "{";
            retstr += "$('.countymapsvg').removeProp('style');"; //removing the existing style of display none
            retstr += "$('.countymapsvg').prop('style', 'display:inline-block');";// adding the style of inline-block

            //zoom and pan functionality, function for general zooming and panning
            retstr += "d3.drag().on('drag', function() { d3.event.stopPropagation(); });";

            retstr += "svg_tabs.call(zoom_tabs);";//necessary for the entire map to zoom, calling the variable above

            retstr += "svg_tabs.on('mouseout', function()";
            retstr += "{";
            retstr += "hovertooltipdiv_tabs.style('display', 'none');"; //if the cursor is outside of the map, then hide the hover over
            retstr += "$('.datastatelabel').html('');"; //and empty all of the data labels
            retstr += "$('.datacountylabel').html('');";
            retstr += "$('.datavaluelabel').html('');";
            retstr += "});";

            //end zoom and pan functionality

            retstr += "d3.queue()"; //starting the queue
            retstr += ".defer(d3.json, 'Scripts/D3MapFiles/Coordinates/us-10m.v1.json')"; //using this json file            
            retstr += ".await(mapReady);"; //calling the 'ready' function
            retstr += "}";
            //end createUSMapChart

            retstr += "</script>";
            return retstr;
        }



        //******
        //*Misc*
        //******
        private bool hasParamErrors()
        {

            bool hasErrors = false;

            string url = Request.RawUrl;


            //*Does a QNum parameter exist?*
            if (!url.Contains("?"))
            {
                hasErrors = true;
            }
            else if (!url.ToLower().Contains("qnum"))
            {
                hasErrors = true;
            }
            else if (!url.ToLower().Contains("=q"))
            {
                hasErrors = true;
            }
            if (hasErrors == true)
            {
                return hasErrors;
            }
            else if (hasErrors == false && url.Contains("="))
            {


                //*Check the QNum format*
                string[] splitter = url.Split('=');
                string num = splitter[1].Substring(1, splitter[1].Length - 1).Trim().Split('&')[0].Trim();


                //*Must be a number*
                if (num.Length == 0)
                {
                    hasErrors = true;
                }
                else if (!Utilities.CheckForNumeric(num))
                {
                    hasErrors = true;
                }
            }


            return hasErrors;

        }
        protected string cleanString(string pstr)
        {
            string retstr = pstr;
            Regex rgx = new Regex("[^a-zA-Z0-9]");
            retstr = rgx.Replace(retstr, "");
            return retstr;
        }
        protected string wrapText(string p_str, int startsize)
        {
            string retstr = "";
            int maxloop = 3;

            if (p_str.Length > startsize && p_str.IndexOf(' ') > -1)
            {
                //retstr = p_title.Substring(0, 80) + "<br>" + p_title.Substring(80, p_title.Length - 80);
                string startString = p_str.Substring(0, startsize);
                int index = startString.LastIndexOf(' ');

                string remainingstr = p_str.Substring(index, p_str.Length - index).Trim();
                retstr = startString.Substring(0, index);
                if (remainingstr.Length > startsize)
                {
                    int whileloopcnt = 0;
                    while (remainingstr.Length > startsize)
                    {
                        whileloopcnt++;
                        if (maxloop == whileloopcnt)
                            break;

                        string str = remainingstr.Substring(0, startsize);
                        int sindex = str.LastIndexOf(' ');
                        if (sindex == -1)//no more spaces in the string limited by size
                        {
                            if (remainingstr.LastIndexOf(' ') != -1)//check to make sure that there aren't any more spaces at all
                            {
                                sindex = remainingstr.LastIndexOf(' ');
                                str = remainingstr;
                            }
                            else
                                break;
                        }
                        retstr = retstr + "<br>" + str.Substring(0, sindex).Trim();
                        remainingstr = remainingstr.Substring(sindex); //starting the remaining string off at the last space determined above
                    }

                    retstr = retstr + "<br>" + remainingstr.Trim();
                }
                else
                {
                    retstr = retstr + "<br>" + p_str.Substring(index, p_str.Length - index).Trim();
                }

            }
            else
                retstr = p_str;
            return retstr;
        }
        public static DataTable datableReSort(DataTable dt, string colName, string direction)
        {
            dt.DefaultView.Sort = colName + " " + direction;
            dt = dt.DefaultView.ToTable();
            return dt;
        }



        //***********
        //*Utilities*
        //***********
        private string getYear()
        {
            string answer = "";
            string cy = "";
            string qsYear = "";


            if ((Request.QueryString["Year"] != null))
            {
                qsYear = Request.QueryString["Year"];
            }

            if (StratYear1.CurrentYear != null)
            {
                cy = StratYear1.CurrentYear;
            }


            answer = qsYear;
            if (string.IsNullOrEmpty(answer))
            {
                answer = cy;
            }


            return answer;
        }
        string getTopicURL(string topic)
        {
            string answer = "";

            string lcTopic = topic.ToLower();

            if (lcTopic.Contains("prevalence")) { answer = "<a href='./TopicHome/PrevalenceIncidence.aspx'>" + topic + "</a>"; }
            if (lcTopic.Contains("awareness")) { answer = "<a href='./TopicHome/Awareness.aspx'>" + topic + "</a>"; }
            if (lcTopic.Contains("risk factor")) { answer = "<a href='./TopicHome/BurdenOfRiskFactors.aspx'>" + topic + "</a>"; }
            if (lcTopic.Contains("outcomes")) { answer = "<a href='./TopicHome/HealthConsequences.aspx'>" + topic + "</a>"; }
            if (lcTopic.Contains("quality of care")) { answer = "<a href='./TopicHome/QualityOfCare.aspx'>" + topic + "</a>"; }
            if (lcTopic.Contains("social")) { answer = "<a href='./TopicHome/HealthCareSystemCapacity.aspx'>" + topic + "</a>"; }

            if (lcTopic.Contains("children and adolescents")) { answer = "<a href='./Data.aspx?CategoryID=8#8'>" + topic + "</a>"; }
            if (lcTopic.Contains("solid organ transplant")) { answer = "<a href='./Data.aspx?CategoryID=9#9'>" + topic + "</a>"; }
            if (lcTopic.Contains("native american")) { answer = "<a href='./Data.aspx?CategoryID=14#14'>" + topic + "</a>"; }
            if (lcTopic.Contains("polycystic kidney disease")) { answer = "<a href='./Data.aspx?CategoryID=16#16'>" + topic + "</a>"; }
            if (lcTopic.Contains("emerging topics")) { answer = "<a href='./Data.aspx?CategoryID=22#22'>" + topic + "</a>"; }

            return answer;
        }
        private string getQuintileColorSetting()
        {
            string answer = "y";
            string quintileSetting = "";
            if (Request.QueryString["colors"] != null)
            {
                quintileSetting = Request.QueryString["colors"].ToString().ToLower();

                switch (quintileSetting)
                {
                    case "all":
                        answer = "a";
                        break;
                    case "selected":
                        answer = "y";
                        break;
                }
            }
            else if (Request.QueryString["showMapSlider"] != null)
            {

                //*If this is the slider - it is always all years*
                if (Request.QueryString["showMapSlider"] == "1")
                {
                    answer = "a";
                }
            }

            return answer;
        }
        private string createNavDropDown(string qnum)
        {
            string answer = "";
            StringBuilder sb = new StringBuilder();

            //Get table of non Mega Menu TMIs            
            DataTable dtTMI = getCachedNonMegaMenuTMI();

            //Locate the topic name that this QNum falls under
            string curTopic = "";
            string curIndicatorText = "";
            DataView dv = dtTMI.DefaultView;
            dv.RowFilter = "QNUM='" + qnum + "'";
            curTopic = dv[0]["TopicText"].ToString();
            curIndicatorText = dv[0]["IndicatorText"].ToString();


            //Filter by topic name
            dv.RowFilter = "";
            dv.RowFilter = "TopicText='" + curTopic + "'";


            //build the drop down
            string curMeasure = dv[0]["MeasureText"].ToString();

            sb.Append("<select id='selNavSP' class='nonMMTMISelect form-control' title='" + curIndicatorText + "'>");
            sb.Append("<optgroup label='" + curMeasure + "'>");
            foreach (DataRowView drv in dv)
            {
                string eMeasure = drv["MeasureText"].ToString();
                if (eMeasure.ToLower() == curMeasure.ToLower())
                {
                    //same measure - just get indicator
                    sb.Append("<option value='" + drv["QNUM"].ToString() + "'");

                    if (drv["QNUM"].ToString() == qnum)
                    {
                        sb.Append(" selected='selected' ");
                    }

                    sb.Append(">");

                    sb.Append(drv["IndicatorText"].ToString());
                    sb.Append("</option>");
                }
                else
                {
                    sb.Append("</optgroup>");
                    sb.Append("<optgroup label='" + eMeasure + "'>");
                    sb.Append("<option value='" + drv["QNUM"].ToString() + "'");
                    if (drv["QNUM"].ToString() == qnum)
                    {
                        sb.Append(" selected='selected'");
                    }

                    sb.Append(">");

                    sb.Append(drv["IndicatorText"].ToString());
                    sb.Append("</option>");

                    curMeasure = eMeasure;
                }
            }
            sb.Append("</select>");


            answer = sb.ToString().Trim();
            sb = null;
            dtTMI.Dispose();

            return answer;
        }
        private string buildTMICrumbs(DataTable dtPage)
        {

            string topic = "";
            string measure = "";
            string indicator = "";


            if (dtPage.Rows[0]["Topic"].ToString().ToLower().Contains("healthy people 2020") && dtPage.Rows.Count > 1)
            {
                topic = dtPage.Rows[1]["Topic"].ToString();
                measure = dtPage.Rows[1]["Measure"].ToString();
                indicator = dtPage.Rows[1]["Indicator"].ToString();
            }
            else
            {
                topic = dtPage.Rows[0]["Topic"].ToString();
                measure = dtPage.Rows[0]["Measure"].ToString();
                indicator = dtPage.Rows[0]["Indicator"].ToString();
            }

            string answer = "";
            StringBuilder sb = new StringBuilder();

            sb.Append(">&nbsp;");

            //Topic
            sb.Append("<span class='TMITopic'>");
            sb.Append(getTopicURL(topic));
            sb.Append("</span>");

            sb.Append("&nbsp;>&nbsp;");

            //Measure
            sb.Append("<span class='TMIMeasure'>");
            sb.Append(measure);
            sb.Append("</span>");

            sb.Append("&nbsp;:&nbsp;");

            //Indicator
            sb.Append("<span class='TMIIndicator'>");
            sb.Append(indicator);
            sb.Append("</span>");


            answer = sb.ToString().Trim();

            return answer;
        }
        private int determineChartID(DataTable dtPage)
        {

            int answer = 0;
            DataView dvFiltered = dtPage.DefaultView;

            //*Get values from the URL*
            string yrText = Request.QueryString["Year"];
            string stratText = Request.QueryString["Strat"];

            //*take first row as default if empty*
            if ((string.IsNullOrEmpty(yrText) && string.IsNullOrEmpty(stratText)) || 
                (QNum.ToUpper().StartsWith("S") && !DAL.proc_IsRelatedToAgeSTD(QNum.Replace("S", "Q"), stratText)))
            {
                answer = Convert.ToInt32(dtPage.Rows[0]["chartID"]);
                return answer;
            }


            //**************
            //*Build Filter*
            //**************
            string filterText = "";
            if (!string.IsNullOrEmpty(stratText))
            {
                filterText = "ViewBy IN('" + stratText + "') ";
            }
            if (!string.IsNullOrEmpty(yrText) & !string.IsNullOrEmpty(stratText))
            {
                filterText += "AND Year IN('" + yrText + "')";
            }
            else if (!string.IsNullOrEmpty(yrText) & string.IsNullOrEmpty(stratText))
            {
                filterText = "Year IN('" + yrText + "')";
            }


            //*************
            //*FilterTable*
            //*************
            dvFiltered.RowFilter = filterText;


            //************************
            //*Grab Answer from Table*
            //************************
            DataTable dtAnswer = dvFiltered.ToTable();
            answer = Convert.ToInt32(dtAnswer.Rows[0]["chartID"]);


            //***************
            //*Return Answer*
            //***************
            return answer;
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

            if (num < 1)
                fmt = fmt.Replace("#,###", "#,##0");

            answer = num.ToString(fmt);

            return answer;
        }



        //*********
        //*Caching*
        //*********
        private bool isQNumEnabled()
        {
            bool answer = true;

            DataTable dtQNums = null;

            if (Cache["LegitimateQNUMS"] == null)
            {
                ArborDataAccessV2 DAL = new ArborDataAccessV2();
                dtQNums = DAL.getAllLegitimateQNumbers();

                Cache.Insert("LegitimateQNUMS", dtQNums, null, DateTime.MaxValue, TimeSpan.FromDays(2));
            }
            else
            {
                dtQNums = (DataTable)Cache["LegitimateQNUMS"];
            }

            DataRow[] drs = dtQNums.Select("QNUM='" + QNum + "' AND IndicatorActive=1 AND PageActive=1");

            if (drs.Length == 0)
            {
                answer = false;
            }

            //Clean-up
            dtQNums.Dispose();
            dtQNums = null;
            drs = null;

            return answer;
        }
        private DataTable getCachedNonMegaMenuTMI()
        {
            DataTable answer = null;

            if (Cache["NonMegaMenuTMI"] == null)
            {
                ArborDataAccessV2 DAL = new ArborDataAccessV2();
                answer = DAL.getAllNonMegaMenuTMI().Tables[0];

                if (answer != null)
                {
                    Cache.Insert("NonMegaMenuTMI", answer, null, DateTime.MaxValue, TimeSpan.FromDays(2));
                }
            }
            else
            {
                answer = (DataTable)Cache["NonMegaMenuTMI"];

            }

            return answer;
        }
        private DataTable getCachedPageData(string QNUM)
        {
            DataTable answer = null;

            if (Cache["getPage"] != null)
            {
                answer = (DataTable)Cache["getPage"];
                DataRow[] drs = answer.Select("QNUM='" + QNUM + "'");

                if (drs.Length > 0)
                {
                    answer = drs.CopyToDataTable();
                }
                else if (drs.Length == 0)
                {
                    //Get new data
                    ArborDataAccessV2 DAL = new ArborDataAccessV2();
                    DataTable dtPage = DAL.getPage(QNUM).Tables[0];

                    DataColumn dc1 = new DataColumn("QNUM", typeof(string));
                    dtPage.Columns.Add(dc1);
                    dtPage.AcceptChanges();

                    foreach (DataRow dr in dtPage.Rows)
                    {
                        dr["QNUM"] = QNUM;
                    }
                    dtPage.AcceptChanges();


                    //Reset the answer table and Cache
                    //answer = (DataTable)Cache["getPage"];
                    //if (answer != null)
                    //{
                    //    answer.Merge(dtPage);
                    //    Cache["getPage"] = answer;
                    //}

                    //Use what we just got
                    //answer = dtPage;

                    if (dtPage != null)
                    {
                        Cache.Insert("getPage", dtPage, null, DateTime.MaxValue, TimeSpan.FromDays(2));
                        answer = dtPage;
                    }

                    //clean-up
                    dtPage.Dispose();
                    dtPage = null;
                }
            }
            else
            {
                //**********
                //*No Cache* - First time only
                //**********
                ArborDataAccessV2 DAL = new ArborDataAccessV2();
                DataTable dtPage = DAL.getPage(QNUM).Tables[0];

                DataColumn dc1 = new DataColumn("QNUM", typeof(string));
                dtPage.Columns.Add(dc1);
                dtPage.AcceptChanges();

                foreach (DataRow dr in dtPage.Rows)
                {
                    dr["QNUM"] = QNUM;
                }
                dtPage.AcceptChanges();

                if (dtPage != null)
                {
                    Cache.Insert("getPage", dtPage, null, DateTime.MaxValue, TimeSpan.FromDays(2));
                    answer = dtPage;
                }

                //clean-up
                dtPage.Dispose();
                dtPage = null;
            }


            return answer;
        }
        private DataTable getCachedDataSourcesFromIndicatorCode(string QNUM)
        {
            DataTable answer = null;

            if (Cache["DataSources"] != null)
            {
                answer = (DataTable)Cache["DataSources"];
                DataView dv = answer.DefaultView;

                //Clear row filter so as to reduce confusion
                dv.RowFilter = "";

                //Add new row filter
                dv.RowFilter = "QNum='" + QNUM + "'";


                if (dv.Count > 0)
                {
                    //Found it - it exists already
                    DataTable dtTemp = dv.ToTable();

                    //Get Any others that are associated with that same indicator
                    int indicatorID = (int)dtTemp.Rows[0]["IndicatorID"];

                    dv.RowFilter = "";
                    dv.RowFilter = "IndicatorID=" + indicatorID.ToString();

                    answer = dv.ToTable();

                    //Clean-up
                    dtTemp.Dispose();
                    dtTemp = null;
                }
                else
                {
                    //Does not exist yet - just add the new one(s) to the cache
                    ArborDataAccessV2 DAL = new ArborDataAccessV2();
                    DataTable tempAnswer = DAL.getDatasourcesFromIndicatorCode(QNum);

                    //Add this data source to the Cached table
                    if (tempAnswer != null)
                    {
                        answer.Merge(tempAnswer);
                        Cache["DataSources"] = answer;

                        //But, for this query, just want this one question's data source
                        answer = tempAnswer;
                    }

                    //Clean-up
                    DAL = null;
                    tempAnswer.Dispose();
                    tempAnswer = null;
                }
            }
            else
            {
                //Look up this data source
                ArborDataAccessV2 DAL = new ArborDataAccessV2();
                DataTable dtDataSources = DAL.getDatasourcesFromIndicatorCode(QNum);

                if (dtDataSources != null)
                {
                    //Cache this data source
                    Cache.Insert("DataSources", dtDataSources, null, DateTime.MaxValue, TimeSpan.FromDays(2));

                    //Set the answer to the be this data source
                    answer = dtDataSources;
                }

                //Clean-up
                DAL = null;
                dtDataSources.Dispose();
                dtDataSources = null;
            }

            return answer;
        }

        private double RefValue(string QNum)
        {
            var refVal = 0.0;
            switch (QNum.ToLower())
            {
                case "q729":
                    refVal = 12.8;
                    break;
                case "q731":
                    refVal = 10.0;
                    break;
                case "q751":
                    refVal = 66.4;
                    break;
                case "q754":
                    refVal = 55.4;
                    break;
            }
            return refVal;
        }

        private void populateYearsDropDown(DataTable yearTable)
        {

            if (yearTable.Rows.Count == 1)
            {
                return;
            }

            StringBuilder sb = new StringBuilder();

            sb.Append("<div class=\"chartMapMenuLabel\">Select Data Year</div>");
            sb.Append("<select class=\"form-control\"  onchange=\"openViewDataBy(this.value);\" aria-label=\"Select Data Year\">");

            foreach (DataRow dr in yearTable.Rows)
            {
                if (Convert.ToInt32(dr["selected"]) != 1)
                {
                    sb.Append("<option value='" + dr["link"].ToString().Replace("~/", "").Trim() + "'>");
                    sb.Append(dr["Year"].ToString().Trim());
                    sb.Append("</option>");

                }
                else if (Convert.ToInt32(dr["selected"]) == 1)
                {
                    sb.Append("<option selected>" + dr["Year"].ToString().Trim() + "</option>");
                }

            }
            sb.Append("</select>");

            litYearText.Text = sb.ToString().Trim();
            parentpnlYears.Visible = true;
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
            populateYearsDropDown(yrTableFiltered);


            //*populate hiddenfield of years for the jQuery slider to reference*
            string yrsCSV = "";
            yrDV.Sort = "StratificationDisplayOrder DESC";
            DataTable tempYrDT = yrDV.ToTable();
            foreach (DataRow dr in tempYrDT.Rows)
            {
                yrsCSV += dr["Year"].ToString() + ",";
            }
            yrsCSV = yrsCSV.TrimEnd(',', ' ');
            //hfCSVYears.Value = yrsCSV;


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

            //(Example) -->  /ckd/detailButtons.aspx?Qnum=Q380
            string chosenStrat = "";
            string chosenYear = "";
            string topic = "";

            if (url.Contains("&Strat"))
            {
                chosenStrat = Request.QueryString["Strat"].Trim().Replace("%20", " ").Trim();
                //CurrentStrat = chosenStrat;
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

                //CurrentStrat = dt.Rows[0]["ViewBy"].ToString().Trim();
            }

        }

        private void updateYearRows(DataTable dt, string selStrat)
        {
            string qNum = Request.QueryString["QNum"].Trim().ToUpper();
            string url = Request.RawUrl;
            //(Example) -->  /ckd/detailButtons.aspx?Qnum=Q380
            string chosenStrat = "";
            string chosenYear = "";
            string topic = "";

            //*Read URL for Params*
            if (url.Contains("&Strat"))
            {
                chosenStrat = Request.QueryString["Strat"].Trim().Replace("%20", " ").Trim();
                //CurrentStrat = chosenStrat;
            }
            if (url.Contains("&Year"))
            {
                chosenYear = Request.QueryString["Year"].Trim().Replace("%20", " ").Trim();
                //CurrentYear = chosenYear;
            }
            if (url.Contains("&topic"))
            {
                topic = Request.QueryString["topic"].Trim().Replace("%20", " ").Trim();
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
                    var qNumTopic = qNum;
                    if (!string.IsNullOrEmpty(topic))
                    {
                        qNumTopic = qNum + "&topic=" + topic;
                    }

                    dr["selected"] = 0;
                    dr["buttonLink"] = "~/images/GO.png";
                    dr["Link"] = "~/detail.aspx?Qnum=" + qNumTopic + "&Strat=" + HttpUtility.UrlEncode(dr["ViewBy"].ToString().Trim()) + "&Year=" + HttpUtility.UrlEncode(dr["Year"].ToString().Trim()) + "#refreshPosition";
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

        protected string SanitizeHtml(string html)
        {
            html = System.Web.HttpUtility.HtmlDecode(html);

            List<string> blackListedTags = new List<string>()
            {
                    "body", "script", "iframe", "form", "object", "embed", "link", "head", "meta"
            };

            foreach (string tag in blackListedTags)
            {
                html = Regex.Replace(html, "<" + tag, "<p", RegexOptions.IgnoreCase);
                html = Regex.Replace(html, "</" + tag, "</p", RegexOptions.IgnoreCase);
            }

            //*Scrub for SQL*
            List<string> blackListedSQL = new List<string>()
            {
                "insert", "select", "delete", "update", "drop", "truncate", "join", "backup", "dbreindex", "dbcc", "create", "alter", ";", "database", "table", "*", "from"
            };

            foreach (string word in blackListedSQL)
            {
                int index = html.IndexOf(word, StringComparison.OrdinalIgnoreCase);
                if (index >= 0)
                {
                    html = html.Remove(index, word.Length);
                }
            }

            return html;
        }
    }
}
