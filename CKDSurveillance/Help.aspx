<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ResponsiveContent_popup.Master" AutoEventWireup="true" CodeBehind="Help.aspx.cs" Inherits="CKDSurveillance_RD.Help" %>

<%@ Register Src="~/UserControls/Glossary.ascx" TagPrefix="uc1" TagName="Glossary" %>
<%@ Register Src="~/UserControls/FAQ.ascx" TagPrefix="uc1" TagName="FAQ" %>
<%--<%@ Register Src="~/UserControls/Bibliography.ascx" TagPrefix="uc1" TagName="Bibliography" %>--%>
<%@ Register Src="~/UserControls/DataSources.ascx" TagPrefix="uc1" TagName="DataSources" %>
<%@ Register Src="~/UserControls/AboutTheProject.ascx" TagPrefix="uc1" TagName="AboutTheProject" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<link href="../TemplatePackage/5.0/css/homepage/hp-2024.min.css" rel="stylesheet" />--%>
    <style type="text/css">

        .readable {
            padding-left: 1em;
            padding-right: 1em;
            padding-bottom: 0.5em!important;
            padding-top: 0.5em!important;
            font-size: 18px;
            justify-content: center;
            text-align: center;
            color: white!important;
        }

        .navbar-custom {
            background-color: #f6fbff;
        }

        .gi {
            cursor: default;
        }
    </style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">


    <nav style="padding-bottom:1px;padding-top:0px;" class="navbar navbar-expand-sm navbar-expand-lg navbar-expand-med navbar-expand-xs bg-light justify-content-center navbar-custom" >

        <!-- Links -->
        <div class="navbar-nav w-100" style="padding-left:2px !important;background-color:#f6fbff;">

            <%--<a class="navbar-brand gi" href="#">   --%>             
                <img src="images/CKD_GI_Larger-t5.png<%--graphic_identifier.png--%>" alt="CDC CKD project Logo" style="width: 300px;" />
            <%--</a>--%>
            <button type="button" style="width:100%;text-align: right;border:none; background-color:#f6fbff;padding:0px;" class="close" title="Close Window" aria-label="Close" onclick="javascript:window.close(); return false;">
                    <span aria-hidden="true" class="readable" style="color:black!important">&times;</span>
                </button>
            <%--
            <li class="nav-item">
                <a class="nav-link" href="Help.aspx?section=F" title="View Frequently Asked questions">FAQs</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="Help.aspx?section=G" title="View the Glossary">Glossary</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="Help.aspx?section=D" title="View Data Sources">Data Sources</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="Help.aspx?section=B" title="View the Bibliography">Bibliography</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="Help.aspx?section=H" title="View Information About the CKD Surveillance Project">About The Project</a>
            </li>--%>

            <%--*Close*--%>
            <%--<div class="nav-item" style="width:100%;text-align: right;">--%>
                <%--<div style="width:100%;text-align: right;border:none; background-color:#f8f9fa;padding:7px;"> </div>--%>
            <%--</div>--%>
        </div>

    </nav>


    <%--*Anchor for 'back to top'*--%>

    <a id="nav-container" name="nav-container"></a>
    
    <div id="divtabContent" class="col-lg-11" style="max-width:800px;">
        <div id="divHelpContent" style="width: 100%; padding-left:30px;">

            <br />

            <a id="contentArea" name="contentArea"></a>


            <%--**************************--%>
            <%--*User Controls of Content*--%>
            <%--**************************--%>
            <uc1:AboutTheProject runat="server" ID="AboutTheProject" />
            <uc1:Glossary runat="server" ID="Glossary" />
            <uc1:FAQ runat="server" ID="FAQ" />
            <%--<uc1:Bibliography runat="server" ID="Bibliography" />--%>
            <uc1:DataSources runat="server" ID="DataSources" />
            <br />

        </div>
    </div>
    <div class="col-lg-1"></div>

   <%-- <script type="text/javascript">
        $(document).ready(function () {
            $(this).find('.btn-cdc-mobileview').hide();
            $(this).find('.btn-cdc-contacts').hide();
        });
    </script>--%>
</asp:Content>
  