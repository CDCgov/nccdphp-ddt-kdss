<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StratYearsLinks.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.StratYearsLinks" %>

<%--****************--%>
<%--*Control Styles*--%>
<%--****************--%>
<style type="text/css">
    /*Containing Div*/
    .stratButtonsContainingDiv
    {        
        width: 175px;
        background-color: #f6fbff;
        padding: 3px 3px 3px 3px;
        margin-top: .7em;
        margin-bottom: 1em;
    }

    .YearButtonsContainingDiv
    {
        width: 175px;
        background-color: #f6fbff;
        padding: 3px 3px 3px 3px;
        margin-bottom: 1em;
    }

    /*Strat Table*/
    .stratTable
    {
        width: 173px;
        margin-left: 2px;
    }

    .stratTableLeftColumn
    {
        width: 21%;
        padding-bottom: 7px;
    }

    .stratTableRightColumn
    {
        max-width: 78%;
        padding-bottom: 7px;
        padding-right: 1px;
    }

    /*Year Table*/
    .yearTable
    {
        width: 173px;
        margin-left: 2px;
    }

    .yearTableLeftColumn
    {
        width: 20%;
        padding-bottom: 7px;
    }

    .yearTableRightColumn
    {
        width: 79%;
        padding-bottom: 7px;
    }

    .sybFieldSet
    {
        margin-left: 2px;
    }
    .stratLinks, .yearLinks
    {
        list-style:none;
        margin-left:0px !important;
        padding-bottom:5px;
        /*border-right:solid 1px #e0e0e0;*/
    }
    .stratLinks li 
    {
        margin-bottom:3px;
        padding-left:12px !important;
    }
    .yearLinks li
    {
        margin-bottom:3px;
        padding-left:12px !important;
    }
    .mapBtn 
    {
        width:132px !important;
    }
    .quintileRanges 
    {
        padding-bottom:2px;
    }
    .dataSourceRBTitle {
        background-color: #c5ded6;
        color:#1a7aa2;
        border-top-left-radius:5px;
        border-top-right-radius:5px;
    }

    .stratLinks {
        background-color:#f6fbff;
        border-bottom-left-radius:5px;
        border-bottom-right-radius:5px;
    }

    .yearLinks {
        background-color:#f6fbff;
        border-bottom-left-radius:5px;
        border-bottom-right-radius:5px;
    }
    .linkNotClickable 
    {
        text-decoration:none;            
        color:black !important;
        cursor:default;
    }

    .curMapSetting 
    {        
        font-size:12px;
        color:#000;
    }

</style>




<asp:Panel ID="pnlQuintileRanges" ClientIDMode="Static" runat="server" CssClass="quintileRanges">
    
    <%--************************--%>
    <%--*Quintile Color Choices*--%>
    <%--************************--%>
    <span class="gutterHeaders">Define Ranges</span>&emsp;&emsp;<img id="imgHelpColors" src="images/help_transBG.png" alt="Description of map color options" title="These buttons affect how the colors are applied to the maps. 'Across All Charts' defines colors ranges across all years of data; 'Chosen Year' divides the colors by this year's data only." />
    

    <%--*Chosen Year*--%>    
    <asp:LinkButton ID="btnOneYear" ClientIDMode="Static" runat="server" OnClientClick="$('#OverlayModal').modal('show');" OnClick="btnColorsOneYear_Click" Text="Chosen Year" CssClass=""></asp:LinkButton>    
    <asp:Literal ID="litOneYear" ClientIDMode="Static" runat="server"></asp:Literal>
    <br />
    

    <%--*Accross all years*--%>
    <asp:LinkButton ID="btnAll" ClientIDMode="Static" runat="server" OnClientClick="$('#OverlayModal').modal('show');" OnClick="btnColorRangesAllCharts_Click" Text="Across All Charts" CssClass=""></asp:LinkButton>    
    <asp:Literal ID="litAll" ClientIDMode="Static" runat="server"></asp:Literal>
    <br />


    <%--*Checkbox Maps over time*--%>
    <div id="divLoadMultiYears" class="mapsOverTime">
        <asp:CheckBox ID="cbMultimaps" runat="server" Text="&nbsp;&nbsp;Maps Over Time" Checked="false" AutoPostBack="true" ClientIDMode="static" onClick="$('#OverlayModal').modal('show');  $('.irs-slider').attr('tabindex', '0');" OnCheckedChanged="cbMultimaps_CheckedChanged" />
    </div>    
    <br />

    
</asp:Panel>


<div class="viewDataBy" runat="server" id="divViewDataBy" >
<%--<div id="divStratButtonOuter" class="">--%>

<%--********--%>
<%--*Strats*--%>
<%--********--%>

<%--<div class='dataSourceRBTitle'>View Data By:</div>--%>
    <asp:Literal ID="litStratText" runat="server" Text='<%# Eval("ViewBy") %>'></asp:Literal>

<%--</div>--%>

</div>

<asp:HiddenField ID="hfCSVYears" runat="server" ClientIDMode="Static" Value="" />
