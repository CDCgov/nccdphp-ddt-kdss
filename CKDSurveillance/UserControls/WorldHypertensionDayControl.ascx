<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WorldHypertensionDayControl.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.WorldHypertensionDayControl" %>

   
<div class="module page-curl ckd-healthy-people">
    <div class="inner">
        <h3 style="font-size:16px; font-family: Poppins;">
            <strong>World Hypertension Day</strong>
        </h3>
        <br />
        <div class="subc">
            <div class="description" style="width:346px; float:left;">
                

                <div id="divLogo" class="whdLogo" style="width:181px; float:left; border:none;">
                    <a href="http://ish-world.com/public/world-hypertension-day.htm" target="_blank"><asp:Image ID="imgWKDLogo" ImageUrl="~/images/WorldHypertensionDay_2.jpg" runat="server" Height="67px" Width="180px" AlternateText="World Hypertension Day logo" /></a>
                </div>

                <div id="divExternalSite" style="width:12px; float:left; border:none; height:67px;">
                    <a href="http://www.cdc.gov/Other/disclaimer.html" target="_blank"><asp:Image id="imgExternalSiteWKDImage" runat="server" ImageUrl="~/images/icon_out.png" style="float:left;" ImageAlign="left"  title="External Web Site" AlternateText="World Kidney Day Logo link Opens an External Web Site"/></a>
                </div>

                <div id="divTagLine" class="whdTagLine" style="width:141px; height:67px; float:left;">
                    <br />
                    <strong>Know Your<br /> Blood Pressure</strong>
                </div>

                

                <div id="divWHDLinks" style="width:342px;" class="oneColumn bulleted-links WHDLinks">
                    <ul>
                        <li><asp:HyperLink ID="hlWHDIndicators" runat="server" CssClass="ckd-faq-link" text="View Surveillance System Indicators on Prevalence of CKD and Hypertension" NavigateUrl="~/WHD.aspx" /></li>
                        <li>                            
                            <span>
                                <a href="http://ish-world.com/public/world-hypertension-day.htm" class="ckd-faq-link" style="float:left;" target="_blank">Go to World Hypertension Day Web Site</a>
                                <a href="http://www.cdc.gov/Other/disclaimer.html" target="_blank" style="text-decoration:none;">&nbsp;<asp:Image id="imgExternalSiteWKDWords" runat="server" ImageUrl="~/images/icon_out.png" title="External Web Site" AlternateText="World Hypertension Day Text link Opens an External Web Site"/></a>
                            </span>
                        </li>
                    </ul>
                </div>                
                
                <%--*ADD <br /> here if necessary*--%>

            </div>           
        </div>
    </div>
</div>