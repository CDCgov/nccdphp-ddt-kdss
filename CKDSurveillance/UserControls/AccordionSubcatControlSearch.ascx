<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AccordionSubcatControlSearch.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.AccordionSubcatControlSearch" %>
<%@ Register Src="~/UserControls/AccordionIndicatorControlSearch.ascx" TagPrefix="uc1" TagName="AccordionIndicatorControlSearch" %>





<%--******************--%>
<%--*Parent Questions*--%>
<%--******************--%>
<asp:Repeater ID="rptSubcategories" runat="server" OnItemDataBound="rptSubcategories_ItemDataBound">
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
            <uc1:AccordionIndicatorControlSearch runat="server" ID="AccordionIndicatorControlSearch1" />
        </asp:panel>
        
    </ItemTemplate>
    <FooterTemplate>
    </FooterTemplate>
</asp:Repeater>