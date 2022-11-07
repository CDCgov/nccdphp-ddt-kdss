<%@ Page Title = "CDC – OSH Publication Catalog & Ordering Admin Tool – Session Timeout" Language="C#" MasterPageFile="~/MasterPages/ResponsiveContentEmpty.Master" AutoEventWireup="true" CodeBehind="SessionTimeout.aspx.cs" Inherits="CKDSurveillance_RD.SessionTimeout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentArea2" runat="server">
    
    <p style="margin-top: 50px;">
        <h2>Your browsing session timed out due to 20 minutes of inactivity.</h2>
    </p>
    <p />
    <p>
        <asp:HyperLink runat="server" NavigateUrl="~/default.aspx" CssClass="anchorblue"><span style="font-size:1.4em">Return to the Publication Catalog & Ordering System</span></asp:HyperLink> 
    </p>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="CustomJavaScript" runat="server">
               
        
</asp:Content>

