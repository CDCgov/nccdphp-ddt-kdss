<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Disclaimer.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.Disclaimer" %>
       
<style type="text/css">
    .disclaimer {
        padding-top:10px;
        background: #E9E9E9 0% 0% no-repeat padding-box;
        opacity: 1;
    }
    .disclaimer-text {
        font: normal normal normal 15px/20px Nunito;
        letter-spacing: 0px;
        color: #565656;
        opacity: 1;
    }
    .disclaimer-title {
        text-align: right;
        font: normal normal 600 17px/22px Nunito;
        letter-spacing: 0px;
        color: #29434E;
        opacity: 1;
    }
    @media (max-width: 767px) {
        .disclaimer-text {
            text-align:left;
        }
        .disclaimer-title {
            text-align:left;
        }
    }
</style>

<div class="col-12 disclaimer">
    <div class="row">
        <div class="col-sm-3 disclaimer-title">
            eGFR Formula Disclaimer
        </div> 
        <div class="col-sm-9 disclaimer-text">
            At the time of the last data update in summer 2022, the race-free eGFR formula was newly recommended and impact on health outcomes is underway. To avoid inconsistent results caused by different formulae, stakeholders continued using the eGFR formula with race during this transition. Since then, comparisons have been made. The estimates for the current website launch are still based on analyses using the eGFR formula with race, however plan is to use race-free eGFR formula for the next data update and upcoming website launch in fall 2023.
        </div>
    </div>
</div>