<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AreYouAware.aspx.cs" MasterPageFile="~/MasterPages/ResponsiveContentLeftNavNew.Master" Inherits="CKDSurveillance_RD.AreYouAware" %>

<%@ Register Src="~/UserControls/RDVersions/EmailSubscribeRD.ascx" TagPrefix="uc1" TagName="EmailSubscribeRD" %>
<%@ Register Src="~/UserControls/RDVersions/AreYouAwareWidget.ascx" TagPrefix="uc1" TagName="AreYouAwareWidget" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="App_Themes/RSWidgets.css" rel="stylesheet" />

    <style type="text/css">
        .rhs {
            position: fixed;
            left: 1200px;
            top: 320px;
        }

        .lhs {
            /*border: solid 1px silver;*/
            /*width: 825px;*/
            /*height: 1200px;*/
        }

        .selectedClass {
            background-color: #c5ded6;
            color: #1a7aa2;
        }

        .archiveList {
            list-style: none;
        }

        .intro {
            padding: 10px;
            background-color: #c5ded6;
            border: solid 1px silver;
            border-bottom-left-radius: 10px;
            border-bottom-right-radius: 10px;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        #menu li {
            padding-left: 3px;
        }

        iframe, object, embed {
            max-width: 100%;
        }

        .iframecls {
            overflow: auto;
            -webkit-overflow-scrolling: touch;
        }
    </style>

    <%--<link rel="stylesheet" href="/../code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">--%>
    <script src="scripts/jquery-ui.js"></script>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">

    <%--    <div class="row">

        <div class="col-lg-12 Pagetitle"style="margin-bottom:5px;">
            Are You Aware Email Archive
        </div>
    </div>--%>



    <%-- <div class="row">
        <div class="col-lg-3"> --%>

    <uc1:AreYouAwareWidget runat="server" ID="AreYouAwareWidget" showNavButtons="false" />

    <%--                  Each "Are You Aware" email is sent to tens of thousands of subscribers. They contain relevant, timely, and pertinent information on the topic of chronic kidney disease (CKD).
                If you'd like to subscribe to future messages, use the <a href="#getemailupdates">Get Email  Updates</a> widget below.            
            <br />
            <br />
            <a name="getemailupdates"></a>

            <uc1:EmailSubscribeRD runat="server" ID="EmailSubscribeRD" />--%>
    <%-- </div>--%>


    <%--*iFrame*--%>
    <%--        <div class="col-lg-9">
             <a id="refreshPosition" name="refreshPosition"></a>
            <div id="contentdiv"></div>
        </div>--%>

    <script>


        //function iframeLoaded() {

        //}

        function changeContent(datestr) {

            //hiding the border for all links
            $("div[id^='link_']").each(function () {
                $(this).css("border", "2px solid white");
            });

            //changing the border color to orange and rounding the corners for the selected link
            //$("#link_" + datestr).css("border", "2px solid gold");
            //$("#link_" + datestr).css("border-radius", "5px");

            //Reload the page so the URL parameter is correct
            location.href = "AreYouAware.aspx?emailDate=" + datestr + "#refreshPosition";

            /*
            $('#contentdiv').load('AYA/' + datestr + '.html');
            $('html, body').animate({
                scrollTop: $("#contentdiv").offset().top -200
            }, 500);//scrolling to the top of the div after the archived content has been loaded  
            */
        }
    </script>
    <%--    </div>--%>


    <asp:HiddenField ID="HF_initialdate" runat="server" />
    <div class="row">
        <div class="col-lg-12" style="margin-bottom: 5px;">
            &nbsp;
        </div>
    </div>

    <script>
        $(function () {

            var datestr = $('#HF_initialdate').val();
            $('#contentdiv').load("AYA/" + datestr + ".html");
            //$("#link_" + datestr).css("border", "2px solid gold");
            //$("#link_" + datestr).css("border-radius", "5px");

            var parentid = $("#link_" + datestr).data("parentid");
            $("#accordion-4i-card-" + parentid).removeClass("collapsed");
            $("#accordion-4i-card-" + parentid).attr("aria-expanded", "true");
            $("#accordion-4i-collapse-" + parentid).addClass("show");
        });

    </script>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="CustomJavaScript" runat="server">

    <script type="text/javascript">
        $(function () {
            $("#menu").menu({
                items: "> :not(.ui-widget-header)"
            });

            var param = getUrlParameter('emailDate');
            chooseEntry(param);
        });

        function chooseEntry(param) {
            $('#menu li').each(function () {
                var dt = $(this).find('span').attr('date');
                if (dt == param) {
                    $(this).addClass('selectedClass');
                } else {
                    $(this).removeClass('selectedClass');
                }
            });
        }

        var getUrlParameter = function getUrlParameter(sParam) {
            var sPageURL = decodeURIComponent(window.location.search.substring(1)),
                sURLVariables = sPageURL.split('&'),
                sParameterName,
                i;

            for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('=');

                if (sParameterName[0] === sParam) {
                    return sParameterName[1] === undefined ? true : sParameterName[1];
                }
            }
        };

        initMetrics();
    </script>

</asp:Content>
