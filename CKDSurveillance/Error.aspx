<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPages/ResponsiveContentLeftNavNew.Master" CodeBehind="Error.aspx.cs" Inherits="CKDSurveillance_RD.Error" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <h1 style="font-family: Poppins;">Application Error</h1>

    <p>
        <asp:Label ID="lblErrorMessage" runat="server"></asp:Label>
        <asp:HyperLink Target="_blank" ID="lnkContact" CssClass="PointyFinger" runat="server" Text="contact us." Visible="true" />
    </p>

    <br />
    <br />
    <br />
    <br />

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="CustomJavaScript" runat="server">
    <script>
        function popupWindow(url, width, height) {
            window.open(url, '_blank', 'width=' + width + ',height=' + height);
            return false; // This prevents the default link action
        }
    </script>
</asp:Content>
