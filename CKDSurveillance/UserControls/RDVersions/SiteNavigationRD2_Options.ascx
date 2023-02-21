<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SiteNavigationRD2_Options.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.SiteNavigationRD2_Options" %>

<style type="text/css">

    .dropdown-menu { /*IE fix*/
        
        width:100%;
        top:0;
        
    }
   
    .descriptionPane
    {
        /*float:left;*/ 
        display:block;         
        max-height:200px; 
        overflow-y:auto;   
    
        margin-bottom:.5em;        
        padding-left:.5em;
        padding-top:.5em;
        padding-bottom:.5em;
        
        background-color: #f5f5f5;
        
        border:solid .1em silver;
        border-radius:7px; 
        
        /*-webkit-box-shadow: 10px 10px 5px -7px rgba(0,0,0,0.71);
        -moz-box-shadow: 10px 10px 5px -7px rgba(0,0,0,0.71);
        box-shadow: 10px 10px 5px -7px rgba(0,0,0,0.71);*/     
    }

    .measureIndicatorsPane
    {
         display:inline-block;  
         /*width:596px;*//*457px; */
         max-height:200px; 
         overflow-y:auto;
         /*float:right;*/

        padding:.3em;
        background-color: #f5f5f5;

        border-radius:7px;
        border:solid .1em silver;
           
         margin-left:5px; 
         margin-bottom: 5px;
    }
    .ui-tabs-panel, .rx-row
    {
        background-color:#c5ded6 !important;
    }
    .buttonUI
    {
        background-color:#1a7aa2;
        color:#ffffff !important;
        font-weight:bold;
        
        line-height:3.5em;

        border-top-right-radius:5px;
        border-top-left-radius:5px;
    }

    .modal-arrow {
            /*content: "";*/
            display: block;
            position: relative;
            margin-top: -2px;
            left: 47%;
            width: 0;
            height: 0;
            border-style: solid;
            border-width: 10px 10px 0 10px;
            border-color: #ffffff transparent  transparent transparent;
        }
    .btn_group {
        display:inline;
        padding:0px 4px 0px 4px;
    }

    .span7 {
        
        margin-left:10px;
        margin-right:5px;
    }

    .menudivider {
        flex:1;
        max-width:2px;
        background-color:#BBB;
        margin:0px !important;
    }


   
    /*.btn {
        padding:4px 4px !important;
    }*/

    /*.btn .btn-measures:hover, .btn .btn-measures:focus, .btn .btn-measures:active, .open>.dropdown-toggle.btn-measures {
    color: #1a7aa2 !important;
    background-color: #1a7aa2 !important;
    border-color: #1a7aa2 !important; 
    background-position: -30px !important;
    }*/

      .btn-primary:hover, .show>.hoverclass{
      color: #1a7aa2 !important;
      background-color: #eee !important;
     
     border-bottom-color: #eee !important;
      background-position: 0 -40px !important;
      text-decoration:none;
      
      
    }

    .hoverclass {
         color: #1a7aa2 !important;
      background-color: #EEE !important;
     
     border-bottom-color: #EEE !important;
      background-position: 0 -40px !important;
    }

    .btn.btn-primary.selectedclass {
         color: #1a7aa2 !important;
      background-color: #eee !important;
     border-color:#F4791F !important;
     border-width:2px;
     border-bottom-color: #DDD !important;
      background-position: 0 -40px !important;
    }

    
     /*.btn-group .btn.btn-primary:not(.dropdown-toggle):hover {
        color: #333;
        background-color: #fff;
        border-color: #ccc;
        cursor: default;
    }*/
    /*.btn-primary:focus {
        border-bottom-color: #DDD !important;
    }*/


    .dropdown-menu {
        margin-top:0px;
        /*margin-top:-509px;
        margin-left:20px;*/
        background-color: #EEE;
         position:relative;
         border-top:#EEE;
         text-align:left;
         /*margin-left:calc(50% - 80px);
         margin-right:calc(50% - 80px);*/

         -webkit-animation-name: example; /* Safari 4.0 - 8.0 */
    -webkit-animation-duration: 4s; /* Safari 4.0 - 8.0 */
    -webkit-animation-delay: 2s; /* Safari 4.0 - 8.0 */
    animation-name: example;
    animation-duration: 4s;
    animation-delay: 2s;

    }

    .measureHeader {
        color:#1a7aa2;
    }

    .MeasureTextTD
    {
        padding: 2px 2px 2px 4px;
        /*border:solid 1px silver;*/
        /*background-color:#ffffff;*/
        color: #1a7aa2;
        font-weight:bold;
        /*font-size:12pt;*/
    
    }

    .IndicatorTD {
        font-size:10pt;
    }

    .dropdown-menu li {
        padding:0px !important;
    }

    .dropdown-menu ul {
        padding:0px !important;
    }

    .siteNavUL li {
        padding:2px !important;
        margin:0px !important;
        /*list-style-type:disc;*/
    }


    .TopicHomeTextTD {
        padding: 4px 4px 4px 4px;
        margin-top:5px;
        border:solid 3px #1a7aa2;
        background-color:#c5ded6;
        border-radius:5px;
        text-align:center;
        font-weight:bold;
        width:100%;
    }

    .row.TopicHomeDiv {
        padding-left:20px !important;
        padding-right:20px !important;
        padding-bottom:10px !important
    }
    .selectedIndicator {
        
        border:solid 2px #F4791F !important;    
        border-radius:5px;   
        padding: 2px 0px 2px 2px !important;
        background-color:#F5F0DD;
        margin-right: 4px
    }

    .selectedBackgroundMeasure {
        /*background-color:#c5ded6;
        padding: 2px 2px 2px 2px;
        
        border-top-left-radius:5px;
        border-top-right-radius:5px;

        border-top:solid 1px #1a7aa2;  
        border-left:solid 1px #1a7aa2;  
        border-right:solid 1px #1a7aa2;*/  

    }

    .selectedBackgroundIndicatorGroup {
        /*background-color:#c5ded6;
        padding: 2px 2px 2px 2px;
        border-bottom-left-radius:5px;
        border-bottom-right-radius:5px;   
        
        border-bottom:solid 1px #1a7aa2;  
        border-left:solid 1px #1a7aa2;  
        border-right:solid 1px #1a7aa2;*/  
    }

    a {
        text-decoration:none !important;
    }

    a:hover {
            text-decoration:underline !important;
    }

    .hideElement {
        display:none;
    }

     /*the dropdown menu will now display on hover*/ /* remove the gap so it doesn't close  */ /* ALSO reomve the data-toggle="dropdown" variables of the buttons*/
    /*.dropdown:hover .dropdown-menu {
        display: block;
        margin-top: 0;
        border-top:#DDD;
    }

    .btn-group {
        position:relative !important;
    }*/

    /*this centers the dropdown mega menu below all of the mega menu buttons*/
    .dropdown-menu-center {
        right: auto;
        left: 50% !important;
        top: 0px !important;
        -webkit-transform: translate(-50%,90px, 0);/*60px is the hieght below the buttons*/
        -o-transform: translate(-50%,90px, 0);
        transform: translate3d(-50%,90px,  0) !important;
    }

    ul {
        margin-bottom:0 !important;
    }

    .btn-primary {
        background-color: #1a7aa2  !important;
        border-color: #1a7aa2  !important; 
        
        color: #FFF !important;
    }

    .btn-megamenu {      
        padding-top: 10px;
        padding-bottom: 10px;
        min-height:90px;
        min-width:160px;
    }

    .buttontext {
        font-size:16px;
    }

    .navbar {
        float: none;
        margin: 0 auto;
        display: block;
        text-align: center;
        padding:0px !important;
    }

    @media (min-width: 1200px) {
        #nav_desktop {
            display:flex;
        }

        #nav_mobile {
            display:none;
        }
    }
    @media (max-width: 1199px)
    {
         #nav_desktop {
            display:none;
        }

        #nav_mobile {
            display:flex;
        }
        /*.btn_group {
            display:block !important;
            padding-bottom:2px;
            min-width:90%;
        }

        #navbarNavDropdown {
            min-width:90%;
        }

        .navbar {
            margin:5px;
            width:100%;
        }
        .btn-megamenu {
            width:90%;
        }*/

        /*.dropdown:hover .dropdown-menu {
            display: none !important;
        }*/
    }


    /*IMPORTANT - hover is controlled in the theme.css line 1291*/
