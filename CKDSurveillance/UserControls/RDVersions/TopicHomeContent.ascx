<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TopicHomeContent.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.TopicHomeContent" %>

 <%--*Plotly Charting Tool*--%>
    <script src="../scripts/plotly-latest.min.js"></script>
<style>
    #hovertooltip {
            display:none;
            background-color: #fff;
            border-radius: 10px;
            /*-moz-border-radius: 10px;
            -webkit-border-radius: 10px;
            -khtml-border-radius: 10px;
            
            -webkit-box-shadow: 3px 3px 3px 3px rgba(0, 0, 0, 0.2);
            box-shadow: 3px 3px 3px 3px rgba(0, 0, 0, 0.2);*/
            padding:2px;
            border: 2px solid #BBB;
            max-width:300px;
            /*height:30px;*/
            color: #333;
            position:absolute;
            z-index:10002;
        } 

     .THPMeasure {
            padding: 2px 2px 2px 4px;
            font-size:16px;
            color: #000;/*#1a7aa2;*/
            /*font-weight:bold;*/
        }

        .THPTitle {
            padding: 10px 2px 10px 2px;
            border-radius:5px;
            text-align:center;
            font-size:28px;
            font-style:italic;
            font-weight:bold;
            /*background-color:#9dc3e6;
            color: #FFF;*/
            background-color:#c5ded6;
            color:#1a7aa2;
        }

        .THPSubDesc {
            background-color:#deebf7;
            border: 1px solid #1a7aa2;
            padding: 4px 10px 4px 10px ;
            border-bottom-left-radius: 5px;
            border-top-left-radius: 5px;
            border-bottom-right-radius: 5px;
            border-top-right-radius: 5px;*/
        }

</style>

<div class="container">
    <div class="row">
        <div class="col-xl-12">
            <div class="THPTitle">
                <asp:Literal ID="Lit_TopicTitle" runat="server"></asp:Literal>
            </div>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-xl-12">
            <div class="row">
                <div class="col-xl-2 d-none d-xl-block"></div>
                <div class="col-xl-8 col-lg-12">
                    <div class="THPSubDesc">                    
                        <asp:Literal ID="Lit_Desc" runat="server"></asp:Literal>
                    </div>
                </div>
                <div class="col-xl-2 d-none d-xl-block"></div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-xl-1 d-none d-xl-block"></div>
        <div class="col-xl-4 col-md-6 col-sm-12">
            <div id="divPlotly_small1" class="ChartArea_small1">
                    <asp:Literal ID="Lit_Plotly_small1" runat="server" ></asp:Literal>                               
                    <div id="svgchart_small1" ></div>                                
            </div>
        </div>
        <div class="col-xl-2 d-none d-xl-block"></div>
        <div class="col-xl-4 col-md-6 col-sm-12">
                <div id="divPlotly_small2" class="ChartArea_small2">
                    <asp:Literal ID="Lit_Plotly_small2" runat="server" ></asp:Literal>                               
                    <div id="svgchart_small2" ></div>
            </div>
        </div>
        <div class="col-xl-1 d-none d-xl-block"></div>
    </div>
    <div class="row">
        <div class="col-xl-3 d-none d-xl-block"></div>
        <div class="col-xl-6 col-lg-12">
            <asp:Literal ID="Lit_IndicatorText" runat="server"></asp:Literal>
        </div>
        <div class="col-xl-3 d-none d-xl-block"></div>
        
    </div>
    <div id="hovertooltip"><span class="hovertoolspan"></span></div>
      <asp:HiddenField ID="HF_SmallChart1Hover" runat="server" />
    <asp:HiddenField ID="HF_SmallChart2Hover" runat="server" />
        <asp:HiddenField ID="HF_SmallChart1URL" runat="server" />
    <asp:HiddenField ID="HF_SmallChart2URL" runat="server" />

    <asp:HiddenField ID="HF_TopicText" runat="server" />
    <asp:HiddenField ID="hfShowCI" runat="server" Value="false" />
    
</div>
<br /><br /><br />
 <script>

            $(document).ready(function () {


                //$("#skipchartlink").prop("style","");
                //$("#skipdatatablelink").prop("style","");
                //$("#skippagedetailslink").prop("style", "");

                ////fix for IE
                //$("#skipchartlink").attr("style", "");
                //$("#skipdatatablelink").attr("style", "");
                //$("#skippagedetailslink").attr("style", "");

               

             });




            var document_href = document.location.href.toLowerCase();
            document_href = document_href.substring(0, document_href.indexOf("topichome"));
            console.log("dhref=" + document_href);
            console.log("chart url=" + $("#HF_ChartURL").val());
     

            $("#svgchart_small1").mousemove(function (event) {

                var left = event.pageX + 10;
                var top = event.pageY - 400;
                console.log("left=" + left + " - top=" + top + " - eventx=" + event.pageX + " - eventy=" + event.pageY);
                $("#hovertooltip").css({ top: top, left: left }).show();
                $(".hovertoolspan").text($("[id$=HF_SmallChart1Hover]").val());
                
            });
            $("#svgchart_small1").mouseout(function () { $("#hovertooltip").hide(); });
            $("#svgchart_small1").click(function () { window.location.href = document_href + $("[id$=HF_SmallChart1URL]").val() });

            $("#svgchart_small2").mousemove(function (event) {

                var left = event.pageX + 10;
                var top = event.pageY - 400;
                console.log("left=" + left + " - top=" + top + " - eventx=" + event.pageX + " - eventy=" + event.pageY);
                $("#hovertooltip").css({ top: top, left: left }).show();
                $(".hovertoolspan").text($("[id$=HF_SmallChart2Hover]").val());
                
            });
            $("#svgchart_small2").mouseout(function () { $("#hovertooltip").hide(); });
            $("#svgchart_small2").click(function () { window.location.href = document_href + $("[id$=HF_SmallChart2URL]").val() });

           
        </script>
    <style>
        #svgchart {
            cursor:pointer;
        }
        #svgchart_small1 {
            cursor:pointer;
        }
        #svgchart_small2 {
            cursor:pointer;
        }
        .hovertoolspan {
            padding:4px;
        }
    </style>
    

<script>
    $(".accordion .card.bar .card-title").on("keypress", function (a) { a.preventDefault() }), $(".accordion .card.bar .card-header:not(.ckd-accordion-subcat-header) .card-title").on("keyup", function (a) { 13 == a.which && $(this).click() }), $(".ckd-accordion-subcat-header .card-title").on("keyup", function (a) { "block" == $(this).parent().next().css("display") ? ($(this).parent().removeClass("collapsed"), $(this).parent().attr("aria-expanded", "true")) : ($(this).parent().addClass("collapsed"), $(this).parent().attr("aria-expanded", "false")) });
</script>