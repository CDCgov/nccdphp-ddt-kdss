<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewIndicatorWidget.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.NewIndicatorWidget" %>




<div class="nccd-modA CornerMe">

     <%--**************--%>
     <%--*Widget Title*--%>
     <%--**************--%>
    <h3 style="font-family: Poppins;">        
       New Indicators!
    </h3>

    <div>                              

        <%--<asp:HyperLink ID="hlNewIndicators" runat="server" NavigateUrl="~/NewIndicators.aspx?type=NewIndicators" Text="View the most recently added indicators to the CKD Surveillance Project" />--%>
        <p>
            <%--In 2017, three new indicators of CKD have been added to the resources on this site.--%>
            <asp:Literal ID="litNewIndicatorsTitle" runat="server" ClientIDMode="Static" />
        </p>
        

        <asp:Literal ID="litNewIndicatorList" runat="server" ClientIDMode="Static" />

        <%--<ul class="list-bullet">
            <li><a href="detail.aspx?QNum=Q687&Strat=Hypertension%20Status,%20Year" target="_blank">CKD Prevalence by Hypertension Status</a></li>
            <li><a href="detail.aspx?QNum=Q685&Strat=Cancer%20Type,%20ACR%20Quintile" target="_blank">Cancer Incidence by Albumin To Creatinine Ratio (ACR) Quintile</a></li>
            <li><a href="detail.aspx?QNum=Q684&Strat=eGFR" target="_blank">Cancer Incidence by eGFR Categories</a></li>
        </ul>--%>

        <p>
            <a href="data.aspx">View all indicators</a>
        </p>
        
        <%--<p>
            See a list of these <a href="NewIndicatorList.aspx">new indicators</a>, or browse <a href="data.aspx">all indicators</a>
        </p>--%>

    </div>

</div>