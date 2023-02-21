<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FAQGlossaryControl.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FAQGlossaryControl" %>

<div class="ckd-faq-glossary-area" style="display: inline-block; margin: 0 auto;">
    
    <%--************--%>
    <%--*Help Popup*--%>
    <%--************--%>
    <asp:HyperLink ID="lnkAboutProject" cssclass="ckd-glossary-link" runat="server" Text="About the Project" ToolTip="Information about the CKD Surveillance Project" NavigateUrl="Help.aspx?section=H" />&nbsp;|&nbsp;
    <asp:hyperlink id="lnkFaq" cssclass="ckd-faq-link" runat="server" text="FAQs" tooltip="FAQs" navigateurl="Help.aspx?section=F" />&nbsp;|&nbsp; 
    <asp:hyperlink id="lnkGlossary" cssclass="ckd-glossary-link" runat="server" text="Glossary" tooltip="Glossary" navigateurl="Help.aspx?section=G" />&nbsp;|&nbsp; 
    <asp:hyperlink id="lnkDS" cssclass="ckd-glossary-link" runat="server" text="Data Sources" tooltip="Data Sources" navigateurl="Help.aspx?section=D" />&nbsp;|&nbsp; 
    <%--<asp:hyperlink id="lnkBib" cssclass="ckd-glossary-link" runat="server" text="Bibliography" tooltip="Bibliography" navigateurl="Help.aspx?section=B"  />&nbsp;|&nbsp; --%>
    <asp:HyperLink ID="lnkCompleteList" cssclass="ckd-glossary-link" runat="server" text="Complete Indicator List" tooltip="Complete Indicator List" navigateurl="~/data.aspx" />
    
    

    <%--************--%>
    <%--*Contact Us*--%> <%--Note: 9/2021 - this was removed in favor of the general CDC contact us in the footer --%>
    <%--************--%>
   <%-- <asp:hyperlink id="lnkContactUs" cssclass="ckd-glossary-link" runat="server" text="Contact Us" tooltip="Contact Us About CKD" navigateurl="~/contactus.aspx" target="_blank" 
        onclick="return popupWindow('contactus.aspx', 800, 740);" />--%> 

    <script type="text/javascript">
        function popupWindow(url, width, height) {

            var popup;
            var windowwidth;
            var windowheight;          

            var winOptions = "help=no, center=yes, scrollbars=yes, " +
                "width=" + width + "px, " +
                "height=" + height + "px, " +
                "resizable=0, status=off, unadorned=yes, screenX=100, screenY=100";

            var ua = navigator.userAgent;
            var isIE = (document.all || document.getElementById);
            var isFirefox = (ua != null && ua.indexOf("Firefox/") != -1);
            var isNetscape = (ua != null && ua.indexOf("Netscape/") != -1);

            popup = window.open(url, "CKD", winOptions);

            if (popup != null && !popup.closed) {
                popup.focus();
            }
            else {
                if (isIE && !isFirefox && !isNetscape) {
                    windowwidth = document.documentElement.offsetWidth;
                    windowheight = document.documentElement.offsetHeight;
                }
                else if (isNetscape || isFirefox) {
                    windowwidth = window.innerWidth;
                    windowheight = window.innerHeight;
                }
                else {
                    windowwidth = document.body.clientWidth;
                    windowheight = document.body.clientHeight;
                }

                var ckd_left = (windowwidth - width) / 2;
                var ckd_top = Math.min((windowheight - height) / 2, 150);

                var fragment = "<div id=\"ckd_window\" style=\"position: absolute; overflow: auto; left:" + ckd_left + "px; top:" + ckd_top
                    + "px; z-index:1; border:0; visibility:hidden; filter:revealTrans(Duration=0.5, Transition=23);\">"
                    + "<iframe id=\"cframe\" src=" + "\"" + url + "\" width=" + width + " height=" + height + "></iframe></div>";
                document.write(fragment);

            }
            return false;
        }
    </script>

</div>