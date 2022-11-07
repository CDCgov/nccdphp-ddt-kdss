<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucSkipNavigation.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.TemplateLocal.ucSkipNavigation" %>

<div id="skipmenu">
	<a href="#searchTarget" tabindex="0" class="skippy">Skip directly to search</a>
	<a href="#azTab" tabindex="0" class="skippy">Skip directly to A to Z list</a>	
	<a href="#share-bar" tabindex="0" class="skippy">Skip directly to page options</a>
	<a href="#contentArea" tabindex="0" class="skippy setFocusLink" onclick="skipNavSetFocus(); return false;">Skip directly to site content</a>
    <%--<a href="#chartArea" tabindex="0" class="skippy" style="display:none" id="skipchartlink">Skip directly to chart</a>
    <a href="#View-Data" tabindex="0" class="skippy" style="display:none" id="skipdatatablelink">Skip directly to data table</a>
    <a href="#detailArea" tabindex="0" class="skippy" style="display:none" id="skippagedetailslink">Skip directly to Key Points, Description, Methods, Field/Data, References</a>--%>
    <asp:Literal ID="litskip" runat="server"></asp:Literal>
</div>