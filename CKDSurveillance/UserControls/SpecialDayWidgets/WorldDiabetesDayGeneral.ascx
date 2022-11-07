<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WorldDiabetesDayGeneral.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.WorldDiabetesDayGeneral" %>



<%--**************--%>
<%--*Linked Image*--%>
<%--**************--%>
<div class="row">
    <div class="col-12">
        <a href="https://www.cdc.gov/kidneydisease/prevention-risk/make-the-connection.html" target="_blank">
            <img id="imgWDD2020" src="images/2020_Nov_Diabetes_Month.jpg" alt="November is Diabetes Month - If you have diabetes, get tested for kidney disease" style="width: 385px;" />
        </a>
    </div>
</div>

<br />

<%--*******************--%>
<%--*Linked Indicators*--%>
<%--*******************--%>
<div class="row">
    
    <%--*One column cushion*--%>
    <div class="col-1"></div>

    <%--Bulleted List--%>
    <div class="col-11">
        <ul class="list-bullet pull-left" style="text-align: left;">
            <li>
                <asp:HyperLink ID="hlIncidence" runat="server" CssClass="ckd-faq-link" Text="CKD Incidence by Diabetes Status" NavigateUrl="~/detail.aspx?Qnum=Q89&Strat=CKD+Stage%2c+Diabetes#refreshPosition" />
            </li>
            <li>
                <asp:HyperLink ID="hlStageDiabetes" runat="server" CssClass="ckd-faq-link" Text="CKD Awareness by Diabetes Status" NavigateUrl="~/detail.aspx?Qnum=Q98&Strat=Year%2c+Diabetes#refreshPosition" />
            </li>
        </ul>
    </div>    
</div>

<br />
<br />