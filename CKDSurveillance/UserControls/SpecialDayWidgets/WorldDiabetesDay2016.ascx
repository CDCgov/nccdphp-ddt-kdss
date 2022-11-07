<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WorldDiabetesDay2016.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.WorldDiabetesDay2016" %>




<div class="">

     

    <div>
       
        <div id="divPlaceHolder" style="border:solid .05em silver;"> <!--height:175px; width:300px">-->            
                <a href="http://www.cdc.gov/features/worldkidneyday/ " alt="World Diabetes Day" target="_blank">
                    <img id="imgWKD2016" src="images/WDD2016.jpg" alt="November is National Diabetes Month" style="width:385px;" />
                </a>
                <%--<map name="WDD">
                    <area shape="rect" coords="0,0,381,35" href="http://www.cdc.gov/diabetes/programs/initiatives/diabetes-kidney-connection.html " alt="November is National Diabetes Month" target="_blank"/>
                    <area shape="rect" coords="0,36,381,261" href="http://www.cdc.gov/features/worldkidneyday/ " alt="World Diabetes Day" target="_blank"/>
                </map>--%>                            
        </div>
        
        <br />

        <table style="border-collapse:collapse;">
            <tr>
                <td valign="top" style="padding:4px;">
                    <div class="oneColumn bulleted-links WHDLinks">
                        <ul class="list-bullet">
                            <li>
                                <asp:HyperLink ID="hlRiskFactors" runat="server" CssClass="ckd-faq-link" text="View surveillance data on risk factors for Diabetes" NavigateUrl="~/FactorsOfInterest.aspx?type=Diabetes" />
                            </li>
                            <li>
                                <asp:HyperLink ID="hlDiabetesPrevalence" runat="server" CssClass="ckd-faq-link" text="Prevalence of self-reported diabetes" NavigateUrl="~/detail.aspx?QNum=Q120&Strat=Age" />
                            </li>                            
                        </ul>
                    </div>
                </td>

            </tr>
        </table>

    </div>

</div>
<br />
<br />