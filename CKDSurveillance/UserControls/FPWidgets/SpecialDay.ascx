<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SpecialDay.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.SpecialDay" %>



<style type="text/css">
    .specialFrame {
        align-content: center;
        text-align:center;
        margin:auto;
        padding-top:0px !important;
    }
</style>

<div class="card bg-white specialFrame" style="border:none;">
       
        <%--********************************--%>
        <%--*Placeholder for Current Widget*--%>
        <%--********************************--%>
         <asp:PlaceHolder ID="phWidget" runat="server" ClientIDMode="Static">
            <%--*See Code behind for loading*--%>
        </asp:PlaceHolder>
    
</div>


