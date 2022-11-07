<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Covid.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.Covid" %>

<style>
    .infoCard {
        text-align: center;
        width: 100%;
    }

    .imgCovidFlu {
        /*max-width: 400px;*/
        /*Experiment*/
        height: 100%;
        width: 100%;
              
        -webkit-box-shadow: 10px 10px 5px 0px rgba(204,194,204,1);
        -moz-box-shadow: 10px 10px 5px 0px rgba(204,194,204,1);
        box-shadow: 10px 10px 5px 0px rgba(204,194,204,1);
    }
    .linksRow {
        text-align:left;
    }
</style>


<%--**********************--%>
<%--*Covid and Flu Widget*--%>
<%--**********************--%>
<div class="row">
    <%-- <div class="col-1"></div>--%>
    <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12">
        <div class="infoCard">
            <div id="divPlaceHolder">

                <%--*Image*--%>
                <a href="https://www.cdc.gov/coronavirus/2019-ncov/prevent-getting-sick/prevention.html" target="_blank">
                    <img id="imgCovidFluWidget" src="images/MaskOnSleevesUp2.png" alt="Mask On Sleeves up! Informational image with links to resources for Covid and Flu shots" class="img-fluid img-responsive imgCovidFlu" style="width: 400px;"/>
                </a>

            </div>
        </div>
    </div>
</div>

<br />

<%--*******--%>
<%--*Links*--%>
<%--*******--%>
<div class="row">
    <div class="col-sm-3 col-md-3 col-lg-1 col-xl-1"></div>
    <div class="col-sm-8 col-md-8 col-lg-10 col-xl-10 linksRow">
        <ul>
            <li>
                <a href="https://www.cdc.gov/coronavirus/2019-ncov/prevent-getting-sick/prevention.html" target="_blank">Protect Yourself From COVID-19</a>
            </li>
            <li>
                <a href="https://www.cdc.gov/kidneydisease/publications-resources/ckd-and-flu.html" target="_blank">Learn More About CKD and Flu </a>
            </li>
        </ul>
    </div>
    <div class="col-sm-1 col-md-1 col-lg-1 col-xl-1"></div>
</div>

<br />