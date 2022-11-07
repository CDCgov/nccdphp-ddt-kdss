<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="accordionsubcatcontrolSpecialFactor.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.accordionsubcatcontrolSpecialFactor" %>
<%@ Register Src="~/UserControls/accordionindicatorcontrolSpecialFactor.ascx" TagPrefix="uc1" TagName="accordionindicatorcontrolSpecialFactor" %>



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
            <uc1:accordionindicatorcontrolSpecialFactor id="AccordionIndicatorControl1" runat="server" />
        </asp:panel>
        
    </ItemTemplate>
    <FooterTemplate>
    </FooterTemplate>
</asp:Repeater>