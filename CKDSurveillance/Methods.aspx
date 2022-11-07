<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ResponsiveContent_popup.Master" AutoEventWireup="true" CodeBehind="Methods.aspx.cs" Inherits="CKDSurveillance_RD.MasterPages.Methods" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">

        #divWrapper
        {
            margin-left:2em;
            width:750px;
        }
        #divHeader
        {
            background-color:#c1ded5;
            color:#1a7aa2; 
            border:solid .1em black; 
            padding:.5em .5em .5em .5em; 
            max-width:680px;
        }

        #divIndicator
        {
            position:relative; 
            left:40px; 
            max-width:640px; 
            color:#084599;
        }
        #divMethodsText
        {
            border-right:solid .2em silver; 
            border-bottom:solid .2em silver; 
            border-left:solid .2em silver; 
            padding:.5em .5em .5em .5em; 
            width:680px;
        }
        #divSpecSheetGrid
        {
            padding:.5em .5em .5em .5em; 
            max-width:680px;
        }        
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">    

    <%--*Page Title*--%>
    <h3>Methods:</h3>
    

    <%--*Row*--%>
    <div class="row">
     <asp:panel id="pnlForm" runat="server" visible="true" cssclass="col-xl-12"> <%--ckd-contact-us-panel--%>
 
         <div id="contentArea" name="contentArea" />
            <%--*Measure/Indicator Label & Text*--%>   
            <div class="" style="border:solid .1em silver; background-color:#c5ded6; border-top-left-radius:10px; border-top-right-radius:10px;">
                <span style="color:#1a7aa2; padding-left:.5em;">
                    <strong><asp:Literal id="litMeasure" runat="server"></asp:Literal></strong>
                </span>
                
                <br />

                <span style="padding-left:2em; color:navy;">
                    <strong><asp:Literal id="litIndicator" runat="server"></asp:Literal></strong>
                </span>
            </div>


            <%--*Methods Description*--%>
            <div style="border-left:solid .1em silver; border-right:solid .1em silver; border-bottom:solid .1em silver; background-color:#FFFFFF; padding:.5em; border-bottom-right-radius:10px;border-bottom-left-radius:10px;">
                    <asp:Literal id="litMethodsText" runat="server"></asp:Literal>                   
             </div>         
              

            <br />
            <br />           
                


            <%--*HTML Grid of Spec Sheet Data*--%>
    <%--        <div id="divSpecSheetGrid">--%>
            <asp:Literal id="litSpecSheetGrid" runat="server"></asp:Literal>                                   
            <%--</div>--%>
                   
         
        </asp:panel>  
        <br />
      
    </div> <%--*class=Row*--%>
    

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomJavaScript" runat="server">
</asp:Content>
