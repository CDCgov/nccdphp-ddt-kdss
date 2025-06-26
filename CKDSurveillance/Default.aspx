<%@ Page Language="C#" MasterPageFile="~/MasterPages/ResponsiveContentLeftNavNew.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CKDSurveillance_RD.Default" %>

<%@ Register Src="~/UserControls/FAQGlossaryControl.ascx" TagPrefix="uc1" TagName="FAQGlossaryControl" %>
<%@ Register Src="~/UserControls/Navigation/MainNav.ascx" TagPrefix="uc1" TagName="MainNav" %>
<%@ Register Src="~/UserControls/FPWidgets/SpecialPopulations.ascx" TagPrefix="uc1" TagName="SpecialPopulations" %>
<%@ Register Src="~/UserControls/FPWidgets/Initiative.ascx" TagPrefix="uc1" TagName="Initiative" %>
<%@ Register Src="~/UserControls/FPWidgets/SuggestedCitationAndVersioning.ascx" TagPrefix="uc1" TagName="SuggestedCitationAndVersioning" %>
<%@ Register Src="~/UserControls/FPWidgets/SpotlightOnIndicators.ascx" TagPrefix="uc1" TagName="SpotlightOnIndicators" %>
<%@ Register Src="~/UserControls/FPWidgets/SpecialDay.ascx" TagPrefix="uc1" TagName="SpecialDay" %>
<%@ Register Src="~/UserControls/FPWidgets/Combined_Initiative_FactSheet.ascx" TagPrefix="uc1" TagName="Combined_Initiative_FactSheet" %>
<%@ Register Src="~/UserControls/SurveyModal.ascx" TagPrefix="uc1" TagName="SurveyModal" %>
<%@ Register Src="~/UserControls/FPWidgets/CurrentTopics.ascx" TagPrefix="uc1" TagName="CurrentTopics" %>
<%@ Register Src="~/UserControls/FPWidgets/AboutKDS.ascx" TagPrefix="uc1" TagName="AboutKDS" %>
<%@ Register Src="~/UserControls/FPWidgets/AYA.ascx" TagPrefix="uc1" TagName="AYA" %>
<%@ Register Src="~/UserControls/FPWidgets/RiskCalculator.ascx" TagPrefix="uc1" TagName="RiskCalculator" %>
<%@ Register Src="~/UserControls/FPWidgets/Prevalence.ascx" TagPrefix="uc1" TagName="Prevalence" %>
<%@ Register Src="~/UserControls/FPWidgets/DataBiteHighlights.ascx" TagPrefix="uc1" TagName="DataBiteHighlights" %>
<%@ Register Src="~/UserControls/FPWidgets/GeneralInformation.ascx" TagPrefix="uc1" TagName="GeneralInformation" %>
<%@ Register Src="~/UserControls/FPWidgets/MainImage.ascx" TagPrefix="uc1" TagName="MainImage" %>
<%@ Register Src="~/UserControls/FPWidgets/OutcomesQofCare.ascx" TagPrefix="uc1" TagName="OutcomesQofCare" %>
<%@ Register Src="~/UserControls/FPWidgets/RiskFactorsForKD.ascx" TagPrefix="uc1" TagName="RiskFactorsForKD" %>

