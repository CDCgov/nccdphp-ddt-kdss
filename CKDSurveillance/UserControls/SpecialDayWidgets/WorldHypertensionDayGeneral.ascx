<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WorldHypertensionDayGeneral.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.WorldHypertensionDayGeneral" %>

<style>
    .infoCard {
        text-align: center;
        width: 100%;
    }

    .imgSpecialDay {        
        -webkit-box-shadow: 10px 10px 5px 0px rgba(204,194,204,1);
        -moz-box-shadow: 10px 10px 5px 0px rgba(204,194,204,1);
        box-shadow: 10px 10px 5px 0px rgba(204,194,204,1);
    }

    .bulletsIntro {
        font-weight: bold;
        text-align: left !important;        
    }
    .UL_SpecDay {
        padding-top:8px;
    }
    .UL_SpecDay, .UL_SpecDay li
    {
        text-align:left !important;
    }
</style>

<%--************************--%>
<%--*World Hypertension Day*--%>
<%--************************--%>

<div class="row">
    <div class="col-1"></div>
    <div class="col-sm-8 col-md-8 col-lg-10 col-xl-10">
        <div class="infoCard">
            <div id="divPlaceHolder">
                <a href="https://www.cdc.gov/kidneydisease/prevention-risk/kidneys-blood-pressure.html" target="_blank">
                    <asp:Image ID="imgHypertension" title="Hypertension Month: Measure Your Blood Pressure Accurately, Control It, Live Longer" ClientIDMode="Static" runat="server" ImageUrl="~/images/hypertension_WG_500x500_2.png" CssClass="img-fluid imgSpecialDay" alt="May is National Hypertension Month: Know your numbers. Control your blood pressure and protect your kidneys" />
                </a>
            </div>
        </div>

        <br />
        
        <span class="bulletsIntro float-left">CKD Surveillance System:</span>
        <br />
        <ul class="UL_SpecDay">
            <li>
                <asp:HyperLink ID="hlHypertensionATC_Adults" runat="server" Text="Hypertension Awareness, Treatment, and Control Among US Adults" NavigateUrl="~/detail.aspx?Qnum=Q135" />
            </li>
            <li>
                <asp:HyperLink ID="hlHypertensionPercentage" runat="server" Text="Hypertension in US Adults with CKD" NavigateUrl="~/detail.aspx?Qnum=Q655" />
            </li>
        </ul>
    </div>
    <div class="col-1"></div>
</div>


<br />