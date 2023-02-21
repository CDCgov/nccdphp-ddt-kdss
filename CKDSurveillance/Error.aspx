<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPages/ResponsiveContentLeftNavNew.Master" CodeBehind="Error.aspx.cs" Inherits="CKDSurveillance_RD.Error" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <h1>Application Error</h1>
   
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
