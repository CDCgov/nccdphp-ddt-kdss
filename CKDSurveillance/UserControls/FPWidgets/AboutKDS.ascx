<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AboutKDS.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.AboutKDS" %>
       

<style type="text/css">
    .aboutsurveillance {
        margin-top:25px;
        margin-left: -25px;
        margin-bottom:25px;
    }
    .aboutsurveillance-link {
        color:#00695C;
        font-weight:bold;
        text-decoration:none !important;
    }
    .aboutsurveillance-text {
        text-align: justify;
        font: normal normal normal 16px/18px Open Sans;
        letter-spacing: 0px;
        color: #000000;
        opacity: 1;
        padding-top:15px;
        margin-left:15px;
        line-height: normal;
    }
    .kdsimage {
        mix-blend-mode: multiply;
        opacity: 1;
    }
    @media (max-width: 767px) {
        .aboutsurveillance-text {
            text-align:left;
        }
    }
</style>


<%--************************************--%>
<%--*Kidney Disease Surveillance System*--%>
<%--************************************--%> 

<div class="col-12 aboutsurveillance">
    <div class="row">
        <div class="col-md-4">
            <%--*Graphic Identifier*--%>
            <asp:HyperLink ID="hlLogo" runat="server" NavigateUrl="~/Default.aspx">
                <%--<asp:Image ImageUrl="~/images/graphic_identifier.png" runat="server" AlternateText="Graphic Identifier for CKD Project" CssClass="img-fluid img-responsive" style="width:640px; height: 100%;" />--%>
                <img id="KDS" src="/ckd/images/CKD_GI_Larger.png" alt="Graphic Identifier for CKD Project" Class="img-fluid img-responsive kdsimage" />
            </asp:HyperLink>
        </div> 
        <div class="col-sm-7 aboutsurveillance-text">
            <div style="margin-bottom:25px;">
                The Kidney Disease Surveillance System is a comprehensive information system for kidney disease to inform and stimulate public health action. The purpose of the system is to support efforts to reduce the burden and impact of kidney disease on the United States.
            </div>
            <a id="lnkAboutProject" title="Information about the CKD Surveillance Project" class="ckd-glossary-link aboutsurveillance-link" onclick="return popupWindow('Help.aspx?section=H', 800, 600);" href="Help.aspx?section=H"><span>About Surveillance</span><i class="fa fa-angle-right right-angle-arrow"></i></a>
        </div>
    </div>
</div>

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