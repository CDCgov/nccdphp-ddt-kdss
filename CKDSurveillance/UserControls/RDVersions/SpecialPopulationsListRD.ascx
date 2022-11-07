<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SpecialPopulationsListRD.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.SpecialPopulationsListRD" %>



<div class="nccd-modA theme-teal CornerMe">
     <%--**************--%>
     <%--*Widget Title*--%>
     <%--**************--%>
    <h3>
       Focus on Special Populations
    </h3>


    <div>        
        <%--******************************--%>
        <%--*Special Populations Repeater*--%>
        <%--******************************--%>
        <asp:Repeater ID="rptSpecialPopulations" runat="server">
            
            <HeaderTemplate>                
                <ul class="list-bullet">
            </HeaderTemplate>

            <ItemTemplate>
                <li>
                    <asp:hyperlink id="lnkIndicator" runat="server" cssclass="ckd-accordion-indicator" navigateurl='<%# "~/Data.aspx?CategoryID=" + Eval("TopicID")%>'>
                        <asp:literal id="litTopicText" runat="server" text='<%#Eval("TopicText")%>'></asp:literal>
                    </asp:hyperlink>
                </li>                    
            </ItemTemplate>

            <FooterTemplate>
                </ul>                    
            </FooterTemplate>
        </asp:Repeater>        
    </div>

</div>