<%--******--%>
<%--*Head*--%>
<%--******--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    

    <style type="text/css">
        
        body {
            font-size: 16px !important;
            border-top: 0px !important;
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
            font-family: Nunito, Open Sans, apple-system, blinkmacsystemfont,Segoe UI, Helvetica Neue, arial, sans-serif;
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
        .rf-margins
        {
            /*background: transparent linear-gradient(290deg, #007C91 0%, #00695C 100%) 0% 0% no-repeat padding-box;*/ 
            background: transparent linear-gradient(290deg, #0081a1 0%, #0057B7 100%) 0% 0% no-repeat padding-box; 
            opacity:0.9;
        }

        #ckd-nav-home{
            background-color: #FFFFFF;
        }
        #ckd-nav-home-link:hover {
            color: #FFFFFF!important;
        }
        #ckd-nav-home-link {
            color: #0b4778  !important;  /*#007C91 #0b4778;*/ /*#007C91;*/ /*#0b4778;*/ /*#007C91;*/
        }
        .ckd-nav-home{
            background-color: #FFFFFF;
        }
        .ckd-nav-home-link:hover {
            color: #FFFFFF!important;
        }
        .ckd-nav-home-link {
            color: #0b4778  !important; /*#007C91*/
        }
        .justify-to-center {
            justify-content: center;
            width: 90%;
        }
        
        .main-image-banner {
            background: transparent url('/kdss/images/CKD_MainBanner.png') 0% 0% no-repeat padding-box;
        }
        .outcomecontainer {
            width: 100%;
            padding-right: 15px;
            padding-left: 15px;
            margin-right: auto;
            margin-left: auto;
        }
        @media (max-width: 767px) {
            .main-image-banner {
                background: transparent url('/kdss/images/CKD_Main_Mobile.png') 0% 0% no-repeat padding-box;
                margin-top: -24px;
            }
            .outcomecontainer {
                padding-left:0px;
                padding-right:0px;
            }
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <%--*********************--%>
    <%--*One Question Survey* (handles cookie, code, everything - just include it.)--%>
    <%--*********************--%>
    <uc1:SurveyModal runat="server" ID="SurveyModal" />

    <%--************--%>
    <%--*Main Image*--%>
    <%--************--%>
    <div class="row d-lg-block main-image-banner" style="background-position: center; background-size: cover;">
        <div class="container justify-to-center">
            <uc1:MainImage runat="server" ID="MainImage1" />
        </div>
    </div>


    <%--************************************--%>
    <%--*Kidney Disease Surveillance System*--%>
    <%--************************************--%>

    <div class="row pt-0 pb-1 county-check" style="background-color:#f6fbff; background-color:#f6fbff;
border-top: solid;border-top-width: thin;border-top-color: #93a0a6;border-bottom: solid;border-bottom-width: thin;border-bottom-color: #93a0a6;">
        <div class="container justify-to-center" >
            <uc1:AboutKDS runat="server" ID="AboutKDS1" />
        </div>
    </div>
    
    <%--*****--%>
    <%--*AYA*--%>
    <%--*****--%>

    <div class="row pt-0 pb-1 county-check" style="background: #FFFFFF 0% 0% no-repeat padding-box; opacity: 1;margin-top: 6px;">
        <div class="container justify-to-center">
            <uc1:AYA runat="server" ID="AYA1" />
        </div>
    </div>

    <%--*****************--%>
    <%--*Risk Calculator*--%>
    <%--*****************--%>

    <div class="row pt-0 pb-1 county-check" style="background: #005EAA 0% 0% no-repeat padding-box !important; box-shadow: 0px 3px 6px #0000006B;">
        <div class="container justify-to-center">
            <uc1:RiskCalculator runat="server" ID="RiskCalculator1" />
        </div>
    </div>

    <%--******************************--%>
    <%--*Prevalence of Kidney Disease*--%>
    <%--******************************--%>

    <div class="row pt-0 pb-1 county-check" style="background: #FFFFFF 0% 0% no-repeat padding-box;box-shadow: 0px 5px 9px #00000029;opacity: 1; ">
        <div class="container justify-to-center">
            <uc1:Prevalence runat="server" ID="Prevalence1" />
        </div>
    </div>

    <%--*********************************--%>
    <%--*Risk Factors for kidney Disease*--%>
    <%--*********************************--%>

    <div class="row pt-0 pb-1 county-check rf-margins"> 
        <div class="container justify-to-center">
             <uc1:RiskFactorsForKD runat="server" ID="RiskFactorsForKD1" />
        </div>
    </div>

    <%--**********************--%>
    <%--*Data Bite highlights*--%>
    <%--**********************--%>
    <div class="row pt-0 pb-1 county-check" style="background: #f6fbff 0% 0% no-repeat padding-box; opacity: 1;">
        <div class="container justify-to-center">
            <uc1:DataBiteHighlights runat="server" ID="DataBiteHighlights" />
        </div>
    </div>
  

    <%--******************************--%>
    <%--*Outcomes and Quality of Care*--%>
    <%--******************************--%>

    <div class="row pt-0 pb-1 county-check" style="background: #FFFFFF 0% 0% no-repeat padding-box;box-shadow: 0px -5px 9px #00000029;opacity: 1;">
        <div class="outcomecontainer showPhoneOnly justify-to-center">
            <uc1:OutcomesQofCare runat="server" ID="OutcomesQofCare1" />
        </div>
        <div class="container phoneNoShow justify-to-center">
            <uc1:OutcomesQofCare runat="server" ID="OutcomesQofCare2" />
        </div>
    </div>

    <%--**********************************************--%>
    <%--*Additional Resources and General Information*--%>
    <%--**********************************************--%>

    <div class="row pt-0 pb-1 county-check" style="background:#f6fbff 0% 0% no-repeat padding-box;opacity: 1;">
        <div class="container justify-to-center">
            <uc1:GeneralInformation runat="server" ID="GeneralInformation1" />
        </div>
    </div>


    <%--*****************--%>
    <%--*Email Subscribe*--%>
    <%--*****************--%>

    <%--<div class="row pt-0 pb-1 county-check" style="background: #29434E 0% 0% no-repeat padding-box;box-shadow: 0px -8px 6px #0000002E; opacity: 1;     display:block;">
        <div class="container">
            <uc1:EmailSubscribeMain runat="server" ID="EmailSubscribeMain1" />
        </div>
    </div>--%>

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
        $(document).ready(function(){
            var listItems = $(".nav-link");

            // Remove 'active' tag for all list items
            for (let i = 0; i < listItems.length; i++) {
                listItems[i].classList.remove("active");
            }
            $("#home").addClass("active");
        });
    </script>

</asp:Content>
