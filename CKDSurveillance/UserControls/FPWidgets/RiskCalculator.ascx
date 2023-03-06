<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RiskCalculator.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.RiskCalculator" %>

<style>
    .calculator-card {        
        padding-bottom:25px;
        opacity: 1;
    }
    .calculator-title {
        text-align: left;
        font: normal normal 600 30px/45px Open Sans;
        letter-spacing: -0.6px;
        color: #FFFFFF;
        opacity: 1;
    }
    .calculator-text {
        text-align: left;
        font: normal normal normal 18px/24px Open Sans;
        letter-spacing: 0px;
        color: #FFFFFF;
        opacity: 1;
        margin-top: 2.5rem;
    }
    .calculator-link {
        text-align: center;
        text-decoration: none;
        font: normal normal 600 18px/24px Open Sans;
        letter-spacing: 0px;
        color: #FFFFFF;
        opacity: 1;
        margin-top: 2.5rem;
        padding-top: 10px;
    }
    .calculator-link :hover {
        color:#FFFFFF;
        text-decoration:underline !important;
    }
    .right-angle-arrow-white {
        font-size: 25px;
        color: #FFFFFF;
        vertical-align: bottom;
        margin-left: 10px;
    }
    .right-angle-arrow-white:hover {
        text-decoration:none !important;
    }
    @media (max-width:767px) {
        .calculator-card {
            display: block;
            flex-direction: column;
        }
        .calculator-text {
            margin-bottom:0px;
            margin-top:0px;
        }
        .calculator-link {
            margin-left:10px;
            margin-top:0px;
        }
        .calculator-title {
            margin-bottom:10px;
        }
    }
</style>



<%--*****************--%>
<%--*Risk Calculator*--%>
<%--*****************--%> 

<div class="calculator-card">
    <div class="row">

            <h2  class="calculator-title col-md-4">Kidney Disease Risk Calculator</h2>

        <div class="col-sm calculator-text">
            The calculator estimates the probability of having Chronic Kidney Disease. The calculations is based on individual characteristics: age, sex, and 7 comorbidities.
        </div>

        <div class="calculator-link"><img src="images/calculator-icon.png" alt="">
            <a id="lbkCalculator" title="Risk Calculator" class="calculator-link" href="Calculators.aspx">Access Calculator<i class="fa fa-angle-right right-angle-arrow-white"></i></a> 

        </div>
    </div>
</div>
