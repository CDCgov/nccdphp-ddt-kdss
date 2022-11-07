<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="InfoCardWidget.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.InfoCardWidget" %>

<style>
    .infoCard {
        text-align: center;
        width: 100%;
    }

    .imgSpecialDay {
        /*max-height: 385px;*/
        /*max-width: 385px;*/

        /*Gentle shadow*/
        -webkit-box-shadow: 10px 10px 5px 0px rgba(204,194,204,1);
        -moz-box-shadow: 10px 10px 5px 0px rgba(204,194,204,1);
        box-shadow: 10px 10px 5px 0px rgba(204,194,204,1);
    }
</style>

<div class="row">
    <div class="col-1"></div>
    <div class="col-sm-8 col-md-8 col-lg-10 col-xl-10">
        <div class="infoCard">
            <div id="divPlaceHolder">
                <!--height:175px; width:300px">-->
                <a href="https://www.cdc.gov/kidneydisease/publications-resources/2019-national-facts.html" alt="Learn more this National Kidney Month" target="_blank">
                    <%--<img id="imgIC2018" src="./images/fifteen-percent.jpg" alt="Learn more this National Kidney Month" class="img-fluid imgSpecialDay" />--%>
                    <img id="imgICMain" src="./images/one-in-three-LinkedIn.jpg" alt="One in three adults with diabetes (and one in five adults with high blood pressure) may have chronic kidney disease" class="img-fluid imgSpecialDay" />
                    <%--one-in-three-LinkedIn.jpg style="max-width: 385px;"--%>
                </a>
            </div>
        </div>
    </div>
    <div class="col-1"></div>
</div>

<br />
<br />

<script type="text/javascript">
    $(document).ready(function () {
        setTimeout(function () {
            $('.infoCard').find('.sprite-16-pdf').remove();
        }, 150);

    });
</script>
