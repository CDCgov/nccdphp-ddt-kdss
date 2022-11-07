<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WorldKidneyDay2018.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.WorldKidneyDay2018" %>


<div class="">

    <div>
       
        <div id="divPlaceHolder" style="border:solid .05em silver;"> <!--height:175px; width:300px">-->                            
                    <img id="imgWKD2017" src="images/WKD2018.jpg" alt="March is National Kidney Month" usemap="#WKD" style="width:385px;" />
                
                <map name="WKD">                
                    <area shape="rect" coords="0,0,383,383" href="https://www.cdc.gov/kidneydisease/prevention-risk/women-kidney-health.html" alt="World Kidney Day" target="_blank"/>
                </map>
        </div>
        
        <br />
        <span style="font-size:14.5px;">CKD is estimated to be more common in women than in men</span>
        <br />
        <table style="border-collapse:collapse;">
            <tr>
                <td valign="top" style="padding:4px;">
                    <div class="oneColumn bulleted-links WHDLinks">
                        <ul class="list-bullet">
                            <li>
                                <asp:HyperLink ID="hlPrevalence" runat="server" CssClass="ckd-faq-link" text="Age-Adjusted Prevalence of CKD Stages 1-4" NavigateUrl="~/detail.aspx?Qnum=Q10#refreshPosition" />
                            </li>
                            <li>
                                <asp:HyperLink ID="hlPercentage" runat="server" CssClass="ckd-faq-link" text=" Percentage with CKD Stage 3 or 4 Who Were Aware of Their Disease" NavigateUrl="~/detail.aspx?QNUM=Q98&Strat=CKD+Stage%2c+Gender#refreshPosition" />
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