<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WorldDiabetesDay.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.WorldDiabetesDay" %>

<div class="module widgetBorder CornerMe">
    
        <h3 class="widgetTitleH3" style="font-size:1.2em; font-family: Poppins;">
            World Diabetes Day
        </h3>
        
                
        <div class="subc">                

                <%--******--%>
                <%--*LOGO*--%>
                <%--******--%>
                <div id="divLogo" class="wddLogo" style="float:left; border:none;">
                    
                    <table width="100%">
                        <tr>
                            <td width="10%">
                                &nbsp;
                            </td>
                            <td width="80%">
                                <div style="padding-left:40px;">
                                    <a href="http://www.idf.org/worlddiabetesday" target="_blank">
                                        <asp:Image ID="imgWDDLogo" ImageUrl="~/images/WDDlogosmall.png" runat="server" Width="180px" AlternateText="World Diabetes Day logo" style="display:block;"/>
                                    </a>
                                </div>
                            </td>
                            <td width="10%">
                                <div id="divExternalSite" style="width:12px; float:left; border:none; height:110px;">
                                    <a href="http://www.cdc.gov/Other/disclaimer.html" target="_blank">
                                        <asp:Image id="imgExternalSiteWKDImage" runat="server" ImageUrl="~/images/icon_out.png" style="float:left;" ImageAlign="left"  title="External Web Site" AlternateText="World Diabetes Day Logo link Opens an External Web Site"/>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </table>    
                                                        
                </div>
                                
                <br />
                

                <%--****************************--%>
                <%--*Bottom Split Links Section*--%>
                <%--****************************--%>
                <div id="divWDDLinks" style="width:340px; clear:left;">
                    
                    <table style="border-collapse:collapse; width:338px;">      
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
                                    <ul class="widgetUL">
                                        <li>
                                            <asp:HyperLink ID="HyperLink1" runat="server" CssClass="ckd-faq-link" text="View Surveillance System Diabetes-Related Indicators" NavigateUrl="~/FactorsOfInterest.aspx?type=Diabetes" />
                                        </li>
                                        <li>
                                            <a href="http://www.cdc.gov/Features/LivingWithDiabetes/" target="_blank">Healthy Living and Diabetes</a>
                                        </li>
                                    </ul>
                                </div>
                            </td>

                        </tr>
                    </table>
                </div>                           
        </div>    
</div>