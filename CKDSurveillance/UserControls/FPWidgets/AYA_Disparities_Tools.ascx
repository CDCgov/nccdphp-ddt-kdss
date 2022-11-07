<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AYA_Disparities_Tools.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.AYA_Disparities_Tools" %>


<div id="accordion">

    <%--*AYA*--%>
    <div class="card">
        <div class="card-header accordHeader" onclick="clickedHeader(0);">
            <a class="card-link clAYA" data-toggle="collapse" href="#0"> <%-- href="#collapseOne">--%>
                Are You Aware
            </a>
        </div>
        <div id="collapseOne" class="collapse" data-parent="#accordion">
            <div class="row" style="margin-left: 5px; margin-right: 5px; margin-bottom: 5px; margin-top: 5px;">
                <div class="card-body bg-white col-sm-9" style="padding-top: 3px;">
                    <p>
                        <a class="list-title mb-1" href="AreYouAware.aspx?emailDate=September_2020">
                            <span class="tickerDate">September 2020</span>
                        </a>
                        &nbsp;-Chronic Kidney Disease Prevalence Is Higher in Older Adults 
                    </p>

                    
                    <p>
                        <a class="list-title" href="AreYouAware.aspx?emailDate=August_2020">
                            <span class="tickerDate">August 2020</span>
                        </a>
                        &nbsp;- Sleep Problems Are More Common in Adults With Chronic Kidney Disease
                    </p>

                    <p>
                        <a class="list-title mb-1" href="AreYouAware.aspx?emailDate=May_2020">
                            <span class="tickerDate">May 2020</span>
                        </a>
                        &nbsp;-Fewer Than a Third of Patients With High Blood Pressure Are Tested for Urine Albumin in Clinical Practice
                    </p>


                </div>
                <div class="col-sm-3 float-right">
                    <img src="./images/comment-warning_Green.png" alt="Are You Aware Summary of CKD information" class="tinyNounImage">
                    <br>
                    <br>
                    <br>
                    <div class="card-footer bt-0 pt-0 bg-white float-right">
                        <a href="AreYouAware.aspx?emailDate=September_2020" class="btn btn-primary specialLinkIconLeft">More</a>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <%--*Calculators*--%>
    <div class="card">
        <div class="card-header accordHeader" onclick="clickedHeader(1);">
            <a class="collapsed card-link clCalcs" data-toggle="collapse"href="#0" ><%-- href="#collapseTwo">--%>
                Calculate Your Risk
            </a>
        </div>
        <div id="collapseTwo" class="collapse" data-parent="#accordion">
            <div class="card ">
                <div class="card-body  ">
                    <div class="row">
                        <div class="col-sm-3 pr-md-0">
                            <img src="./images/Tools_Green.png" alt="Calculate Your Risk of CKD" class="card-img-top img-fluid p-0 tinyNounImage">
                        </div>
                        <div class="col-sm-9">
                            <p style="font-weight: bold;">
                                Risk Calculators:
                            </p>
                            <ul>
                                <li><a class=" td-none td-ul-hover" href="Calculators.aspx#tab-Bang">Probability of CKD</a></li>
                                <li><a class=" td-none td-ul-hover" href="Calculators.aspx#tab-Tangri">Progression of CKD</a></li>
                            </ul>

                            <br>
                            <br>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <%--Disparities Explorer--%>
    <div class="card">
        <div class="card-header accordHeader" onclick="clickedHeader(2);">
            <a class="collapsed card-link clDE" data-toggle="collapse" href="#0"><%--href="#collapseThree">--%>
                Explore Disparities
            </a>
        </div>
        <div id="collapseThree" class="collapse" data-parent="#accordion">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-2 pr-md-0">
                            <img src="./images/Disparities_Green.png" alt="Disparities Explorer for CKD outcomes" class="card-img-top img-fluid p-0 tinyNounImage">
                        </div>
                        <div class="col-sm-10 ">
                            <p>
                                Explore evidence of disparity in CKD outcomes using the Disparities Explorer:
                            </p>
                            <a class=" td-none td-ul-hover" href="DisparityExplorerV2.aspx">Examination of Population Differences</a>
                            <br>
                            <br>
                            <br>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>


<script type="text/javascript">

    
    $(document).ready(function () {
       
        startAccordion();
        equalizeHeights();
        rotateAwareness();        

        addEvents();
    });

  
    var awtabToClick = 0;
    var awinter = 0;    
    function rotateAwareness() {

        var i = 0;
        awinter = setInterval(function () {
            switch (awtabToClick) {
                case 0:
                    $('.clAYA').click();
                    $('#collapseOne').fadeIn(750);
                    awtabToClick++;
                    break;
                case 1:
                    $('.clCalcs').click();
                    $('#collapseTwo').fadeIn(750);
                    awtabToClick++;
                    break;
                case 2:
                    $('.clDE').click();
                    $('#collapseThree').fadeIn(750);
                    awtabToClick = 0;
                    break;
            }

            if (i < 10000000) {
                i++;
            } else {
                clearInterval(awinter);
            }

        }, 5500);
    }
    
    function startAccordion() {

        $('.clAYA').click();        
        $('#collapseOne').fadeIn(750);

        awtabToClick++;        
    }
    function clickedHeader(num) {
        
        
        //Show what they clicked
        switch (num) {
            case 0:
                $('#collapseOne, #collapseTwo, #collapseThree').hide();                            
                $('#collapseOne').fadeIn(750);
                break;
            case 1:
                $('#collapseOne, #collapseTwo, #collapseThree').hide();
                $('#collapseTwo').fadeIn(750);
                break;
            case 2:
                $('#collapseOne, #collapseTwo, #collapseThree').hide();
                $('#collapseThree').fadeIn(750);
               break;
        }        
    }
    function equalizeHeights(){

        //*******
        //*Note:* 
        //*******------------------------------------------------------------------------
        // Make sure this is called AFTER the accordion is opened / (animation started). 
        // Otherwise there is no meaningful height value (especially for IE/edge)
        //-------------------------------------------------------------------------------

        var ayaHeight = $('#collapseOne').height(); //try innerHeight?
        //var calcsHeight = $('#collapseTwo').height();
        //var disparitiesHeight = $('#collapseThree').height(); 

        //Sort descending and get the largest value
        //var heightsArray = [ayaHeight, calcsHeight, disparitiesHeight];
        //heightsArray.sort(function(a, b) {
        //    return b - a;
        //});
        
        //Set all divs to the tallest div
        //$('#collapseOne, #collapseTwo, #collapseThree').height(heightsArray[0]);
        $('#collapseOne, #collapseTwo, #collapseThree').height(ayaHeight);
    }


    //****************
    //*Control events*
    //****************
    function addEvents() {

        //Stop Rotating on mouse-enter
        $('.collapse, .clAYA, .clDE, .clCalcs, .accordHeader').on('mouseenter', function () {
            window.clearInterval(awinter);
        });

        //Rotate anew on mouse out
        $('.collapse, .clAYA, .clDE, .clCalcs, .accordHeader').on('mouseleave', function () {
            rotateAwareness();
        });
    }

    //*************
    //*Page Events*
    //*************

    //On page resize - fix heights
    $(window).resize(function () { equalizeHeights(); });


</script>