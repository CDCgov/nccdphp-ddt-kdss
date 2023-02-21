<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ResponsiveContentLeftNavNew.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CKDSurveillance_RD.ErrorDefault.Default" %>

<%@ Register Src="~/UserControls/TemplateLocal/ucBreadcrumbs.ascx" TagPrefix="uc1" TagName="ucBreadcrumbs" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contentArea2" runat="server">
    
    

    <p>
       <asp:label id="lblErrorMessage" runat="server"></asp:label>
        <asp:hyperlink target="_blank" id="lnkContact" CssClass="PointyFinger" runat="server" text="contact us." visible="true" />
    </p>

    <br />
    <br />
    <br />
    <br />



</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomJavaScript" runat="server">
</asp:Content>
