<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RiskFactorsRD.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.RiskFactorsRD" %>

<div class="nccd-modA CornerMe">
    
     <%--**************--%>
     <%--*Widget Title*--%>
     <%--**************--%>
    <h3>
       Focus on Risk Factors and Themes
    </h3>

    <div>
        <%--***********************--%>
        <%--*Risk factors Repeater*--%>
        <%--***********************--%>
        <asp:Repeater ID="rptFactors" runat="server">
            <HeaderTemplate>
                <ul class="list-bullet">
            </HeaderTemplate>

            <ItemTemplate>
                <li style="line-height:1.75em;">
                    <asp:HyperLink ID="hlFactors" runat="server"  NavigateUrl='<%# "~/FactorsOfInterest.aspx?type=" + Eval("Factor") %>'>
                        <asp:literal id="litFactort" runat="server" text='<%#Eval("DisplayFactor")%>'></asp:literal>
                    </asp:HyperLink>
                </li>
            </ItemTemplate>

            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
    </div>

</div>