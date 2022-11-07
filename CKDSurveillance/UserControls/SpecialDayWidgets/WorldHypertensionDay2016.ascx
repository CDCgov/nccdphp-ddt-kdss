<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WorldHypertensionDay2016.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.WorldHypertensionDay2016" %>




<div class="">
     
    <div>
       
        <%--http://www.cdc.gov/features/worldkidneyday/ --%>

        <div id="divPlaceHolder" style="border:solid .05em silver;"> <!--height:175px; width:300px">-->                        
                <img id="imgWHD2016" src="images/whd_2016.jpg" usemap="#WHD" alt="May is National Hypertension Month" />            
                <map name="WHD">
                    <area shape="rect" coords="0,0,381,35" href="http://www.cdc.gov/features/worldkidneyday/" alt="May is National Hypertension Month" target="_blank"/>
                    <area shape="rect" coords="0,36,381,261" href="http://www.cdc.gov/bloodpressure/measure.htm"" alt="High Blood Pressure damages Kidneys" target="_blank"/>
                </map>

            <%--<a href="http://www.cdc.gov/features/worldkidneyday/">
                <img id="imgOneInTwo" src="images/one-of-two-linkedin.jpg" style="width:383px;" alt="One of two adults aged 30-64 is expected to develop chronic kidney disease in their lifetime" />
            </a>--%>

        </div>
        
        <br />

        <table style="border-collapse:collapse;">
            <tr>
                <td valign="top" style="padding:4px;">
                    <div class="oneColumn bulleted-links WHDLinks">
                        <ul class="list-bullet">

                            <li><asp:HyperLink ID="hlHypertensionPrevalence" runat="server" CssClass="ckd-faq-link" text="CKD Prevalence by Hypertension Status and Year" NavigateUrl="~/detail.aspx?Qnum=Q687" /></li>
                            <li><asp:HyperLink ID="hlHypertensionPercentage" runat="server" CssClass="ckd-faq-link" text="Percentage with Hypertension by Definition 1999-2014" NavigateUrl="~/detail.aspx?Qnum=Q652&Strat=Definition" /></li>
                            <li>
                                <asp:HyperLink ID="hlHypertension" runat="server" CssClass="ckd-faq-link" text="View hypertension indicators in the CKD Surveillance System" NavigateUrl="~/FactorsOfInterest.aspx?type=Hypertension" />
                            </li>
                            <%--<li>
                                <asp:HyperLink ID="hlHypertension" runat="server" CssClass="ckd-faq-link" text="View hypertension indicators in the CKD Surveillance System" NavigateUrl="~/FactorsOfInterest.aspx?type=Hypertension" />
                            </li>
                            <li>
                                <asp:HyperLink ID="hlRiskFactors" runat="server" CssClass="ckd-faq-link" text="View surveillance data on risk factors for CKD" NavigateUrl="~/Data.aspx?CategoryID=4" />
                            </li>--%>
                        </ul>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>

<br />
<br />