<%@ Page Title="" MaintainScrollPositionOnPostback="true" Language="C#" MasterPageFile="~/MasterPages/ResponsiveContentLeftNavNew.Master" AutoEventWireup="true" CodeBehind="Detail.aspx.cs" Inherits="CKDSurveillance_RD.MasterPages.Detail" %>

<%@ Register Src="~/UserControls/StratYearsLinks.ascx" TagPrefix="uc1" TagName="StratYearsButtons" %>
<%@ Register Src="~/UserControls/FAQGlossaryControl.ascx" TagPrefix="uc1" TagName="FAQGlossaryControl" %>
<%@ Register Src="~/UserControls/RDVersions/StratYearsRD.ascx" TagPrefix="uc1" TagName="StratYearsRD" %>
<%@ Register Src="~/UserControls/RDVersions/DataSourceDDLsRD.ascx" TagPrefix="uc1" TagName="DataSourceDDLsRD" %>
<%@ Register Src="~/UserControls/Navigation/SideNav.ascx" TagPrefix="uc1" TagName="SideNav" %>
<%@ Register Src="~/UserControls/StratYearsLinksMaps.ascx" TagPrefix="uc1" TagName="StratYearsLinksMaps" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="App_Themes/RSWidgets.css" rel="stylesheet" />
    

