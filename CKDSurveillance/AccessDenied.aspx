<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeBehind="AccessDenied.aspx.cs" MasterPageFile="~/MasterPages/Blank.Master" Inherits="CKDSurveillance_RD.AccessDenied" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentArea2" runat="server">

<p>   
    You have reached this page because you are not authorized to use it, or you have tried to access it 
    in a non-standard way. If you think you should have access to the system, 
    please contact the <asp:HyperLink runat="server" Target="_blank" ID="lnkAdmin">system administrator</asp:HyperLink>. </p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="CustomJavaScript" runat="server">
               
        
</asp:Content>
