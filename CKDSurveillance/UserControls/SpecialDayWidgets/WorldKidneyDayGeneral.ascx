<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WorldKidneyDayGeneral.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.SpecialDayWidgets.WorldKidneyDayGeneral" %>

<style type="text/css">
    .linksOfInterest 
    {
        text-align:left !important;
    }
</style>



<div id="divPlaceHolder" style="border: solid .05em silver;">
    <a href="https://www.cdc.gov/kidneydisease/publications-resources/live-well-with-chronic-kidney-disease.html" target="_blank">
        <img id="imgWKD" src="images/KDSMad.jpg" alt="March is National Kidney Month: Live well with chronic kidney disease" usemap="#WKD" style="width: 100%;" />
    </a>
</div>

<ul class="list-bullet linksOfInterest">
    <li>
        <asp:HyperLink ID="hlPrevalence" runat="server" CssClass="ckd-faq-link" Text="Hypertension Prevalence in the CKD Population" NavigateUrl="~/detail.aspx?Qnum=Q655#refreshPosition" />
    </li>
    <li>
        <asp:HyperLink ID="hlPercentage" runat="server" CssClass="ckd-faq-link" Text="Smoking Prevalence in the CKD Population" NavigateUrl="~/detail.aspx?QNUM=Q664#refreshPosition" />
    </li>
</ul>

<br />
<br />
