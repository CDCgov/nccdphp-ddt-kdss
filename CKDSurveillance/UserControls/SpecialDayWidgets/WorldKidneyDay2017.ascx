<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WorldKidneyDay2017.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.WorldKidneyDay2017" %>


<div class="">

    <div>
       
        <div id="divPlaceHolder" style="border:solid .05em silver;"> <!--height:175px; width:300px">-->            
                <%--<a href="http://www.worldkidneyday.org/2016-campaign/2016-wkd-theme/" alt="World Kidney Day 2017" target="_blank">--%>
                    <img id="imgWKD2017" src="images/WKD2017.jpg" alt="March is National Kidney Month" usemap="#WKD" style="width:385px;" />
                <%--</a>--%>
                <map name="WKD">
                    <%--<area shape="rect" coords="0,0,381,35" href="https://www.cdc.gov/mmwr/volumes/66/wr/mm6608a7.htm?s_cid=mm6608a7_w" alt="March is National  Kidney Month" target="_blank"/>--%>
                    <area shape="rect" coords="0,0,381,261" href="http://www.cdc.gov/features/worldkidneyday/ " alt="World Kidney Day" target="_blank"/>
                </map>
        </div>
        
        <br />

        <table style="border-collapse:collapse;">
            <tr>
                <td valign="top" style="padding:4px;">
                    <div class="oneColumn bulleted-links WHDLinks">
                        <ul class="list-bullet">
                            <li>
                                <asp:HyperLink ID="hlRiskFactors" runat="server" CssClass="ckd-faq-link" text="Percentage overweight or obese in the U.S. adult population" NavigateUrl="~/detail.aspx?Qnum=Q143" />
                            </li>
                            <li>
                                <asp:HyperLink ID="hlBMIDiabetes" runat="server" CssClass="ckd-faq-link" text="Age Adjusted Percentage Reporting Diabetes by BMI" NavigateUrl="~/detail.aspx?Qnum=Q121&Strat=BMI" />
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