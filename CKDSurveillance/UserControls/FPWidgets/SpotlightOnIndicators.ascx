<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SpotlightOnIndicators.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.SpotlightOnIndicators" %>

<style type="text/css">
    .nav-tabs {
        background-color: #fdfdfd;
        border: solid 1px #c6c6c6;
    }

    .spotlightTitle {
        font-family: "Open Sans","apple-system";
    }
    .tab-pane {
        padding-top:5px !important;
        padding-bottom:0px !important;
    }
</style>


<%--*************************--%>
<%--*SpotLight On Indicators*--%>
<%--*************************--%>
<div id="divSOI" onmouseover="stopEval();" onmouseout="startEval();">
    <div class="card-title h4 mb text-left spotlightTitle">Spotlight on Indicators</div>
    <div id="accordionTabs_3" class="accordion accordion-white mb-3 ds-8" style="min-height: 400px !important;">
        <div class="tabs-module">
            <ul class="nav nav-tabs" id="tabs-3" role="tablist">
                <li class="nav-item siTab0" onclick="makeSelection('tabs-3-1');" onkeydown="checkTabEnterKey(event,'tabs-3-1');"><a class="nav-link active" data-toggle="tab" role="tab" href="#tabs-3-1" aria-selected="true">Are You Aware?</a></li>
                <li class="nav-item siTab1" onclick="makeSelection('tabs-3-2');" onkeydown="checkTabEnterKey(event,'tabs-3-2');"><a class="nav-link" data-toggle="tab" role="tab" href="#tabs-3-2" aria-selected="false">Primary Care</a></li>
                <li class="nav-item siTab2" onclick="makeSelection('tabs-3-3');" onkeydown="checkTabEnterKey(event,'tabs-3-3');"><a class="nav-link" data-toggle="tab" role="tab" href="#tabs-3-3" aria-selected="false">New Indicators</a></li>
            </ul>
            <div class="tab-content">
                <%--*****--%>
                <%--*AYA*--%>
                <%--*****--%>
                <div class="tab-pane tabFOI active current bt-3 bt-primary" role="tabpanel" id="tabs-3-1">

                    <div class="row">
                        <div class="col-12 float-right">
                            <img src="./images/comment-warning_Green.png" alt="Are You Aware Summary of CKD information" class="tinyNounImage float-right">
                        </div>
                    </div>

                    <div class="row" style="margin-left: 3px; margin-right: 2px; margin-bottom: 5px; margin-top: 5px;">
                        <div class="card-body bg-white col-12 col-sm-12 cols-md-12 cols-lg-12 col-xl-12" style="padding-top: 3px;">

                            <%--*AYA Details from DB*--%>
                            <asp:Literal ID="litAYADetails" runat="server" ClientIDMode="Static"></asp:Literal>
                        </div>
                    </div>

                    <%--************--%>
                    <%--*AYA Footer*--%>
                    <%--************--%>
                    <div class="row">
                        <div class="col-12">
                            <div class="card-footer bt-0 pt-0 bg-white float-right">

                                <%--*Get Button Details from DB*--%>
                                <asp:Literal ID="litBtnMore" runat="server" ClientIDMode="Static" />
                            </div>
                        </div>
                    </div>
                </div>


                <%--*********************--%>
                <%--*Primary Care Widget*--%>
                <%--*********************--%>
                <div class="tab-pane tabFOI bt-4 bt-gray-d1" role="tabpanel" id="tabs-3-2">

                    <%--*************--%>
                    <%--*Steth image*--%>
                    <%--*************--%>
                    <div class="row">
                        <div class="card-body col-sm-12 float-right" style="padding-top: 3px;">
                            <img src="./images/steth2.png" class="tinyNounImage float-right" alt="Patient Primary Care Resources" />
                        </div>
                    </div>


                    <div class="row" style="margin-left: 3px; margin-right: 2px; margin-bottom: 5px; margin-top: 5px;">
                        <div class="col-sm-12">
                            <p>
                                Awareness of patients’ CKD among primary care physicians remains low. These topics for primary care providers is vital 
                               for their work on risk factor modification to delay CKD progression and prevent complications.
                            </p>
                            <br />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-11">
                            <div class="card-footer bt-0 pt-0  bg-white float-right">
                                <a href="PrimaryCarePhysicians.aspx" class="btn btn-primary specialLinkIconLeft float-right">More</a>
                            </div>
                        </div>
                        <div class="col-sm-1"></div>
                    </div>
                </div>


                <%--****************--%>
                <%--*New Indicators*--%>
                <%--****************--%>
                <div class="tab-pane tabFOI bt-3 bt-primary" role="tabpanel" id="tabs-3-3">

                    <div class="row">
                        <div class="col-sm-12">
                            <ul class="mb-0 block-list" style="padding-right: 10px;">
                                <li>
                                    <a class="list-title mb-1" href="detail.aspx?QNum=Q715#refreshPosition">Awareness of CKD (NHANES)</a>
                                </li>
                                <li>
                                    <a class="list-title mb-1" href="detail.aspx?QNum=Q716#refreshPosition">Prevalence of CKD (DoD)</a>
                                </li>
                                <li>
                                    <a class="list-title mb-1" href="detail.aspx?QNum=Q713#refreshPosition">ACE / ARB Use (NHANES)</a>
                                </li>
                                <li>
                                    <a class="list-title mb-1" href="detail.aspx?QNum=Q712#refreshPosition">Food Insecurity (NHANES)</a>
                                </li>
                                <li>
                                    <a class="list-title mb-1" href="detail.aspx?QNum=Q717#refreshPosition">CKD and DASH Diet (NHANES)</a>
                                </li>
                                <li>
                                    <a class="list-title mb-1" href="detail.aspx?QNum=Q718#refreshPosition">Veteran Diagnosis (National VA)</a>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div class="card-footer bt-0 pt-0 bg-white pl-0 pr-0 pull-right text-right">
                        <div class="row">
                            <div class="col-sm-11 float-right"><a href="data.aspx" class="btn btn-primary b-primary float-right">All Indicators</a></div>
                            <div class="col-sm-1"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="hfRotate" value="1" />
