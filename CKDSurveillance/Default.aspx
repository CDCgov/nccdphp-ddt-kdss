<%@ Page Language="C#" MasterPageFile="~/MasterPages/ResponsiveContentLeftNav.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CKDSurveillance_RD.Default" %>

<%@ Register Src="~/UserControls/FAQGlossaryControl.ascx" TagPrefix="uc1" TagName="FAQGlossaryControl" %>
<%@ Register Src="~/UserControls/Navigation/MainNav.ascx" TagPrefix="uc1" TagName="MainNav" %>
<%@ Register Src="~/UserControls/FPWidgets/SpecialPopulations.ascx" TagPrefix="uc1" TagName="SpecialPopulations" %>
<%@ Register Src="~/UserControls/FPWidgets/Initiative.ascx" TagPrefix="uc1" TagName="Initiative" %>
<%@ Register Src="~/UserControls/FPWidgets/SuggestedCitationAndVersioning.ascx" TagPrefix="uc1" TagName="SuggestedCitationAndVersioning" %>
<%@ Register Src="~/UserControls/FPWidgets/SpotlightOnIndicators.ascx" TagPrefix="uc1" TagName="SpotlightOnIndicators" %>
<%@ Register Src="~/UserControls/FPWidgets/SpecialDay.ascx" TagPrefix="uc1" TagName="SpecialDay" %>
<%@ Register Src="~/UserControls/FPWidgets/Calculators.ascx" TagPrefix="uc1" TagName="Calculators" %>
<%@ Register Src="~/UserControls/FPWidgets/Combined_Initiative_FactSheet.ascx" TagPrefix="uc1" TagName="Combined_Initiative_FactSheet" %>
<%@ Register Src="~/UserControls/SurveyModal.ascx" TagPrefix="uc1" TagName="SurveyModal" %>
<%@ Register Src="~/UserControls/FPWidgets/CurrentTopics.ascx" TagPrefix="uc1" TagName="CurrentTopics" %>


