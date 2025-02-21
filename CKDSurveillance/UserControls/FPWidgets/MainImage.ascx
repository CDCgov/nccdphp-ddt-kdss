<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainImage.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.MainImage" %>

<link href='/css/Fonts.css?family=Nunito:400,300,600,700,800' rel='stylesheet' type='text/css'>   

<style type="text/css">
    
    .main-icon-mobile {
        display:none;
    }
    .main-info {
        padding-top:23%;
        text-align: left;
        font: normal normal bold 16px/22px Nunito;
        letter-spacing: 0px;
        color: #29434E;
        opacity: 1;
    }
    .main-symbol {
        text-align: left;
        font: normal normal 600 70px/66px Zilla Slab;
        letter-spacing: -0.7px;
        color: #005fa3 !important;
    }
    @media (min-width: 768px) {
        .main-text {
            padding-top:20%;
            padding-bottom:2em;
            text-align: left;
            font: normal normal bold 64px/66px Nunito!important; 
            letter-spacing: -0.64px;
            color: #29434E;
        }
        .main-image {
        opacity: 1;
        /*width: 1780px;*/
        height: 538px;
    }
        .main-icon {
            display:block;
            padding-top:23%;        
        }
    }
    @media (max-width: 767px) {
        .main-text {
            text-align: left;
            font: normal normal bold 40px/42px Nunito;
            letter-spacing: -0.4px;
            color: #29434E;
            height: 55px;
            padding-top:40%;
        }
        .main-image {
            display:contents;
        }
        .main-icon {
            display:none;
        }
        .main-info {
            padding-top:35%;
            width: 50%;
            text-align: left;
            font: normal normal bold 15px/20px Nunito;
            letter-spacing: 0px;
            color: #29434E;
            opacity: 1;
            padding-bottom: 40px;
        }
        .main-icon-mobile {
            display:block;
            padding-top:35%;
            padding-left:10px;
            padding-bottom:20px
        }
        .main-symbol {
            text-align: left;
            font: normal normal 600 46px/42px Zilla Slab;
            letter-spacing: -0.46px;
            color: #005ea2; /*#00695C;*/
        }
    }
</style>


<%--************--%>
<%--*Main Image*--%>
<%--************--%> 

<div class="main-image">
    <div class="row">
        <h1 class="col-md-6 main-text phoneNoShow" style="font-family: Poppins;"><span>Tracking</span> <span class="main-symbol">&</span> <span>Preventing <br />Kidney Disease in America</span></h1>
        <h3 class="col-md-6 main-text showPhoneOnly" style="font-family: Poppins;"><span style="font-weight:bold">Tracking</span> <span class="main-symbol">&</span> Preventing Kidney Disease in America</h3>
        <div class="col-sx-1 main-icon">
            <img src="images/main_icon2.png" Class="img-fluid img-responsive" alt=""/>
    <%--    </div>
        <div class="col-sx-1 main-icon" style="padding-left:1em;">--%>
            <img src="images/main_icon1.png" Class="img-fluid img-responsive" alt=""/>
        </div>
       <%-- <div class="col-sx-1 main-icon-mobile">
            <img src="images/main_icon2_mobile.png" Class="img-fluid img-responsive" alt=""/>
        </div>
        <div class="col-sx-1 main-icon-mobile">
            <img src="images/main_icon1_mobile.png" Class="img-fluid img-responsive" alt=""/>
        </div>--%>
        <%--<div class="col-md-4 main-info showPhoneOnly">
            <img src="images/info_black_24dp.png" Class="img-fluid img-responsive" alt=""/>Blood & Urine Tests Measure Kidney Function, Damage & Other Abnormalities
        </div>
        <div class="col-md-4 main-info phoneNoShow">
            <img src="images/info_black_24dp.png" Class="img-fluid img-responsive" alt=""/>Blood & Urine Tests Measure<br /> Kidney Function, Damage & <br />Other Abnormalities
        </div>--%>
    </div>
</div>
