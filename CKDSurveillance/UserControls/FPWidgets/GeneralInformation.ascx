<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GeneralInformation.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.GeneralInformation" %>
       

<style type="text/css">
    .general-information {
        margin-top:75px;
        margin-bottom:75px;
    }
    .generalinformation-title {
        text-align: left;
        font: normal normal 600 20px/34px Nunito;
        letter-spacing: -0.4px;
        color: #242424;
        text-transform: uppercase;
        opacity: 1;
        padding-left:1rem;
    }
    .additionalresources {
        text-align: left;
        font: normal normal 600 20px/34px Nunito;
        letter-spacing: -0.4px;
        color: #242424;
        text-transform: uppercase;
        opacity: 1;
        padding-left:1rem;
        padding-bottom:20px;
    }
    .generalinformation-subtitle {
        text-align: left;
        font: normal normal normal 24px/33px Nunito;
        letter-spacing: -0.24px;
        color: #29434E;
        opacity: 1;
        padding-top:20px;
        padding-bottom:10px;
        padding-left: 1rem;
    }
    .generalinformation-text {
        text-align: left;
        font: normal normal normal 18px/25px Nunito;
        letter-spacing: -0.27px;
        color: #000000;
        opacity: 1;
        padding-left:1rem;
        display: block;
    }
    .generalinformation-link {
        text-align: left;
        font: normal normal normal 18px/52px Nunito;
        letter-spacing: 0px;
        color:#005fa3 !important; /*color: #00778C;*/
        opacity: 1;        
        text-decoration:none;
    }
    .generalinformation-link-li {
        padding: 0rem 0 !important;
        border-bottom: 1px solid #e0e0e0 !important;
        list-style-type: none;
    }
    .generalinformation-link-padding {
        text-align: left;
        font: normal normal normal 18px/52px Nunito;
        letter-spacing: 0px;
        color: #005fa3 !important; /*color: #00778C;*/
        opacity: 1;        
        text-decoration:none;
        padding-left:1rem;
    }

    .generalinformation-box {
        background: #FFFFFF 0% 0% no-repeat padding-box;
        opacity: 0.83;
        padding-left: 30px;
        padding-right: 15px;
        padding-top: 45px;
        padding-bottom: 45px;
    }
    .generalinformation-box-title {
        text-align: left;
        font: normal normal 600 20px/34px Nunito;
        letter-spacing: -0.4px;
        color: #242424;
        text-transform: uppercase;
        opacity: 1;
    }
    .generalinformation-box-text {
        text-align: left;
        font: normal normal normal 18px/25px Nunito;
        letter-spacing: 0px;
        color: #000000;
        opacity: 1;
    }
    .generalinformation-box-link {
        text-align: left;
        font: normal normal normal 19px/52px Nunito;
        letter-spacing: 0px;
        color: #0b4778 ; /*#007C91;*/
        opacity: 1;
        padding-left: 20px;
    }
    .generalinformation-download {
        background: url('images/DownloadGreen.png') no-repeat;
        display: inline-block;
        width: 29px;
        height: 29px;
    }
    @media (max-width: 767px) {
        .generalinformation-title {
            margin-top:20px;
        }
    }

</style>


<%--*********************--%>
<%--*General Information --%>
<%--*********************--%> 

<div class="row general-information">
        <div class="col-md-3">
                <div class="row additionalresources">ADDITIONAL RESOURCES</div>
                <ul class="generalinformation-link">
                  <%--  <li class="generalinformation-link-li">
                        <a href="/help.aspx?section=F" class="generalinformation-link" target="popup"
                            onclick="return popupWindow('help.aspx?section=G', 800, 600);">Frequently Asked Questions</a>
                    </li>--%>
                    <li class="generalinformation-link-li">
                        <a href="data.aspx?categoryID=67" class="generalinformation-link" <%--target="new"--%> >Healthy People  <%--<span class="fi cdc-icon-external x16"></span>--%></a>
                    </li>
                    <li class="generalinformation-link-li">
                        <a href="help.aspx?section=G" class="generalinformation-link" target="popup" 
                            onclick="return popupWindow('help.aspx?section=G', 800, 600);">Glossary</a>
                    </li>
                    <li class="generalinformation-link-li">
                        <a href="help.aspx?section=D" class="generalinformation-link" target="popup" 
                            onclick="return popupWindow('help.aspx?section=D', 800, 600);">Data Sources</a>
                    </li>
                   <%-- <li class="generalinformation-link-li">
                        <a href="/data.aspx"  class="generalinformation-link">Complete Indicators List</a>
                    </li>--%>

                </ul>
             </div>
        <div class="col-md-9">
            <div class="row generalinformation-title">GENERAL INFORMATION</div>
            <div class="row generalinformation-subtitle"><a href="https://www.cdc.gov/kidneydisease/publications-resources/ckd-national-facts.html" style="padding-left:0px; text-decoration:none; color:#005fa3 !important";<%--color: #00778C" --%>target="_blank">Fact Sheet: Chronic Kidney Disease in the United States, 2023</a></div>
            <div class="row generalinformation-text">When people develop <span style="font-weight:bold">chronic kidney disease (CKD)</span>, their kidneys become damaged and over time may not clean the blood as well as healthy kidneys. If kidneys do not work well, toxic waste and extra fluid accumulate in the body and may lead to high blood pressure, heart disease, stroke, and early death. However, people with CKD and people at risk for CKD can take steps to protect their kidneys with the help of their health care providers.</div>
           <%-- <div class="row">
                <a href="Documents/CKD_FactSheet_2023.pdf" class="generalinformation-link-padding"  alt="Download CKD Fact Sheet" download>
                    <span class="generalinformation-download"></span>&nbsp;<span style="vertical-align:super">Download CKD Fact Sheet</span></a>
            </div>--%>
            <br />
            <div class="generalinformation-box">
                <div class="generalinformation-box-title">CHRONIC KIDNEY DISEASE (CKD) INITIATIVE</div>
                <br />
                <div class="generalinformation-box-text">In 2006, the CDC established the Chronic Kidney Disease (CKD) Initiative to provide public health strategies for promoting kidney health. Current activities of the CKD Initiative include surveillance, epidemiology, health outcomes, and economic studies in partnership with various offices at the CDC, other governmental agencies, universities, and national organizations.
                <a href="https://www.cdc.gov/kidneydisease/index.html" style="opacity: 1; text-decoration:none;" target="new">Visit CKD Initiative<span class="fi cdc-icon-external x16"></span></a></div>  <%--#007C91--%>
            </div>
        </div>
    </div>