</style>
<%--*Navigate to here after page refresh*--%>
        <a id="refreshPosition" name="refreshPosition"></a>
<div class="container " style="padding-bottom:20px; padding-top:20px;text-align:center;width:100%">

    
    <div class="row" style="margin-left:0px;text-align:center;" id="nav_desktop">
    
        
        <nav class="navbar navbar-toggleable-md navbar-light bg-faded" >
            <div id="navbarNavDropdown">
            <%--<div class="col-lg-12">--%>  
                <div class="btn_group dropdown">
                  <button class="btn btn-primary dropdown-toggle btn-megamenu" data-flip="false"  type="button" id="dropdownMenuButton_Prevalence" data-toggle="dropdown" data-topicid="1" data-topicpage="PrevalenceIncidence" aria-haspopup="true" aria-expanded="false">
                    <span class="buttontext" style="font-weight:bold">Prevalence and <br /> Incidence</span><%--<img alt="Open Menu" style="max-height:10px; padding-left:2px;" src="images/down.png" />--%>
                  </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton_Prevalence"  >
                        <div class="row TopicHomeDiv" ><div class="TopicHomeTextTD" data-topicid="1" data-topicpage="PrevalenceIncidence">View Prevalence and Incidence Summary</div></div>
                         <div class="row dropdownrow" style="align-items: stretch;">
                             <asp:Literal ID="litPrevalenceIndicators" runat="server"></asp:Literal>  
                         </div>
                     </div>
                </div>
                <div class="btn_group dropdown">
                  <button class="btn btn-primary dropdown-toggle btn-megamenu" data-flip="false"  type="button" id="dropdownMenuButton_Awareness" data-toggle="dropdown" data-topicid="3" data-topicpage="Awareness" aria-haspopup="true" aria-expanded="false">
                    <span class="buttontext" style="font-weight:bold">Awareness</span>
                  </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton_Awareness">
                        <div class="row TopicHomeDiv" ><div class="TopicHomeTextTD" data-topicid="3" data-topicpage="Awareness">View Awareness Summary</div></div>
                         <div class="row dropdownrow" style="align-items: stretch;">
                             <asp:Literal ID="litAwarenessIndicators" runat="server"></asp:Literal> 
                         </div>
                     </div>
                </div>
                <div class="btn_group dropdown">
                  <button class="btn btn-primary dropdown-toggle btn-megamenu" data-flip="false" type="button" id="dropdownMenuButton_Burden" data-toggle="dropdown" data-topicid="4" data-topicpage="BurdenOfRiskFactors" aria-haspopup="true" aria-expanded="false">
                    <span class="buttontext" style="font-weight:bold">Burden of <br /> Risk Factors</span>
                  </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton_Burden">
                        <div class="row TopicHomeDiv"><div class="TopicHomeTextTD" data-topicid="4" data-topicpage="BurdenOfRiskFactors">View Burden of Risk Factors Summary</div></div>
                         <div class="row dropdownrow" style="align-items: stretch;">
                             <asp:Literal ID="litBurdenIndicators" runat="server"></asp:Literal>   
                         </div>
                     </div>
                </div>
                <div class="btn_group dropdown">
                  <button class="btn btn-primary dropdown-toggle btn-megamenu" data-flip="false" type="button" id="dropdownMenuButton_HealthConsequences" data-toggle="dropdown" data-topicid="5" data-topicpage="HealthConsequences" aria-haspopup="true" aria-expanded="false">
                    <span class="buttontext" style="font-weight:bold">Health <br /> Consequences</span>
                  </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton_HealthConsequences">
                        <div class="row TopicHomeDiv"><div class="TopicHomeTextTD" data-topicid="5" data-topicpage="HealthConsequences">View Health Consequences Summary</div></div>
                         <div class="row dropdownrow" style="align-items: stretch;">
                             <asp:Literal ID="litHealthConsequencesIndicators" runat="server"></asp:Literal>  
                         </div>
                     </div>
                </div>
                <div class="btn_group dropdown">
                  <button class="btn btn-primary dropdown-toggle btn-megamenu" data-flip="false" type="button" id="dropdownMenuButton_Quality" data-toggle="dropdown" data-topicid="6" data-topicpage="QualityOfCare" aria-haspopup="true" aria-expanded="false">
                    <span class="buttontext" style="font-weight:bold">Quality <br /> of Care</span>
                  </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton_Quality">
                        <div class="row TopicHomeDiv" ><div class="TopicHomeTextTD" data-topicid="6" data-topicpage="QualityOfCare">View Quality of Care Summary</div></div>
                         <div class="row dropdownrow" style="align-items: stretch;">
                             <asp:Literal ID="litQualityIndicators" runat="server"></asp:Literal>   
                         </div>
                     </div>
                </div>
               <div class="btn_group dropdown" style="display:none">
                  <button class="btn btn-primary dropdown-toggle btn-megamenu" data-flip="false" type="button" id="dropdownMenuButton_HealthSystem" data-toggle="dropdown" data-topicid="7" data-topicpage="HealthCareSystemCapacity" aria-haspopup="true" aria-expanded="false">
                    <span class="buttontext" style="font-weight:bold">Health Care <br /> System Capacity</span>
                  </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton_HealthSystem">
                        <div class="row TopicHomeDiv" ><div class="TopicHomeTextTD" data-topicid="7" data-topicpage="HealthCareSystemCapacity">View Health Care System Capacity Summary</div></div>
                         <div class="row dropdownrow" style="align-items: stretch;">
                             <asp:Literal ID="litHealthSystemIndicators" runat="server"></asp:Literal>
                         </div>
                     </div>
                </div>
                <div class="btn_group dropdown">
                  <button class="btn btn-primary dropdown-toggle btn-megamenu" data-flip="false" type="button" id="dropdownMenuButton_SocialDeterminants" data-toggle="dropdown" data-topicid="24" data-topicpage="SocialDeterminantsOfHealth" aria-haspopup="true" aria-expanded="false">
                    <span class="buttontext" style="font-weight:bold">Social Determinants</span>
                  </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton_SocialDeterminants">
                        <div class="row TopicHomeDiv" ><div class="TopicHomeTextTD" data-topicid="24" data-topicpage="SocialDeterminantsOfHealth">View Social Determinants Summary</div></div>
                         <div class="row dropdownrow" style="align-items: stretch;">
                             <asp:Literal ID="litSocialDeterminants" runat="server"></asp:Literal>
                         </div>
                     </div>
                </div>
            <%--</div>--%>
            </div>
        </nav>
        <%--<div class="btn_group" style="display:inline">
            
        </div>
        <div class="btn_group" style="display:inline">
           
        </div>
        <div class="btn_group" style="display:inline">
            
        </div>
        <div class="btn_group" style="display:inline">
            
        </div>
        <div class="btn_group" style="display:inline">
            
        </div>
        <div class="btn_group" style="display:inline">
            
        </div>--%>
    </div>
    <div class="row" style="margin-left:0px;text-align:center;" id="nav_mobile">
        <div class="col-xl-1"></div>
            <div class="col-xl-10">
                <div class="accordion indicator-plus accordion-white" aria-multiselectable="true" role="tabpanel">
                    
                    <asp:Literal id="litMobileIndicators" runat="server"></asp:Literal>
                </div>
            </div>
            <div class="col-xl-1"></div>
    </div>
