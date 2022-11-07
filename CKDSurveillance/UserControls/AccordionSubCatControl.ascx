<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AccordionSubCatControl.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.AccordionSubCatControl" %>
<%@ Register Src="~/UserControls/AccordionIndicatorControl.ascx" TagPrefix="uc1" TagName="AccordionIndicatorControl" %>




<%--******************--%>
<%--*Parent Questions*--%>
<%--******************--%>
<asp:Repeater ID="rptSubcategories" runat="server" onitemdatabound="rptSubcategories_ItemDataBound">
    <HeaderTemplate>
    </HeaderTemplate>
    <ItemTemplate>            
        <div class="ckd-accordion-subcat-header" id="_dvSubCategoryRegular" runat="server" tabindex="0">                        
            
            <asp:Label ID="lblSubCategory" cssclass="ckd-accordion-subcat-label ckd-accordion-minus" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"QuestionText").ToString() %>'></asp:Label>
                        
        </div>
        
        
        
        <%--*************************--%>
        <%--*Leaf level of Questions*--%>
        <%--*************************--%>
        <asp:panel id="pnlContent" runat="server" cssclass="ckd-accordion-subcat-content">            
            <uc1:AccordionIndicatorControl runat="server" ID="AccordionIndicatorControl" />
        </asp:panel>
        
    </ItemTemplate>
    <FooterTemplate>
    </FooterTemplate>
</asp:Repeater>