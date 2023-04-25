<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QualityOfCare.aspx.cs" Inherits="CKDSurveillance_RD.TopicHome.QualityOfCare" MasterPageFile="~/MasterPages/ResponsiveContentLeftNavNew.Master" %>

<%@ Register Src="~/UserControls/RDVersions/TopicHomeContent.ascx" TagPrefix="uc1" TagName="TopicHomeContent" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <uc1:TopicHomeContent runat="server" id="TopicHomeContent" TopicID="6" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="CustomJavaScript" runat="server">
    <script>     
        initMetrics();
    </script>
</asp:Content>