</div>

<asp:HiddenField ID="HF_TopicText" runat="server" />

<script type="text/javascript">

    $(document).ready(function () {
        
        //navigate to the topic home pages on click

        $('.TopicHomeTextTD').mouseenter(function () { $(this).css('cursor', 'pointer').css('color', '#F4791F'); })
        $('.TopicHomeTextTD').mouseleave(function () { $(this).css('cursor', 'default').css('color', ''); })
        $('.TopicHomeTextTD').click(function () {
            //var hostname = document.location.origin;
            //var domain = document.location.pathname.substr(1);
            //domain = domain.substr(0,domain.indexOf('/'));
            //window.location.href = hostname + '/' + domain + '/topichomepoc.aspx?t=' + $(this).attr("data-topic");
            var document_href = document.location.href;
            if (document_href.toLowerCase().indexOf("topichome") > -1)
                location.href = $(this).attr('data-topicpage') + ".aspx?topicid=" + $(this).attr('data-topicid') + "#refreshPosition";
            else
                location.href = "TopicHome/" + $(this).attr('data-topicpage') + ".aspx?topicid=" + $(this).attr('data-topicid') + "#refreshPosition";
        })
        
        //$('.btn.btn-primary').mouseenter(function () {
        //    console.log("inside enter");
        //    if (!$(this).hasClass("selectedclass") && !$(this).parent().hasClass("show"))
        //        $(this).find('img').attr('src', 'images/down_dark.png');
        //    $(this).find(".dropdown-menu").animate({ down: "100%" }, "slow");
        //})
        // .mouseleave(function () {
        //        console.log("inside leave");
        //    if (!$(this).hasClass("selectedclass") && !$(this).parent().hasClass("show"))
        //        $(this).find('img').attr('src', 'images/down.png');
        //    $(this).find(".dropdown-menu").animate({ up: "100%" }, "slow");
        //});

        //$('.btn.btn-primary.dropdown-toggle').bind("hover", function (e) {
        //    $(this).find('img').attr('src', 'images/down_dark.png');
        //});

        $('.btn.btn-primary').bind("click", function (e) {
            //console.log("inside click from ready");
            //$(".btn.btn-primary").each(function () { //removing the hover class for all buttons
            //    $(this).removeClass("hoverclass");
            //    if ($(this).hasClass("selectedclass"))
            //        $(this).find('img').attr('src', 'images/down_dark.png');
            //    else
            //        $(this).find('img').attr('src', 'images/down.png');
            //});
            
            //if (!$(this).parent().hasClass("show")) {
            //    $(this).addClass("hoverclass");
            //    $(this).find('img').attr('src', 'images/up.png');
            //}
            //else {
            //    //if (!$(this).hasClass("hoverclass"))
            //    //    $(this).find('img').attr('src', 'images/down.png');
            //    //else
            //        $(this).find('img').attr('src', 'images/down_dark.png');
            //}

            //$(this).find(".dropdown-menu").animate({ down: "100%" }, "slow");
        });

        $("button[id^=dropdownMenuButton]").each(function () {
            
            
            var btntext = $(this).text().trim();
            var btntext = btntext.replace(/ /g, ''); //replacing spaces that were created by br tags so the compare will work, this is using a global replace
            var hftext = $("input[id*=HF_TopicText]").val().trim();
            
            var hftext = hftext.replace(/ /g, ''); //replacing spaces so the compare will work

            //console.log("HF text=" + hftext);
            //console.log("BTN text=" + btntext);

            if (hftext.indexOf(btntext) > -1) {
                $(this).addClass("selectedclass");
                $(this).addClass("hoverclass");
                //$(this).find('img').attr('src', 'images/down_dark.png');
                $(this).prop('disabled', false);
            }
        });

       

        //checkResponsiveMenu();

        //$('body').on('mouseover mouseout', '.btn.btn-primary', function (e) {
        //    console.log("inside toggle");
        //    $(e.target).dropdown('toggle');
        //});

        //$('body').on('mouseover mouseout', '.buttontext', function (e) {
        //    console.log("inside toggle text");
        //    $(e.parent.target).dropdown('toggle');
        //});
        
    });

    $("button[id^=dropdownMenuButton]").click(function (event) {

        //var hostname = document.location.origin;
        //var domain = document.location.pathname.substr(1);
        var document_href = document.location.href;

        //console.log("domain=" + domain);
        console.log("document_href=" + document_href);
        //domain = domain.substr(0, domain.indexOf('/'));
        //console.log("hostname=" + hostname);
        //console.log("domainaft=" + domain);
        event.preventDefault();     
        if(document_href.toLowerCase().indexOf("topichome") > -1)
            location.href = $(this).attr('data-topicpage') + ".aspx?topicid=" + $(this).attr('data-topicid') + "#refreshPosition";
        else
            location.href = "TopicHome/" + $(this).attr('data-topicpage') + ".aspx?topicid=" + $(this).attr('data-topicid') + "#refreshPosition";
    });

    $(window).resize(function () {
      // checkResponsiveMenu();
    });

    //function checkResponsiveMenu() { //this function is modifying the layout of the mega menu so that it is 
    //    var sw = $(window).width();
    //    //console.log("inside checkResWin");
    //    //console.log("sw=" + sw);
    //    if (sw <= 1182) {

    //        $(".menudivider").each(function () {
    //            $(this).addClass("hideElement");
    //        });

    //        $(".menucolumn").each(function () {
    //            //$(this).removeClass("span7");
    //           // $(this).addClass("span24");
    //            $(this).css("margin-left", "10px");
    //        });

    //        $(".dropdownrow").each(function () {
    //            //$(this).css("display", "block");
    //            //$(this).css("align-items", "");
    //        });

    //        $(".btn_group, .dropdown").each(function () {
    //            $(this).css("display", "block");
    //        });

    //        $(".btn, .btn-primary, .dropdown-toggle").each(function () {
    //            $(this).css("width", "100%");
    //        });

    //    }
    //    else if (sw > 1182) {
    //        $(".menudivider").each(function () {
    //            $(this).removeClass("hideElement");
    //        });

    //        $(".menucolumn").each(function () {
    //            //$(this).addClass("span7");
    //            //$(this).removeClass("span24");
    //            $(this).css("margin-left", "25px");
    //        });

    //        $(".dropdownrow").each(function () {
    //            //$(this).css("display", "flex");
    //            //$(this).css("align-items", "stretch");
    //        });

    //        $(".btn_group, .dropdown").each(function () {
    //            $(this).css("display", "inline");
    //        });

    //        $(".btn, .btn-primary, .dropdown-toggle").each(function () {
    //            $(this).css("width", "");
    //        });
    //    }
    //}

    //$(".dropdown-toggle").click(function () {
        
    //    console.log("inside click");
    //    $(".btn.btn-primary.dropdown-toggle").each(function () { //removing the hover class for all buttons
    //                $(this).removeClass("hoverclass");
    //    });

    //    $(this).addClass("hoverclass"); //adding the hover class to the specific item highlighted
    //});
    //$(".btn.btn-primary.dropdown-toggle").hover(function () {

    //    $(".btn.btn-primary.dropdown-toggle").each(function () { //removing the hover class for all buttons
    //        $(this).removeClass("hoverclass");
    //    });

    //    $(this).addClass("hoverclass");  //adding the hover class to the specific item highlighted
    //    // }
    //    //,
    //    //function () {
    //    //    $(this).removeClass("hoverclass");//on hover out, remove the highlight button       
        
    //});

   

</script>