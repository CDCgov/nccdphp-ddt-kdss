<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Prevalence.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.Prevalence" %>
       

<style type="text/css">
    .prev-prev {
        color:#712177;
        margin-right: 5px;
    }
    .prev-row {
        margin-top:35px;
        margin-bottom: 75px;
    }
    .prev-title {
        text-align: left;
        font: normal normal 600 30px/34px Open Sans;
        letter-spacing: -0.6px;
        color: #000000;
    }
/*    .prev-img-box {
        background: #FFFFFF 0% 0% no-repeat padding-box;
        box-shadow: 0px 3px 6px #00000029;
        border: 1px solid #CFCFCF;
        opacity: 1;
        padding-top:1px;
        cursor: pointer;
        height:20%;
    }*/
    .prevalence-img-card {
        box-shadow: inset 0px 3px 6px #00000029;
        opacity: 1;                
        height: 73%;
    }
    .prev-img {
        width:100%;
        height: 100%;
    }
    .prev-subtitle {
        text-align: left;
        font: normal normal normal 24px/28px Open Sans;
        letter-spacing: -0.24px;
        color: #29434E;
        opacity: 1;
        margin-top:5px;        
    }
    .prev-body {
        text-align: left;
        font: normal normal normal 16px/21px Open Sans;
        letter-spacing: 0px;
        color: #000000;
        opacity: 1;
        margin-top:5px;        
    }
    .prev-footer {
        text-align: left;
        font: italic normal normal 14px/21px Roboto;
        letter-spacing: 0px;
        color: #6D6D6D;
        opacity: 1;
        margin-top:10px;
    }
    .prev-img-box-margin {
        margin-right: 20px!important;
    }
    .prev-underline {
        text-decoration-color:#00695C;
        text-underline-offset: 15px;
        text-decoration-thickness: 3px;
    }
    @media (max-width: 767px) {
        .prev-row {
            margin-top:0px;
        }
        .prev-underline {
            text-decoration-line:none;

        }
        .prev-img-box-margin {
            margin-right: 0px!important;
        }
        .prev-img-box {
            margin-bottom:20px;
        }
         .prev-body {
            height: 15%;
        }
    }
</style>


<%--******************************--%>
<%--*Prevalence of Kidney Disease*--%>
<%--******************************--%> 

<div class="col-12">
    <div class="row prev-title">
        <h2><span class="prev-prev"><u class="prev-underline">Prev</u>alence</span>of Chronic Kidney Disease (CKD)</h2>
    </div>
    <div class="row prev-row">
        <div class="col-md p-3 prev-img-box prev-img-box-margin" onclick="location.href='/detail.aspx?Qnum=Q372';">
            <div class="prevalence-img-card">
                <img src="./images/Prev1.png" class="prev-img" alt="Prevalence of CKD Stages 1–4  during 2015-2016 in the U.S. was 14.2%."/>
            </div>
            <div class="prev-subtitle">Prevalence of CKD Stages 1–4 by Year
            </div>
            <%--<div class="prev-body">During 2015-2016, prevalence of CKD in the U.S. was 14.2%.
            </div>--%>
            <div class="prev-footer">Source of information: NHANES
            </div>
        </div>
        <div class="col-md p-3 prev-img-box prev-img-box-margin" onclick="location.href='/detail.aspx?Qnum=Q705';">
            <div class="prevalence-img-card">
                <img src="./images/Prev3.png" class="prev-img" alt="Prevalence of CKD by the percentage of patients with a CKD code is distributed unevenly across states."/>
            </div>
            <div class="prev-subtitle">Prevalence of CKD by U.S.<br /> State and County
            </div>
            <%--<div class="prev-body">The percentage of patients with a CKD code is distributed unevenly across states.
            </div>--%>
            <div class="prev-footer">Source of information: CMS-Medicare
            </div>
        </div>
         <div class="col-md p-3 prev-img-box" onclick="location.href='/detail.aspx?Qnum=Q702';">
            <div class="prevalence-img-card">
                <img src="./images/Prev2.png" class="prev-img" alt="CKD Prevalence in adults with diabetes remained the same (20%) in 1999–2004 & 2011–2018."/>
            </div>
            <div class="prev-subtitle">CKD Prevalence by Diabetes<br /> Mellitus Status
            </div>
            <%--<div class="prev-body">The prevalence of CKD in adults with diabetes remained the same (20%) in 1999–2004 & 2011–2018
            </div>--%>
            <div class="prev-footer">Source of information: NHANES
            </div>
        </div>
    </div>
</div>
