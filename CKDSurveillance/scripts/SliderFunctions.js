
/*
6/23/2016
http://www.jqueryrain.com/?Reu_7VWT
Functions in support of the .js slider - simpleSlider
used on the detailX pages

Note: 
Requires a hidden field: #hfSliderVal - that contains the current slider value

*/

//Global for incrementing - consider changing this
var cnt = 0;
var animate = 0;


function sliderNext() {

    $('#Chart1').hide();

    var cv = getCurrentVal();

    //Disallow moving higher than end value - this is automatic - no code needed

    if (parseInt(cv) > 0) {
        $('#simpleSlider').simpleSlider('setValue', cv + 1);
    }
}

function sliderPrevious() {

    $('#Chart1').hide();

    var cv = getCurrentVal();

    //Disallow moving lower than end value - this is automatic - no code needed

    if (parseInt(cv) > 0) {
        $('#simpleSlider').simpleSlider('setValue', cv - 1);
    }
}


function sliderAnimateForward() {
    
    $('#Chart1').hide();
    

    if (cnt == 25) {
        clearNavButtonCSS();
        return;
    }

    var animateState = $('#hfAnimateState').val();

    if (animateState == "0") {
        return;
    }

    var cv = getCurrentVal();
    var minstr = getExtremeVal('MIN');
    var min = parseInt(minstr);
    var max = parseInt(getExtremeVal('MAX'));
    
    if (cv == max) {
        cv = min;
        cnt++;
    } else {
        cv++;
    }
    
    $('#simpleSlider').simpleSlider('setValue', cv);

    setTimeout(function () {
        sliderAnimateForward();
    }, 500);

    
}



function sliderAnimateBackward() {

    
    $('#Chart1').hide();

    if (cnt == 25) {
        clearNavButtonCSS();
        return;
    }
    
    var animateState = $('#hfAnimateState').val();

    if (animateState == "0") {
        return;
    }

    var cv = getCurrentVal();
    var minstr = getExtremeVal('MIN');
    var min = parseInt(minstr);
    var max = parseInt(getExtremeVal('MAX'));

    if (cv == min) {
        cv = max;
        cnt++;
    } else {
        cv--;
    }

    //Go to the start
    $('#simpleSlider').simpleSlider('setValue', cv);
    
    setTimeout(function () {
        sliderAnimateBackward();
    }, 500);

    //clearNavButtonCSS();
}

function sliderStopAnimating() {
    $('#hfAnimateState').val("0");
}

function navPressed(btnID) {
    clearNavButtonCSS();
    $("#" + btnID).addClass('navButtonClicked');
}
function clearNavButtonCSS() {
    $('.vTickerNavButton').removeClass('navButtonClicked');
}



//***********
//*Utilities*
//***********
function getCurrentVal() {

    var cv = parseInt($('#hfSliderVal').val());    
    return cv;
}

function getExtremeVal(Max_or_Min) {
    var answer;    
    var yrs = $('#hfCSVYears').val();
    var yrArray = yrs.split(',');
    
    if (Max_or_Min == "MAX") {
        answer = findmax(yrArray);
    } else if (Max_or_Min == "MIN") {
        answer = findmin(yrArray);
    }

    return answer;
}

function findmax(array) {
    var max = 0;
    var a = array.length;
    var counter;

    for (counter = 0; counter < a; counter++) {
        if (array[counter] > max) {
            max = array[counter]
        }
    }

    return max;
}

function findmin(array) {
    var min = 99999;
    var a = array.length;
    var counter;

    for (counter = 0; counter < a; counter++) {
        if (array[counter] < min) {
            min = array[counter]
        }
    }

    return min;
}

//Possible alternative to setTimeOut - not currently used
function sleep(milliseconds) {
    var start = new Date().getTime();
    for (var i = 0; i < 1e7; i++) {
        if ((new Date().getTime() - start) > milliseconds) {
            break;
        }
    }
}

