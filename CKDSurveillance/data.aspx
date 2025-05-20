<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Data.aspx.cs" Inherits="CKDSurveillance_RD.Data" MasterPageFile="~/MasterPages/ResponsiveContentLeftNavNew.Master" %>

<%@ Register Src="~/UserControls/Navigation/SideNav.ascx" TagPrefix="uc1" TagName="SideNav" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <style>
        .accordion-table-header {
            text-align: center;
            font-weight: bold;
            color: #1a7aa2;
            font-size: 16px;
        }

        .dsList {
            border-radius: 5px;
            border: solid 1px silver;
            background-color: whitesmoke;
            display: none;
            z-index: 1000;
            cursor: pointer;
            display: block;
            position: absolute;
            overflow-y: auto;
            max-height: 400px;
            background-clip: padding-box;
            box-shadow: 0 5px 10px rgba(0,0,0,0.2);
        }

            .dsList ul {
                padding: 0;
                margin: 0;
                list-style: none;
                text-align: left;
            }

        .dsSearch {
            cursor: pointer;
        }

        .subTitleHPlink {
            text-align: left;
            /*font: normal normal 600 17px/52px Open Sans;*/
            font-family:Nunito;
            font-size: 17px !important;
            font-weight:600 !important;
            letter-spacing: 0px;
            text-decoration: none !important; /*remove underline*/
            color:  #0b4778 !important; /*#007C91;*/
            opacity: 1;
            padding-left:10px !important;            
        }

        .subTitleHPbg {
            background: /*#00695C*/ #005ea2 0% 0% no-repeat padding-box;             
            opacity: 0.05;   
            padding-top:10px !important;
            padding-bottom:10px !important;
        }
        .subTitleHPleftmargin{
            background: /*#00695C*/ #005ea2 0% 0% no-repeat padding-box;
            opacity: 0.15;
        }
        .HPIDheader{
            text-align: left !important;
            /*font: normal normal 600 22px/42px Open Sans;*/
            font-family:Nunito !important;
            font-size: 22px !important;
            font-weight:600 !important;
            letter-spacing: -0.22px;
            color: #222222;
            opacity: 1;
        }
        .HPIDtext{
            text-align: left !important;
            /*font: normal normal normal 17px/24px Open Sans;*/
            font-family:Nunito !important;
            font-size: 17px !important;
            letter-spacing: 0px;
            color: #000000;
            opacity: 1;
            padding-top:5px;
            /*padding-bottom:5px;*/
        }
        .bodyColHeaderBg{
            background: #29434EBF 0% 0% no-repeat padding-box;
            opacity: 1;
            padding-top:10px;
            padding-bottom:10px;
        }
        .bodyColHeaderText{
            text-align: center;
            /*font: normal normal 600 18px/24px Open Sans;*/
            font-family:Nunito !important;
            font-size: 19px !important;
            font-weight:600 !important;      /*600	Semi Bold (Demi Bold)    */   
            letter-spacing: 0px;
            color: #FFFFFF;
            opacity: 1;
        }
        PIbodyTitle {
            font-family: Poppins !important;
            font-size: 38px !important;
            letter-spacing: -0.38px;
            margin-top:17px !important;
            margin-bottom:12px;
            /*color: #29434E;
            opacity: 1;*/
        }
    </style>


    <br /><br />
    
