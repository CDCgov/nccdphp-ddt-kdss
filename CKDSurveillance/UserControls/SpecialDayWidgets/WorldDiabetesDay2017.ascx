<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WorldDiabetesDay2017.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.WorldDiabetesDay2017" %>




<div class="">

     

    <div>
       
        <div id="divPlaceHolder" style="border:solid .05em silver;"> <!--height:175px; width:300px">-->            
                <a href="https://www.cdc.gov/diabetes/pdfs/programs/CKD_TakeCare.pdf" alt="World Diabetes Day" target="_blank">
                    <img id="imgWDD2017" src="images/17_283823-A_Ojeda_Natl_Diabetes_Month_B.png" alt="November is National Diabetes Month" style="width:385px;" />
                </a>
                <%--<map name="WDD">
                    <area shape="rect" coords="0,0,381,35" href="http://www.cdc.gov/diabetes/programs/initiatives/diabetes-kidney-connection.html " alt="November is National Diabetes Month" target="_blank"/>
                    <area shape="rect" coords="0,36,381,261" href="http://www.cdc.gov/features/worldkidneyday/ " alt="World Diabetes Day" target="_blank"/>
                </map>--%>                            
        </div>
        
        <br />

        <table style="border-collapse:collapse;">
            <tr>
                <td style="padding:4px; vertical-align:top;">
                    <div class="oneColumn bulleted-links WHDLinks">
                        <ul class="list-bullet">
                            <li>
                                <asp:HyperLink ID="hlAgeAdjustedPrevalence" runat="server" CssClass="ckd-faq-link" text="Age-Adjusted Prevalence of CKD Stages 1-4 by Diabetes" NavigateUrl="~/detail.aspx?Qnum=Q10&Strat=Diabetes#refreshPosition" />                                 
                            </li>
                            <li>
                                <asp:HyperLink ID="hlStageDiabetes" runat="server" CssClass="ckd-faq-link" text="Disease Awareness by CKD Stage and Diabetes" NavigateUrl="~/detail.aspx?Qnum=Q98&Strat=CKD+Stage%2c+Diabetes#refreshPosition" />                                 
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