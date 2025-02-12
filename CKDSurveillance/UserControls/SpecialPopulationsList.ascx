<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SpecialPopulationsList.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.SpecialPopulationsList" %>


 <div class="widgetContainer">            
        
     <%--**************--%>
     <%--*Widget Title*--%>
     <%--**************--%>
    <h3 class="widgetTitleH3" style="font-size:1.2em; font-family: Poppins;">
        <strong>Focus on Special Populations</strong>
    </h3>


    <div class="subc">
            
        <%--******************************--%>
        <%--*Special Populations Repeater*--%>
        <%--******************************--%>
        <asp:Repeater ID="rptSpecialPopulations" runat="server">
            
            <HeaderTemplate>
                <%--*Just a smidge of separation from Title*--%>
                <ul class="widgetUL">
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