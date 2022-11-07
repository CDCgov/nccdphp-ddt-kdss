<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucSkipNavigation_PopupThin.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.TemplateLocal.ucSkipNavigation_PopupThin" %>

<div id="skipmenu">
	<a href="#nav-container" tabindex="0" class="skippy navcontainer">Skip directly to navigation</a>
    <a href="#contentArea" tabindex="0" class="skippy contentarea">Skip directly to site content</a>    
    <asp:Literal ID="litskip" runat="server"></asp:Literal>
</div>