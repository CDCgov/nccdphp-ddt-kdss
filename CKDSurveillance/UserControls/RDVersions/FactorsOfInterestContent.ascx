<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FactorsOfInterestContent.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.FactorsOfInterestContent" %>

<style>
    #hovertooltip {
        display: none;
        background-color: #fff;
        color: #333;
        border-radius: 10px;
        border: 2px solid #BBB;
        padding: 2px;
        max-width: 300px;
        position: absolute;
        z-index: 10002;
    }

    .THPMeasure {
        padding: 2px 2px 2px 4px;
        font-size: 16px;
        color: #000; /*#1a7aa2;*/
    }

    .THPTitle {
        padding: 10px 2px 10px 2px;
        border-radius: 5px;
        text-align: center;
        font-size: 28px;
        font-style: italic;
        font-weight: bold;
        /*background-color:#9dc3e6;
            color: #FFF;*/
        background-color: #c5ded6;
        color: #1a7aa2;
    }

    .THPSubDesc {
        background-color: #deebf7;
        border: 1px solid #1a7aa2;
        border-radius: 5px;
        padding: 4px 10px 4px 10px;
    }
    .topicLevelRow {
        background-color:#C5DED6 !important;
    }
    .factorTableHeader {
        color:#1A7AA2;
        background-color:#C1DED5;
        
        padding-top:8px;
        padding-bottom:8px;

        border-radius:5px;

        font-weight:bold;
        text-align:center;
        font-size:17px;

        margin-bottom:5px;
    }
</style>



<div class="container">

   

    <br />


    <%--******************--%>
    <%--*Page Description*--%>
    <%--******************--%>
    <div class="row">
        <div class="col-xl-12">
            <div class="row">                
                <div class="col-xl-12 col-lg-12">
                    <div class="THPSubDesc">
                        <asp:Literal ID="Lit_Desc" runat="server"></asp:Literal>
                    </div>
                </div>                
            </div>
        </div>
    </div>

    <br />


    <%--**************--%>
    <%--*Page Content*--%>
    <%--**************--%>
    <div class="row">
        <div class="col-xl-1 d-none d-xl-block"></div>
        <div class="col-xl-10 col-lg-12 col-md-12 col-sm-12">
            <div class="row factorTableHeader">
                <div class="col-7">Indicators</div>
                <div class="col-2">Most Recent Year</div>
                <div class="col-3">Data Source</div>
            </div>
        </div>
        <div class="col-xl-1 d-none d-xl-block"></div>
    </div>

    <div class="row">
        <div class="col-xl-1 d-none d-xl-block"></div>
        <div class="col-xl-10 col-lg-12 col-md-12 col-sm-12">
            <asp:Literal ID="Lit_IndicatorText" runat="server"></asp:Literal>
        </div>
        <div class="col-xl-1 d-none d-xl-block"></div>
    </div>


    <div id="hovertooltip">
        <span class="hovertoolspan"></span>
    </div>


    <%--*********--%>
    <%--*Hiddens*--%>
    <%--*********--%>
    <asp:HiddenField ID="HF_SmallChart1Hover" runat="server" />
    <asp:HiddenField ID="HF_SmallChart2Hover" runat="server" />
    <asp:HiddenField ID="HF_SmallChart1URL" runat="server" />
    <asp:HiddenField ID="HF_SmallChart2URL" runat="server" />
    <asp:HiddenField ID="HF_FI_TopicText" runat="server" />
    <asp:HiddenField ID="hfShowCI" runat="server" Value="false" />

</div>



<!-- 10/30/2019 From Thach @ CDC -->
<script>
    $(".accordion .card.bar .card-title").on("keypress", function (a) { a.preventDefault(); });
    $(".accordion .card.bar .card-header:not(.ckd-accordion-subcat-header) .card-title").on("keyup", function (a) { 13 == a.which && $(this).click(); });
    $(".ckd-accordion-subcat-header .card-title").on("keyup", function (a) {
        "block" == $(this).parent().next().css("display") ? ($(this).parent().removeClass("collapsed"), $(this).parent().attr("aria-expanded", "true")) : ($(this).parent().addClass("collapsed"), $(this).parent().attr("aria-expanded", "false"))
    });
</script>
