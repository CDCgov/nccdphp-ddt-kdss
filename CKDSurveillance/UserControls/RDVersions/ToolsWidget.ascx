<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ToolsWidget.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.ToolsWidget" %>

<style type="text/css">
    .calc 
    {
        padding-left:1em;
    }
</style>

<div class="nccd-modA CornerMe">
     
     <%--**************--%>
     <%--*Widget Title*--%>
     <%--**************--%>
    <h3>
       New Tools!
    </h3>

    <div>    
        CKD Calculators (<em>estimate individual risk</em>)
        <br />
        <div class="calc">
            <a href='Calculators.aspx#tab-Bang'>Probability of CKD</a>
            <br />
            <a href='Calculators.aspx#tab-Tangri'>Progression of CKD</a>
        </div>
     <br />
        Disparity Explorer (<em>examine population differences</em>)
        <div class="calc">
            <a href="DisparityExplorerV2.aspx" target="_blank">Explore Disparities</a>
        </div>            
    </div>
</div>