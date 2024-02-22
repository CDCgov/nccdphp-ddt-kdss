<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AwarenessArchive.aspx.cs" Inherits="CKDSurveillance_RD.TopicHome.AwarenessArchive" MasterPageFile="~/MasterPages/ResponsiveContentLeftNavNew.Master" %>

<%@ Register Src="~/UserControls/RDVersions/TopicHomeContent.ascx" TagPrefix="uc1" TagName="TopicHomeContent" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <uc1:TopicHomeContent runat="server" id="TopicHomeContent" TopicID="25" />
</asp:Content>
