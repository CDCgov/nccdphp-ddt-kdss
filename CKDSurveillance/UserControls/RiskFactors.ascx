<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RiskFactors.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RiskFactors" %>

<div class="WidgetContainer">
    
    <%--**************--%>
    <%--*Widget Title*--%>
    <%--**************--%>
    <h3 class="widgetTitleH3" style="font-size:1.2em; font-family: Poppins;">
        <strong>Focus on Risk Factors and Themes</strong>
    </h3>
    

    <div class="subc" style="float:left;">

        <%--***********************--%>
        <%--*Risk factors Repeater*--%>
        <%--***********************--%>
        <asp:Repeater ID="rptFactors" runat="server">
            <HeaderTemplate>
                <ul style="padding-top:.7em;">
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




<%--<div class="module page-curl ckd-healthy-people OuterBox">--%>
<%--<div class="OuterBox">
    <div class="inner">
        <h3 class="WidgetTitle">
            <strong>Focus on Risk Factors and Themes</strong>
        </h3>
        <br />
        <div class="subc">
            
            <div class="" style="float:left;">


            <asp:Repeater ID="rptFactors" runat="server">
                <HeaderTemplate>
                    <ul>
                </HeaderTemplate>

                <ItemTemplate>
                    <li>
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
    </div>
</div>--%>