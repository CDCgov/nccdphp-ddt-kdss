<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPages/ResponsiveContentLeftNav.Master" CodeBehind="FactorsofInterest.aspx.cs" Inherits="CKDSurveillance_RD.FactorsofInterest" %>

<%@ Register Src="~/UserControls/SuggestedCitationControl.ascx" TagPrefix="uc1" TagName="SuggestedCitationControl" %>
<%@ Register Src="~/UserControls/RDVersions/FactorsOfInterestContent.ascx" TagPrefix="uc1" TagName="FactorsOfInterestContent" %>


<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">

    <script src="scripts/AccordionUtility.js" type="text/javascript"></script>

    <style type="text/css">
        .RoundedAll {
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            border-bottom-left-radius: 10px;
            border-bottom-right-radius: 10px;
        }

        .generalFactorDescription {
            background-color: #f6fcfb;
            margin-bottom: .7em;
            margin-top: .1em;
            padding: .5em;
            margin-left: -.2em;
        }
    </style>


    <%--*Page specific CSS*--%>
    <link href="css/FactorsOfInterest.css" rel="stylesheet" />

</asp:Content>

<asp:Content ContentPlaceHolderID="CustomJavaScript" runat="server">

</asp:Content>

<%--**************--%>
<%--*Content Main*--%>
<%--**************--%>
<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">




    <div id="top-container">
        <div class="Pagetitle" runat="server" id="_dvPageTitle">
            <asp:Literal ID="litBrowseLabel" runat="server" Text="Focus on Risk Factors and Themes"></asp:Literal>
        </div>
    </div>

    <br />

    <%--**************--%>
    <%--*Main Content*--%>
    <%--**************--%>
    <uc1:FactorsOfInterestContent runat="server" ID="FactorsOfInterestContent" />



    <br />
    <br />

    <div class="module roundem faqs padcontents10" style="display: block;">
        <uc1:SuggestedCitationControl runat="server" ID="SuggestedCitationControl" />
    </div>    
    

</asp:Content>
