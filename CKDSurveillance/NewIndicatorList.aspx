<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPages/ResponsiveContentLeftNavNew.Master" CodeBehind="NewIndicatorList.aspx.cs" Inherits="CKDSurveillance_RD.NewIndicatorList" %>

<%--<%@ register assembly="CommonControls" namespace="NG.NCCDPHP.CommonControls" tagprefix="cdc" %>--%>
<%@ Register Src="~/UserControls/SuggestedCitationControl.ascx" TagPrefix="uc1" TagName="SuggestedCitationControl" %>
<%@ Register Src="~/UserControls/accordionsubcatcontrolSpecialFactor.ascx" TagPrefix="uc2" TagName="accordionsubcatcontrolSpecialFactor" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    
    <script src="scripts/AccordionUtility.js" type="text/javascript"></script>

    <style type="text/css">
        .RoundedAll
        {
            border-top-left-radius:10px;
            border-top-right-radius:10px;
            border-bottom-left-radius:10px;
            border-bottom-right-radius:10px;                        
        }
        .generalFactorDescription
        {
            background-color:#f6fcfb; 
            margin-bottom:.7em; 
            margin-top:.1em; 
            padding:.5em; 
            margin-left:-.2em;
        }
        .colHeader
        {
            padding:.5em;
            background-color:#c1ded5;
            border: solid .1em silver;
        }
        .basicCellStyle
        {
            padding-right:.5em;
        }
         .middleCellStyle
        {
            padding-right:.5em;
            padding-left:1em;
        }
        .indicatorLink
        {
            text-decoration:none !important;
        }
        .indicatorLink:hover
        {
            text-decoration:underline !important;
        }
    </style>

</asp:content>

<asp:Content ContentPlaceHolderID="CustomJavaScript" runat="server">

</asp:Content>

<%--**************--%>
<%--*Content Main*--%>
<%--**************--%>
<asp:Content ID="ContentMain" ContentPlaceHolderID="contentArea2" runat="server">

    <div id="ckd-accordion-tooltip">
        <div class="borderdraw"></div>
        <div class="ckd-accordion-tooltip-body">
        </div>
    </div>


    <div id="top-container">                
        <div class="Pagetitle" runat="server" id="_dvPageTitle">
            <asp:Literal id="litBrowseLabel" runat="server" Text="New Indicators"></asp:Literal>
        </div>
    </div>
    
    <br />
    

    <%--*************--%>
    <%--*Description*--%>
    <%--*************--%>
    <div id="divCombineLogoCopy" class="span24 RoundedAll generalFactorDescription">       
        In 2016, <strong>20</strong> new indicators of CKD have been added to the resources on this site.
    </div>

    <br />
    <br />
    <br />
    <br />



    <%--****************--%>
    <%--*Indicator List*--%>
    <%--****************--%>
    <div id="divNewIndicatorList" class="span24 RoundedAll">

        <asp:GridView ID="gvNewIndicatorList" runat="server"
            AlternatingRowStyle-BackColor="#e8eee9"
            AutoGenerateColumns="false"
            ClientIDMode="Static"
            RowHeaderColumn="New Indicators" 
            UseAccessibleHeader="true"
            CellPadding="4"            
            >
            
            <Columns>

                <%--*TOPIC*--%>
                <asp:TemplateField AccessibleHeaderText="Topic" HeaderText="Topics" HeaderStyle-CssClass="colHeader">
                    <ItemTemplate>
                        <asp:Label ID="lblTopic" runat="server" Text='<%#Eval("Topic") %>' />
                    </ItemTemplate>
                    <ItemStyle VerticalAlign="Top" CssClass="basicCellStyle" />
                </asp:TemplateField>

                <%--*MEASURE*--%>
                <asp:TemplateField AccessibleHeaderText="Measure" HeaderText="Measures" HeaderStyle-CssClass="colHeader">
                    <ItemTemplate>
                        <asp:Label ID="lblMeasure" runat="server" Text='<%#Eval("Measure") %>' />
                    </ItemTemplate>
                    <ItemStyle VerticalAlign="Top" CssClass="middleCellStyle basicCellStyle"/>
                </asp:TemplateField>

                <%--*MEASURE*--%>
                <asp:TemplateField AccessibleHeaderText="Indicator" HeaderText="Indicators" HeaderStyle-CssClass="colHeader">
                    <ItemTemplate>
                        <asp:Hyperlink ID="lblMIndicator" runat="server" CssClass="indicatorLink" Text='<%#Eval("Indicator") %>' NavigateUrl='<%# Eval("ChartURL") %>' />
                    </ItemTemplate>
                    <ItemStyle VerticalAlign="Top"/>
                </asp:TemplateField>

            </Columns>

        </asp:GridView>

    </div> 


    

     
         
    <%--*Page timing element*--%>
    <span id="LoadTime" style="width:400px;color:Olive;"></span>

        
     <br />
     <br />

    <div class="row-fluid">
        <br />
        <br />

        <div class="module roundem faqs span24"  style="display:block; margin-left:12px; margin-top:3em;">
            <uc1:SuggestedCitationControl runat="server" ID="SuggestedCitationControl" />
        </div>
    </div>
    

</asp:content>