<!-- Page Content Wrap -->
	<div class="container d-flex flex-wrap body-wrapper bg-white">

			<!-- Content -->
			<main id="PImainbody"   class="col-xl-9 order-xl-2"  role="main" aria-label="Main Content Area" style="border:0px;padding-top:1px; padding-left:15px; padding-right:15px;">
					<div id="PIdivbody" class="row" >
						<div  class="col content" style="margin-top: 0px !important;padding-left:51px; padding-right:15px;border:0px;">										
							<div class="cdc-2020-bar container">
								<div class="row no-gutters">
									<div class="bar-item" style="padding-left:0px;">
											<a href="default.aspx"  style="border-top:#2B8277" id="ckd-nav-home-link2" class="ckd-nav-home-link">										
											<span class="PIhomebreadcrumb"><u>Home</u></span> </a> 
										    <span id="bcTopic" class="PIbodybreadcrumb"> > Healthy People 2030 </span>  <%--selected topic from top nav --%>
											<span id="bcSelListItem" class="PIbodybreadcrumb">  </span>  <%--selected list item from left nav --%>
											<%--<span id="bcPIlinks" class="PIbodybreadcrumb">  > </span>--%>
									</div>
								</div>
							</div>
							<div style="padding-top:40px !important; font-size:38px; font-family:Nunito;">
								<h1 id="content" class="PIbodyTitle" style="font-family: Poppins;"><span id="topicTitle" >
                                    <%--<asp:Literal ID="Lit_TopicTitle" runat="server"></asp:Literal>--%>
                                    Healthy People 2030
                                    </span> </h1>								
							</div>
							<p>                   
								<span class="PIbody"><%--<asp:Literal ID="Lit_Desc" runat="server"></asp:Literal>--%>
                                    The Healthy People 2030 (HP2030) program sets data-driven national objectives to improve the health and well-being of Americans over the next decade. There are 14 goals related to kidney disease, 10 of which are about chronic kidney disease. Shown below are six HP2030 goals related to chronic kidney disease (CKD-01, CKD-02, CKD-04, CKD-05 and CKD-D01) and one goal (D-05) related to diabetes and urinary albumin testing. Goals are tracked using several data sources. See <a href="health.gov/healthypeople">health.gov/healthypeople</a>
                                    for the HP2030 website. 
								</span>
							</p>
                                                       
                      
                       <%-- <div class="row">
                            <div class="accordion indicator-plus accordion-white" aria-multiselectable="true" role="tabpanel">
                                <asp:Literal ID="litHp2020_new" runat="server"></asp:Literal>
                            </div>
                        </div>--%>



    <asp:Panel ID="pnlIndicators" runat="server">
        <div class="container">
            <div class="row">              
                    <div class="Pagetitle" runat="server" id="_dvPageTitle">
                        <asp:Literal ID="litBrowseLabel" runat="server" Text="Browse Data by Topic"></asp:Literal>
                    </div>               
            </div>
        </div>
        <div class="container">
    <%--        <div class="row" style="padding-bottom: 10px;">
                <div class="col-md-8"></div>
                <div class="col-md-3 col-sm-12 text-right">
                    <button class="openall btn btn-primary">&nbsp;Expand All&nbsp;</button>
                    <button class="closeall btn btn-primary">&nbsp;Collapse All&nbsp;</button>
                </div>
            </div>--%>
            <div class="row">                
                    <%--***********************************--%>
                    <%--*List of Data Sources (short name)*--%>
                    <%--***********************************--%>
                    <asp:Literal ID="litDataSources" runat="server" Text="" ClientIDMode="Static" />                
            </div>
            <div class="row">               
                    <div class="accordion indicator-plus accordion-white" role="tabpanel">
                        <asp:Literal ID="litIndicators" runat="server"></asp:Literal>
                    </div>               
            </div>

            <div class="row">                
                    <div class="accordion indicator-plus accordion-white" role="tabpanel">
                        <asp:Literal ID="litSpecialPops" runat="server"></asp:Literal>
                    </div>                
            </div>
        </div>
    </asp:Panel>

    <%--*******************************--%>
    <!--*Show Healthy People 2020 text*-->
    <%--*******************************--%>
    <asp:Panel ID="pnlHP2020" runat="server">
        <div class="container">           
                    <div id="_dvHP2020Description" runat="server" style="clear: both; margin-top: 10px" >  <%--class="module roundem faqs padcontents10"--%>
                            <div  style="margin-top: 10px">                               
                                       <%--*2030*--%>
                                    <div class="row navBoldHeader d-sm-block subTitleHPbg" >   <%--style="background: #00695C 0% 0% no-repeat padding-box; opacity: 0.05; padding-right:0px;margin-right:0px;"--%>
                                        <a class="subTitleHPlink" href="https://health.gov/healthypeople/objectives-and-data/browse-objectives/chronic-kidney-disease" ID="lnkHealthy2030Objectives" target="_blank">View the CKD objectives for Healthy People 2030 &nbsp; 
                                            <img src="images/HP2030-blackarrow.png" alt="open a new window"/> </a>
                                     
                                        <%--   <asp:HyperLink CssClass ="subTitleHPlink"
                                            ID="lnkHealthy2030Objectives" runat="server" NavigateUrl="https://health.gov/healthypeople/objectives-and-data/browse-objectives/chronic-kidney-disease"
                                            Text="View the CKD objectives for Healthy People 2030" Target="_blank">                                            
                                        </asp:HyperLink>
                                        <span class="fi cdc-icon-external x16">&nbsp;&nbsp;</span>--%>
                                    </div>
                                </div>                                             
                    </div>              
            

<%--            <div class="row" style="padding-bottom: 10px; margin-top: 10px;">
                <div class="col-md-8"></div>
                <div class="col-md-4 col-sm-12">
                    <button class="openall btn btn-primary b-primary">&nbsp;Expand All&nbsp;</button>
                    <button class="closeall btn btn-primary b-primary">&nbsp;Collapse All&nbsp;</button>
                </div>
            </div>--%>
            <br />
            
                <div class="row HPIDheader">                 
                    Healthy People 2030
                </div>
                <div class="row HPIDtext">
                    Healthy People 2030 provides science-based national objectives for improving the health of all Americans.
                </div>
            <br />
                <div class="row ckd-accordion-table-header-row bodyColHeaderBg" >
                    <div class="col-6 accordion-table-header bodyColHeaderText" style="text-align: left !important;">Indicators Related To HP 2030 Objectives</div>
                    <div class="col-3 accordion-table-header bodyColHeaderText">Data Source</div>
                    <div class="col-3 accordion-table-header bodyColHeaderText">Most Recent Year</div>
                </div>
                
            
            <div class="row">
                <%--<div class="col-xl-1"></div>
                <div class="col-xl-10">--%>
                    <div class="accordion indicator-plus accordion-white" role="tabpanel">

                        <asp:Literal ID="litHp2020" runat="server" Visible="true"></asp:Literal>
                    </div>
                <%--</div>
                <div class="col-xl-1"></div>--%>
            </div>

        </div>

    </asp:Panel>
</div>	
</div>
</main>

			<!-- Left / Bottom Nav -->
			<div class="col-xl-3 order-xl-1 leftnav-wrapper">
				<nav role="navigation" aria-label="Left Navigation Menu" style="border-bottom-color:white">
					<div id="cdc-left-nav-menu" >
					     <uc1:SideNav runat="server" id="SideNav" />
					</div>	
				</nav>
			</div>
	</div>
    <br /><br />

    <!-- 10/30/2019 From Thach @ CDC -->
    <script type="text/javascript">

        $('#pnlIndicators a.card-title').on('keyup', function (e) { (e.which == 13 ? $(this).click() : "") });


        //DS arrow - keyboard navigable
        $('#btnOpenDS').on('keyup', function (e) { (e.which == 13 ? $(this).click() : "") });


        function toggleDSList(btn) {
            $('.dsList').slideToggle(500);
        }
    </script>

</asp:Content>