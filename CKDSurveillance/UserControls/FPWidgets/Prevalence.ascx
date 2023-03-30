<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Prevalence.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.Prevalence" %>
       

<style type="text/css">
    .prevalence-prev {
        color:#712177;
        margin-right: 5px;
    }
    .prevalence-row {
        margin-top:35px;
        margin-bottom: 75px;
    }
    .prevalence-title {
        text-align: left;
        font: normal normal 600 30px/34px Open Sans;
        letter-spacing: -0.6px;
        color: #000000;
    }
    .prevalence-img-box {
        background: #FFFFFF 0% 0% no-repeat padding-box;
        box-shadow: 0px 3px 6px #00000029;
        border: 1px solid #CFCFCF;
        opacity: 1;
        padding-top:25px;
        cursor: pointer;
    }
    .prevalence-img-card {
        box-shadow: inset 0px 3px 6px #00000029;
        opacity: 1;                
        height: 73%;
    }
    .prevalence-img {
        width:100%;
        height:80%;
    }
    .prevalence-subtitle {
        text-align: left;
        font: normal normal normal 24px/28px Open Sans;
        letter-spacing: -0.24px;
        color: #29434E;
        opacity: 1;
        margin-top:5px;        
    }
    .prevalence-body {
        text-align: left;
        font: normal normal normal 16px/21px Open Sans;
        letter-spacing: 0px;
        color: #000000;
        opacity: 1;
        margin-top:5px;        
    }
    .prevalence-footer {
        text-align: left;
        font: italic normal normal 14px/21px Roboto;
        letter-spacing: 0px;
        color: #6D6D6D;
        opacity: 1;
        margin-top:10px;
    }
    .prevalence-img-box-margin {
        margin-right: 20px!important;
    }
    .prevalence-underline {
        text-decoration-color:#00695C;
        text-underline-offset: 15px;
        text-decoration-thickness: 3px;
    }
    @media (max-width: 767px) {
        .prevalence-row {
            margin-top:0px;
        }
        .prevalence-underline {
            text-decoration-line:none;

        }
        .prevalence-img-box-margin {
            margin-right: 0px!important;
        }
        .prevalence-img-box {
            margin-bottom:20px;
        }
        .prevalence-body {
            height: 15%;
        }
    }
    @media (min-width: 1201px) {
        .prevalence-img-card {
            height: 60%;
        }
        .prevalence-subtitle {
            height: 15%;
        }
        .prevalence-text {
            height: 10%;
        }
</style>


<%--******************************--%>
<%--*Prevalence of Kidney Disease*--%>
<%--******************************--%> 

<div class="col-12">
    <div class="row prevalence-title">
        <h2><span class="prevalence-prev"><u class="prev-underline">Prev</u>alence</span>of Chronic Kidney Disease (CKD)</h2>
    </div>
    <div class="row prevalence-row">
        <div class="col-md p-3 prevalence-img-box prevalence-img-box-margin" onclick="location.href='./detail.aspx?Qnum=Q372';">
            <a class="prevalence-img-card" href="./detail.aspx?Qnum=Q372">
                <img src="./images/Prev1.png" class="prevalence-img" alt="Prevalence of CKD Stages 1–4  during 2015-2016 in the U.S. was 14.2%."/>
            </a>
            <div class="prevalence-subtitle">Prevalence of CKD Among U.S. <br />Adults, by Stage
            </div>
            <%--<div class="prev-body">During 2015-2016, prevalence of CKD in the U.S. was 14.2%.
            </div>--%>
            <div class="prevalence-footer">Source of information: NHANES
            </div>
        </div>
        <div class="col-md p-3 prevalence-img-box prevalence-img-box-margin" onclick="location.href='./detail.aspx?Qnum=Q705';">
            <a class="prevalence-img-card" href="./detail.aspx?Qnum=Q705">
                <img src="./images/Prev3.png" class="prevalence-img" alt="Prevalence of CKD by the percentage of patients with a CKD code is distributed unevenly across states."/>
            </a>
            <div class="prevalence-subtitle">Prevalence of CKD by U.S.<br /> State and County
            </div>
            <%--<div class="prev-body">The percentage of patients with a CKD code is distributed unevenly across states.
            </div>--%>
            <div class="prevalence-footer">Source of information: CMS-Medicare
            </div>
        </div>
         <div class="col-md p-3 prevalence-img-box" onclick="location.href='./detail.aspx?Qnum=Q702';">
            <a class="prevalence-img-card" href="./detail.aspx?Qnum=Q702">
                <img src="./images/Prev2.png" class="prevalence-img" alt="CKD Prevalence in adults with diabetes remained the same (20%) in 1999–2004 & 2011–2018."/>
            </a>
            <div class="prevalence-subtitle">Prevalence of CKD Stages 3-4, <br />by Diabetes and Prediabetes
            </div>
            <%--<div class="prev-body">The prevalence of CKD in adults with diabetes remained the same (20%) in 1999–2004 & 2011–2018
            </div>--%>
            <div class="prevalence-footer">Source of information: NHANES
            </div>
        </div>
    </div>
</div>