<%--*Ion Range Slider CSS*--%>
    <link href="App_Themes/ion.rangeSlider.css?val=1" rel="stylesheet" />
    <link href="App_Themes/ion.rangeSlider.skinHTML5.css?val=1" rel="stylesheet" />

    <script src="scripts/d3.v4.min.js" type="text/javascript"></script>
    <script src="scripts/D3MapFiles/topojson.v1.min.js" type="text/javascript"></script>

    <%--*Ion Range Slider JS*--%>
    <script src="scripts/ion.rangeSlider.js" type="text/javascript"></script>

    <%--*Plotly Charting Tool*--%>
    <script src="scripts/plotly-latest.min.js"></script>
    <script src="scripts/LinkedMap.js"></script>

    <link href="css/LinkedMap.css" rel="stylesheet" />

   <script src="Scripts/bootstrap.min.js"></script>

    <%--*Temp CSS*--%>
    <asp:Literal ID="litCSS" runat="server" ClientIDMode="Static"></asp:Literal>

    <%--*****************************--%>
    <%--*D3 Map styles*--%>
    <%--*****************************--%>
     <style>
        .outline {
            fill: none;
            stroke: #000;
            stroke-width: 1.5px;
        }

        .feature {
            fill: #ccc;
        }

        .mesh {
            fill: none;
            stroke: #fff;
            stroke-width: .5px;
            stroke-linejoin: round;
        }

        .county:hover {
            fill: orange;
        }

        #states:hover {
            fill: blue;
        }

        .county {
            fill: #fef3cf;
            stroke: #111;
        }

        div.hovertooltip {
            position: absolute;
            text-align: left;
            min-width: 100px;
            height: 55px;
            padding: 6px;
            font: bold 12px Nunito !important; /*sans-serif*/
            background: #fefefe;
            border: 3px solid orange;
            border-radius: 8px;
            pointer-events: none;
            display: none;
            opacity: 1;
        }

        .countymapsvg {
            padding-top: 5px;
        }

        .datastatelabel {
            color: navy;
            font-weight: bold;
        }

        .datacountylabel {
            display: none;
            color: navy;
            font-weight: bold;
        }

        .datavaluelabel {
            display: none;
            color: navy;
            font-weight: bold;
        }

        .upperlegend {
            font-weight: bold;
            font-size: 10pt;
            font-family: Arial;
        }

        .lowerlegend {
            font-weight: bold;
            font-size: 10pt;
            font-family: Arial;
        }

         .maptitletext {
            font-weight: bold;
            font-size: 10pt;
            font-family: Arial;
        }

         .countymaptitletext
         {
             font-weight: bold;
            font-size: 8pt;
            font-family: Arial;
         }

         .btnzoomout
         {
            width:130px;
         }

         .btnzoom
         {
            width:60px;
         }

        .stateddclass
        {
            border: 2px solid orange;
        }
				
				.relatedModuleWrap ul
				{
					margin-left: 0px !important;
				}

         .downloadbutton {
              font-size: 8pt;
            font-family: Arial;
            width:120px;
         }

         .imgtablewrapper {
            position: relative;
         }
         .imgtable {
            display: table;
         }
         .imgrow {
            display: table-row;
         }
         .imgcell {
              display: table-cell;
         }
         .imgcell.empty
         {
              border: none;
              width: 100px;
         }
         .imgcell.rowspanned {
              position: absolute;
              top: 10%;
              bottom: 0;
              padding-left:10%;
              vertical-align:central;
         }
         .imgspan {
             font-size:16px;
         }
         .imgsize-ab {
             width:900px;
             height:700px;
         }
         .imgsize-c {
             max-width:650px;
         }
         .imgsize-d {
             max-width:850px;
             height:auto;
         }

         .topicDescDiv {
            text-align: left;
            font: normal normal normal 17px/24px Nunito;
            letter-spacing: 0px;
            color: #000000;
            margin-top:20px;
            margin-bottom: 20px;
         }

         .spnDataSource {
            text-align: left;
            font: normal normal 600 17px/24px Nunito;
            letter-spacing: 0px;
            color: #000000;
         }
         .homebreadcrumb{
			text-align: left;
			text-decoration: underline;			
			letter-spacing: 0px;
			color: #005EAA;
			font-family: Nunito;
			font-size:14px;
		}
		.bodybreadcrumb{
			text-align: left;			
			font-family: Nunito;
			font-size:14px;
			letter-spacing: 0px;
			color: #000000;
		}
         .chartInstruction {
            background: #f6fbff 0% 0% no-repeat padding-box;
            opacity: 1;
            padding:5px;
         }

         .chartInstructionText {
            font: normal normal normal 17px/24px Nunito;
            letter-spacing: 0px;
            color: #000000;
            opacity:1;
            margin:15px;
         }

         .spnRiskCategory {
            text-align: left;
            font: normal normal 600 17px/24px Nunito;
            letter-spacing: 0px;
            color: #005ea2; /*#00695C;*/
         }

         #svgchart {
            opacity: 1;
            transition: opacity 3s linear 3s, opacity 3s;
         }

         #svgchartRel {
            opacity: 0;
            transition: opacity 3s linear 3s, opacity 3s;
         }

    </style>

    <%--*****************************--%>
    <%--*END D3 Map styles*--%>
    <%--*****************************--%>


    <%--*General Page CSS*--%>
    <link href="css/DetailCSS.css" rel="stylesheet" />
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">

    <%--*****************************--%>
    <%--*Modal overlay for page load*--%>
    <%--*****************************--%>
    <div class="modal" id="OverlayModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" style="width: 300px; height: 300px; align-content: center; text-align: center;">
            <div class="modal-content">
                <div class="modal-body form-horizontal" style="text-align: center; overflow-x: hidden; align-content: center; ">
                    <div class="form-group">
                        <h3 style="font-family:Poppins !important;">Loading</h3> <%--*H3 font set locally since it is subject to bootstrap and app.css, and page, etc.*--%>
                        <img id="imgPageLoadingGif" src="images/LoadSwirl.gif" alt="page loading image" />
                    </div>
                </div>
            </div>
        </div>
    </div>


    <script type="text/javascript">
        //*Show the loading overlay on page load for all maps*
        var urlVal = window.location.href;
        var shouldShow = false;

        if (urlVal.indexOf('Q69') > 0) {
            shouldShow = true;
        } else if (urlVal.indexOf('Q96') > 0) {
            shouldShow = true;
        } else if (urlVal.indexOf('Q235') > 0) {
            shouldShow = true;
        } else if (urlVal.indexOf('Q600') > 0) {
            shouldShow = true;
        }

        if (shouldShow == true) {
            $('#OverlayModal').modal('show');
        } else {
            $('#OverlayModal').modal('hide');
            $('.modal').hide();
        }
    </script>



    <div id="top-container">

    </div>

    <br />

    <div id="bottom-container" class="container d-flex flex-wrap body-wrapper bg-white">


        <%--*Topic, Measure, Indicator Breadcrumbs*--%>
        <asp:HiddenField ID="hfTMITopicname" ClientIDMode="Static" runat="server" />
        <asp:HiddenField ID="hfCategoryID" ClientIDMode="Static" runat="server" />
        <asp:HiddenField ID="hfTMIMeasurename" ClientIDMode="Static" runat="server" />
        <asp:HiddenField ID="hfTMIIndicatorname" ClientIDMode="Static" runat="server" />
        <asp:HiddenField ID="hfChartOrTable" ClientIDMode="Static" runat="server" Value="c" />
        <asp:HiddenField ID="hfChartType" runat="server" />
        <asp:HiddenField ID="hfChartMode" runat="server" />
        <asp:HiddenField ID="hfChartColor" runat="server" />
        <asp:HiddenField ID="hfShowCI" runat="server" />
        <asp:HiddenField ID="hfMapType" runat="server" />
        <asp:HiddenField ID="hfCurrentYear" runat="server" />
        <asp:HiddenField ID="hfChartID" runat="server" />
        <asp:HiddenField ID="hfMaxYVal" runat="server" />        
        <asp:HiddenField ID="hfMaxStackedYVal" runat="server" />     
        <asp:HiddenField ID="hfMaxConfidence" runat="server" />        
        <asp:HiddenField ID="hfChartYValToUse" runat="server" />  

        <asp:HiddenField ID="HF_TopicText" runat="server" />


        <%--*********************--%>
        <%--*RD Data Sources DDL*--%>
        <%--*********************--%>
      
        <span style="height: .2em;">&nbsp;</span>

        <%--*Strats and Years DDL*--%>
      
        <uc1:StratYearsRD runat="server" ID="StratYearsRD1" Visible="false"/>

       

        <%--************************--%>
        <%--*Charts / Maps / Tables*--%>
        <%--************************--%>
        <div class="row">
            <div id="divStratsCharts" class="col-lg-12">                               

                <div class="row">

                    


                    <%--**********************--%>
                    <%--*Left Column Material*--%>
                    <%--**********************--%>

                    <%--************************--%>
                    <%--*Center Column Material*--%>
                    <%--************************--%>
                    <section id="PImainbody"   class="col-xl-9 order-xl-2"  role="main" aria-label="Main Content Area">
                        <div class="cdc-2020-bar container" style="padding-bottom:25px !important; padding-left:0px !important">
								<div class="row no-gutters">
									<div class="bar-item">
											<a href="default.aspx"  style="border-top:#2B8277" id="ckd-nav-home-link3" class="ckd-nav-home-link">										
											<span class="homebreadcrumb"><u>Home</u></span> </a> 
                                            >
										    <a class="bodybreadcrumb" style="border-top:#2B8277; text-decoration: none;" id="bcTopicLink" runat="server" ></a>  <%--selected topic from top nav --%>
											>
                                            <span id="bcMeasure" class="bodybreadcrumb" runat="server">  </span>  <%--selected list item from left nav --%>
                                            <span id="bcIndicator" class="bodybreadcrumb" runat="server">  </span>  <%--selected list item from left nav --%>
									</div>
								</div>
						</div>

                        <div id="divCenter">
                        <h1 class="IndicatorPagetitle" style="font-family: Poppins;">
                            <asp:Literal ID="litTopic" runat="server" Text="" />
                        </h1>
                        <span class="IndicatorPagetitle showPhoneOnly">
                            <asp:Literal ID="litTopicMobile" runat="server" Text="" />
                        </span>

                        <div class="topicDescDiv">
                            <asp:Literal ID="litTopicDesc" runat="server" Text="" />
                        </div>
                        
                        <div class="topicDescDiv" id="divDataSource" runat="server">
                            <span class="spnDataSource">Data Source: </span><asp:Literal ID="litDataSource" runat="server" Text="" />
                        </div>

                        <div class="chartInstruction" runat="server" id="divChartInstruction">
                            <div class="chartInstructionText">
                                <asp:Literal ID="litChartInstruction" runat="server" Text="" />
                            </div>
                        </div>

                        <hr style="border: 1px solid #C3C3C3; opacity: 0.42;margin-top: 1px !important;" />
                        <%--*Chart Title*--%>

                        <div class="IndicatorSubPagetitle">
                            <asp:Literal ID="litChartTitleText" runat="server" Text="" Visible="true"></asp:Literal>  <%--Text="Big Bold Chart Title"--%>
                        </div>
                        <asp:Literal ID="litDDLMeasInd" ClientIDMode="Static" runat="server"></asp:Literal>
                        <asp:Literal ID="litChartSubTitleText" runat="server" Text="Subtitle of Data source Name" Visible="false"></asp:Literal>
  

                        <%--********--%>
                        <%--*Slider*--%>
                        <%--********--%>
                        <asp:Panel ID="sliderWrapper" runat="server" class="sliderWrapperDiv" ClientIDMode="Static" Visible="false">

                            <table style="width: 100%; align-content: center; text-align: center;">
                                <tr>
                                    <td>

                                        <%--******************************--%>
                                        <%--*Slider using ion.rangeslider*--%>
                                        <%--******************************--%>
                                        <label for="mapSlider" style="height: 1px;">&nbsp;</label>
                                        <input type="text" id="mapSlider" name="mapSliderControl" value="" style="max-width: 750px;" />

                                        <br />
                                    </td>
                                </tr>
                            </table>

                            <table width="95%" style="text-align: center; margin-top: 5px;">
                                <tr>
                                    <td></td>
                                    <td>
                                        <img id="imgPrevMap" class="MapAnimationButtons MapAnimationPrev" src="images/Rewind.png" onclick="changeMap('prev');" title="Animate Maps Backward" alt="Animate the map backward one year" />
                                        <img id="imgPlayStop" class="MapAnimationButtons MapAnimationPlayPause" src="images/PLAY.png" onclick="TogglePlayStop($(this).attr('id')); sliderAnimateForward(0);" alt="Start or stop the map animation" />
                                        <img id="imgNextMap" class="MapAnimationButtons MapAnimationNext" src="images/Fast_Forward.png" onclick="changeMap('next');" title="Animate Maps Forward" alt="Animate the map forward one year" />
                                    </td>
                                    <td></td>
                                </tr>
                            </table>

                            <br />

                        </asp:Panel>

                        <%--*********************--%>
                        <%--*Begin Charts / Maps*--%>
                        <%--*********************--%>
                        
                        <asp:Panel ID="pnlPlotly" runat="server" ClientIDMode="Static">

                                <%--************************--%>
                                <%--*  BEGIN Plotly Chart  *--%>
                                <%--************************--%>

                                <style>
            
                                    /*hiding Plotly specific tool bar items*/
                                    a[data-title="Save and edit plot in cloud"] { 
                                        display:none;
                                    }

                                        a[data-title="Produced with Plotly"]:before {
                                        content: "Text";
                                    }

                                    .js-plotly-plot .plotly .modebar-btn.modebar-btn--logo {
                                        display:none;
                                    }

                                    .modebar-btn tp-link-policy {
                                        background-color:none !important;
                                    }

                                    .legend {
                                        padding-top:10px;
                                    }
                                    
                                    .svgchartclass{
                                        max-height:800px !important;
                                    }

                                    .chartToolDiv {
                                        position: absolute;
                                        left:65%;
                                    }
                                    
                                    .chartDownloadBtn {
                                        margin-bottom: 3px;
                                        background-image: url("images/CommonControls/download_csv_sm.png");
                                        background-repeat: no-repeat;
                                        background-position: 6px 10px !important;
                                        padding-left: 32px;
                                    }

                                    .chartDropDown {
                                        margin-left:10px;                                     
                                    }

                                    .iconPPTBtn {
                                        margin-bottom: 3px;
                                        background-image: url("images/CommonControls/power-point-icon.png");
                                        background-repeat: no-repeat;
                                        background-position: 7px 10px !important;
                                        padding-left: 40px;
                                        text-align:center;
                                        vertical-align:bottom;
                                        padding-top:10px;
                                    }
                                    .ppt-icon{
                                        font-size:14px;
                                    }

                                    .viewDataBy {
                                        background: /*#00695C*/ #005ea2 0% 0% no-repeat padding-box;
                                        opacity: 1;
                                        width: 362px;
                                        height: 96px;
                                        padding-top: 10px;
                                        padding-left: 25px!important;
                                        padding-right: 25px!important;
                                        border-radius: 5px;
                                    }

                                    .viewDataByLabel {
                                        text-align: left;
                                        font: normal normal bold 17px/20px Nunito;
                                        letter-spacing: 0px;
                                        color: #FFFFFF;
                                        opacity: 1;
                                        margin-bottom: 5px;
                                        margin-left:-15px !important;
                                    }
                                    
                                    .menu-content div{
                                        display:inline-table;
                                        padding-left: 5px; /*15px;*/
                                        padding-right: 5px; /*15px;*/
                                    }
                                    .menu-content{
                                        background-color: var(--colors-blue-cool-vivid-5);
                                        opacity: 1;
                                        margin-left: 2px;
                                        margin-right: 2px;      
                                        display: flex;
                                        align-items: center;
                                    }
                                    .menu-content-menu {
                                        margin-left: 2px;
                                        margin-right: 2px;
                                        vertical-align:sub;
                                        margin-right: 0;
                                    }
                                    .moveright {
                                        display: flex;
                                        justify-content: flex-end;
                                        margin-right: 0;
                                        padding-left: 1px;
                                        padding-right: 1px;
                                        width: 52%;
                                    }

                                    @media (max-width: 767px) {
                                        .chartDropDown {
                                            margin-left:-15px;
                                        }

                                        .ccolstyle {
                                            padding-top: 1px;
                                            padding-bottom: 1px;
                                        }

                                        .menu-content{
                                            display:inline-block;
                                            height: auto;
                                            width:100%;
                                        }
                                        .menu-content div{
                                            display:block;
                                            text-align:center;
                                        }
                                        .menu-content-menu {
                                            height: auto;
                                            margin-left: 2px;
                                            margin-right: 2px;
                                        }
                                        .chartToolDiv {
                                            position: relative;
                                            left:auto;
                                            padding-top:2px!important;
                                        }
                                    }
                                </style>

                            <div class="menu-content " id="divMenuContent" style="padding-top:5px;padding-bottom:5px; display: flex; justify-content: flex-end">

                                <%--*View Data By*--%>
                                 <uc1:StratYearsButtons runat="server" ID="StratYear1" />                                
                                 <div class="menu-content-menu" style="width:40%">
                                    <asp:CheckBox ID="CB_ChartCI" CssClass="checkBoxList chartMenuLabel col" Text="95% Confidence Intervals" runat="server" aria-label="95% Confidence Intervals"/>
                                </div>
                                <%-- View as table--%>
                                <div class="menu-content-menu moveright" id="divMenuData" style="margin-left:5%">
                                    <div class="custom-control custom-switch" id="btnViewAsTable" runat="server" >
                                        <input type="checkbox" class="custom-control-input" id="chViewTable"  onclick="toggleChartTable()">
                                        <label class="custom-control-label chartMenuLabel viewTableBtnLabel" for="chViewTable" >View as table</label>
                                    </div>
                                    <%-- Download --%>
                                    <div>
                                        <label class="chartMenuLabel">Download:</label>
                                        <asp:Button ID="csvDownload" CssClass="noPrint btn cdc-icon-download_01 chartDownloadBtn chartMenuLabel" style="font-size:17px" runat ="server" Text="CSV" Visible="true" OnClick="lnkDownloadBottom_Click" class="cdc-icon-download_01 chartMenuLabel">
                                        </asp:Button>
                                        <a href="." runat="server" id="lnkCSV" style="text-decoration:none!important" visible="false">
                                            <span class="noPrint btn chartDownloadBtn">csv</span>
                                        </a>
                                        <a href="." runat="server" id="lnkPPT" style="text-decoration:none!important">
                                            <span class="noPrint btn ppt-icon iconPPTBtn chartMenuLabel">PPT</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                                <div style="width:50%;margin:auto;text-align: center!important;" runat="server" id="divRBSTD" class="chartMenuLabel">  
                                    <fieldset><legend></legend>
                                    <input type="radio" id="rbstd1" value="1" name="rbstd" runat="server" checked />
                                    <label for="rbstd1" id="lblrbstd1" runat="server"></label>
                                    <input type="radio" id="rbstd2" value="2" name="rbstd" runat="server"/>
                                    <label for="rbstd2" id="lblrbstd2" runat="server"></label><br>
                                    </fieldset>
                                </div>
                            <div>
                            </div>
                            <div class="row" id="divMapMenu" runat="server">                                
                                <div class="col-3 chartMapMenu">
                                    <div  for="ddstate" class="chartMapMenuLabel">Select by State</div>
                                        <select id="ddstate" class="form-control" aria-label="Select by State" style="appearance:auto">
                                            <option value="select">Select a state</option>
                                            <option value="01">Alabama</option>
                                            <option value="02">Alaska</option>
                                            <option value="04">Arizona</option>
                                            <option value="05">Arkansas</option>
                                            <option value="06">California</option>
                                            <option value="08">Colorado</option>
                                            <option value="09">Connecticut</option>
                                            <option value="10">Delaware</option>
                                            <option value="11">District of Columbia</option>
                                            <option value="12">Florida</option>
                                            <option value="13">Georgia</option>
                                            <option value="15">Hawaii</option>
                                            <option value="16">Idaho</option>
                                            <option value="17">Illinois</option>
                                            <option value="18">Indiana</option>
                                            <option value="19">Iowa</option>
                                            <option value="20">Kansas</option>
                                            <option value="21">Kentucky</option>
                                            <option value="22">Louisiana</option>
                                            <option value="23">Maine</option>
                                            <option value="24">Maryland</option>
                                            <option value="25">Massachusetts</option>
                                            <option value="26">Michigan</option>
                                            <option value="27">Minnesota</option>
                                            <option value="28">Mississippi</option>
                                            <option value="29">Missouri</option>
                                            <option value="30">Montana</option>
                                            <option value="31">Nebraska</option>
                                            <option value="32">Nevada</option>
                                            <option value="33">New Hampshire</option>
                                            <option value="34">New Jersey</option>
                                            <option value="35">New Mexico</option>
                                            <option value="36">New York</option>
                                            <option value="37">North Carolina</option>
                                            <option value="38">North Dakota</option>
                                            <option value="39">Ohio</option>
                                            <option value="40">Oklahoma</option>
                                            <option value="41">Oregon</option>
                                            <option value="42">Pennsylvania</option>
                                            <option value="44">Rhode Island</option>
                                            <option value="45">South Carolina</option>
                                            <option value="46">South Dakota</option>
                                            <option value="47">Tennessee</option>
                                            <option value="48">Texas</option>
                                            <option value="49">Utah</option>
                                            <option value="50">Vermont</option>
                                            <option value="51">Virginia</option>
                                            <option value="53">Washington</option>
                                            <option value="54">West Virginia</option>
                                            <option value="55">Wisconsin</option>
                                            <option value="56">Wyoming</option>
                                        </select>
                                </div>
                                <div class="col-2 chartMapMenu" runat="server" id="parentpnlYears" visible="false">
                                    <asp:Panel ID="pnlYears" runat="server">

                                    <%--*******--%>
                                    <%--*Years*--%>
                                    <%--*******--%>
                                    <asp:Literal ID="litYearText" runat="server" Text='<%# Eval("Year") %>'></asp:Literal>

                                    </asp:Panel>
                                </div>
                                <div id="divzoombtn" style="margin-left: 70%;">
                                    <button  class="noPrint btn btn-blue btnzoomout" id="btnreset" type="button" runat="server">Zoom out</button>
                                </div>
                            </div>

                            <div id="divPlotly" class="ChartArea">
                                    <asp:Literal ID="Lit_Plotly" runat="server" ></asp:Literal>
                                    <div id="svgchart" vis="1"></div>
                                    <asp:Literal ID="Lit_PlotlyRel" runat="server" ></asp:Literal>
                                    <div id="svgchartRel" vis="0" ></div>
                            </div>


                            <script>
                                function initChartRadioButton() {
                                    const currentUrl = window.location.href;

                                    const url = new URL(currentUrl);

                                    const params = url.searchParams;

                                    const paramrbstd = params.get('rbstd'); 
                                    if (paramrbstd != null) {
                                        console.log(`Radio Button: ${paramrbstd}`); 

                                        const radioButtons = document.querySelectorAll('input[type="radio"][name*="rbstd"]');

                                        // Loop through and select the one with value 'Option 2'
                                        for (const radioButton of radioButtons) {
                                            console.log(`radioButton for loop: ${radioButton.value}`);                                             

                                            if (radioButton.value === paramrbstd) {
                                                console.log(`radioButton.value: ${paramrbstd}`); 
                                                radioButton.checked = true; // Selects the radio button
                                                break; // Stop loop after selecting
                                            }
                                        }

                                        if (paramrbstd === "1") {
                                            $("#svgchart").show(); 
                                            $("#svgchartRel").hide();
                                            $('#divData').show();
                                            $('#divDataRel').hide();

                                            var svgchartRel = document.getElementById("svgchartRel");
                                            svgchartRel.style.opacity = "0";
                                            var svgchart = document.getElementById("svgchart");
                                            svgchart.style.opacity = "1";

                                            redrawPlotlyChart();

                                        } else if (paramrbstd === "2") {
                                            $("#svgchart").hide();
                                            $("#svgchartRel").show();
                                            $('#divData').hide();
                                            $('#divDataRel').show();

                                            var svgchartRel = document.getElementById("svgchartRel");
                                            svgchartRel.style.opacity = "1";
                                            var svgchart = document.getElementById("svgchart");
                                            svgchart.style.opacity = "0";

                                            redrawPlotlyChart();
                                        }
                                    }
                                }

                                function initStdChartTable() {
                                    $("#svgchart").show(); // Select the first radio button
                                    $("#svgchartRel").hide();
                                    $('#divData').show();
                                    $('#divDataRel').hide();

                                    const radioButtons = document.querySelectorAll('input[type="radio"][name*="rbstd"]');

                                    radioButtons.forEach((radio) => {
                                        radio.addEventListener('click', () => {
                                            if (radio.value === "1") {
                                                $("#svgchart").show(); // Select the first radio button
                                                $("#svgchartRel").hide();
                                                $('#divData').show();
                                                $('#divDataRel').hide();

                                                var svgchartRel = document.getElementById("svgchartRel");
                                                svgchartRel.style.opacity = "0";
                                                var svgchart = document.getElementById("svgchart");
                                                svgchart.style.opacity = "1";

                                                redrawPlotlyChart();

                                            } else if (radio.value === "2") {
                                                $("#svgchart").hide(); // Select the first radio button
                                                $("#svgchartRel").show();
                                                $('#divData').hide();
                                                $('#divDataRel').show();

                                                var svgchartRel = document.getElementById("svgchartRel");
                                                svgchartRel.style.opacity = "1";
                                                var svgchart = document.getElementById("svgchart");
                                                svgchart.style.opacity = "0";

                                                redrawPlotlyChart();
                                            }
                                        });
                                    });
                                }

                                function toggleChartTable() {
                                    var checkBox = document.getElementById("chViewTable");

                                    if (checkBox.checked == true) {
                                        $('#divPlotly').hide();
                                        $('#pnlD3MapsTabs').hide();
                                        $('#map').hide();
                                        toggleTable();
                                    } else {
                                        $('#divPlotly').show();
                                        if ($('#hfMapType').val() == "6")
                                            $('#pnlD3MapsTabs').show();
                                        $('#map').show();
                                        toggleTable();
                                    }

                                    redrawPlotlyChart();
                                }
                                $(function () {

                                    compliance508();

                                })

                                function compliance508() {
                                    $('.modebar-group').each(function () {
                                        $(this).find('[data-title="Produced with Plotly"]').remove();//removing this anchor tag so that Plotly becomes 508 compliant.
                                    });

                                    //adding tabindex
                                    $('a[data-title="Download Chart as PNG"]').attr("tabIndex", 0);
                                    $('a[data-title="Zoom"]').attr("tabIndex", 0);
                                    $('a[data-title="Pan"]').attr("tabIndex", 0);
                                    $('a[data-title="Zoom in"]').attr("tabIndex", 0);
                                    $('a[data-title="Zoom out"]').attr("tabIndex", 0);
                                    $('a[data-title="Autoscale"]').attr("tabIndex", 0);
                                    $('a[data-title="Reset axes"]').attr("tabIndex", 0);
                                    $('a[data-title="Toggle show closest data on hover"]').attr("tabIndex", 0);
                                    $('a[data-title="Show closest data on hover"]').attr("tabIndex", 0);
                                    $('a[data-title="Compare data on hover"]').attr("tabIndex", 0);
                                    $('a[data-title="Download Chart as SVG"]').attr("tabIndex", 0);

                                    //adding alt tags
                                    $('a[data-title="Download Chart as PNG"]').attr("alt", "Download Chart as PNG");
                                    $('a[data-title="Zoom "]').attr("alt", "Zoom");
                                    $('a[data-title="Pan"]').attr("alt", "Pan");
                                    $('a[data-title="Zoom in"]').attr("alt", "Zoom in");
                                    $('a[data-title="Zoom out"]').attr("alt", "Zoom out");
                                    $('a[data-title="Autoscale"]').attr("alt", "Autoscale");
                                    $('a[data-title="Reset axes"]').attr("alt", "Reset axes");
                                    $('a[data-title="Show closest data on hover"]').attr("alt", "Show closest data on hover");
                                    $('a[data-title="Compare data on hover"]').attr("alt", "Compare data on hover");
                                    $('a[data-title="Download Chart as SVG"]').attr("alt", "Download Chart as SVG");



                                    $('a:not([href])').attr("background-color", "none");
                                    //adding keypress check to account for the enter button being pressed
                                    $('a[data-title="Download Chart as PNG"]').keypress(
                                        function () {
                                            downloadBtn = $('a[data-title="Download Chart as PNG"]')[0]
                                            downloadBtn.click();
                                            console.log("clicked download");
                                        }
                                    );

                                    $('a[data-title="Download Chart as SVG"]').keypress(
                                        function () {
                                            downloadBtn = $('a[data-title="Download Chart as SVG"]')[0]
                                            downloadBtn.click();
                                            console.log("clicked download");
                                        }
                                    );

                                    $('a[data-title="Zoom"]').keypress(
                                        function () {
                                            zoomBtn = $('a[data-title="Zoom"]')[0]
                                            zoomBtn.click();
                                            console.log("clicked zoom");
                                        }
                                    );

                                    $('a[data-title="Pan"]').keypress(
                                        function () {
                                            panBtn = $('a[data-title="Pan"]')[0]
                                            panBtn.click();
                                            console.log("clicked pan");
                                        }
                                    );

                                    $('a[data-title="Zoom in"]').keypress(
                                        function () {
                                            zoominBtn = $('a[data-title="Zoom in"]')[0]
                                            zoominBtn.click();
                                            console.log("clicked zoom in");
                                        }
                                    );

                                    $('a[data-title="Zoom out"]').keypress(
                                        function () {
                                            zoomoutBtn = $('a[data-title="Zoom out"]')[0]
                                            zoomoutBtn.click();
                                            console.log("clicked zoom out");
                                        }
                                    );

                                    $('a[data-title="Autoscale"]').keypress(
                                        function () {
                                            autoscaleBtn = $('a[data-title="Autoscale"]')[0]
                                            autoscaleBtn.click();
                                            console.log("clicked Autoscale");
                                        }
                                    );

                                    $('a[data-title="Reset axes"]').keypress(
                                        function () {
                                            resetBtn = $('a[data-title="Reset axes"]')[0]
                                            resetBtn.click();
                                            console.log("clicked Reset axes");
                                        }
                                    );

                                    $('a[data-title="Show closest data on hover"]').keypress(
                                        function () {
                                            toggleBtn = $('a[data-title="Show closest data on hover"]')[0]
                                            toggleBtn.click();
                                            console.log("clicked Toggle");
                                        }
                                    );

                                    $('a[data-title="Compare data on hover"]').keypress(
                                        function () {
                                            compareBtn = $('a[data-title="Compare data on hover"]')[0]
                                            compareBtn.click();
                                            console.log("clicked Compare data on hover");
                                        }
                                    );

                                    //end keypress functionality
                                    $(".main-svg").append("<desc>" + $('meta[name=description]').attr("content") + "</desc>");
                                    $(".main-svg").attr("alt", $('meta[name=description]').attr("content"));


                                }

                            </script>

                                <%--************************--%>
                                <%--*   END Plotly Chart   *--%>
                                <%--************************--%>
                        </asp:Panel>
                        
                        <asp:Panel runat="server" ID="pnlData" style="max-width:1200px;"> <%--added a max width to account for the graphic identifier from floating off the page --%>
                            <a id="chartArea" name="chartArea" ></a>    
                            <%--*Message for visually disabled charts*--%>
                            <asp:Literal ID="litNoChart" runat="server"></asp:Literal>


                            <!-- ****** -->
                            <!-- *MAPS* -->
                            <!-- ****** -->
                            <asp:Panel ID="pnlMap" ClientIDMode="Static" runat="server" Style="overflow-x: auto; overflow-y: hidden; margin-top:40px">
                                <asp:Label ID="lblMap" runat="server"></asp:Label>
                                <div style="width:100%;text-align:right;">
                                    <button  id='exportButton' class="noPrint btn btn-light" type="button" runat="server"><span class="cdc-icon-download_01"></span>&nbsp;Download Map</button>                                    
                                </div>
                                <%--*Raphael Dynamic Maps (SVG)*--%>
                                
                                <div id="map" style="font-size: 8pt; font-family: verdana;" >    
                                    <div id="divStaticLeft" class="col-xl-2 col-lg-4" runat="server">
                                        <div id="map1" runat="server">
                                            <div class="imgcell">
                                                <img src="images/DataCharts/Poverty2x.png" runat="server" class="imgsize-ab" alt="Percentage of the population under the poverty level, by county (2018)"/>
                                            </div>
                                        </div>
                                        <div id="map2" runat="server">
                                            <div class="imgcell">
                                                <img src="images/DataCharts/PM2.5_mean2x.png" runat="server" class="imgsize-ab" alt="Average daily PM2.5, by county (2014)"/>
                                            </div>
                                        </div>
                                        <div id="map3" runat="server">
                                            <div class="imgcell">
                                                <img src="images/DataCharts/County-Level_Residential_Segregation_V2.png" runat="server" class="imgsize-ab" alt="Percentage of the population under the poverty level, by county (2018)"/>
                                            </div>
                                        </div>
                                        <div id="staticimg" runat="server">
                                            <div class="imgcell"  style="left:5%;">
                                                <img src="images/DataCharts/June_2024.png" runat="server" class="imgsize-d" alt="Prevalence of Awareness of CKD among U.S. Adults by Albuminuria category and eGFR category (2017-2020), data can be reviewed in the CSV download"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            
                                <%--*D3 Maps*--%>
                                <%--*Other Year divs*--%>
                                <asp:PlaceHolder ID="phDivs" runat="server" ClientIDMode="Static"></asp:PlaceHolder>
                            </asp:Panel>
                            <%-- <br />--%>

                            <span class="smallscreenmessage" style="display:none;">Map charts are best viewed on tablet or desktops</span>
                         
                        
                            <%--Maintain whether we are showing the map slider (0=no, 1=yes)--%>
                            <asp:HiddenField ID="hfShowMapSlider" runat="server" ClientIDMode="Static" Value="0" />

                            <asp:HiddenField ID="hfSliderVal" runat="server" ClientIDMode="Static" Value="" />
                            <asp:HiddenField ID="hfAnimateState" runat="server" ClientIDMode="Static" Value="0" />
                            <asp:HiddenField ID="hfYearList" runat="server" ClientIDMode="Static" Value="" />
                        




                            <!-- ******* -->
                            <!-- *Chart* -->
                            <!-- ******* -->
                            <asp:Panel ID="pnlChart" runat="server" ClientIDMode="Static">
                                <div id="divChart" class="ChartArea">


                                    <%--*************--%>
                                    <%--*HP2020 Logo*--%>
                                    <%--*************--%>
                                    <asp:Image ID="imgHP2020" runat="server" ImageUrl="images/healthyPeople.jpg" ToolTip="HP2020 Material" AlternateText="Healthy People 2020 Goals Logo" Visible="false" CssClass="HP2020LogoOverlay" />


                                    <%--*******--%>
                                    <%--*Chart*--%>
                                    <%--*******--%>
                                    <table>
                                        <tr>
                                            <td align="center">
                                                <asp:Literal ID="litPageTitle" runat="server" /></td>
                                        </tr>                                        
                                        <tr>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>

                                </div>
                            </asp:Panel>


                            <%--************************--%>
                            <%--* Begin D3 Maps Chart  *--%>
                            <%--************************--%>
                            <asp:Panel ID="pnlD3MapsTabs" runat="server" ClientIDMode="Static" Style="overflow-x: hidden; overflow-y: hidden;">
                                <%-- Linked Map buttons and sliders --%>

                                <div class="filterTable" id="linkedmapfilter" runat="server" visible="false">
                                  <div class="divTableCell">
                                    <div class="divTableRow">
                                      <button onclick="Pov_Selected()" class="pov linkedmapbtn" type="button">
                                        Poverty
                                      </button>
                                    </div>
                                    <div class="divTableRow">
                                      <button onclick="CKD_Selected()" class="ckd linkedmapbtn" type="button">
                                        Chronic kidney disease
                                      </button>
                                    </div>
                                  </div>
                                  <div class="divSliderCell">
                                    <label for="pov_slider-1" id="lbl_pov_slider-1" style="visibility:hidden;margin-bottom:0rem!important">POV Low</label>
                                    <label for="pov_slider-2" id="lbl_pov_slider-2" style="visibility:hidden;margin-bottom:0rem!important">POV High</label>
                                    <div class="linkedmapwrapper">
                                      <div class="pov slider-header">
                                        Population in Poverty by County
                                      </div>
                                      <div class="linkedmapvalues">
                                        <span id="pov_range1" class="rangeMin"> 0 % </span>
                                        <span id="pov_range2" class="rangeMax"> 100 %</span>
                                      </div>
                                      <div class="linkedmapcontainer pov-slider-body">
                                        <div class="slider-track" id="pov_slider"></div>
                                        <input
                                          type="range"
                                          min="0"
                                          max="100"
                                          value="0"
                                          id="pov_slider-1"
                                          oninput="pov_slideOne()"
                                        />
                                        <input
                                          type="range"
                                          min="0"
                                          max="100"
                                          value="100"
                                          id="pov_slider-2"
                                          oninput="pov_slideTwo()"
                                        />
                                      </div>
                                    </div>
                                  </div>
                                  <div class="divSliderCell">
                                    <label for="ckd_slider-1" id="lbl_ckd_slider-1" style="visibility:hidden;margin-bottom:0rem!important">CKD Low</label>
                                    <label for="ckd_slider-2" id="lbl_ckd_slider-2" style="visibility:hidden;margin-bottom:0rem!important">CKD High</label>
                                    <div class="linkedmapwrapper">
                                      <div class="ckd slider-header">
                                        CKD in the U.S. Medicare Population
                                      </div>
                                      <div class="linkedmapvalues">
                                        <span id="ckd_range1" class="rangeMin"> 0 %</span>
                                        <span id="ckd_range2" class="rangeMax"> 100 %</span>
                                      </div>
                                      <div class="linkedmapcontainer ckd-slider-body">
                                        <div class="slider-track" id="ckd_slider"></div>
                                        <input
                                          type="range"
                                          min="0"
                                          max="100"
                                          value="0"
                                          id="ckd_slider-1"
                                          oninput="ckd_slideOne()"
                                        />
                                        <input
                                          type="range"
                                          min="0"
                                          max="100"
                                          value="100"
                                          id="ckd_slider-2"
                                          oninput="ckd_slideTwo()"
                                        />
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                 <%-- Linked Map buttons and sliders --%>

                                <div class="tab-content" id="main_map" style="width:100%;float:left;">
                                  <span id="main_map_title" runat="server" class="chartheader">Population in poverty by county</span>
                                  <div id="tab_maps" class="tab-pane in active">
                                      
                                    <div style="width:100%;text-align:right; padding-top:5px;">
                                        <button class="noPrint btn btn-light btnzoom" type="button" id="zoom_in" runat="server">+</button>
                                        <button class="noPrint btn btn-light btnzoom" type="button" id="zoom_out" runat="server">-</button>
                                    </div>
                                        <span class="msgzoomout" style="visibility:hidden">Select a state from the dropdown below</span>
                                       
                                    <div style="padding-left:0px; margin-left:-5px;" id="countymap" >
                                        <svg class="countymapsvgwrapper" width="1000px" height="660px">
                                            <svg class="countymapsvg" width="1000px" height="600px" ></svg>
                                        </svg>
                                    </div>
                                  </div>
                                  <div id="tab_chart" class="tab-pane">
            
                                    <div  style="padding-left:15px;">
                                        <div id="bar_chart"></div>
                                    </div> 
                                  </div>
                                  <div id="tab_heatmap" class="tab-pane">
            
                                    <div  style="padding-left:15px;">
                                         <div id="heatmapchart" style="width:90%;"></div>
                                    </div>
                                  </div>
                                <div id="mapbar" style="width:70%;float:right;vertical-align:top;text-align:left;font-family: Arial;">
                                      <div style="display:none">
                                         <span>State:</span>&nbsp;<span class="datastatelabel"></span><br />
                                        <span>County:</span>&nbsp;<span class="datacountylabel"></span><br />
                                        <span>Data:</span>&nbsp;<span class="datavaluelabel"></span><br /><br />
                                    </div>
                                    <svg class="legendsvg" width="1000px" height="50px"></svg>
                                    <label for="cballcounties_id" style="display:none" >View all US counties</label><input type="checkbox" class="cballcounties" id="cballcounties_id" style="display:none" />

                                    <span for="heatmapsort" class="heatmapsortlbl">Sort By:</span><br />
                                    <select id="heatmapsort">
                                        <option value="select"></option>
                                        <option value="County DESC, year" selected >County name, asc</option>
                                        <option value="County ASC, year" >County name, desc</option>                
                                        <option value="CountyOrder ASC, year">Data value, asc</option>
                                        <option value="CountyOrder DESC, year">Data value, desc</option>
                                    </select>

                                    <div id="tinystatemap" style="width:200px;height:200px;padding-bottom:10px;cursor: pointer" title="View map of this data"></div>            
                                    <div id="tinyheatmap" style="width:200px;height:200px;cursor: pointer;display:none"  title="View heatmap of this data"></div>
                                    <div id="tinybarchart" style="width:200px;height:200px;cursor: pointer;display:none"  title="View histogram of this data"></div>

                                </div>
                                </div>
                                <div class="tab-content" id="linkedmap_scatter" style="width:50%;float:left;display:none;">
                                    <span id="linkedmap_scatter_title" runat="server" class="chartheader">Population in poverty and CKD by county</span>
                                    <div id="tab_linkedmapscatter"></div>
                                </div>
                            </asp:Panel>

                            <%--************************--%>
                            <%--*   END D3 Maps Chart  *--%>
                            <%--************************--%>

                        </asp:Panel>

                        <br />

                        <asp:Literal ID="LiteratureIndicatorFootnote" runat="server" Visible="false"></asp:Literal>
                    
                        <%--*******--%>
                        <%--*Table*--%>
                        <%--*******--%>
                        <a id="View-Data" name="View-Data"></a>
                        <div class="tableHeaderBar" id="tableHeaderBar" runat="server">

                            <div class="row">
                                <div class="col-md-6 col-12" style="float: left">
                                    <span id="spnViewDataTable" tabindex="0" onclick="toggleTable();" onkeyup="toggleTableKeyBoard(event);">+ View Data Table</span>
                                </div>
                                <div class="col-md-6 col-12" style="float: right; width: 65%; text-align: right;">
                                 
                                    <%--*Download Buttons*--%>
                                    <asp:Button ID="lnkDownload" CssClass="noPrint btn btn-light cdc-icon-download_01" runat="server" Text="Download Table" Visible="true" OnClick="lnkDownloadBottom_Click" class="cdc-icon-download_01">
                                    </asp:Button>
                                    <asp:Button ID="btnDownloadChart" runat="server" CssClass="btn btn-light cdc-icon-download_01" OnClick="btnDownloadChart_Click" class="cdc-icon-download_01">
                                    </asp:Button>
                                    <a href="./Documents/Q705_Table.xlsx" runat="server" id="staticDownloadButton" >
                                        <span class="btn btn-light">Download Table</span>
                                    </a>
                                </div>
                            </div>
                        </div>


                        <div class="tableContainer" style="display: none; width:100%" vis="0">

                            <%--*Table*--%>
                            <div style="overflow: auto; width:100%" class="printTable" id="divData">
                                <asp:GridView ID="gvData" Width="100%" runat="server" CssClass="ckd-details-dynamic-table" UseAccessibleHeader="true" captionalign="Top"  DataRowBound="gvData_DataRowBound" ClientIDMode="Static">
                                </asp:GridView>
                            </div>
                             <div style="overflow: auto; width:100%" class="printTable" id="divDataRel">
                                 <asp:GridView ID="gvDataRel" Width="100%" runat="server" CssClass="ckd-details-dynamic-table" UseAccessibleHeader="true" captionalign="Top"  DataRowBound="gvData_DataRowBound" ClientIDMode="Static">
                                 </asp:GridView>
                             </div>
                            <br />

                            <%--*Notes*--%>
                            
                        </div>

                            

                        <!-- ************** -->
                        <!-- *Content Tabs* -->
                        <!-- ************** -->
                        <div class="row">
                                <div id="divContentTabs" class="tabs-module">
                                    <a id="detailArea" name="detailArea"></a>
                                    <ul class="nav nav-tabs no-syndicate" id="tabs-3" role="list" style="background-color:#ffffff" aria-label="tabparent" aria-busy="true">
                                        <li class="nav-item active" style="margin-top: 0rem !important; margin-bottom: 2rem !important; " id="tab-1" role="listitem"><a class="nav-tab-link nav-link inactive-nav-link" data-toggle="tab" role="link" href="#tab-KeyPoints">Notes</a></li>
                                        <li class="nav-item" id="tab-2" style="margin-top: 0rem !important; margin-bottom: 2rem !important; " role="listitem"><a class="nav-tab-link nav-link inactive-nav-link" data-toggle="tab" role="link" href="#tab-ChartDescription">Data Source Description</a></li>
                                        <li class="nav-item" id="tab-3" style="margin-top: 0rem !important; margin-bottom: 2rem !important; " role="listitem"><a class="nav-tab-link nav-link inactive-nav-link" data-toggle="tab" role="link" href="#tab-SpecSheet">Indicator Specifications</a></li>
                                        <li class="nav-item" id="tab-4" style="margin-top: 0rem !important; margin-bottom: 2rem !important; " role="listitem"><a class="nav-tab-link nav-link inactive-nav-link" data-toggle="tab" role="link" href="#tab-RefDataSources">References</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="tab-pane active" role="tabpanel" tabindex="0" aria-labelledby="tab-1" id="tab-KeyPoints">
                                            <div class="ct-row">

                                                <%--*KP/Methods Content*--%>
                                                <div class="kptext">
                                                    <asp:Literal ID="litFootNotesText" runat="server"></asp:Literal>
                                                </div>

                                            </div>
                                        </div>

                                        <div class="tab-pane" role="tabpanel" tabindex="0" aria-labelledby="tab-2" id="tab-ChartDescription">
                                            <div class="ct-row">
                                
                                                <!--*******************-->
                                                <!--*Chart Explanation*-->
                                                <%--Spacing is managed on the server-side--%>
                                                <!--*******************-->
                                                <asp:Literal ID="litMethodsDesc" runat="server"></asp:Literal>

                                            </div>
                                        </div>

                                        <div class="tab-pane" role="tabpanel" tabindex="0" aria-labelledby="tab-3" id="tab-SpecSheet">
                                            <div class="ct-row">

                                                <%--*HTML Grid of Spec Sheet Data*--%>
                                                <asp:Literal ID="litSpecSheetGrid" runat="server"></asp:Literal>

                                            </div>
                                        </div>

                                        <div class="tab-pane" role="tabpanel" tabindex="0" aria-labelledby="tab-4" id="tab-RefDataSources">
                                            <div class="ct-row">
                                                <asp:Panel ID="pnlReferences" runat="server" Style="" class="printReferences">
                                                    <div class="tabbyDiv">

                                                        <asp:Repeater runat="server" ID="rptrReferences">
                                                            <HeaderTemplate>
                                                                <ul>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>

                                                                <li style="margin-bottom: .9em;">
                                                                    <asp:Literal ID="lblRefences" runat="server" Text='<%# Eval("ReferenceText") %>' ClientIDMode="AutoID"></asp:Literal>
                                                                    <br />
                                                                    <asp:HyperLink runat="server" Target="_self" NavigateUrl='<%# Eval("URL") %>' Text='<%#Eval("URL").ToString().Replace("-", "&#8209;")%>' ToolTip='<%#Eval("URL")%>' />
                                                                </li>

                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                </ul>
                                                            </FooterTemplate>
                                                        </asp:Repeater>

                                                    </div>
                                                </asp:Panel>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                        </div>

                        <br />

                    </div>
                    </section>

                    
                    <div id="divLEFT" class="col-xl-3 order-xl-1 leftnav-wrapper" runat="server">
                        
                        <%--*************************************************************--%>
                        <%-- TODO: (BEGIN) Replace left div with the new indicator links --%>
                        <%--*************************************************************--%>
                        <nav role="navigation" aria-label="Left Navigation Menu" style="border-bottom-color:white">
                            <div id="div1" class="divLeftMenuContainer" runat="server">
                               <uc1:SideNav runat="server" id="SideNav1" />
                            </div>
                        </nav>

                        <div id="divLeftContainer" class="divLeftContainer" runat="server" Visible=false>

                            <%--*Go button Navs*--%>
                            <uc1:StratYearsLinksMaps runat="server" id="StratYearsLinksMaps" />
                           
                            <div class="dataSourceRBTitle" id="chartFormatOptions" runat="server" style="margin-top:10px;">&nbsp;&nbsp;Chart Format</div>
                                <div style="background-color: #f6fbff; padding-left:5px; margin-top:-5px;" id="chartFormatControls" runat="server">
                                    <asp:RadioButtonList ID="RB_ChartType" CssClass="radioButtonList" runat="server" RepeatLayout="Table" RepeatDirection="Vertical" >
                                        <asp:ListItem Text="Bar" Value="'bar'"></asp:ListItem>
                                        <asp:ListItem Text="Line" Value="'line'" ></asp:ListItem>
                                        <asp:ListItem Text="Stacked Bar" Value="'stacked'" ></asp:ListItem>
                                    </asp:RadioButtonList>
                        
                                </div>

                            <div class="dataSourceRBTitle" id="chartColorOptions" runat="server" style="margin-top:10px;">&nbsp;&nbsp;Chart Colors</div>
                                <div style="background-color: #f6fbff; padding-left:5px; margin-top:-5px;" id="chartColorControls" runat="server">
                                    <asp:RadioButtonList ID="RB_ChartColor" CssClass="radioButtonList" runat="server" RepeatLayout="Table" RepeatDirection="Vertical" >
                                        <%--<asp:ListItem Text="Contrast" Value="'#189BDC', '#b0e57c', '#98abc5', '#1f77b4', '#ffb456', '#7f7f7f', '#e377c2', '#8c564b', '#444444', '#ff6456', '#e4e51b', '#aa51ff', '#98CA32', '#9D0E01', '#EA3E88'"></asp:ListItem>--%>
                                        <%--<asp:ListItem Text="Contrast" Value="'#6BAED6','#74C476','#969696','#FD8D3C', '#8c564b', '#444444', '#ff6456', '#e4e51b', '#aa51ff', '#98CA32', '#9D0E01', '#EA3E88','#189BDC', '#b0e57c', '#98abc5', '#1f77b4','#7f7f7f', '#e377c2', '#ffb456'"></asp:ListItem>--%>
                                        <asp:ListItem Text="Contrast" Value="'#712177','#0b4778','#969696','#FD8D3C', '#8c564b', '#444444', '#ff6456', '#e4e51b', '#aa51ff', '#98CA32', '#9D0E01', '#EA3E88','#189BDC', '#b0e57c', '#98abc5', '#1f77b4','#7f7f7f', '#e377c2', '#ffb456'"></asp:ListItem>  <%--'#007C91',--%>
                                        <asp:ListItem Text="Gradient" Value="'#949494','#08a3b4', '#4169e1', '#00008b', '#949494', '#08a3b4', '#4169e1', '#00008b', '#949494', '#08a3b4', '#4169e1', '#00008b', '#949494', '#08a3b4', '#4169e1', '#00008b'" ></asp:ListItem>                                       
                                    </asp:RadioButtonList>
                                </div>
                        </div>

                        <%--***********************************************************--%>
                        <%-- TODO: (END) Replace left div with the new indicator links --%>
                        <%--***********************************************************--%>


                        <div id="divRightContainer" class="divRightContainer" runat="server">
                            
                            <%--*Most Recently Visited*--%>
                            <asp:PlaceHolder ID="phMRV" runat="server" ></asp:PlaceHolder>

                         
                        </div>


                    </div>

                </div>
            </div>
        </div>

        <div id="png-container"  style="width:960px; height:900px;display:none;"></div>

    </div>
    <!-- *End of Detail Area* -->
    <style>
        .nav-item.active {
            margin-top: 0rem !important;
            background-color:#E8E8E8!important;
            color:#000000!important;
            border: 1px solid #E8E8E8 !important;
            text-align: center;
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            font-size: 18px;
            letter-spacing: 0px;
            opacity: 1;
            border-radius: 6px;
        }
        
        .inactive-nav-link {
            text-align: center;
            font: normal normal normal 17px/24px Nunito!important;
            letter-spacing: 0px;
            color: #000000!important; 
            opacity: 1;
        }

        .chartMenuLabel {
            text-align: left;
            font: normal normal normal 17px/20px Nunito;
            letter-spacing: 0px;
            color: #29434E;
            opacity: 1;
        }
        .chartMapMenu {
            margin-bottom:10px;
        }

        .chartMapMenuLabel {
            text-align: left;
            font: normal normal normal 15px/20px Nunito;
            letter-spacing: 0px;
            color: #29434E;
            opacity: 1;
            margin-top: 10px;
            margin-bottom:5px;
        }

        .viewTableBtnLabel {
            padding-top:2px;
            padding-left:5px;
            top: calc(0.2rem);
        }

        #input-container {
            vertical-align: top;
            background-color: var(--colors-blue-cool-vivid-5);
            opacity: 1;
            height: 107px;
            margin-left: 2px;
            margin-right: 2px;
        }
        #wrapper [class*=module]>* {
            padding: 0 0px 0 15px;
        }
        .alternaterow {
            background-color:#ddd;
        }

        .ccolstyle {
            padding-top:5px;
            padding-bottom:5px;
        }

        .spanstyle {
            margin:0px 0px 0px 0px;

        }

        .btn_disabled {
            color:#aaa;
        }

        .js-plotly-plot .plotly .modebar {
            z-index:0 !important;
        }

    </style>
    <script>
        function openDataSource(selVal) {
            window.location.href = "./detail.aspx?Qnum=" + selVal + "#refreshPosition";
        }
        function openViewDataBy(selVal) {
            window.location.href = "./" + selVal.replace("%3f", "?");
        }

    </script>
     <%--*Navigate to here after page refresh*--%>
    <input type="hidden" id="_ispostback" value="<%=Page.IsPostBack.ToString()%>" />


    

        <script>

            function legendAutoScaleClick() { //this function is called after the chart has been created in the createPlotlyScript and createTripleStratPlotlyScript functions. It's purpose is to execute the clicking of the Autoscale button
                console.log("inside legendclick");
                autoscaleBtn = $('a[data-title="Autoscale"]')[0]
                autoscaleBtn.click();
            }

            $(document).ready(function () {   
                
                initStdChartTable();
                initChartRadioButton();

                var divVD = document.getElementById("divViewDataBy");
                if (typeof (divVD) != 'undefined' && divVD != null) {
                    $('#divMenuData').removeAttr("style");
                    $('#divMenuContent').removeAttr("style");
                    var divCI = document.getElementById("CB_ChartCI");
                    if (typeof (divCI) == 'undefined' || divCI == null) {
                        $('#divMenuData').attr("style", "margin-left:1%");
                    }
                }else{
                    var divCI = document.getElementById("CB_ChartCI");
                    if (typeof (divCI) == 'undefined' || divCI == null) {
                        $('#divMenuData').removeAttr("style");
                    }
                }
                
                
                var sw = $(window).width();
                $('#tableHeaderBar').hide();

                if ($('#map').length < 1) {
                    //If we are NOT on a map indicator, then hide the small screen message
                    $('.smallscreenmessage').hide();

                } else {//otherwise, display the map message is the screen is small, or hide it if it is too big
                    if (sw <= 972) {
                        $('.smallscreenmessage').show();
                    }
                    else
                        $('.smallscreenmessage').hide();
                }     

                if ($("#hfChartID").val() == "4319") {
                    document.getElementById("btnreset").innerHTML = "Reset Filters";
                    document.getElementById("divzoombtn").style.marginLeft = "75%";
                }
                else
                {
                    $(".chartheader").hide();
                }

                $("input[id*='CB_ChartCI']").click(function () {
                    console.log("cbchart=" + $(this).prop('checked'));
                    if ($(this).prop('checked')) {
                        if ($('#hfMaxConfidence').val() > $('#hfChartYValToUse').val()) {
                            $('#hfChartYValToUse').val($('#hfMaxConfidence').val()); // if the confidence intervals checkbox is checked then use the max confidence value to draw the chart
                        }
                        $('#hfShowCI').val("true");
                    }
                    else {
                        if ($('#hfMaxYVal').val() > $('#hfChartYValToUse').val()) {
                            $('#hfChartYValToUse').val($('#hfMaxYVal').val()); // if the confidence intervals checkbox is NOT checked then use the max y value to draw the chart
                        }
                        $('#hfShowCI').val("false");
                    }

                    redrawPlotlyChart();

                });

                $("input[id*='RB_ChartType']").click(function () {
                    
                    if ($("input[name*='RB_ChartType']:checked").val() == "'stacked'") {
                        $('#hfChartType').val("'bar'");
                        $('#hfChartMode').val("'stack'");
                        $('#hfChartYValToUse').val($('#hfMaxStackedYVal').val())//use the max stacked value for stacked bars, otherwise the chart is too big for the display area
                    }
                    else
                    {
                        $('#hfChartType').val($("input[name*='RB_ChartType']:checked").val());
                        $('#hfChartMode').val("'group'");
                        $('#hfChartYValToUse').val($('#hfMaxYVal').val())
                    }

                    redrawPlotlyChart();
                });

                $("input[id*='RB_ChartColor']").click(function () {

                    //placing the colors in a hidden field to be referenced by the Plotly Script, the values contain '' around the actual colors so Plotly can handle the chart creation
                    $('#hfChartColor').val($("input[name*='RB_ChartColor']:checked").val());

                    var colors = $('#hfChartColor').val();
                    var colors_split = colors.split(",");

                    redrawPlotlyChart();
                })

            });

            function redrawPlotlyChart() {

                createPlotlyChart();
                //createPlotlyChartRel(); /* TODO: comment out this block */

                
                if (document.getElementById("divRBSTD") != null) { 
                    createPlotlyChartRel();
                }
                

                compliance508();
            }

            //calling the auto scale so that the graph is redrawn with the remaining data taking up the entire chart
            function clickAutoScaleButton() {
                console.log("inside clickAutoScaleButton");
                autoscaleBtn = $('a[data-title="Autoscale"]')[0]
                autoscaleBtn.click();
            }
            
        </script>
    