<%--******--%>
<%--*Head*--%>
<%--******--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    

    <style type="text/css">
        
        body {
            font-size: 16px !important;
        }

        @media screen and (min-width: 1201px) {
            .MainNav, .MoreLinks {
                display: block;
            }

            .midfaqs {
                display: block;
            }
        }

        @media screen and (max-width: 1200px) {
            .RotatingPanel {
                width: 99%;
                height: 99%;
            }

            .MainNav, .MoreLinks {
                display: none;
            }

            .midfaqs {
                display: block;
            }
        }

        .cell {
            border: solid 1px silver;
            padding: 5px;
        }

        .headercell {
            border: solid 1px Black;
            background-color: silver;
            color: maroon;
            font-weight: bold;
            padding: 5px;
        }

        ul li {
            margin-bottom: 2px;
        }

        [class*=nccd-mod] > * {
            padding: 15px 15px 15px 15px;
        }

        .nccd-modA h3 {
            background-color: #c5ded6 !important;
            color: #1a7aa2 !important;
            font-family: Verdana;
            font-size: 16px;
            font-weight: bold;
            padding: 5px 10px;
        }

        .secondaryWidgetTitle {
            font-size: 18px;
            font-weight: bold !important;
            font-style: italic;
        }

        .specialDayImage {
            -webkit-box-shadow: 5px 5px 5px 0px rgba(176,170,176,1);
            -moz-box-shadow: 5px 5px 5px 0px rgba(176,170,176,1);
            box-shadow: 5px 5px 5px 0px rgba(176,170,176,1);
        }

        .tinyNounImage {
            height: 48px;
            width: 48px;
        }

        .smallerNounImage {
            height: 96px;
            width: 96px;
        }

        .mediumNounImage {
            height: 120px;
            width: 120px;
        }

        .spotlightTitle {
            font-family: Open Sans, apple-system, blinkmacsystemfont,Segoe UI, Helvetica Neue, arial, sans-serif;
        }

        .tightCardGroup {
            margin-bottom: 7px !important;
        }

        .tighterCardHeader {
            padding-bottom: 0px !important;
            margin-bottom: 2px !important;
            padding-left: 10px !important;
        }

        .tab-pane.fade {
            transition: all 0.2s !important;
            transform: translateY(1rem) !important;
        }

            .tab-pane.fade.show {
                transform: translateY(0rem) !important;
            }

        .nav-item {
            border: solid 1px #e6e6e6;
            background-color: #f5f5f5;
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">


    <%--*********************--%>
    <%--*One Question Survey* (handles cookie, code, everything - just include it.)--%>
    <%--*********************--%>
    <uc1:SurveyModal runat="server" ID="SurveyModal" />




    <%--*********--%>
    <%--*Widgets*--%>
    <%--*********--%>

    <div class="row">

        <%--LEFT Column--%>
        <div class="col-lg-4 order-sm-1 order-lg-1">

            <%--**************--%>
            <%--*Special Pops*--%>
            <%--**************--%>
            <uc1:SpecialPopulations runat="server" ID="SpecialPopulations" />


            <%--****************--%>
            <%--*Current Topics*--%>
            <%--****************--%>
            <uc1:CurrentTopics runat="server" ID="CurrentTopics" />

            <br />
            <br />

        </div>


        <%--*MIDDLE column*--%>
        <div class="col-lg-4 order-sm-3 order-lg-2">

            <%--*************************--%>
            <%--*SpotLight On Indicators*--%>
            <%--*************************--%>
            <uc1:SpotlightOnIndicators runat="server" ID="SpotlightOnIndicators" />


        </div>



        <%--*Right third*--%>
        <div class="col-lg-4 order-sm-2 order-lg-3">

            <%--*********************--%>
            <%--*Special Day Widget*--%>
            <%--*********************--%>
            <uc1:SpecialDay runat="server" ID="SpecialDay" />


            <%--*************--%>
            <%--*Calculators*--%>
            <%--*************--%>
            <uc1:Calculators runat="server" ID="Calculators" />

        </div>
    </div>

    <%--*******************--%>
    <%--*Six brief Widgets*--%>
    <%--*******************--%>
    <div class="row">

        <%--*Info for Patients / Healthy People*--%>
        <div class="col-lg-4 order-sm-1 order-lg-1 splash-col">
            <div class="row">
                <div class="col-md-12">

                    <%--*Information For Patients--%>
                    <a href="https://www.niddk.nih.gov/health-information/kidney-disease" class="bg-white bl-3 bl-primary ds-8 mb-3 nav-btn nav-btn-horizontal noLinking noDecoration card" style="height: 66px;" target="_blank">
                        <div class="card-body bg-white" style="height: 64px;">
                            <div class="row align-items-center">
                                <div class="col">
                                    <div class="card-title h4 mb text-left">Information For Patients</div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <%--*Healthy People*--%>
                    <%--<a href="https://health.gov/healthypeople/objectives-and-data/browse-objectives/chronic-kidney-disease" class="bg-white bl-3 bl-primary ds-8 mb-3 nav-btn nav-btn-horizontal noLinking noDecoration card" style="height: 66px;" target="_blank">--%>
                    <a href="data.aspx?categoryID=67" class="bg-white bl-3 bl-primary ds-8 mb-3 nav-btn nav-btn-horizontal noLinking noDecoration card" style="height: 66px;" target="_blank">
                        <div class="card-body bg-white" style="height: 64px;">
                            <div class="row align-items-center">
                                <div class="col">
                                    <div class="card-title h4 mb text-left">Healthy People</div>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>

        <%--*Research and Publications / CKD Initiative*--%>
        <div class="col-lg-4 order-sm-1 order-lg-1 splash-col">
            <div class="row">
                <div class="col-md-12">

                    <%--*Research and Publications--%>
                    <a href="https://www.cdc.gov/kidneydisease/publications-resources/publications.html" class="bg-white bl-3 bl-primary ds-8 mb-3 nav-btn nav-btn-horizontal noLinking noDecoration card" style="height: 66px;" target="_blank">
                        <div class="card-body bg-white" style="height: 64px;">
                            <div class="row align-items-center">
                                <div class="col">
                                    <div class="card-title h4 mb text-left">Research And Publications</div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <%--*CKD Initiative*--%>
                    <a href="https://www.cdc.gov/kidneydisease/about-the-ckd-initiative.html" class="bg-white bl-3 bl-primary ds-8 mb-3 nav-btn nav-btn-horizontal noLinking noDecoration card" style="height: 66px;" target="_blank">
                        <div class="card-body bg-white" style="height: 64px;">
                            <div class="row align-items-center">
                                <div class="col">
                                    <div class="card-title h4 mb text-left">CKD Initiative</div>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>

        <%--*Email Updates*--%>
        <div class="col-lg-4 order-sm-1 order-lg-1 splash-col">
            <div class="row">
                <div class="col-md-12">

                    <%--*Top text - Get Email Updates*--%>
                    <div class="bg-white bl-3 bl-primary ds-8 mb-3 nav-btn nav-btn-horizontal noLinking noDecoration card" style="height: 148px;">
                        <div class="row align-items-center">
                            <div class="col">
                                <div class="card-title h4 mb text-left" style="padding-top: 16px; padding-left: 16px;">Get Email Updates:</div>
                            </div>
                        </div>
                        <br />

                        <%--*Textbox / button*--%>
                        <div class="row align-items-center">
                            <div class="col" style="padding-left: 40px; padding-right: 40px;">
                                <div class="input-group mb-3" style="cursor: pointer;">
                                    <input id="gov-d-email" name="email" type="email" class="form-control" placeholder="Email Address" />
                                    <div class="input-group-append">
                                        <span class="input-group-text btn-primary" id="basic-addon2" tabindex="0" onkeypress="checkTXTForSubmit(event,'submitArea');" onclick="triggerSearch();">
                                            <asp:LinkButton ID="btnSubmitEmailSubscription" runat="server" ClientIDMode="Static" CssClass="btn btn-link" ForeColor="White" ToolTip="Submit email address for subscription to CDC CKD email newsletter communication" AlternateText="Submit email address for subscription to CDC CKD email newsletter communication" Text="Submit" />
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>


    <%--***********************************--%>
    <%--*Suggested Citation and Versioning*--%>
    <%--***********************************--%>
    <div class="row">
        <div class="col-lg-4 order-sm-1 order-lg-1 splash-col">
            <uc1:SuggestedCitationAndVersioning runat="server" ID="SuggestedCitationAndVersioning" />
        </div>
        <div class="col-lg-4 order-sm-1 order-lg-1 splash-col">
        </div>
        <div class="col-lg-4 order-sm-1 order-lg-1 splash-col">
        </div>
    </div>


</asp:Content>



<asp:Content ID="Content3" ContentPlaceHolderID="CustomJavaScript" runat="server">

    <script type="text/javascript">
        //subscription submit and redirect
        document.getElementById("btnSubmitEmailSubscription").onclick = function (e) {
            e.preventDefault();
            var topicID = 'USCDC_974',
                govEmail = encodeURIComponent(document.getElementById('gov-d-email').value),
                govOrigin = '',
                govPop = 't',
                fullUrl = "https://tools.cdc.gov/campaignproxyservice/subscriptions.aspx?email=" + govEmail + '&topic_id=' + topicID + '&origin=' + govOrigin + '&pop=' + govPop;

            window.open(fullUrl, '_blank');
        };
    </script>

</asp:Content>
