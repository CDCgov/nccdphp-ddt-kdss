<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OutcomesQofCare.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.OutcomesQofCare" %>
       

<style type="text/css">
    .outcomes-qofcare-box {
       margin-top:75px;
       margin-bottom:3rem;
    }
    .outcome-box {
        padding-right:200px;
    }
    .outcomes-title {
        text-align: left;
        font: normal normal 600 30px/34px Open Sans;
        letter-spacing: -0.6px;
        opacity: 1;
        margin-bottom:15px;
        padding-left: 5px;
        margin-top: 25px;
    }
    .outcomes-qofcare-link {
        text-align: left;
        font: normal normal normal 18px/45px Open Sans !important;
        letter-spacing: 0px;
        color: #007C91;
        opacity: 1;
        text-decoration: none;
    }
    .qofcare-link {
        text-align: left;
        font: normal normal normal 18px/45px Open Sans !important;
        letter-spacing: 0px;
        color: #06778B;
        opacity: 1;
        text-decoration: none;
    }
    .qualityofcare-box {
        background: #F5F5F5 0% 0% no-repeat padding-box;
        border: 1px solid #D9D9D9;
        opacity: 0.81;
        padding-bottom:25px;
        padding-left:25px;
        padding-right:200px;
    }
    .qualityofcare-title {
        text-align: left;
        font: normal normal 600 30px/34px Open Sans;
        letter-spacing: -0.6px;
        color: #000000;
        margin-top:-15px;
        margin-bottom: 15px;
        padding-left: 5px;
    }
    .right-angle-arrow {     
        font-size: 25px;
        color: #007C91;
        vertical-align: sub;
        margin-left: 10px;
    }
    @media (max-width: 767px){
        .outcomes-qofcare-box {
           margin-top: 1rem;
           margin-bottom: 1rem;
           margin-left: -5px;
           padding-right: 10px;
        }
        .outcomes-title {
            padding-right: 20px;
        }
        .qualityofcare-box {
            width: 100%;
            margin-left: 0px;
            padding-bottom: 0px; 
            padding-left: 30px; 
            padding-right: 15px;
        }
        .qualityofcare-title {
            padding-right: 5px;
            margin-top: 15px;
        }
        .outcome-box {
            padding-right:0px;
            margin-left:15px;
            margin-right:15px;
            margin-bottom:15px;
        }
    }
    
</style>


<%--******************************--%>
<%--*Outcomes and Quality of Care*--%>
<%--******************************--%> 

<div class="outcomes-qofcare-box">
    <div class="row">
        <div class="col-md-6 outcome-box">
            <div class="outcomes-title"><h2><span style="color:#712177;">Outcomes</span> Related to <br /><u style="text-decoration-color:#00695C;text-underline-offset: 15px;">Kidn</u>ey Disease</h2></div>
            <ul class="linked-list">
                <li style="margin-bottom:-1rem;">
                    <a class="outcomes-qofcare-link" href="detail.aspx?Qnum=Q185"><span>Mortality by Stages of Kidney Disease</span><i class="fa fa-angle-right right-angle-arrow"></i></a>
                </li>
                <li style="margin-bottom:-1rem;">
                    <a class="outcomes-qofcare-link" href="detail.aspx?Qnum=Q364"><span>Various Sleep Symptoms</span><i class="fa fa-angle-right right-angle-arrow"></i></a>
                </li>
                <li style="margin-bottom:-1rem;">
                    <a class="outcomes-qofcare-link" href="detail.aspx?Qnum=Q703"><span>Population Reporting Disability</span><i class="fa fa-angle-right right-angle-arrow"></i></a>
                </li>
            </ul>
        </div>
        <%--<div class="col-md-2 d-none d-lg-block"></div>--%>
        <div class="col-md-6 qualityofcare-box">
            <div class="qualityofcare-title phoneNoShow"><h2>State of <span style="color:#712177;">Quality of Care</span><br /><u style="text-decoration-color:#00695C;text-underline-offset: 15px;">for K</u>idney Disease</h2></div>
            <div class="qualityofcare-title showPhoneOnly"><h2>State of <span style="color:#712177;"><br />Quality of Care</span><br /><u style="text-decoration-color:#00695C">for K</u>idney Disease</h2></div>
            <ul class="linked-list">
                <li style="margin-bottom:-1rem;">
                    <a class="qofcare-link" href="detail.aspx?Qnum=Q605"><span>ACEi/ARB use among CKD</span><i class="fa fa-angle-right right-angle-arrow"></i></a>
                </li>
                <li style="margin-bottom:-1rem;">
                    <a class="qofcare-link" href="detail.aspx?Qnum=Q640"><span>Albuminuria Testing among U.S. Veterans</span><i class="fa fa-angle-right right-angle-arrow"></i></a>
                </li>
                <li style="margin-bottom:-1rem;">
                    <a class="qofcare-link" href="detail.aspx?Qnum=Q700"><span>Use of Prescribed NSAIDs in CKD</span><i class="fa fa-angle-right right-angle-arrow"></i></a>
                </li>
                <li style="margin-bottom:-1rem;">
                    <a class="qofcare-link" href="detail.aspx?Qnum=Q719"><span>SGLT2 Inhibitor Use in CKD and Diabetes</span><i class="fa fa-angle-right right-angle-arrow"></i></a>
                </li>
            </ul>
        </div>
    </div>
</div>