</asp:Content>



<asp:Content ID="Content3" ContentPlaceHolderID="CustomJavaScript" runat="server">

    <script src="scripts/raphael.js" type="text/javascript"></script>
    <script src="scripts/jquery.usmap2.js?v=4" type="text/javascript"></script>
    <script src="scripts/jquery.corner.js" type="text/javascript"></script>

    <script type="text/javascript">
    <!--        //

    $(document).ready(function () {

        //hide the divRightContainer if it doesn't have children
        if ($(".divRightContainer").children().length)
            $(".divRightContainer").show();
        else
            $(".divRightContainer").hide();

        if ($('#map').length < 1) {
            //If we are NOT on a map indicator ...
            $('#sliderWrapper').hide();

        } else {


            //*****************
            //*MAP Slider code*
            //*****************
            var yrs = $('#hfCSVYears').val().split(',');//Note: hfCSVYears is in StratYearButtons.ascx
            var starter = yrs.length - 1;
            $("#mapSlider").ionRangeSlider({
                type: "single",
                grid: true,
                grid_snap: true,
                from: starter,
                step: 1,
                values: yrs,
                prefix: "",
                prettify_enabled: false,
                keyboard: true,

                onChange: function (data) {
                    var val = $('#mapSlider').val();
                    var yrs = $('#hfCSVYears').val().split(',');
                    var curIndex = yrs.indexOf(val);
                    
                    updateMap(curIndex);
                }
            });

            $(document).keydown(function (e) {
                if ((e.keyCode || e.which) == 37) {
                    //Left                        
                    $('#imgPrevMap').trigger('click');
                } else if ((e.keyCode || e.which) == 39) {
                    //Right                        
                    $('#imgNextMap').trigger('click');
                }
            });
        }




        $('.ckd-explanation-accordion-header').click(function () {
            $(this).next().slideToggle();
            $(this).find('span').toggleClass('ckd-accordion-plus');
            $(this).find('span').toggleClass('ckd-accordion-minus');
            return false;
        });


        $('#selNavSP').change(function () { //handles the change of the dropdown list of different indicators
            var sval = $("select#selNavSP option:checked").val();
            document.location.href = "detail.aspx?Qnum=" + sval + "#refreshPosition";
        });


        //*Draw a right border for the data table's div if it scrolls*
        var tbleWidth = $('table[id$="gvData"]').width();


        //*Count columns in table to determine width*
        var colCount = $('.ckd-details-dynamic-table').find('tr:first th').length;
        if (colCount < 3) {
            //$('.ckd-details-dynamic-table').css('width', 'auto');
            $('.ckd-details-dynamic-table').css('width', '100%');
        }



        //Hide all maps but the main one            
        setTimeout(function () {
            $('.addedMap').hide();
        }, 100);


        //Close the modal for page load
        $('#OverlayModal').modal('hide');
        $('.overlayContainer').hide();


        //Add focus-ability to slider handle
        $('.irs-slider').attr('tabindex', '0');


        //Format HTML data table with <br />
        $('.ckd-details-dynamic-table td').each(function () {
            var val = $(this).html().replace('(95% CI:', '<br />(95% CI:');
            $(this).html(val);
        });


        //Show correct nav on Map pages
        if ($('#hfMapWhatNavToShow').val() == 's') {
            $('#divMapSelectedYears').show();           
            $('#divMapAllYears').hide();

            $('#spnAcrossAllYearsPlus').show();
            $('#spnAcrossAllYearsMinus').hide();

            $('#spnSelectedYearPlus').hide();
            $('#spnSelectedYearMinus').show();
            
        } else {
            $('#divMapSelectedYears').hide();
            $('#divMapAllYears').show();

            $('#spnAcrossAllYearsPlus').hide();
            $('#spnAcrossAllYearsMinus').show();

            $('#spnSelectedYearPlus').show();
            $('#spnSelectedYearMinus').hide();
        }

    });

    //*change interface when all Years (span) is clicked*
    function adjustForAllYears() {
        $('#hfShowMapSlider').val('1'); //show the slider on postback

        //Read the url params - get the QNum
        var qnum = location.search.split('=')[1].split('&')[0];
        var redir = './detail.aspx?Qnum=' + qnum + '&showMapSlider=1#refreshPosition';

        //Reload the page        
        window.location = redir;
    }


    function wrapRelatedMostRecent() {

        var sw = $(window).width();

        //wrapping the Related Indicators and Most Recently Viewed below the chart image so that it doesn't overlay--7/10 BS
        if (sw <= 1200) {

            $('#divRightColumn').removeClass("col-xl-2");
            $('#divRightColumn').addClass("col-xl-12");

        }
        else {
            $('#divRightColumn').addClass("col-xl-2")
            $('#divRightColumn').removeClass("col-xl-12");
        }
    }

    function makeAccordionCollapsible() {

        var sw = $(window).width();

        //Permit the accordions to collapse all (if on small enough screen)
        if (sw <= 750) {

            setTimeout(function () {
                $('#divContentTabs').accordion({ collapsible: true });
            }, 100);
        }
    }

    function chooseMap() {
        var yr = "#div" + $('#mapSlider').val();
        $('.addedMap').hide();
        $('#map').hide();
        $(yr).show();
    }



    function TogglePlayStop(btnID) {

        if ($('#' + btnID).attr('src') == 'images/PLAY.png') {
            $('#' + btnID).attr('src', 'images/smallStopSquare.png');
            $('#hfAnimateState').val("1"); // it is playing
        } else {
            $('#' + btnID).attr('src', 'images/PLAY.png');
            $('#hfAnimateState').val("0"); // it is paused/stopped
        }
    }


    function changeMap(dir) {

        //get the array of years and a reference to the slider
        var yrs = $('#hfCSVYears').val().split(',');//Note: hfCSVYears is in StratYearButtons.ascx and contains the comma-separated list of years
        var slider = $("#mapSlider").data("ionRangeSlider");

        var min = 0;
        var max = parseInt(yrs.length);

        

        //Get  current slider text value
        var val = $('#mapSlider').val();
        var curIndex = yrs.indexOf(val);
        var newIndex;

        switch (dir) {
            case "next":
                if (curIndex == max - 1) {
                    newIndex = min;
                } else {
                    newIndex = curIndex + 1;
                }
                break;
            case "prev":
                if (curIndex == 0) {
                    newIndex = max -1;
                } else {
                    newIndex = curIndex - 1;
                }
                break;
        }

        //Set the slider's new position
        slider.update({ from: newIndex });

        updateMap(newIndex);
    }
    function sliderAnimateForward(cnt) {

        //If this is a stop - do not animate
        var as = $('#hfAnimateState').val();
        if (as == "0") { return; }


        var yrs = $('#hfCSVYears').val().split(',');//Note: hfCSVYears is in StratYearButtons.ascx and contains the comma-separated list of years
        var slider = $("#mapSlider").data("ionRangeSlider");

        //Get  current slider text value
        var val = $('#mapSlider').val();
        var curIndex = yrs.indexOf(val);
        var newIndex;


        if (cnt >= 25) {
            //Turn it off and quit.
            $('#hfAnimateState').val("0");
            $('#imgPlayStop').attr('src', 'images/STOP_Button.png');

            return;
        }


        var min = 0;
        var max = parseInt(yrs.length);

        if (curIndex == max - 1) {
            newIndex = min;
            cnt++;
        } else {
            newIndex = curIndex + 1;
        }
        
        //Set the slider's new position
        slider.update({ from: newIndex });

        updateMap(newIndex);


        //Do it 25 times
        setTimeout(function () {
            sliderAnimateForward(cnt);
        }, 1000);
    }
    

    $(window).resize(function () {
        adjustBreadCrumbs();
        makeAccordionCollapsible();
        wrapRelatedMostRecent();

        var sw = $(window).width();
        
        if ($('#map').length < 1) {
            //If we are NOT on a map indicator, then hide the small screen message
            $('.smallscreenmessage').hide();

        } else {//otherwise, display the map message is the screen is small, or hide it if it is too big
            if (sw <= 972) {
                $('.smallscreenmessage').show();
            }
            else
                $('.smallscreenmessage').hide();
        }       
        
    });


    //*Properly align and wrap the stratification radio buttons' text*
    function alignRadioButtonText() {

        $('input:radio').each(function () {
            var id = this.id;

            //*Wrap the radio buttons*
            if (id.indexOf("rblStrat") > -1) {
                $('#' + id).parent().children('label').wrap('<div style="float:right; width:86%; padding-bottom:3px; padding-top:2px;"></div>');
                $('#' + id).wrap('<div style="float:left; width:13%; padding-bottom:3px; padding-top:4px;"></div>');
            }
            else if (id.indexOf("rblYears") > -1) {
                $('#' + id).parent().children('label').wrap('<div style="float:right; width:86%; padding-bottom:3px; padding-top:0px;"></div>');
                $('#' + id).wrap('<div style="float:left; width:13%; padding-bottom:3px; padding-top:3px;"></div>');
            }
        })
    }



    //Place TMI indicators in top bread crumb
    adjustBreadCrumbs();


    function adjustBreadCrumbs() {

        //Make sure the old menu is deleted (for resize consideration)  
        $('.bread-crumb').show();
        $('#vp1-CKDMenu-button').remove();


        var sw = $(window).width();
        if (sw <= 498) {
            $('.bread-crumb').hide();
            $('#mobile-menu ul').append('<li id="vp1-CKDMenu-button" class="border-bottom-white" style="color:#ffffff; margin-right:.4em;" onclick="manageCKDMenuClick(); return false;">CKD MENU</li>');
            $('#vp1-CKDMenu-button').insertBefore($('#vp1-a2z-button'));
        }

        setTimeout(function () {
            //These will ALWAYS be internal links.
            $('.TMITopic a').removeClass('tp-link-policy tp-external-link-fix');

        }, 100);
    }

    function toggleTable() {

        //Executes on click of span #spnViewDataTable to hide/show table contents
        var showing = $('.tableContainer').attr('vis');

        switch (showing) {
            case '0':
                $('.tableContainer').slideDown(1000);
                $('.tableContainer').attr('vis', '1');
                $('#spnViewDataTable').html('&mdash; Hide Data Table');
                break;
            case '1':
                $('.tableContainer').slideUp(1000);
                $('.tableContainer').attr('vis', '0');
                $('#spnViewDataTable').text('+ View Data Table');
                break;
        }
        }


    function toggleTableKeyBoard(e) {

        var kc = e.keyCode;
        //If visitor pressed <ENTER>, toggle the table
        if (kc === 13) {
            toggleTable(); // see immediately above - function on page
        }
    }


    //If this is a phone/tablet - adjust collapsibility of tabs/accordion
    makeAccordionCollapsible();



    </script>
    <asp:Literal ID="litfunctions" runat="server" />

      <%--**********************--%>
    <%--*BEGIN D3 Map JS code*--%>
    <%--**********************--%>
    <script>
        var previousyear;
        function updateMap(value) {
            
            var yrs = $('#hfCSVYears').val().split(',');
            console.log("yrs len=" +yrs.length + "- value=" + value + " - yr 0= " + yrs[0]);
                           
            if (value == 0) //first year in the slider
                previousyear = yrs[yrs.length - 1]; 
            else if (value == yrs.length) //last year in the slider
                previousyear = yrs[0];
            else
                previousyear = yrs[value - 1];
            //setting the previous year here so that the previous year svg group <g> can be deleted after the current group is drawn. 
            //sequence is important so that there isn't a 'blip' on the screen

            if (value > yrs.length)
                value = 0;

            yearselected = yrs[value];
            fillTheMap(1);
        }

        function zoomed() {           
            g_con.attr("transform", d3.event.transform); // updated for d3 v4
            g_text.attr("transform", d3.event.transform); // updated for d3 v4
            
        }
        function fillTheTitleFooter(c_title, c_footer) {
            console.log("inside fillTheTitleFooter");
            var margin = { "left": 0, "top": 0 };
            var title_g = svg.append("g")
                .attr("class", "titlefoot")
                .attr("transform", "translate (" + margin.left + "," + margin.top + ")");
            console.log("ctitle=" + c_title);
            console.log("c_footer=" + c_footer);
            title_g.append("text")    
                .attr("x", 20)
                .attr("y", 15)
                .attr("class", "maptitletext")
                .text(c_title);

            title_g.append("text")
                .attr("x", 10)
                .attr("y", 490)
                .text(c_footer);
        }

        function fillChartTitle_tabs(c_title, c_footer) {

            d3.selectAll(".countymapsvgwrapper .countymaptitletext").remove();

            d3.select('.countymapsvgwrapper').append("text")
                .attr("class", "countymaptitletext")
                .attr("x", 20)
                .attr("y", 630)
                .text(c_title + "-" + $("#ddstate option:selected").text());
            d3.select('.countymapsvgwrapper').append("text")
                .attr("class", "countymaptitletext")
                .attr("x", 20)
                .attr("y", 650)
                .text(c_footer);
        }

        function fillTheLegend() {
            //begin legend code
            var boxmargin = 4,
                lineheight = 14,
                keyheight = 10,
                keywidth = 40,
                boxwidth = 2 * keywidth;

            var titleheight = lineheight * 4;

            var margin = { "left": actualwidth - 100, "top": actualheight - 100 };
            valMin = 1;//hardcodeing for now since there will only be 544
            valMax = 5;
            var x = d3.scaleLinear()
                .domain([valMin, valMax]);

            var quantize = d3.scaleQuantize()
                .domain([valMin, valMax])
                .range(colorarray);

            var ranges = quantize.range().length;
            var legend = svg.append("g")
                .attr("transform", "translate (" + margin.left + "," + margin.top + ")");

            // make quantized key legend items
            var li = legend.append("g")
                .attr("transform", "translate (-45,-40)")
                .attr("class", "legend-items");

            li.selectAll("rect")
                .data(quantize.range().map(function (color) {
                    var d = quantize.invertExtent(color);
                    
                    if (d[0] == null) d[0] = x.domain()[0];
                    if (d[1] == null) d[1] = x.domain()[1];
                    return d;
                }))
                .enter().append("rect")
                .attr("y", function (d, i) { return i * lineheight + lineheight - keyheight - 4; })
                .attr("width", keywidth)
                .attr("height", keyheight + 4)
                .style("stroke", "#000")
                .style("stroke-width", "1px")
                .style("fill", function (d) {
                    return quantize(d[0]);
                });

            d3.select('.upperlegend').remove();
            d3.select('.lowerlegend').remove();

            li.append("text")
                .attr("class", "upperlegend")
                .attr("x", 0)
                .attr("y", -5)
                .text(legendtext);

            li.append("text")
                .attr("class", "upperlegend")
                .attr("x", 48)
                .attr("y", 14)
                .text(displaytextarray[0]);
            li.append("text")
                .attr("class", "upperlegend")
                .attr("x", 48)
                .attr("y", 28)
                .text(displaytextarray[1]);
            li.append("text")
                .attr("class", "upperlegend")
                .attr("x", 48)
                .attr("y", 42)
                .text(displaytextarray[2]);
            li.append("text")
                .attr("class", "upperlegend")
                .attr("x", 48)
                .attr("y", 56)
                .text(displaytextarray[3]);

            li.append("text")
                .attr("class", "lowerlegend")
                .attr("x", 48)
                .attr("y", 70)
                .text(displaytextarray[4]);

            //end legend code

        }

        function fillTheMap(type) {
            console.log("FillTheMap");
             $("#range").html(yearselected); //this is the slider
            // D3 Projection
            var projection = d3.geoAlbersUsa()
                .translate([width / 2, height / 2]) // translate to center of screen
                .scale(scaleval); // scale things down so see entire US

            // Define path generator
            var path = d3.geoPath() // path generator that will convert GeoJSON to SVG paths
                .projection(projection); // tell path generator to use albersUsa projection



            // Load GeoJSON data and merge with states data
            d3.json("Scripts/D3MapFiles/Coordinates/us-states.json", function (json) {
                    g_con = svg.append("g")
                        .attr("class","g" + yearselected) //adding the year selected, so it can be referenced later for deletion
                        .selectAll("path")
                        .data(json.features)
                        .enter()
                        .append("path")
                        .attr("d", path)
                        .style("stroke", "#333")
                        .style("stroke-width", "1")
                        .each(fillState);

                    g_text = svg.append("g")
                        .attr("class", "gtext" + yearselected) //adding the year selected, so it can be referenced later for deletion
                        .selectAll("text")
                        .data(json.features)
                        .enter()
                        .append("svg:text")
                        .attr("x", function (d) {

                            if (d.properties.name.indexOf("Michigan") > -1)
                                return path.centroid(d)[0] + 8;
                            else if (d.properties.name.indexOf("Florida") > -1)
                                return path.centroid(d)[0] + 10;
                            else if (d.properties.name.indexOf("Delaware") > -1)
                                return path.centroid(d)[0] + 17;
                            else if (d.properties.name.indexOf("New Jersey") > -1)
                                return path.centroid(d)[0] + 17;
                            else if (d.properties.name.indexOf("Louisiana") > -1)
                                return path.centroid(d)[0] - 10;
                            else if (d.properties.name.indexOf("Hawaii") > -1)
                                return path.centroid(d)[0] - 20;
                            else if (d.properties.name.indexOf("Maryland") > -1)
                                return path.centroid(d)[0] + 10;
                            else if (d.properties.name.indexOf("Rhode Island") > -1)
                                return path.centroid(d)[0] + 10;
                            else if (d.properties.name.indexOf("California") > -1)
                                return path.centroid(d)[0] - 10;
                            else
                                return path.centroid(d)[0];

                        })
                        .attr("y", function (d) {
                            if (d.properties.name.indexOf("Michigan") > -1)
                                return path.centroid(d)[1] + 20;
                            else if (d.properties.name.indexOf("Connecticut") > -1)
                                return path.centroid(d)[1] + 4;
                            else if (d.properties.name.indexOf("Rhode Island") > -1)
                                return path.centroid(d)[1] + 15;
                            else if (d.properties.name.indexOf("Massachusetts") > -1)
                                return path.centroid(d)[1] + 2;
                            else if (d.properties.name.indexOf("Kentucky") > -1)
                                return path.centroid(d)[1] + 5;
                            else if (d.properties.name.indexOf("Tennessee") > -1)
                                return path.centroid(d)[1] + 5;
                            else if (d.properties.name.indexOf("New Hampshire") > -1)
                                return path.centroid(d)[1] + 10;
                            else if (d.properties.name.indexOf("Vermont") > -1)
                                return path.centroid(d)[1] - 3;
                            else if (d.properties.name.indexOf("Delaware") > -1)
                                return path.centroid(d)[1] + 10;
                            else if (d.properties.name.indexOf("New Jersey") > -1)
                                return path.centroid(d)[1] + 10;
                            else if (d.properties.name.indexOf("Maryland") > -1)
                                return path.centroid(d)[1] + 10;
                            else
                                return path.centroid(d)[1];
                        })
                        .attr("text-anchor", "middle")
                        .attr('font-size', '8pt')
                        .attr('font-weight', 'bold')
                        .each(fillText);

                    if (type == 1) //only if this is an update, which is driven by the slider
                    {
                         //setting the previous year here so that the previous year svg group <g> can be deleted after the current group is drawn. 
                        //sequence is important so that there isn't a 'blip' on the screen
                        svg.selectAll("g.g" + previousyear).remove();//removing previous map
                        svg.selectAll("g.gtext" + previousyear).remove(); //removing previous map text
                    }
                //}
                
                function fillText(d) {
                    //filtering the stateData array(local) and then pulling the abbreviation from it to display on the map
                    d3.select(this)
                        .data(stateData.filter(function (C) { return (C.year == yearselected && C.name == d.properties.name) }))
                        .on('mouseover', function (D) {
                            hovertooltipdiv.style('left', d3.event.pageX + 'px').style('top', d3.event.pageY - 60 + 'px') //displaying the popup on the text in addition to the state
                                .style('display', 'inline-block')
                                .html(D.name + '<br>' + D.value);
                        })
                        .text(function (A) {

                            return A.abbr;
                        })
                        .style("cursor", "default")//showing the deafult cursor instead of the text cursor

                }

                function fillState(d) {
                    
                    d3.select(this).style('fill', null);
                    
                    d3.select(this)
                        .data(stateData.filter(function (C) {
                            if (C.year == yearselected && C.name == d.properties.name)
                            return (C.year == yearselected && C.name == d.properties.name)
                        }))
                        .style("fill", function (Clr) {
                            if (Clr.year == yearselected && Clr.name == d.properties.name)
                                {
                                return Clr.color
                            }
                            
                        })  
                        .on('mouseover', function (D) {
                            
                            if (D.year == yearselected && D.name == d.properties.name) {
                                hovertooltipdiv.style('left', d3.event.pageX + 'px').style('top', d3.event.pageY - 60 + 'px')
                                    .style('display', 'inline-block')
                                    .html(D.name + '<br>' + D.value);
                            }
                            
                        })
                        .on('mouseout', function (D) { hovertooltipdiv.style('display', 'none'); });
                }

                function fillCounty(d) {

                    d3.select(this).style('fill', null);

                    d3.select(this)
                        .data(countyData.filter(function (C) {
                            if (C.name == d.properties.name) //C.year == yearselected &&
                                return (C.name == d.properties.name) //C.year == yearselected &&
                        }))
                        .attr("fill", function (Clr) {
                            if (Clr.name == d.properties.name) { //Clr.year == yearselected && 
                                return Clr.color
                            }

                        })  
                        .on('mouseover', function (D) {

                            if (D.name == d.properties.name) { //D.year == yearselected &&
                                var statedatalabelval = createstatehoverover(D.id);
                                hovertooltipdiv_tabs.style('left', d3.event.pageX + 100 + 'px').style('top', d3.event.pageY - 60 + 'px') //displaying the popup on the text in addition to the state
                                    .style('display', 'inline-block')
                                    .style('transition', '.5s')
                                    .style('opacity', '1')
                                    .html(statedatalabelval );
                            }

                        })
                        .on('mouseout', function (D) { hovertooltipdiv_tabs.style('display', 'none'); });
                }


            });
        }

    </script>
    <%--**********************--%>
    <%--*END D3 Map JS code*--%>
    <%--**********************--%>

    <%--**********************--%>
    <%--*Used for Map JS code*--%>
    <%--**********************--%>
    <div id="divMapCode">
        <asp:Literal ID="litJS" runat="server" />
    </div>

    
        <asp:Literal ID="litD3Map" runat="server" />
    <asp:PlaceHolder ID="phMaps" runat="server" ClientIDMode="Static"></asp:PlaceHolder>

     <%--**********************--%>
    <%--*BEGIN Used for Map JS Tabs code*--%>
    <%--**********************--%>
    

    
        <asp:Literal ID="litD3MapTabs" runat="server" />
    <script>

       
    </script>
     <%--**********************--%>
    <%--*END Used for Map JS Tabs code*--%>
    <%--**********************--%>

    <%--**********************--%>
    <%--*BEGIN  D3 Maps V2 TABS chart update*--%>
    <%--**********************--%>
     <script>

         var stateData_tabs = [];

         //***** Q705 change *******/
         const colorarray_tabs = ["#FFFFFF", "#AED6F1", "#85C1E9", "#59B1EC", "#2E86C1"];
         //***** Q705 change *******/

         const statearray_tabs = ["Alabama", "Alaska", "Arkansas", "Arizona", "California", "Colorado", "Connecticut", "District of Columbia", "Delaware", "Florida", "Georgia", "Hawaii", "Iowa", "Idaho", "Illinois", "Indiana", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland",
             "Massachusetts", "Michigan", "Minnesota", "Missouri", "Mississippi", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota",
             "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "Wisconsin", "West Virginia", "Wyoming"];
         const abbrarray_tabs = ["AL", "AK", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "ME", "MD",
             "MA", "MI", "MN", "MO", "MS", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND",
             "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WI", "WV", "WY"];

         const fipsarray_tabs = ["01", "02", "05", "04", "06", "08", "09", "11", "10", "12", "13", "15", "19", "16", "17", "18", "20", "21", "22", "23", "24",
             "25", "26", "27", "29", "28", "30", "31", "32", "33", "34", "35", "36", "37", "38",
             "39", "40", "41", "42", "44", "45", "46", "47", "48", "49", "50", "51", "53", "55", "54", "56"];
        
         statearray_tabs.forEach(function (statename, index) {
             stateData_tabs.push({ "name": statename, "abbr": abbrarray_tabs[index], "fips": fipsarray_tabs[index] });
         });

         var svg_tabs = d3.select('.countymapsvg');
         var width_tabs = svg_tabs.attr("width");
         var height_tabs = svg_tabs.attr("height");
         var actualwidth_tabs = width_tabs.replace("px", ""); //numeric value used for width
         var actualheight_tabs = height_tabs.replace("px", ""); //numeric value used for height

         var hovertooltipdiv_tabs = d3.select('body').append('div').attr('class', 'hovertooltip_tabs'); //adding hover tooltip div

         var mapcolors_tabs = ['#c6dbef', '#9ecae1', '#4292c6', '#08519c', '#081e6b'];//'#deebf7',
         var counties_tabs, states_tabs; //global variables to be used throughout

         var valMin_tabs, valMax_tabs, minmaxDiff_tabs; //public variables to be used for legend and the color fill of the counties

         var path_tabs = d3.geoPath().projection(null);
         var global_us_tabs, global_csv_tabs; //created global variables so the json and csv data can be accessed throughout the code
         var global_pov_data, global_ckd_data;
         var zoom_tabs = d3.zoom()
             .scaleExtent([1, 8])
             .on("zoom", zoomed); //default values set for 'zooming', calling the 'zoomed' function below

         $(document).ready(function () {
            
             $("#tinystatemap").hide();//hiding the state map on load
             $("#heatmapsort").hide(); //hide on load
             $(".heatmapsortlbl").hide();             

             var mapwidth_tabs = 790, //setting the height and width to mathc the values of the svg above
                 mapheight_tabs = 500;

             if ($('#hfMapType').val() == "6") { //if this is a county map, then create it along with displaying the tabs
                 
                 createUSMapChart(mapwidth_tabs, mapheight_tabs); //creating the map on page load
                 $("#pnlD3MapsTabs").show();//show the map tabs panel
                 $("#pnlMap").hide(); //hide the existing map panel
                 $("#btnDownloadChart").hide(); //hide the download chart button
                 $("#chartFormatOptions").hide(); //hide the formatting options
                 $("#chartFormatControls").hide(); 
                 $("#chartColorOptions").hide(); //hide the color options
                 $("#chartColorControls").hide(); 

                 console.log("createUSMapChart");
              
             }
             else
                 $("#pnlD3MapsTabs").hide(); //otherwise hide the map tabs panel
             

             $("#ddstate").change(function () {

                 var statecode_tabs = $(this).val();

                 if(statecode_tabs == "select")
                 {
                     $(".btnzoomout").click();
                     return;
                 }

                 var featurestate_tabs = topojson.feature(global_us_tabs, global_us_tabs.objects.states)
                     .features
                     .filter(function (d) { return d.id == statecode_tabs; })[0]; // filtering out the state by FIPS code, which is passed in above. get a geojson object (not an array of objects)
                 stateClicked_tabs(featurestate_tabs);

                 callHandler(statecode_tabs);

                 //10/13/2020
                 if ($("#tabbtn_maps").parent().hasClass("active")) $("#tabbtn_maps").click();
                 else if ($("#tabbtn_chart").parent().hasClass("active")) $("#tabbtn_chart").click();
                 else if ($("#tabbtn_heatmap").parent().hasClass("active")) $("#tabbtn_heatmap").click(); 

                 if ($("#hfChartID").val() == "4319") {
                     processData(allData);
                 }
             });

             $("#heatmapsort").change(function () {
                 if ($(this).val() != "select") {
                     var statecode_tabs = $("#ddstate").val();
                     callHandler(statecode_tabs);
                 }
             });

             $("#tabbtn_heatmap").click(function () {
                 console.log("inside tabbtn_heatmap click");
                 $("#heatmapsort").show();
                 $(".heatmapsortlbl").show();
                 var gd4 = d3.select('#heatmapchart');
                 var graphdiv = gd4.node();
                 Plotly.Plots.resize(graphdiv);

                 var gd4 = d3.select('#heatmapchart');
                 var graphdiv = gd4.node();
                 Plotly.Plots.resize(graphdiv);

                 $("#tinystatemap").show();

                 $(".btnzoomout").hide();
                 $("#exportCountyMapButton").hide();
                 

                 $(this).parent().addClass("active");
                 $("#tabbtn_maps").parent().removeClass("active");
                 $("#tabbtn_chart").parent().removeClass("active");

             });
             $("#tabbtn_maps").click(function () {
                 $("#heatmapsort").hide();
                 $(".heatmapsortlbl").hide();
                 $("#tinystatemap").hide();
                 $(".btnzoomout").show();
                 $("#exportCountyMapButton").show();
                 $(this).parent().addClass("active");
                 $("#tabbtn_chart").parent().removeClass("active");
                 $("#tabbtn_heatmap").parent().removeClass("active");
             });

             $("#tabbtn_chart").click(function () {
                 $("#heatmapsort").hide();
                 $(".heatmapsortlbl").hide();
                 $("#tinystatemap").show();
                 $("#tinybarchart").hide();
                 $(".btnzoomout").hide();
                 $("#exportCountyMapButton").hide();
                 $(this).parent().addClass("active");
                 $("#tabbtn_maps").parent().removeClass("active");
                 $("#tabbtn_heatmap").parent().removeClass("active");
             });

             //triggering the tabs to be clicked when the "tiny" charts are clicked on
             $("#tinystatemap").click(function () {
                 $("#tabbtn_maps").click();
                 console.log("inside tinystatemap click");
             });


             $("#tinybarchart").click(function () {
                 $("#tabbtn_chart").click();
                 console.log("inside tinybarchart click");
             });



             $(".btnzoomout").click(function () {
                 if ($("#hfChartID").val() == "4319") {
                     minX = 0;
                     maxX = 100;
                     minY = 0;
                     maxY = 100;

                     minVal = 0;
                     maxVal = 100;

                     selectedFips = '';

                     document.getElementById("pov_slider-1").value = 0;
                     document.getElementById("pov_slider-2").value = 100;
                     document.getElementById("ckd_slider-1").value = 0;
                     document.getElementById("ckd_slider-2").value = 100;

                     pov_slideOne();
                     pov_slideTwo();
                     ckd_slideOne();
                     ckd_slideTwo();

                     fillColor();
                 }
                 zoomOutToUS();                 
                 showAllCounties();
                 $("#heatmapsort").hide();
                 $(".heatmapsortlbl").hide();
                 $("#tinystatemap").hide();
                 $("#tinybarchart").hide();
                 $("#tinyheatmap").hide();

                 if ($("#hfChartID").val() == "4319") {
                     processData(allData);
                 }
             });

             //Fix search box at top(2021-May Release)
             $('#headerSearch').attr('style','max-width:225px;'); //thin up the box a bit
             $('.form-control-clear').remove(); //Remove 'X'
         });

         function callHandler(stateval) {
             console.log("inside call Handler");

             $.ajax({
                 type: "POST",
                 url: "Handlers/MapData_Handler.ashx",
                 data: "selectedstate=" + stateval + "^valMin=" + valMin_tabs + "^valMax=" + valMax_tabs + "^sortvalue=" + $("#heatmapsort").val() + "^yr=" + $("#hfCurrentYear").val() + "^chartid=" + $("#hfChartID").val() ,
                 success: function (response) {

                     eval(response);

                 },
                 error: function (jqXHR, textStatus, errorThrown) {
                     alert("textStatus=" + textStatus + " -- AJAX callHandler Error:" + errorThrown);
                 }
             });
         }

         function mapReady(error, usdata) { //the 'us' is the json data file from the the queue function, the 'csvdata' is from the csv file data
             
             if (error) throw error;
             global_us_tabs = usdata; //adding this passed int data to the global data
             if ($("#hfChartID").val() == "4319") {
                 if(colorSelected == colorCKDDark)
                     global_csv_tabs = countyDataArray.filter(val => val.datatype.includes("CKD"));//csvdata; //adding this passed int data to the global data
                 else
                     global_csv_tabs = countyDataArray.filter(val => val.datatype.includes("POV"));//csvdata; //adding this passed int data to the global data
             }
             else
                global_csv_tabs = countyDataArray;//csvdata; //adding this passed int data to the global data

             valMin_tabs = d3.min(global_csv_tabs, function (d) { return +d.countydatavalue; });//finding the minimum value in the csv data
             valMax_tabs = d3.max(global_csv_tabs, function (d) { return +d.countydatavalue; });//finding the maximum value in the csv data

             minmaxDiff_tabs = valMax_tabs - valMin_tabs; //finding the difference/range
             fillTheLegend_tabs(); // filling the legend with the quintiles

             //added 10/7/2020 to shrink the map to the actual width and height
             var stateprojectiondata = topojson.feature(usdata, usdata.objects.states);
             var projection = d3.geoIdentity().fitSize([actualwidth_tabs, actualheight_tabs], stateprojectiondata);
             var path_tabs = d3.geoPath()
                 .projection(projection);

             states_tabs = svg_tabs.append("g")

                 .selectAll("path") //creation of the state paths
                 .data(topojson.feature(global_us_tabs, global_us_tabs.objects.states).features)
                 .enter().append("path")
                 .attr("id", findstateid) //calling the findstateid function
                 .attr("class", findstatecls) //calling the findstatecls function

                 .style("stroke", "#000")//has to be added here so that the save image function holds onto the style.
                 .style("stroke-width", "1.5px") //adding thicker state borders
                 .style("fill", "#ccc")
                 .attr("d", path_tabs) //adding the path projection above
                 .on("mouseover", function (D) {
                     var statedatalabelval = createstatehoverover(D.id);
                     hovertooltipdiv_tabs.style('left', d3.event.pageX + 100 + 'px').style('top', d3.event.pageY - 60 + 'px') //displaying the popup on the text in addition to the state
                         .style('display', 'inline-block')
                         .style('transition', '.5s')
                         .style('opacity', '1')
                         .html(statedatalabelval + "<br><br>Click to view county level data");

                     $(".datastatelabel").html(statedatalabelval);
                     $(".datacountylabel").html("");
                     $(".datavaluelabel").html("");
                 })
                 .on("dblclick", reset)
                 .on("click", stateClicked_tabs); //when the state is clicked, call the 'stateclicked' function

             function createstatehoverover(stateid) {
                 var return_name = "";
                 d3.select(this)
                     .data(stateData_tabs.filter(function (C) {
                         if (C.fips == stateid)
                             return_name = C.name;
                     }
                     ));

                 return return_name;
             }

             function findstateid(s) {
                 return "state-" + s.id;//returning the id to be attached to the "id" value
             }

             function findstatecls(s) {
                 return "cls-state-" + s.id;//returning the id to be attached to the "id" value
             }

             function reset() {
                 states_tabs.transition() //zooming out //have to zoom on the 'states' portion of the svg
                     .duration(500)
                     .call(zoom_tabs.transform, d3.zoomIdentity); // updated for d3 v4
             }

             //starting off by showing GA first when the map page is loaded
             $(".btnzoomout").click();

             var statecode_tabs = $("#ddstate").val();
             if (statecode_tabs != "select") {
                 var featurestate_tabs = topojson.feature(global_us_tabs, global_us_tabs.objects.states)
                 .features
                 .filter(function (d) { return d.id == statecode_tabs; })[0]; // filtering out the state by FIPS code, which is passed in above. get a geojson object (not an array of objects)
             
                 stateClicked_tabs(featurestate_tabs);

                 callHandler(statecode_tabs);
             }
             
         }


         //moved this outside of the createmap function so that it can be accessed by the dropdown state change
         function stateClicked_tabs(d) { //passing in the json string of the state             
             hideAllCounties();
             $(".msgzoomout").hide();
             $(".btnzoomout").show();
             $("#exportCountyMapButton").show();
             hovertooltipdiv_tabs.style('display', 'none')
                 .style('opacity', '0;')

             var statecode = d.id; //finding the state id based on the data passed in
             var statename = "";
             stateData_tabs.filter(function (S) { //finding the statename so that it can be used when updating the label outside of the map
                 if (S.fips == statecode)
                     statename = S.name;
             });

             selectedstateid = statecode;
             var allCounties = topojson.feature(global_us_tabs, global_us_tabs.objects.counties).features; //finding all counties
             var countiesarray = [];

             allCounties.forEach(function (c) { //then loop through all of the counties and filter out based on the first two characters (which is the state)
                 var sid = statecode;
                 var cid = c.id + "";
                 if (cid.slice(0, sid.length) === sid && cid.length - sid.length == 3) countiesarray.push(c);
             });

             if ($("#hfChartID").val() == "4319") {
                 if (colorSelected == colorCKDDark)
                     global_csv_tabs = countyDataArray.filter(val => val.datatype.includes("CKD"));//csvdata; //adding this passed int data to the global data
                 else
                     global_csv_tabs = countyDataArray.filter(val => val.datatype.includes("POV"));//csvdata; //adding this passed int data to the global data
             }

             //if we don't show all counties then remove the other counties being shown, otherwise keep them displayed
             svg_tabs.selectAll("g.counties").remove();//removing any existing counties that are being displayed

             //added 10/7/2020 to project the counties to fit to the actual width and height variables
             var countyprojectiondata = topojson.feature(global_us_tabs, global_us_tabs.objects.counties);
             var countyprojection = d3.geoIdentity().fitSize([actualwidth_tabs, actualheight_tabs], countyprojectiondata);
             var path_tabs = d3.geoPath()
                 .projection(countyprojection);

             counties_tabs = svg_tabs.append('g').attr('class', 'counties').selectAll('path') //begin drawing the paths
                 .data(countiesarray) //using only the filtered counties for the state
                 .enter()
                 .append('path').attr('d', path_tabs).attr("id", function (d) { return d.id; })

                 .style("fill", function (cdata) { //loading the csv data in the queue
                     var filtercountyrow = global_csv_tabs.filter(function (d, i) {
                         return d.fipscounty == cdata.id; //just match on the countyid from the countiesarray and match it with the fipscounty columns fro mthe excel file and then return the whole row of data
                     });

                     if (filtercountyrow.length === 0)
                         dataval = "MIA";
                     else
                         dataval = filtercountyrow[0]["countydatavalue"];
                     
                     var colorval;
                     colorval = findColorVal(dataval);

                     if (selectedFips != "" && cdata.id != selectedFips)
                         colorval = "#ddd";

                     return colorval;
                 })

                 .style("stroke", "#444")//has to be added here so that the save image function holds onto the style.
                 .style("stroke-width", ".5px")
                 .on("mouseover", function (D) {

                     hovertooltipdiv_tabs.style('left', d3.event.pageX + 50 + 'px').style('top', d3.event.pageY - 60 + 'px') //displaying the popup on the text in addition to the state
                         .style('display', 'inline-block') //setting up the hover tool div
                         .style('transition', '.5s')
                         .style('opacity', '1')
                         .html(function (h) {

                             var filtercountyrow = global_csv_tabs.filter(function (d, i) {
                                 return d.fipscounty == D.id; //just match on the countyid and then return the whole row of data
                             });

                             var county_val;
                             var data_val;
                             var countydatalabelval;

                             if (filtercountyrow.length === 0) {
                                 county_val = "NA";
                                 data_val = "";
                                 countydatalabelval = "NA";
                             }
                             else if ((filtercountyrow[0]["countydatavalue"] === "NA" || Number(filtercountyrow[0]["countydatavalue"]) <= 10) && $("#hfChartID").val() != "4319") {
                                 statename = filtercountyrow[0]["state"]
                                 county_val = filtercountyrow[0]["county"];
                                 data_val = filtercountyrow[0]["countydatavalue"];
                                 var color = findColorVal(data_val);
                                 var htmlwrap = "<div style='background-color:" + color + ";font-weight:bold;font-size:22px;text-align:center'>NA</div>";
                                 htmlwrap = htmlwrap + "<div style='margin-top:5px;font-size:18px'>County: <span style='font-weight:bold;font-size:18px'>" + county_val + "</span></div>";
                                 htmlwrap = htmlwrap + "<div style='margin-top:5px'>State: <span >" + statename + "</span></div>";
                                 countydatalabelval = htmlwrap;
                             }
                             else {
                                 county_val = filtercountyrow[0]["county"];
                                 data_val = filtercountyrow[0]["countydatavalue"];
                                 
                                 var color = findColorVal(data_val);
                                 if (selectedFips != "" && D.id != selectedFips)
                                     color = "#ddd";
                                 var htmlwrap = "<div style='background-color:" + color + ";font-weight:bold;font-size:22px;text-align:center'>" + data_val + "%</div>";

                                 if ($("#hfChartID").val() === "4319" && data_val === "NA")
                                     htmlwrap = "<div style='background-color:" + color + ";font-weight:bold;font-size:22px;text-align:center'>" + data_val + "</div>";

                                 if (statecode == "22")
                                     htmlwrap = htmlwrap + "<div style='margin-top:5px;font-size:18px'>Parish: <span style='font-weight:bold;font-size:18px'>" + county_val + "</span></div>";
                                 else if (statecode == "02")
                                     htmlwrap = htmlwrap + "<div style='margin-top:5px;font-size:18px'>Borough: <span style='font-weight:bold;font-size:18px'>" + county_val + "</span></div>";
                                 else
                                     htmlwrap = htmlwrap + "<div style='margin-top:5px;font-size:18px'>County: <span style='font-weight:bold;font-size:18px'>" + county_val + "</span></div>";
                                 
                                 htmlwrap = htmlwrap + "<div style='margin-top:5px'>State: <span >" + statename + "</span></div>";
                                 countydatalabelval = htmlwrap;
                             }

                             $(".datastatelabel").html(statename);

                             $(".datacountylabel").removeAttr("style").hide();
                             $(".datacountylabel").show();
                             $(".datacountylabel").html(county_val);

                             $(".datavaluelabel").removeAttr("style").hide();
                             $(".datavaluelabel").show();
                             $(".datavaluelabel").html(data_val);

                             return countydatalabelval;
                         })

                 })
                 .on("click", function (data) {
                     if ($("#hfChartID").val() == "4319") {
                         selectedFips = data.id;
                         stateClicked_tabs(d);
                         processData(allData);
                     }
                 });

             //finding the bounds and location for zooming, from bl.ocks.org/iamkevinv/0a24e9126cd2fa6b283c6f2d774b69a2
             var bounds = path_tabs.bounds(d),
                 dx = bounds[1][0] - bounds[0][0],
                 dy = bounds[1][1] - bounds[0][1],
                 x = (bounds[0][0] + bounds[1][0]) / 2,
                 y = (bounds[0][1] + bounds[1][1]) / 2,
                 scale = Math.max(1, Math.min(8, 0.9 / Math.max(dx / actualwidth_tabs, dy / actualheight_tabs))),
                 translate = [actualwidth_tabs / 2 - scale * x, actualheight_tabs / 2 - scale * y];

             states_tabs.transition() //have to zoom on the 'states' portion of the svg using the translate and scale calculated from above
                 .duration(750)
                 .call(zoom_tabs.transform, d3.zoomIdentity.translate(translate[0], translate[1]).scale(scale)); // updated for d3 v4


             drawTinyStateLevelMap(statecode);

             if ($("#ddstate").val() != statecode) {
                 $("#ddstate").val(statecode);
                 callHandler(statecode);
             }
                 
         }

         //moved this outside of the createmap function so that it can be accessed by the dropdown state change
         function showAllCounties() { //passing in the json string of the state
             selectedstateid = "";
             if ($("#hfChartID").val() == "4319") {
                 if (colorSelected == colorCKDDark)
                     global_csv_tabs = countyDataArray.filter(val => val.datatype.includes("CKD"));//csvdata; //adding this passed int data to the global data
                 else
                     global_csv_tabs = countyDataArray.filter(val => val.datatype.includes("POV"));//csvdata; //adding this passed int data to the global data
             }

             svg_tabs.selectAll("g.counties").remove();

             var allCounties = topojson.feature(global_us_tabs, global_us_tabs.objects.counties).features; //finding all counties
             
             var countyprojectiondata = topojson.feature(global_us_tabs, global_us_tabs.objects.counties);
             var countyprojection = d3.geoIdentity().fitSize([actualwidth_tabs, actualheight_tabs], countyprojectiondata);
             var path_tabs = d3.geoPath()
                 .projection(countyprojection);

             counties_tabs = svg_tabs.append('g').attr('class', 'counties').selectAll('path') //begin drawing the paths
                 .data(allCounties) //using only the filtered counties for the state
                 .enter()
                 .append('path').attr('d', path_tabs).attr("id", function (d) { return d.id; })

                 .style("fill", function (cdata) { //loading the csv data in the queue
                     var filtercountyrow = global_csv_tabs.filter(function (d, i) {
                         return d.fipscounty == cdata.id; //just match on the countyid from the countiesarray and match it with the fipscounty columns fro mthe excel file and then return the whole row of data
                     });

                     if (filtercountyrow.length === 0)
                         dataval = "MIA";
                     else
                         dataval = filtercountyrow[0]["countydatavalue"];

                     var colorval;
                     colorval = findColorVal(dataval);
                     if (selectedFips != "" && cdata.id != selectedFips)
                         colorval = "#ddd";

                     return colorval;
                 })

                 .style("stroke", "#444")//has to be added here so that the save image function holds onto the style.
                 .style("stroke-width", ".5px")
                 .on("mouseover", function (D) {

                     hovertooltipdiv_tabs.style('left', d3.event.pageX + 50 + 'px').style('top', d3.event.pageY - 60 + 'px') //displaying the popup on the text in addition to the state
                         .style('display', 'inline-block') //setting up the hover tool div
                         .style('transition', '.5s')
                         .style('opacity', '1')
                         .html(function (h) {

                             var filtercountyrow = global_csv_tabs.filter(function (d, i) {
                                 return d.fipscounty == D.id; //just match on the countyid and then return the whole row of data
                             });

                             var county_val;
                             var data_val;
                             var countydatalabelval;
                             var statename;

                             if (filtercountyrow.length === 0) {
                                 county_val = "NA";
                                 data_val = "";
                                 countydatalabelval = "NA";
                             }
                             else if ((filtercountyrow[0]["countydatavalue"] === "NA" || Number(filtercountyrow[0]["countydatavalue"]) <= 10) && $("#hfChartID").val() != "4319") {
                                 statename = filtercountyrow[0]["state"]
                                 county_val = filtercountyrow[0]["county"];
                                 data_val = filtercountyrow[0]["countydatavalue"];
                                 var color = findColorVal(data_val);                                
                                 var htmlwrap = "<div style='background-color:" + color + ";font-weight:bold;font-size:22px;text-align:center'>NA</div>";
                                 htmlwrap = htmlwrap + "<div style='margin-top:5px;font-size:18px'>County: <span style='font-weight:bold;font-size:18px'>" + county_val + "</span></div>";
                                 htmlwrap = htmlwrap + "<div style='margin-top:5px'>State: <span >" + statename + "</span></div>";
                                 countydatalabelval = htmlwrap;
                             }
                             else {
                                 statename = filtercountyrow[0]["state"]
                                 county_val = filtercountyrow[0]["county"];
                                 data_val = filtercountyrow[0]["countydatavalue"];
                                 var color = findColorVal(data_val);
                                 if (selectedFips != "" && D.id != selectedFips)
                                     color = "#ddd";

                                 var htmlwrap = "<div style='background-color:" + color + ";font-weight:bold;font-size:22px;text-align:center'>" + data_val + "%</div>";

                                 if ($("#hfChartID").val() === "4319" && data_val ==="NA")
                                     htmlwrap = "<div style='background-color:" + color + ";font-weight:bold;font-size:22px;text-align:center'>" + data_val + "</div>";
                                
                                 htmlwrap = htmlwrap + "<div style='margin-top:5px;font-size:18px'>County: <span style='font-weight:bold;font-size:18px'>" + county_val + "</span></div>";
                                 htmlwrap = htmlwrap + "<div style='margin-top:5px'>State: <span >" + statename + "</span></div>";
                                 countydatalabelval = htmlwrap;
                             }

                             $(".datastatelabel").html(statename);

                             $(".datacountylabel").removeAttr("style").hide();
                             $(".datacountylabel").show();
                             $(".datacountylabel").html(county_val);

                             $(".datavaluelabel").removeAttr("style").hide();
                             $(".datavaluelabel").show();
                             $(".datavaluelabel").html(data_val);

                             return countydatalabelval;
                         })

                 })
                 .on("click", function (data) {
                     if ($("#hfChartID").val() == "4319") {
                         selectedFips = data.id;
                         changeColor();
                         processData(allData);
                     }
                 });
         }

         function hideAllCounties() {
             svg_tabs.selectAll("g.counties").remove();
         }

         function zoomOutToUS() {
             states_tabs.transition() //zooming out //have to zoom on the 'states' portion of the svg
                 .duration(750)
                 .call(zoom_tabs.transform, d3.zoomIdentity);
             $("#ddstate").val("select");
         }

         function fillTheLegend_tabs() {
             //begin legend code
             var boxmargin = 4,
                 lineheight = 14,
                 keyheight = 10,
                 keywidth = 45,
                 boxwidth = 2 * keywidth;

             var titleheight = lineheight * 4;

             var margin = { "left": 10, "top": 10 };

             var x = d3.scaleLinear()
                 .domain([valMin_tabs, valMax_tabs]);

             var quantize = d3.scaleQuantize()
                 .domain([valMin_tabs, valMax_tabs])
                 .range(colorarray_tabs);

             var ranges = quantize.range().length;
             var legendsvg = d3.select('.legendsvg');

             var legend = legendsvg.append("g")
                 .attr("transform", "translate (" + margin.left + "," + margin.top + ")");

             var lb = legend.append("rect")
                 .attr("transform", "translate (0,0)")
                 .attr("class", "legend-box")
                 .attr("fill", "#fff")
                 .attr("width", ranges * lineheight + 2 * boxmargin + lineheight - keyheight)
                 .attr("height", lineheight);


             // make quantized key legend items
             var li = legend.append("g")
                 .attr("transform", "translate (8,0)")
                 .attr("class", "legend-items");

           
             li.selectAll("rect")
                 .data(quantize.range().map(function (color) {
                     var d = quantize.invertExtent(color);
                     if (d[0] == null) d[0] = x.domain()[0];
                     if (d[1] == null) d[1] = x.domain()[1];
                     return d;
                 }))
                 .enter().append("rect")
                 .attr("x", function (d, i) { return (i - 1) * 2 * keywidth + (2 * keywidth); })
                 .attr("width", keywidth * 2 )
                 .attr("height", keyheight * 2)
                 .style("stroke", "#29434E")
                 .style("stroke-width", "0.5px")
                 .style("fill", function (d) { return quantize(d[0]); });

             d3.select('.upperlegend').remove();
             d3.select('.lowerlegend').remove();

             var legendtext1 = "";
             var legendtext2 = "";
             var legendtext3 = "";
             var legendtext4 = "";
             var legendtext5 = "";            

             if ($("#hfChartID").val() == "4019") { //Overall
                 legendtext1 = "NA";
                 legendtext2 = "< 14%";
                 legendtext3 = "14 - 16.9%";
                 legendtext4 = "17 - 19.9%";
                 legendtext5 = "≥ 20%";
             } else if ($("#hfChartID").val() == "4039") { //Diabetes
                 legendtext1 = "NA";
                 legendtext2 = "< 22%";
                 legendtext3 = "22 - 26.9%";
                 legendtext4 = "27 - 31.9%";
                 legendtext5 = "≥ 32%";
             } else if ($("#hfChartID").val() == "4040") { //Hypertension
                 legendtext1 = "NA";
                 legendtext2 = "< 18%";
                 legendtext3 = "18 - 20.9%";
                 legendtext4 = "21 - 24.9%";
                 legendtext5 = "≥ 25 %";
             }

             li.append("text")
                 .attr("class", "upperlegend")
                 .attr("x", 31)
                 .attr("y", 14)
                 .text(legendtext1);

             li.append("text")
                 .attr("class", "upperlegend")
                 .attr("x", 112)
                 .attr("y", 14)
                 .text(legendtext2);

             li.append("text")
                 .attr("class", "upperlegend")
                 .attr("x", 192)
                 .attr("y", 14)
                 .text(legendtext3);

             li.append("text")
                 .attr("class", "upperlegend")
                 .attr("x", 280)
                 .attr("y", 14)
                 .text(legendtext4);

             li.append("text")
                 .attr("class", "upperlegend")
                 .attr("x", 386)
                 .attr("y", 14)
                 .text(legendtext5);

             //end legend code

         }

         function zoomed() {
             states_tabs.attr("transform", d3.event.transform); // updated for d3 v4 //have to zoom on the 'states' portion of the svg
             counties_tabs.attr("transform", d3.event.transform); // updated for d3 v4 //have to zoom on the 'counties' portion of the svg
         }

         // If the drag behavior prevents the default click,
         // also stop propagation so we don’t click-to-zoom.
         function stopped() {
             if (d3.event.defaultPrevented) d3.event.stopPropagation();
         }

         function findColorVal(dataval) {    
             var colorval;
             //***** Q705 change *******/
             if ($("#hfChartID").val() == "4019") { //Overall
                 if (dataval === "NA")
                    colorval = "#ddd"; //was white at one point
                 else if (dataval === "MIA")
                     colorval = "#ddd";
                 else if (dataval >= valMin_tabs + 20) 
                     colorval = colorarray_tabs[4];
                 else if (dataval >= (valMin_tabs + 17) && dataval < (valMin_tabs + 20))
                     colorval = colorarray_tabs[3];
                 else if (dataval >= (valMin_tabs + 14) && dataval < (valMin_tabs + 17)) 
                     colorval = colorarray_tabs[2];
                 else if (dataval >= (valMin_tabs + 10) && dataval < (valMin_tabs + 14)) 
                     colorval = colorarray_tabs[1];
                 else if (dataval < (valMin_tabs + 10)) 
                     colorval = colorarray_tabs[0];

             } else if ($("#hfChartID").val() == "4039") { //Diabetes
                 if (dataval === "NA")
                     colorval = "#ddd"; //was white at one point
                 else if (dataval === "MIA")
                     colorval = "#ddd";
                 else if (dataval >= valMin_tabs + 32) 
                     colorval = colorarray_tabs[4];
                 else if (dataval >= (valMin_tabs + 27) && dataval < (valMin_tabs + 32))
                     colorval = colorarray_tabs[3];
                 else if (dataval >= (valMin_tabs + 22) && dataval < (valMin_tabs + 27))
                     colorval = colorarray_tabs[2];
                 else if (dataval >= (valMin_tabs + 10) && dataval < (valMin_tabs + 22))
                     colorval = colorarray_tabs[1];
                 else if (dataval < (valMin_tabs + 10))
                     colorval = colorarray_tabs[0];
             }
             else if ($("#hfChartID").val() == "4040") { //Hypertension
                 if (dataval === "NA")
                     colorval = "#ddd"; //was white at one point
                 else if (dataval === "MIA")
                     colorval = "#ddd";
                 else if (dataval >= valMin_tabs + 25) 
                     colorval = colorarray_tabs[4];
                 else if (dataval >= (valMin_tabs + 21) && dataval < (valMin_tabs + 25)) 
                     colorval = colorarray_tabs[3];
                 else if (dataval >= (valMin_tabs + 18) && dataval < (valMin_tabs + 21)) 
                     colorval = colorarray_tabs[2];
                 else if (dataval >= (valMin_tabs + 10) && dataval < (valMin_tabs + 18)) 
                     colorval = colorarray_tabs[1];
                 else if (dataval < (valMin_tabs + 10)) 
                     colorval = colorarray_tabs[0];
             }
                 /* Linked Map */
             else if ($("#hfChartID").val() == "4319") { /* TODO: add logic for CKD and POV */
                 var interval = 1.9;
                 if (dataval === "NA")
                     colorval = "#ddd"; //was white at one point
                 else if (dataval === "MIA")
                     colorval = "#ddd";
                 else if (parseFloat(dataval) >= parseFloat(minVal) && parseInt(dataval) <= parseFloat(maxVal)) {
                     for (var i = 1; i < 30; i++) {
                         if (parseFloat(dataval) < valMin_tabs) {
                             if (colorSelected == colorPovDark) {
                                 colorval = pov_colorarray_tabs[0];
                                 break;
                             }
                             else {
                                 colorval = ckd_colorarray_tabs[0];
                                 break;
                             }
                         }
                         else if (parseFloat(dataval) >= (valMin_tabs + interval * (i - 1)) && parseFloat(dataval) < (valMin_tabs + interval * i)) {
                             if (colorSelected == colorPovDark) {
                                 colorval = pov_colorarray_tabs[i];
                                 break;
                             }
                             else {
                                 colorval = ckd_colorarray_tabs[i];
                                 break;
                             }
                         }
                     }
                 }
                 else 
                    colorval = "#ddd";

                 document.getElementById("main_map").style.width = "50%";
                 document.getElementById("linkedmap_scatter").style.display = "initial";
                 document.getElementById("mapbar").style.display = "none";
                 
             }

             return colorval;
         }

     </script>
    <%--**********************--%>
    <%--*END D3 Maps V2 TABS chart update*--%>
    <%--**********************--%>


    <%--**********************--%>
    <%--*BEGIN save as png functionality*--%>
    <%--**********************--%>
     <script>
         d3.select('#exportCountyMapButton').on('click', function () { exportMap("county"); });
         d3.select('#exportButton').on('click', function () { exportMap("national"); });

         // Set-up the export button
         function exportMap(maptype) {

             $("#canvascontainer").find("#canvas").remove(); //removing the canvas element

             $("<canvas id='canvas'  width='960' height='650' ></canvas>").appendTo("#canvascontainer"); //adding a new canvas element

             var svgString;
             if (maptype == "county")
                 svgString = new XMLSerializer().serializeToString(document.querySelector('.countymapsvgwrapper'));//svgString = new XMLSerializer().serializeToString(document.querySelector('.countymapsvg'));
             else
                 svgString = new XMLSerializer().serializeToString(document.querySelector('.usmapsvg'));

             var canvas = document.getElementById("canvas");
             var ctx = canvas.getContext("2d");
             var DOMURL = self.URL || self.webkitURL || self;
             var img = new Image();
             var svg = new Blob([svgString], { type: "image/svg+xml;charset=utf-8" });
             var url = DOMURL.createObjectURL(svg);
             img.onload = function () {
                 ctx.drawImage(img, 0, 0);
                 var png = canvas.toDataURL("image/png");
                 
                 document.querySelector('#png-container').innerHTML = '<img src="' + png + '"/>';
                 DOMURL.revokeObjectURL(png);

                 var link = document.createElement('a');
                 link.href = png;
                 link.download = "Downloaded Charts.png";
                 document.body.appendChild(link);
                 link.click();

             };
             img.src = url;

             $("#canvas").prop("style", "display:none");
         }

         // Below are the functions that handle actual exporting:
         // getSVGString ( svgNode ) and svgString2Image( svgString, width, height, format, callback )
         function getSVGString(svgNode) {
             svgNode.setAttribute('xlink', 'http://www.w3.org/1999/xlink');
             var cssStyleText = getCSSStyles(svgNode);
             appendCSS(cssStyleText, svgNode);

             var serializer = new XMLSerializer();
             var svgString = serializer.serializeToString(svgNode);
             svgString = svgString.replace(/(\w+)?:?xlink=/g, 'xmlns:xlink='); // Fix root xlink without namespace
             svgString = svgString.replace(/NS\d+:href/g, 'xlink:href'); // Safari NS namespace fix

             return svgString;

             function getCSSStyles(parentElement) {
                 var selectorTextArr = [];

                 // Add Parent element Id and Classes to the list
                 selectorTextArr.push('#' + parentElement.id);
                 for (var c = 0; c < parentElement.classList.length; c++)
                     if (!contains('.' + parentElement.classList[c], selectorTextArr))
                         selectorTextArr.push('.' + parentElement.classList[c]);

                 // Add Children element Ids and Classes to the list
                 var nodes = parentElement.getElementsByTagName("*");
                 for (var i = 0; i < nodes.length; i++) {
                     var id = nodes[i].id;
                     if (!contains('#' + id, selectorTextArr))
                         selectorTextArr.push('#' + id);

                     var classes = nodes[i].classList;
                     for (var c = 0; c < classes.length; c++)
                         if (!contains('.' + classes[c], selectorTextArr))
                             selectorTextArr.push('.' + classes[c]);
                 }

                 // Extract CSS Rules
                 var extractedCSSText = "";
                 for (var i = 0; i < document.styleSheets.length; i++) {
                     var s = document.styleSheets[i];

                     try {
                         if (!s.cssRules) continue;
                     } catch (e) {
                         if (e.name !== 'SecurityError') throw e; // for Firefox
                         continue;
                     }

                     var cssRules = s.cssRules;
                     for (var r = 0; r < cssRules.length; r++) {
                         if (contains(cssRules[r].selectorText, selectorTextArr))
                             extractedCSSText += cssRules[r].cssText;
                     }
                 }


                 return extractedCSSText;

                 function contains(str, arr) {
                     return arr.indexOf(str) === -1 ? false : true;
                 }

             }

             function appendCSS(cssText, element) {
                 var styleElement = document.createElement("style");
                 styleElement.setAttribute("type", "text/css");
                 styleElement.innerHTML = cssText;
                 var refNode = element.hasChildNodes() ? element.children[0] : null;
                 element.insertBefore(styleElement, refNode);
             }
         }


         function svgString2Image(svgString, width, height, format, callback) {
             var format = format ? format : 'png';

             var imgsrc = 'data:image/svg+xml;base64,' + btoa(unescape(encodeURIComponent(svgString))); // Convert SVG string to data URL

             var canvas = document.createElement("canvas");
             var context = canvas.getContext("2d");

             canvas.width = width;
             canvas.height = height;

             var image = new Image();
             image.onload = function () {
                 context.clearRect(0, 0, width, height);
                 context.drawImage(image, 0, 0, width, height);

                 canvas.toBlob(function (blob) {
                     var filesize = Math.round(blob.length / 1024) + ' KB';
                     if (callback) callback(blob, filesize);
                 });


             };

             image.src = imgsrc;
         }
     </script>
    <%--**********************--%>
    <%--*END save as png functionality*--%>
    <%--**********************--%>
   
</asp:Content>