<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WorldKidneyDay2016.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.WorldKidneyDay2016" %>




<div class="">

     

    <div>
       
        <div id="divPlaceHolder" style="border:solid .05em silver;"> <!--height:175px; width:300px">-->            
                <img id="imgWKD2016" src="images/16_262603_leonard_mar_ckd.jpg" usemap="#WKD" alt="March is National Kidney Month" />            
                <map name="WKD">
                    <area shape="rect" coords="0,0,381,35" href="http://www.cdc.gov/mmwr/volumes/65/wr/mm6508a4.htm?s_cid=mm6508a4_e" alt="March is National Kidney Month" target="_blank"/>
                    <area shape="rect" coords="0,36,381,261" href="http://www.cdc.gov/Features/WorldKidneyDay" alt="World Kidney Day" target="_blank"/>
                </map>                            
        </div>
        
        <br />

        <table style="border-collapse:collapse;">
            <tr>
                <td valign="top" style="padding:4px;">
                    <div class="oneColumn bulleted-links WHDLinks">
                        <ul class="list-bullet">
                            <li>
                                <asp:HyperLink ID="hlPediatric" runat="server" CssClass="ckd-faq-link" text="View pediatric-related indicators in the CKD Surveillance System" NavigateUrl="~/Data.aspx?CategoryID=8" />
                            </li>
                            <li>
                                <asp:HyperLink ID="hlRiskFactors" runat="server" CssClass="ckd-faq-link" text="View surveillance data on risk factors for CKD" NavigateUrl="~/Data.aspx?CategoryID=4" />
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