<input type="hidden" id="hfMostRecentSecond" value="1" />

<script type="text/javascript">


    var permittedSeconds = [00, 05, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55];
    $(document).ready(function () {

        console.log("Document ready");

        //Start with first tab
        $('.siTab0').find('a').click();

        //Prevent widget bounce beneath this widget
        equalizeHeights();

        //Start the timer
        //setInterval(rotate, 1000);
    });


    function rotate() {

        console.log('rotate()');

        //*Notes*
        //Only change every 5 seconds (see array above - nums) -- (should handle run away queueing by the setInterval)


        //If visitor has mouse over any of the rotater parts - pause [stop rotating]
        var eval = $('#hfRotate').val();
        if (eval != '1') { return; }


        //Get dates
        var d = new Date();
        var curSecond = d.getSeconds();


        //Prevent widget bounce beneath this widget
        //equalizeHeights();



        //*Declarations*
        var storedIndexLocation = $('#hfMostRecentSecond').val();
        var indexLocation = permittedSeconds.indexOf(curSecond);

        console.log('stored index: ' + storedIndexLocation);
        console.log('Current second: ' + curSecond);
        console.log('eval: ' + eval);


        //Evaluate current second
        if (indexLocation == -1) {
            //No actions on 'in-between' seconds
            return;
        } else if (indexLocation == storedIndexLocation) {
            //Handle unexpected 'same second' replay hiccups
            console.log('cur location is same as stored - ignoring');
            return;
        } else {
            //Store index location
            $('#hfMostRecentSecond').val(indexLocation)
        }



        //Fade out previous tab's contents
        $('.prev').fadeOut(350);


        //Start next tab AFTER current tab is done fading out
        setTimeout(function () {
            console.log("set timeout to fade in new widget and fade out old widget");
            $('.current').fadeIn(750);


            var curID = $('.current').attr('id');
            console.log('curID: ' + curID);

            switch (curID) {
                case "tabs-3-1":
                    $('.siTab0').find('a').click();
                    $('#tabs-3-1').removeClass('current').addClass('prev');
                    $('#tabs-3-2').addClass('current').removeClass('prev');
                    break;
                case "tabs-3-2":
                    $('.siTab1').find('a').click();
                    $('#tabs-3-2').removeClass('current').addClass('prev');
                    $('#tabs-3-3').addClass('current').removeClass('prev');
                    break;
                case "tabs-3-3":
                    $('.siTab2').find('a').click();
                    $('#tabs-3-3').removeClass('current').addClass('prev');
                    $('#tabs-3-1').addClass('current').removeClass('prev');
                    break;
            }
        }, 360); // start 10 milliseconds after the fadeout
    }

    function stopEval() {
        //console.log("Stop Eval");
        $('#hfRotate').val('0');
    }

    function startEval() {
        //console.log("Start Eval");
        $('#hfRotate').val('1');
    }

    function makeSelection(curID, isKeyBoard) {

        console.log('make selection');

        //Always honor keyboard entry
        if (typeof isKeyBoard === 'undefined' || isKeyBoard != true) {
            //If the mouse is NOT hovering over the widget - leave
            var eval = $('#hfRotate').val();
            if (eval == '1') { return; }
        }

        //Hide content first, make no tab the active  tab
        $('#tabs-3-1, #tabs-3-2, #tabs-3-3').hide();
        $('.siTab0, .siTab1, .siTab2').find('a').removeClass('active');


        //Based on the tab clicked - made tab active / show associated content
        switch (curID) {
            case "tabs-3-1":
                $('#tabs-3-1').fadeIn(750);
                $('.siTab0').find('a').addClass('active');
                break;
            case "tabs-3-2":
                $('#tabs-3-2').fadeIn(750);
                $('.siTab1').find('a').addClass('active');
                break;
            case "tabs-3-3":
                $('#tabs-3-3').fadeIn(750);
                $('.siTab2').find('a').addClass('active');
                break;
        }
    }

    function equalizeHeights() {

        console.log("Equalizing Heights");

        //*******
        //*Note:* 
        //*******------------------------------------------------------------------------
        // Make sure this is called AFTER the accordion is opened / (animation started). 
        // Otherwise there is no meaningful height value (especially for IE/edge)
        //-------------------------------------------------------------------------------        

        //Set all divs to the tallest div        
        var h1 = $('#tabs-3-1').height();
        var h2 = $('#tabs-3-2').height();
        var h3 = $('#tabs-3-3').height();

        var tallest;
        tallest = Math.max(h1, h2, h3);

        //Set all heights to be the same
        $('#tabs-3-1, #tabs-3-2, #tabs-3-3').height(tallest);
    }

    function checkTabEnterKey(e, tabNum) {

        /* check if enter key was pressed on the focussed tab*/
        if (e.keyCode == 13) {
            makeSelection(tabNum, true);
        }
    }


    //***************
    //*Window events*
    //***************
    $(window).focus(function () {
        //If the main page regains or has focus - start eval
        startEval();
    });
    $(window).blur(function () {
        //If the main page loses focus - stop eval
        stopEval();
    });

</script>
