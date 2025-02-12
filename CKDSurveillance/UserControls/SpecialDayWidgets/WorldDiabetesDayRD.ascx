<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WorldDiabetesDayRD.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.WorldDiabetesDayRD" %>




<div class="module-typeA CornerMe">

     <%--**************--%>
     <%--*Widget Title*--%>
     <%--**************--%>
    <h3 style="font-family: Poppins;">
       World Diabetes Day
    </h3>

    <div>
        <p>
            <%--<a href="http://www.idf.org/worlddiabetesday" target="_blank">--%>
                <asp:Image runat="server" class="center" alt="World Diabetes Day Logo" src="images/WDDlogosmall.png" />
            <%--</a>--%>
        </p>

        <table style="border-collapse:collapse;">      
            <tr>
                <td width="50%" style="background-color:#DBE5F1; padding:4px;">
                    <span style="font-weight:bold;color:#E46C0A; text-align:left; padding-bottom:4px;">
                        Make the Diabetes and Kidney Disease Connection
                    </span>
                        
                    <br />

                    <span style="color:Black; font-weight:bold;">
                        <em>If you have diabetes, ask your doctor about kidney disease.</em>
                    </span>
                </td>

                <td valign="top" style="padding:4px;">
                    <div class="oneColumn bulleted-links WHDLinks">
                        <ul class="list-bullet">
                            <li>
                                <asp:HyperLink ID="HyperLink2" runat="server" CssClass="ckd-faq-link" text="View Surveillance System Diabetes-Related Indicators" NavigateUrl="~/FactorsOfInterest.aspx?type=Diabetes" />
                            </li>
                            <li>
                                <a href="http://www.cdc.gov/diabetes/managing/eatright.html" target="_blank">Healthy Eating and Diabetes</a>
                            </li>
                        </ul>
                    </div>
                </td>

            </tr>
        </table>

    </div>

</div>