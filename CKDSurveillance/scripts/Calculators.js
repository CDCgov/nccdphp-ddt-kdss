
//*Events*
$(document).keydown(function (e) {

    //See Experiment project file: SliderFun.html for keyboard management (508 required)

    var handle = getCurrentSliderHandle();

    if (handle == '0') { return; }
    var txtID = $(':focus').parent().parent().find('.irs-hidden-input').attr('id');

    //*Get the slider*
    var $slider = $('#' + txtID).data('ionRangeSlider');

    //*Get the key pressed*
    if ((e.keyCode || e.which) == 37) {//clicked left arrow        
        moveSlider('d' + handle);
    } else if ((e.keyCode || e.which) == 39) {//clicked right arrow
        moveSlider('a' + handle);
    } else if ((e.keyCode || e.which) == 9) {//Clicked a Tab
        handle = 'b'; //tab
    }


    //Show Graph - if there is enough detail
    showTangriGraphOnSliderChange();


    //Give them all tab-stops
    $('.irs-slider').attr('tabindex', '0');


    //*Reset focus*
    setTimeout(function () {
        switch (handle) {
            case "f":
                $('#' + txtID).parent().find('.from').focus();
                break;
            case "t":
                $('#' + txtID).parent().find('.to').focus();
                break;
            case "b":
                //Do nothing - rather, actively DON'T retain the focus. Be free....fly away...
                break;
        }
    }, 0);

});


//*utilites*
function formatValueForChartText(calculatedValue) {

    var answer;
    //console.log("calc val=" + calculatedValue);
    if (calculatedValue == 0) { calculatedValue = 0.01; }
    if (calculatedValue < 1) { answer = '<1%'; } else { answer = parseFloat(calculatedValue).toFixed(1).toString() + '%'; }


    return answer;
}
function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode != 46 && charCode > 31
      && (charCode < 48 || charCode > 57))
        return false;

    return true;
}
function limitAgeEntry() {

    //Purpose: Do not permit someone to enter a 3 digit year
    //Location(s): Used on Age field in Tangri Calculator

    var contents = $('#txtAge').val();

    if (contents.length > 2) {
        $('#txtAge').val(contents.substring(0, 2))
    }
}
function removeRequirement(name) {

    console.log("inside removeRequirement");
    //Purpose: toggle validation messages on Tangri calculator
    //Location(s): Age and sex fields on Tangri Calculator
    var Tangri_or_Bang = 'b';    

    //*Hide the li's*
    switch (name) {
        case 'tage':
            if ($('#txtAge').val().length > 1) { $('#tage').addClass('hiddenMsg'); }
            Tangri_or_Bang = 't';
            break;
        case 'tsex':
            $('#tsex').addClass('hiddenMsg');
            Tangri_or_Bang = 't';
            break;
        case 'bage':           
            $('#LiBangAge').addClass('hiddenMsg');            
            break;
        case 'bsex':
            $('#LiBangSex').addClass('hiddenMsg');            
            break;
    }

    //*********************
    //*Short cut Variables*
    //*********************
    var isOfAge;
    var maleIsSelected;
    var femaleIsSelected;
    var hasSelectedSex;


    //*************************
    //*Manage Bang Validations*
    //*************************
    if (Tangri_or_Bang == 'b') {

        isOfAge = $('#selBang2').val() > 0;
        femaleIsSelected = $('#rbSexFemale').is(':checked');//console.log('Bang calc female selected: ' + femaleIsSelected);        
        maleIsSelected = $('#rbSexMale').is(':checked');//console.log('Bang calc male selected: ' + maleIsSelected);
        hasSelectedSex = (maleIsSelected == true || femaleIsSelected == true);
        
        setTimeout(function () {
            if (isOfAge == true && hasSelectedSex == true) {
                $('.bang_req_list, .bang_req_list li, .bang_required_messages').addClass('hiddenMsg');
                $('#divBangGraph').removeClass('hiddenMsg');                
            } else if (isOfAge == false) {
                $('.bang_req_list, #LiBangAge, .bang_required_messages').removeClass('hiddenMsg');
                $('#divBangGraph').addClass('hiddenMsg');
                $('#spnBangAnswer').hide();
            } else if (hasSelectedSex == false) {
                $('.bang_req_list, #LiBangSex, .bang_required_messages').removeClass('hiddenMsg');                
                $('#divBangGraph').addClass('hiddenMsg');
                $('#spnBangAnswer').hide();
            } else {
                $('.bang_req_list').addClass('hiddenMsg');
                $('#divBangGraph').addClass('hiddenMsg');
            }
        }, 0);
    }


    //***************************
    //*Manage Tangri Validations*
    //***************************
    else if (Tangri_or_Bang == 't') {

        isOfAge = parseInt($('#txtAge').val()) >= 18;
        maleIsSelected = $('#rbTangriSexMale').is(':checked');//console.log('male selected: ' + maleIsSelected);
        femaleIsSelected = $('#rbTangriSexFemale').is(':checked');//console.log('female selected: ' + femaleIsSelected);
        hasSelectedSex = (maleIsSelected == true || femaleIsSelected == true);//console.log('hasSelectedSex selected: ' + hasSelectedSex);


        //*Manage the outer Div*
        setTimeout(function () {
            if (isOfAge == true && hasSelectedSex == true) {
                $('.tangri_required_messages').addClass('hiddenMsg');//.hide();
                $('#divTangriGraph').removeClass('hiddenMsg');//.show();
            } else if (isOfAge == false) {
                $('.tangri_required_messages').removeClass('hiddenMsg');//.show();
                $('#divTangriGraph').addClass('hiddenMsg');//.hide();
                $('#tage').removeClass('hiddenMsg');//.show();
            } else if (hasSelectedSex == false) {
                $('.tangri_required_messages').removeClass('hiddenMsg');//.show();
                $('#tsex').removeClass('hiddenMsg');//.show();
                $('#divTangriGraph').addClass('hiddenMsg');//.hide();
            } else {
                $('.tangri_required_messages').addClass('hiddenMsg');//.show();
                $('#divTangriGraph').addClass('hiddenMsg');//.hide();
            }
        }, 0);
    }
}
function resetChoices(calculatorName) {

    switch (calculatorName) {
        case 'bang':
            $('#selBang2').val(0);
            $("#rbSexFemale").prop("checked", false);
            $("#rbSexMale").prop("checked", false);
            $("#rbAnemiaNo").prop("checked", true);
            $("#rbHypertensionNo").prop("checked", true);
            $("#rbDiabetesNo").prop("checked", true);
            $("#rbCVDNo").prop("checked", true);
            $("#rbCHFNo").prop("checked", true);
            $("#rbPVDNo").prop("checked", true);
            $("#rbProteinuriaNo").prop("checked", true);

            $('#divBangGraph').html('');
            $('.bangControls').hide().fadeIn(500);            
            
            $('#divBangGraph').removeClass('hiddenMsg');
            $('.bang_req_list, .bang_req_list li, .bang_required_messages').removeClass('hiddenMsg');
            $('#spnBangAnswer').hide();

            break;

        case 'tangri':
            $('#txtAge').text('').val('');
            $('#rbTangriSexFemale').prop("checked", false);
            $('#rbTangriSexMale').prop("checked", false);
            $('#txtEGFR').text('').val('');

            $('#txtACRatio').text('').val('');
            $('#selACRatio').val(1);

            $('#txtSCalcium').text('').val('');
            $('#selSCalcium').val(1);

            $('#txtSPhosphate').text('').val('');
            $('#selSPhosphate').val(1);

            $('#txtSBicarbinate').text('').val('');
            $('#selSBicarbinate').val(1);

            $('#txtSAlbumin').text('').val('');
            $('#selSAlbumin').val(1);

            $('#divBangGraph').html('');
            $('.tangriControls').hide().fadeIn(500);
            $('#spnTangriAnswer').html('');

            resetSliders();

            $('#divTangriGraph').text('').val('');
            
            $('#divTangriGraph').removeClass('hiddenMsg');
            $('.tangri_required_messages, .tangri_required_messages li').removeClass('hiddenMsg');
            break;
    }

    return false;
}
function submitData(calculatorName) {

    console.log("inside submitData " + calculatorName);
    var values = '';


    //*Get the entered values*
    switch (calculatorName) {
        case 'bang':

            //******************
            //*NEED Age AND Sex*
            //******************
            var selectedAge = $('#selBang2 option:selected').val();
            var sex = $('input[type=radio][name=rbSex]:checked').val();
            if (selectedAge == 0 || typeof (sex) == 'undefined') {
                return;
            }

            checkForBangResult();

            break;
        case 'tangri':
            graphTangriResults(checkForTangriResult());
    }


    return false;
}


//*BANG*
function checkForBangResult() {

    var answer = 0;


    var selectedAge = $('#selBang2 option:selected').val();
    var sex = $('input[type=radio][name=rbSex]:checked').val();
    var anemia = $('input[type=radio][name=rbAnemia]:checked').val();
    var hypertension = $('input[type=radio][name=rbHypertension]:checked').val();
    var diabetes = $('input[type=radio][name=rbDiabetes]:checked').val();
    var CVD = $('input[type=radio][name=rbCVD]:checked').val();
    var CHF = $('input[type=radio][name=rbCHF]:checked').val();
    var PVD = $('input[type=radio][name=rbPVD]:checked').val();
    var proteinuria = $('input[type=radio][name=rbProteinuria]:checked').val();
    var interceptThingie = -5.4;


    var calcAnswer = 0;
    var scored = 0;
    var general = 15.4;
    var ckd_prob = 0;


    //*****************
    //*Determine score*
    //*****************
    var crude_score = selectedAge + 1;
    crude_score += sex == 0 ? 1 : 0; //add one if female
    crude_score += anemia;
    crude_score += hypertension;
    crude_score += diabetes;
    crude_score += CVD;
    crude_score += CHF;
    crude_score += PVD;
    crude_score += proteinuria;

    var crude_score1 = crude_score >= 4 ? crude_score : 0;


    //************
    //*xB thingie*
    //************
    var xB = interceptThingie;
    switch (selectedAge) {
        case '2':
            xB += 1.55;
            break;
        case '3':
            xB += 2.31;
            break;
        case '4':
            xB += 3.23;
            break;
    }

    if (sex == 0) { xB += .29; }
    xB += anemia * .93;
    xB += hypertension * .45;
    xB += diabetes * .44;
    xB += CVD * .59;
    xB += CHF * .45;
    xB += PVD * .74;
    xB += proteinuria * .83;

    var CKD_Probability = 1 / (1 + Math.exp(xB * -1));
    var ckd_prob_pretty = (CKD_Probability * 100).toFixed(1);


    //***********************
    //*Show text probability*
    //***********************       
    var txt = "<div>U.S. National Average: <a href='https://nccd.cdc.gov/ckd/detail.aspx?Qnum=Q372' target='_blank'>15.4%</a></div>";    
    $('#spnBangAnswer').html(txt).show();


    //***************
    //*Graph Results*
    //***************
    graphBangResults(scored, general, ckd_prob_pretty);


    //Visual Alert of change
    $('.svg-container').hide().fadeIn(50);


    return answer;
}
function graphBangResults(scored, general, ckd_prob) {

    
    //*Build Chart
    //var xdata = ['Prevalence<br>of CKD, U.S.', 'CKD Probability<br>(This Person)%'];
    var xdata = ['CKD Probability<br>(This Person)%'];

    //No such thing as 0
    //if (general == 0) { general = 0.01; }
    if (ckd_prob == 0) { ckd_prob = 0.01; }

    //1 significant digit only
    //var ydata = [parseFloat(general).toFixed(1), parseFloat(ckd_prob).toFixed(1)]; //Removed SCORE from Brenda's suggestion
    var ydata = [parseFloat(ckd_prob).toFixed(1)]; //Removed General from Jenn's suggestion (3/15/2019 email)

   
    //*Add percentage signs to chart text
    //var generalText = formatValueForChartText(general);
    var ckdProbText = formatValueForChartText(ckd_prob);


    var data = [{
        x: xdata,
        y: ydata,
        type: 'bar',
        //text: ydata,
        //text: [generalText,ckdProbText],
        text: [ckdProbText],
        textposition: 'auto',
        hoverinfo: 'none',
        marker: {
            color: 'rgb(158,202,225)',
            //opacity: 0.6,
            line: {
                color: 'rbg(8,48,107)',
                width: 1.5
            }
        }

    }];

    var layout = {
        yaxis: {
            title: 'Percent',
            fixedrange: true,
            range: [0, 100],
            backgroundcolor: 'rgb(250,250,210)',
            linecolor: 'rgb(0,0,0,0)',
            gridcolor: 'rgb(0,0,0,0)'
        },
        xaxis: {
            fixedrange: true,
            backgroundcolor: 'rgb(250,250,210)',
            linecolor: 'rgb(0,0,0,0)'
        },
        plot_bgcolor: 'rgb(255,255,255)',
        paper_bgcolor: 'rgb(250,250,210)',

    };

    Plotly.newPlot('divBangGraph', data, layout);
}


//*TANGRI*
function checkForTangriResult() {

    var answer = 0;

    if ($('.TangriAddedFields').is(':visible')) {
        //Calculate Long Version                
        answer = runTangriLongVersion()
        return answer;
    } else {
        //Calculate Short Version                
        answer = runTangriShortVersion();
        return answer;
    }

    //Visual Alert of change
    $('.svg-container').hide().fadeIn(300);

}
function getTangriLongValue(age, sex, egfr, albuminCRRatio, acratioUnits, calcium, calciumUnits, phosphorous, phosphorusUnits, albumin, albuminUnits, bicarbonate, bicarbonateUnits, yearType) {

    //*********************************
    //*Tangri Long version calculation*
    //*********************************

    //*Make sure all values are entered*
    if (typeof (age) != 'undefined' && typeof (sex) != 'undefined' && typeof (egfr) != 'undefined' && typeof (albuminCRRatio) != 'undefined' && typeof (acratioUnits) != 'undefined'
        && typeof (calcium) != 'undefined' && typeof (calciumUnits) != 'undefined'
        && typeof (phosphorous) != 'undefined' && typeof (phosphorusUnits) != 'undefined'
        && typeof (albumin) != 'undefined' && typeof (albuminUnits) != 'undefined'
        && typeof (bicarbonate) != 'undefined' && typeof (bicarbonateUnits) != 'undefined'
        ) {

        var ageX, ageCoeff, ageXBar, ageBetaXBar, ageBetaX;
        var sexX, sexCoeff, sexXBar, sexBetaXBar, sexBetaX;
        var egfrX, egfrCoeff, egfrXBar, egfrBetaXBar, egfrBetaX;
        var ratioX, ratioCoeff, ratioXBar, ratioBetaXBar, ratioBetaX;
        var calciumX, calciumCoeff, calciumXBar, calciumBetaXBar, calciumBetaX;
        var phosX, phosCoeff, phosXBar, phosBetaXBar, phosBetaX;
        var albuminX, albuminCoeff, albuminXBar, albuminBetaXBar, albuminBetaX;
        var biCarbX, biCarbCoeff, biCarbXBar, biCarbBetaXBar, biCarbBetaX;

        //*****
        //*AGE*
        //*****
        ageX = age / 10;
        ageCoeff = -0.1992;
        ageXBar = 7.036;
        ageBetaXBar = ageCoeff * ageXBar;
        ageBetaX = ageCoeff * ageX;
        //console.log('ageBetaXBar: ' + ageBetaXBar);

        //*****
        //*SEX*
        //*****
        sexX = sex;//Whatever sex was chosen - rb0=female, rb1=male
        sexCoeff = 0.1602;
        sexXBar = 0.5642;
        sexBetaXBar = sexCoeff * sexXBar;
        sexBetaX = sexCoeff * sexX;
        //console.log('sexBetaXBar: ' + sexBetaXBar);

        //******
        //*eGFR*
        //******
        egfrX = egfr / 5;
        egfrCoeff = -0.4919;
        egfrXBar = 7.222;
        egfrBetaXBar = egfrCoeff * egfrXBar;
        egfrBetaX = egfrCoeff * egfrX;
        //console.log('egfrBetaXBar: ' + egfrBetaXBar);


        //*******
        //*RATIO*
        //*******
        ratioX = Math.log(albuminCRRatio);
        ratioCoeff = 0.3364;
        ratioXBar = 5.137;
        ratioBetaXBar = ratioCoeff * ratioXBar;
        ratioBetaX = ratioCoeff * ratioX;
        //console.log('ratioBetaXBar: ' + ratioBetaXBar);

        //*********
        //*Calcium*
        //*********
        calciumX = calcium;
        calciumCoeff = -0.2228;
        calciumXBar = 9.355;
        calciumBetaXBar = calciumCoeff * calciumXBar;
        calciumBetaX = calciumCoeff * calciumX;
        //console.log('calciumBetaXBar: ' + calciumBetaXBar);
        //console.log('calciumBetaX: ' + calciumBetaX);

        //*************
        //*Phosphorous*
        //*************
        phosX = phosphorous;
        phosCoeff = 0.2604;
        phosXBar = 3.916;
        phosBetaXBar = phosCoeff * phosXBar;
        phosBetaX = phosCoeff * phosX;
        //console.log('phosBetaXBar: ' + phosBetaXBar);
        //console.log('phosBetaX: ' + phosBetaX);


        //*********
        //*Albumin*
        //*********
        albuminX = albumin;
        albuminCoeff = -0.3441;
        albuminXBar = 3.997;
        albuminBetaXBar = albuminCoeff * albuminXBar;
        albuminBetaX = albuminCoeff * albuminX;
        //console.log('albuminBetaXBar: ' + albuminBetaXBar);
        //console.log('albuminBetaX: ' + albuminBetaX);


        //*************
        //*Bicarbonate*
        //*************
        biCarbX = bicarbonate;
        biCarbCoeff = -0.07354;
        biCarbXBar = 25.57;
        biCarbBetaXBar = biCarbCoeff * biCarbXBar;
        biCarbBetaX = biCarbCoeff * biCarbX;
        //console.log('biCarbBetaXBar: ' + biCarbBetaXBar);
        //console.log('biCarbBetaX: ' + biCarbBetaX);


        var betaXBarTotal = ageBetaXBar + sexBetaXBar + egfrBetaXBar + ratioBetaXBar + calciumBetaXBar + phosBetaXBar + albuminBetaXBar + biCarbBetaXBar;
        //console.log('betaXBar-Total: ' + betaXBarTotal);


        var betaXTotal = ageBetaX + sexBetaX + egfrBetaX + ratioBetaX + calciumBetaX + phosBetaX + albuminBetaX + biCarbBetaX;
        // console.log('betaX-Total: ' + betaXTotal);


        var baseLine = 0.9096; //5-year (defualt)
        if (typeof (yearType) != 'undefined' && yearType == '2') { baseLine = 0.9757; } //2 year

        var risk = 1 - Math.pow(baseLine, Math.exp(betaXTotal - betaXBarTotal));
        var report = Math.min(0.7, risk);

        //console.log('Long version calc = ' + report + ' risk is: ' + risk);
        return (risk * 100).toFixed(1);
    }
}
function getTangriShortValue(age, sex, egfr, albuminCRRatio, acratioUnits, yearType) {

    //console.log('albumin val: ' + albuminCRRatio);

    //*Make sure all values are entered*
    if (typeof (age) != 'undefined' && typeof (sex) != 'undefined' && typeof (egfr) != 'undefined' && typeof (albuminCRRatio) != 'undefined' && typeof (acratioUnits) != 'undefined') {

        //if (sex >= 0 && egfr > 0 && albuminCRRatio >= 0 && age > 0 && acratioUnits >= 0) {
            //if (sex >= 0 && albuminCRRatio >= 0 && age > 0 && acratioUnits >= 0) {
            //console.log('Values: ' + age + '|' + sex + '|' + egfr + '|' + albuminCRRatio + '|' + acratioUnits);

            var ageX, ageCoeff, ageXBar, ageBetaXBar, ageBetaX;
            var sexX, sexCoeff, sexXBar, sexBetaXBar, sexBetaX;
            var egfrX, egfrCoeff, egfrXBar, egfrBetaXBar, egfrBetaX;
            var ratioX, ratioCoeff, ratioXBar, ratioBetaXBar, ratioBetaX;


            //*****
            //*AGE*
            //*****
            ageX = age / 10;
            ageCoeff = -0.2201;
            ageXBar = 7.036;
            ageBetaXBar = ageCoeff * ageXBar;
            ageBetaX = ageCoeff * ageX;
            //console.log('ageBetaXBar: ' + ageBetaXBar);

            //*****
            //*SEX*
            //*****
            sexX = sex;//Whatever sex was chosen - rb0=female, rb1=male
            sexCoeff = 0.2467;
            sexXBar = 0.5642;
            sexBetaXBar = sexCoeff * sexXBar;
            sexBetaX = sexCoeff * sexX;
            //console.log('sexBetaXBar: ' + sexBetaXBar);

            //******
            //*eGFR*
            //******
            egfrX = egfr / 5;
            //console.log('egfrX: ' + egfrX);
            egfrCoeff = -0.5567;
            egfrXBar = 7.222;
            egfrBetaXBar = egfrCoeff * egfrXBar;
            egfrBetaX = egfrCoeff * egfrX;
            //console.log('egfrBetaXBar: ' + egfrBetaXBar);
           // console.log('egfrBetaX: ' + egfrBetaX);


            //*******
            //*RATIO*
            //*******
            //curUnit = $('#selACRatio option:selected').text();
            //console.log('unit: ' + curUnit);

            //if (curUnit === 'mg/mmol') { albuminCRRatio = albuminCRRatio * 10; }
            //console.log('***albuCRRation: ' + albuminCRRatio);
            ratioX = Math.log(albuminCRRatio);
            //console.log('ratiox: ' + ratioX);


            ratioCoeff = 0.4510;
            ratioXBar = 5.317;
            ratioBetaXBar = ratioCoeff * ratioXBar;
            ratioBetaX = ratioCoeff * ratioX;
            //console.log('ratioBetaXBar: ' + ratioBetaXBar);


            var betaXBarTotal = ageBetaXBar + sexBetaXBar + egfrBetaXBar + ratioBetaXBar;
            //console.log('betaXBar-Total: ' + betaXBarTotal);


            var betaXTotal = ageBetaX + sexBetaX + egfrBetaX + ratioBetaX;
            //console.log('betaX-Total: ' + betaXTotal);


            //var st = 0.963370;                    
            var baseLine = 0.8996; //5-year (default)
            if (typeof(yearType) != 'undefined' && yearType == '2') { baseLine = 0.9751; } //2 year

            var risk = 1 - Math.pow(baseLine, Math.exp(betaXTotal - betaXBarTotal));
            var report = Math.min(0.7, risk);

            //console.log('Short version calc = ' + report + ' risk is: ' + risk);
            return (risk * 100).toFixed(1);
        //}
    }
}
function graphTangriResults(twoYrData, fiveYrData) {
    //console.log("graphTangriResults");
    //Using the Ben S model (s:\mlipham\Bens\plotlyML.html)
    var xData = ['Two Year<br />Risk of Progression', 'Five Year<br />Risk of Progression'];
    
    var twoYrZero = parseFloat(twoYrData[0]);
    var fiveYrZero = parseFloat(fiveYrData[0]);
    var twoYrOne = parseFloat(twoYrData[1]);
    var fiveYrOne = parseFloat(fiveYrData[1]);

    var twoyeartext;
    var fiveyeartext;

    if (typeof (twoYrData[1]) === "undefined") {
        twoYrOne = 0;
        twoyeartext = formatValueForChartText(twoYrOne);
    }
    else { twoyeartext = formatValueForChartText(twoYrZero) + ' - ' + formatValueForChartText(twoYrOne); }  //text above the bar should contain a range, unless the value is <1%

    if (typeof (fiveYrData[1]) === "undefined") {
        fiveYrOne = 0;
        fiveyeartext = formatValueForChartText(fiveYrOne);
    }
    else { fiveyeartext = formatValueForChartText(fiveYrZero) + ' - ' + formatValueForChartText(fiveYrOne);  } //text above the bar should contain a range, unless the value is <1%

    var textList = [twoyeartext, fiveyeartext];
    var yData = [twoYrOne, fiveYrOne];

    //console.log('xdata:' + xData);
    //console.log('textlist:' + textList);
    //console.log('ydata:' + yData);

    //console.log('2year:' + twoYrData);
    //console.log('5year:' + fiveYrData);

    //*Base*
    var trace1 = {
        x: xData,
        y: [twoYrData[0], fiveYrData[0]],
        text: '',
        marker: {
            color: 'rgba(61,15,132,0.0)' //purple
        },
        type: 'bar',
        hoverinfo: 'skip'
    };


    //*Lowest Risk*
    var trace2 = {
        x: xData,
        y: [twoYrData[1] - twoYrData[0], 0],//total - trace1 y[i] (put in first slot only - nothing in second series placeholder)
        type: 'bar',
        text: ['Upper Risk:' + twoYrData[1] + '<br>Lower Risk:' + twoYrData[0], ''],
        marker: {
            //color: 'rgba(255, 153, 51,1)',
            color: 'rgba(211, 211, 211, 1)', //gray
            line: {
                color: 'rgba(0, 0, 0,1.0)',
                width: 1
            }
        },
        name: ''
    };
    
    //*Highest Risk*
    var trace3 = {
        x: xData,
        y: [0, fiveYrData[1] - fiveYrData[0]],//total - trace1 y[i] (put in second slot only - nothing in first series placeholder)
        type: 'bar',
        text: ['', 'Upper Risk:' + fiveYrData[1] + '<br>Lower Risk:' + fiveYrData[0]],
        marker: {
            //color: 'rgba(153, 204, 255, 1)',
            color: 'rgba(211, 211, 211, 1)', //gray
            line: {
                color: 'rgba(0, 0, 0, 1.0)',
                width: 1
            }
        },
        name: ''
    };

    var data = [trace1, trace2, trace3];

    var shapesArray;
    if (typeof(twoYrData[1]) === "undefined" || typeof(fiveYrData[1]) === "undefined") //if the second value of the array is undefined, then don't display the blue/orange lines
    {
        shapesArray = "";
    }
    else
    {
        shapesArray = "[ " +//drawing line borders to represent the upper and lower risks
        " {"  + //two year upper risk
        "type: 'line'," +
            "xref: 'paper'," +
            "x0: 0.05," +
            "y0: twoYrData[1]," +
            "x1: 0.45," +
            "y1: twoYrData[1]," +
            "line: {" +
            //"    color: 'rgb(153, 204, 255)'," + //Light Blue
            "    color: 'rgb(128, 0, 0)'," + //Maroon
            "    width: 4," +
            "    dash: 'solid'" +
            "}" +
        "}," +
        "{" +   //two year lower risk
            "type: 'line'," +
            "xref: 'paper'," +
            "x0: 0.05," +
            "y0: twoYrData[0]," +
            "x1: 0.45," +
            "y1: twoYrData[0]," +
            "line: {" +
            //"    color: 'rgb(255, 153, 51)'," + //Orange
            "    color: 'rgb(102, 178 ,102 )'," + //Green
            "    width: 4," +
            "    dash: 'solid'" +
            "}" +
        "}," +

        "{ " +//five year upper risk
            "type: 'line'," +
            "xref: 'paper'," +
            "x0: 0.55," +
            "y0: fiveYrData[1]," +
            "x1: 0.95," +
            "y1: fiveYrData[1]," +
            "line: {" +
            //"    color: 'rgb(153, 204, 255)'," + //light blue
            "    color: 'rgb(128, 0, 0)'," + //Maroon
            "    width: 4," +
            "    dash: 'solid'" +
            "}" +
        "}," +
        "{ " + //five year lower risk 
            "type: 'line'," +
            "xref: 'paper'," +
            "x0: 0.55," +
            "y0: fiveYrData[0]," +
            "x1: 0.95," +
            "y1: fiveYrData[0]," +
            "line: {" +
            //"    color: 'rgb(255, 153, 51)'," + //Orange
             "    color: 'rgb(102, 178 ,102 )'," + //Green
            "    width: 4," +
            "    dash: 'solid'" +
            "}" +
        "}]";
    }

    //console.log("sa=" + shapesArray);

    var layout = {
        title: '',
        barmode: 'stack',
        paper_bgcolor: 'rgba(245,246,249,1)', //Light gray
        plot_bgcolor: 'rgba(245,246,249,1)', //Light gray
        width: 500,
        height: 500,
        text: '',
        showlegend: false,
        hovermode: 'closest',
        displayModeBar: false,
        annotations: [],
        yaxis: {
            title: 'Percent',
            fixedrange: true,
            range: [0, 105],
            backgroundcolor: 'rgb(250,250,210)',
            linecolor: 'rgb(0,0,0,0)',
            gridcolor: 'rgb(205,205,205,0)'
        },
        shapes: eval(shapesArray)
        };

    for (var i = 0; i < 2; i++) { //displays the text above the bar
        var y_int = parseFloat(yData[i]);
        var y_int_pos = 0;
        y_int_pos = y_int + 3;

        //console.log("y_int_pos=" + y_int_pos);
        var result = {
            x: xData[i],
            y: y_int_pos,
            text: textList[i],           
            font: {
                family: 'Arial',
                size: 14,
                color: 'rgba(0,0,0,1)' //Black
            },
            showarrow: false
        };
        layout.annotations.push(result);
    };

    Plotly.newPlot('divTangriGraph', data, layout, { displaylogo: false });

    //$('.modebar-group').each(function () {
    //    $(this).find('[data-title="Produced with Plotly"]').parent.remove();//removing this anchor tag so that Plotly becomes 508 compliant.
    //});

    //$('.gradients').append("<linearGradient id='mygradient'><stop offset='0%' stop-color='rgb(255, 255, 0)' stop-opacity='1'></stop><stop offset='100%' stop-color='rgb(44, 88, 44)' stop-opacity='1'></stop></linearGradient>");
    //$(".point").find("path").css({ 'fill': '' });
    ////$(".points").empty();
    //$(".point").find("path").css({ 'fill': 'url(#mygradient)' });
}

function runTangriLongVersion(yrType) {

   // console.log("runTangriLongVersion=" + yrType);
    //setTimeout(function () { console.log("after timeout"); }, 3000);
    //********************************
    //*TODO: Double check conversions*
    //********************************

    //*Get variables*
    var age;
    var sex;
    var egfrMin, egfrMax;
    var albuminCRRatioMin, albuminCRRatioMax;
    var acratioUnits;
    var calciumMin, calciumMax;
    var calciumUnits;
    var phosphorousMin, phosphorousMax;
    var phosphorusUnits;
    var albuminMin, albuminMax;
    var albuminUnits;
    var bicarbonateMin, bicarbonateMax;
    var bicarbonateUnits;

    age = $('#txtAge').val();
    sex = $('input[type=radio][name=rbSexTangri]:checked').val();


    //******
    //*eGFR* -- these are reversed on purpose (negative coefficient)
    //******    
    egfrMin = getSliderValue('egfr', 'to');
    egfrMax = getSliderValue('egfr', 'from');


    //*****
    //*ACR*
    //*****
    albuminCRRatioMin = getSliderValue('acratio', 'from');
    albuminCRRatioMax = getSliderValue('acratio', 'to');
    acratioUnits = $('#selACRatio').val();
    if (acratioUnits == 2) {
        //[Urine albumin to creatinine ratio] mg/g to mg/mmol multiply by 0.113        
        albuminCRRatioMin /= 0.113;
        albuminCRRatioMax /= 0.113;
    }


    //*********
    //*Calcium* -- these are reversed on purpose (negative coefficient)
    //*********
    calciumMin = getSliderValue('calcium', 'to');
    calciumMax = getSliderValue('calcium', 'from');
    calciumUnits = $('#selSCalcium').val();
    if (calciumUnits == 2) {
        //serum Calcium mg.dL to mmol/L multiply by 0.2495
        calciumMin /= .2495;
        calciumMax /= .2495;
    }


    //*************
    //*Phosphorous* (positive coeff - reversed)
    //*************
    phosphorousMin = getSliderValue('phosphate', 'from');
    phosphorousMax = getSliderValue('phosphate', 'to');
    phosphorusUnits = $('#selSPhosphate').val();
    if (phosphorusUnits == '2') {
        //Serum Phosphate - mg/dL to mmol/L - multiply by .3229
        phosphorousMin /= .3229;
        phosphorousMax /= .3229;

        //console.log('(mmol/L) PhosphorousMin:' + phosphorousMin);
        //console.log('(mmol/L) PhosphorousMax:' + phosphorousMax);
    }


    //*************
    //*BiCarbonate* (negative coeff - reversed)
    //*************
    bicarbonateMin = getSliderValue('bicarb', 'to');
    bicarbonateMax = getSliderValue('bicarb', 'from');
    bicarbonateUnits = $('#selSBicarbinate').val(); //-- no conversion(?)


    //*********
    //*Albumin* (negative coeff)
    //*********    
    albuminMin = getSliderValue('albumin', 'to');
    albuminMax = getSliderValue('albumin', 'from');
    albuminUnits = $('#selSAlbumin').val();
    if (albuminUnits == 2) {
        albuminMin /= 10;
        albuminMax /= 10;
    }

   // console.log('runTangriLongVersion - after getting values');
    //console.log('age:' + age);
    //console.log('sex:' + sex);
    //console.log('egfrMin:' +egfrMin );
    //console.log('albuminCRRationMin:' + albuminCRRatioMin);
    //console.log('AcratioUnits:' + acratioUnits);
    //console.log('calciumMin:' + calciumMin);
    //console.log('calciumUnits:' + calciumUnits);
    //console.log('PhosphorousMin:' + phosphorousMin);
    //console.log('albuminMin:' + albuminMin);
    //console.log('albuminUnits:' + albuminUnits);
    //console.log('bicarbMin:' + bicarbonateMin);
    //console.log('bicarbUnits:' + bicarbonateUnits);


    //Min
    var minAnswer = getTangriLongValue(age, sex, egfrMin, albuminCRRatioMin, acratioUnits, calciumMin, calciumUnits, phosphorousMin, phosphorusUnits, albuminMin, albuminUnits, bicarbonateMin, bicarbonateUnits, yrType);
    //console.log('minAnswer: ' + minAnswer);
    //Max
    var maxAnswer = getTangriLongValue(age, sex, egfrMax, albuminCRRatioMax, acratioUnits, calciumMax, calciumUnits, phosphorousMax, phosphorusUnits, albuminMax, albuminUnits, bicarbonateMax, bicarbonateUnits, yrType);
    //console.log('maxAnswer: ' + maxAnswer);

    var answer = [minAnswer, maxAnswer];

    return answer;

    //Draw the graph
    //graphTangriResults(minAnswer, maxAnswer);
}
function runTangriShortVersion(yrType) {

    //*Get variables*
    var age;
    var sex;
    var egfrMin, egfrMax;
    var albuminCRRatioMin, albuminCRRatioMax;
    var acratioUnits;


    //*Basics*
    age = $('#txtAge').val();
    sex = $('input[type=radio][name=rbSexTangri]:checked').val();


    //*eGFR* -- these are reversed on purpose
    egfrMax = getSliderValue('egfr', 'from');
    egfrMin = getSliderValue('egfr', 'to');

   // if (egfrMin == 0) { egfrMin = 1; }
    //if (egfrMax == 0) { egfrMax = 1; }

    //*ACR*
    albuminCRRatioMin = getSliderValue('acratio', 'from');
    albuminCRRatioMax = getSliderValue('acratio', 'to');


    //*Units*
    //Urine albumin to creatinine ratio (mg/g)	from:mg/g	to:mg/mmol	multiply	0.113
    acratioUnits = $('#selACRatio').val();
    if (acratioUnits == 2) {
        //albuminCRRatio *= 0.113; old
        //albuminCRRatioMin *= 0.113;
        //albuminCRRatioMax *= 0.113;
        albuminCRRatioMin /= 0.113;
        albuminCRRatioMax /= 0.113;
    }


    //*******
    //*Debug*
    //*******
    //console.log('egfr min: ' + egfrMin);
    //console.log('egfr max: ' + egfrMax);
    //console.log('albuminCR min: ' + albuminCRRatioMin);
    //console.log('albuminCR max: ' + albuminCRRatioMax);
    //console.log('acratio units: ' + acratioUnits);


    //Min
    var minAnswer = getTangriShortValue(age, sex, egfrMin, albuminCRRatioMin, acratioUnits, yrType);
    //console.log('min answer: ' + minAnswer);

    //Max
    var maxAnswer = getTangriShortValue(age, sex, egfrMax, albuminCRRatioMax, acratioUnits, yrType);
    //console.log('max answer: ' + maxAnswer);

    var answer = [minAnswer, maxAnswer];
    //console.log('answer: ' + answer);
    return answer;

    //Draw the graph
    //graphTangriResults(minAnswer, maxAnswer);


    //console.log('Min Answer: ' + minAnswer + ', MAXaNSWER: ' + maxAnswer);
}
function runTangriShortVersion_TwoandFiveYear() {
   // console.log("inside runTangriShortVersion_TwoandFiveYear");
    var twoYearShort = runTangriShortVersion(2);
    var fiveYearShort = runTangriShortVersion(5);


    //Duplicate each value so as to eliminate the whiskers
    var twoYearFloatyBar = [twoYearShort[0], twoYearShort[0], twoYearShort[1], twoYearShort[1]];    
    var fiveYearFloatyBar = [fiveYearShort[0], fiveYearShort[0], fiveYearShort[1], fiveYearShort[1]];


    //Pass ranges to graphing method
    //graphTangriResults(twoYearFloatyBar, fiveYearFloatyBar);
    graphTangriResults(twoYearShort, fiveYearShort);

}
function runTangriLongVersion_TwoandFiveYear() {

   // console.log("runTangriLongVersion_TwoandFiveYear");
    var twoYearLong = runTangriLongVersion(2);
    var fiveYearLong = runTangriLongVersion(5);

    //Duplicate each value so as to eliminate the whiskers
    var twoYearFloatyBar = [twoYearLong[0], twoYearLong[0], twoYearLong[1], twoYearLong[1]];
    var fiveYearFloatyBar = [fiveYearLong[0], fiveYearLong[0], fiveYearLong[1], fiveYearLong[1]];


    //Pass ranges to graphing method
    //graphTangriResults(twoYearFloatyBar, fiveYearFloatyBar);
    graphTangriResults(twoYearLong, fiveYearLong);

}
function showTangriGraphOnSliderChange() {

   // console.log('inside showTangriGraphOnSliderChange');
    //**********************************
    //*Gather details for loading graph*
    //**********************************
    var age = $('#txtAge').val();
    var female = $('#rbTangriSexFemale').is(':checked');
    var male = $('#rbTangriSexMale').is(':checked');
    var hasGender = (female == true || male == true);

    //**************
    //*Update Graph*
    //**************
    if (age.length > 0 && hasGender == true) {
        //Using short version
        if ($('#btnShowLongerVersion').is(':visible')) {
            runTangriShortVersion_TwoandFiveYear();
            console.log('Running Short version.');
        } else {
            runTangriLongVersion_TwoandFiveYear();
            console.log('Running Long version.');
        }
    }
}


//*Sliders*
function fixSliderExceptions() {

    //Set up classes for CSS purposes on sliders
    $('span.irs-from').addClass('min');
    $('span.irs-to').addClass('max');


    //*****************************************
    //*Fix exceptions to above min/max classes*
    //*****************************************
    //eGFR
    $('#txtEGFR').parent().find('.irs-from').addClass('max').removeClass('min');
    $('#txtEGFR').parent().find('.irs-to').addClass('min').removeClass('max');

    //Serum Calcium
    $('#txtSCalcium').parent().find('.irs-from').addClass('max').removeClass('min');
    $('#txtSCalcium').parent().find('.irs-to').addClass('min').removeClass('max');

    //BiCarbonate
    $('#txtSBicarbinate').parent().find('.irs-from').addClass('max').removeClass('min');
    $('#txtSBicarbinate').parent().find('.irs-to').addClass('min').removeClass('max');

    //Albumin
    $('#txtSAlbumin').parent().find('.irs-from').addClass('max').removeClass('min');
    $('#txtSAlbumin').parent().find('.irs-to').addClass('min').removeClass('max');

}
function getCurrentSliderHandle() {

    //assume a slider doesn't have the focus
    var answer = '0';
    var $objMitDemFocus = $(':focus');


    //*Is a slider*
    if ($objMitDemFocus.hasClass('irs-slider')) {
        if ($objMitDemFocus.hasClass('from')) {
            answer = 'f';
        } else if ($objMitDemFocus.hasClass('to')) {
            answer = 't';
        }
    }

    return answer;
}
function getSliderValue(sliderID, tofrom) {
    //Obtain the value of the requested slider (handle)

    var $slider;
    var from;
    var to;
    var answer = '';

    switch (sliderID) {
        case 'egfr':
            $slider = $('#eGFRSlider').data('ionRangeSlider');
            break;
        case 'acratio':
            $slider = $('#ureaAlbuminSlider').data('ionRangeSlider');
            break;
        case 'calcium':
            $slider = $('#calciumSlider').data('ionRangeSlider');
            break;
        case 'phosphate':
            $slider = $('#phosSlider').data('ionRangeSlider');
            break;
        case 'bicarb':
            $slider = $('#biCarbSlider').data('ionRangeSlider');
            break;
        case 'albumin':
            $slider = $('#albSlider').data('ionRangeSlider');
            break;
    }


    switch (tofrom) {
        case 'to':
            to = $slider.old_to;
            answer = to;
            break;
        case 'from':
            from = $slider.old_from;
            answer = from;
            break;
        case 'both':
            to = $slider.old_to;
            from = $slider.old_from;
            answer = to + '|' + from;
            break;
    }

    //console.log('slider answer: ' + answer);
    return answer;
}
function initiateSliders() {
    //console.log("initiateSliders");
    //Permitted highs and lows (validation)
    var mn, mx, curUnit;

    //****************
    //*Slider(s) code*
    //****************            
    var eGFRFrom = 15;
    var eGFRTo = 60;
    mn = 10;
    mx = 60;
    $("#eGFRSlider").ionRangeSlider({        
        type: "double", grid: true, grid_snap: true, from: eGFRFrom, to: eGFRTo, min: mn, max: mx, step: 3, prettify_enabled: true, keyboard: true,
        onChange: function (data) {
            $('#txtEGFR').val('');            
            showTangriGraphOnSliderChange();
        }
    });
    $("#eGFRSlider").attr('step', '3');
    $('#txtEGFR').attr('min', mn).attr('max', mx);


    //**************
    //*Urea Albumin*
    //**************
    var uaFrom = 10;
    var usTo = 500;
    mn = 10;
    mx = 3000;
    $("#ureaAlbuminSlider").ionRangeSlider({
        type: "double", grid: true, grid_snap: true, from: uaFrom, to: usTo, min: mn, max: mx, step: 100, prettify_enabled: true, keyboard: true,
        onChange: function (data) {            
            $('#txtACRatio').val('');            
            showTangriGraphOnSliderChange();
        }
    });
    $("#ureaAlbuminSlider").attr('step', '50');
    $('#txtACRatio').attr('min', mn).attr('max', mx);
    curUnit = $('#selACRatio option:selected').text();
    //Show correct range for this unit
    $('#ACRationRange').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');

    //***************
    //*Serum Calcium*
    //***************
    var calciumFrom = 8.4;
    var calciumTo = 10.2;
    mn = 7.5;
    mx = 10.5;
    $("#calciumSlider").ionRangeSlider({
        type: "double", grid: true, grid_snap: true, from: calciumFrom, to: calciumTo, min: mn, max: mx, step: .5, prettify_enabled: true, keyboard: true,
        onChange: function (data) {
            $('#txtSCalcium').val('');            
            showTangriGraphOnSliderChange();
        }
    });
    $("#calciumSlider").attr('step', '.5');
    $('#txtSCalcium').attr('min', mn).attr('max', mx);
    curUnit = $('#selSCalcium option:selected').text();

    //Show correct range for this unit
    $('#spnSCal').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');


    //*****************
    //*Serum Phosphate*
    //*****************
    var phosFrom = 3;
    var phosTo = 4.5;
    mn = 3;
    mx = 6.5;
    $("#phosSlider").ionRangeSlider({
        type: "double", grid: true, grid_snap: true, from: phosFrom, to: phosTo, min: mn, max: mx, step: .5, prettify_enabled: true, keyboard: true,
        onChange: function (data) {
            $('#txtSPhosphate').val('');            
            showTangriGraphOnSliderChange();
        }
    });
    $("#phosSlider").attr('step', '.5');
    $('#txtSPhosphate').attr('min', mn).attr('max', mx);
    curUnit = $('#selSPhosphate option:selected').text();
    //Show correct range for this unit
    $('#spnPhosphate').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');


    //*******************
    //*Serum BiCarbonate*
    //*******************
    var biCarbFrom = 22;
    var biCarbTo = 28;
    mn = 15;
    mx = 28;
    $("#biCarbSlider").ionRangeSlider({
        type: "double", grid: true, grid_snap: true, from: biCarbFrom, to: biCarbTo, min: mn, max: mx, step: 2, prettify_enabled: true, keyboard: true,
        onChange: function (data) {
            $('#txtSBicarbinate').val('');            
            showTangriGraphOnSliderChange();
        }
    });
    $("#biCarbSlider").attr('step', '2');
    $('#txtSBicarbinate').attr('min', mn).attr('max', mx);
    curUnit = $('#selSBicarbinate option:selected').text();
    //Show correct range for this unit
    $('#spnBiCarb').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');

    //***************
    //*Serum ALBUMIN*
    //***************
    var albFrom = 2.5;
    var albTo = 54;
    mn = 1;
    mx = 4;
    $("#albSlider").ionRangeSlider({
        type: "double", grid: true, grid_snap: true, from: albFrom, to: albTo, min: mn, max: mx, step: .5, prettify_enabled: true, keyboard: true,
        onChange: function (data) {
            $('#txtSAlbumin').val('');            
            showTangriGraphOnSliderChange();
        }
    });
    $("#albSlider").attr('step', '.5');
    $('#txtSAlbumin').attr('min', mn).attr('max', mx);
    curUnit = $('#selSAlbumin option:selected').text();
    //Show correct range for this unit
    $('#spnSAlbumin').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');


    //Make all slider handles 'focussable'
    $('.irs-slider').attr('tabindex', '0');


    //ADjustments to get CSS working correctly
    fixSliderExceptions();


    //Add a toolip instructions for the sliders
    addToolTipInstructions();

}
function moveSlider(dir) {

    //Which has the focus?
    var $objMitDemFocus = $(':focus');

    //Get txtBox
    var txtID = $(':focus').parent().parent().find('.irs-hidden-input').attr('id');

    var $slider = $('#' + txtID).data('ionRangeSlider');
    var fromxzor = $slider.old_from;//$('.irs-from').text();
    var toxzor = $slider.old_to;//$('.irs-to').text();

    //*STEP*
    var step = 1;
    if (typeof ($('#' + txtID).attr('step')) != 'undefined') {
        step = parseFloat($('#' + txtID).attr('step'));
    }

    //console.log('step: ' + step);

    switch (dir) {
        case "df":
            fromxzor -= step;
            $slider.update({ from: fromxzor });
            break;
        case "af":
            fromxzor += step;
            $slider.update({ from: fromxzor });
            break;
        case "dt":
            toxzor -= step;
            $slider.update({ to: toxzor });
            break;
        case "at":
            toxzor += step;
            $slider.update({ to: toxzor });
            break;
    }
}
function resetIndividualSlider(sliderName) {

    //*Gets called when the refresh image near each slider is pressed*

    switch (sliderName) {
        case 'egfr':
            //console.log('egfr reset');
            var $egfr = $("#eGFRSlider");
            var $slider1;
            try {
                $slider1 = $egfr.data("ionRangeSlider");
                $slider1.destroy();

                $egfr.parent().find('.from, .to').text('');
                $egfr.parent().find('span').remove();

            } catch (ex) {
                console.log('Encountered problems resetting eGFR: ' + ex.message);
            }            

            $egfr.ionRangeSlider({
                type: "double", grid: true, grid_snap: true, from: 15, to: 60, min: 10, max: 60, step: 3, prettify_enabled: true, keyboard: true,
                onChange: function (data) {
                    //Clear textbox
                    $('#txtEGFR').val('');
                    //console.log('changing eGFR slider from resetIndividualSlider');
                    showTangriGraphOnSliderChange();
                }
            });

            //Set it back to original spot(s)
            $slider1 = $egfr.data("ionRangeSlider");
            $slider1.update({ to: 60, from: 15, keyboard: true });
            $egfr.attr('step', '3');
            $('#txtEGFR').text('').val('');
            break;

        case 'acratio':
            unitChange('acratio');
            $('#txtACRatio').text('').val('');
            //console.log('changing acratio slider from resetIndividualSlider');
            break;
        case 'calcium':
            unitChange('calcium');
            $('#txtSCalcium').text('').val('');
            break;
        case 'phosphate':
            unitChange('phosphate');
            $('#txtSPhosphate').text('').val('');
            //console.log('changing phosphate slider from resetIndividualSlider');
            break;
        case 'bicarb':
            var $bicarb = $("#biCarbSlider");
            var $sliderbc;
            try {
                $sliderbc = $bicarb.data("ionRangeSlider");
                $sliderbc.destroy();

                $bicarb.parent().find('.from, .to').text('');
                $bicarb.parent().find('span').remove();
            } catch (ex) {
                console.log('Encountered problems resetting biCarbonate: ' + ex.message);
            }

            $bicarb.ionRangeSlider({
                type: "double", grid: true, grid_snap: true, from: 22, to: 28, min: 15, max: 28, step: 2, prettify_enabled: true, keyboard: true,
                onChange: function (data) {
                    // fired on every range slider update
                    showTangriGraphOnSliderChange();
                }
            });

            //Set it back to original spot(s)
            $sliderbc = $bicarb.data("ionRangeSlider");
            $sliderbc.update({ to: 28, from: 22, keyboard: true });
            $('#txtSBicarbinate').text('').val('');
            //console.log('changing bicarb slider from resetIndividualSlider');
            break;
        case 'albumin':
            unitChange('albumin');
            $('#txtSAlbumin').text('').val('');
            //console.log('changing albumin slider from resetIndividualSlider');
            break;
    }

    //Adjust sliders for proper CSS
    fixSliderExceptions();

    //Now update graph
    showTangriGraphOnSliderChange();

}
function resetSliders() {

   // console.log("inside reset Slider");
    //****************
    //*Slider(s) code*
    //****************
    try {
        var slider1 = $("#eGFRSlider").data("ionRangeSlider");
        slider1.destroy();
        $("#eGFRSlider").parent().find('.from, .to').text('');
    } catch (ex) {

    }
    $("#eGFRSlider").ionRangeSlider({
        type: "double", grid: true, grid_snap: true, from: 15, to: 60, min: 0, max: 120, step: 3, prettify_enabled: true, keyboard: true,
        onChange: function (data) {

            $('#txtEGFR').val('');
            console.log('resetting slider for eGFR');

            // fired on every range slider update
            showTangriGraphOnSliderChange();
        }
    });
    $("#eGFRSlider").attr('step', '3');


    //all other sliders
    unitChange('acratio');
    unitChange('calcium');
    unitChange('phosphate');
    unitChange('albumin');


    //ADjustments to get CSS working correctly
    fixSliderExceptions();


    return false;
}
function unitChange(slidername) {

    var curUnit;
    var $slider;
    var fm;
    var t;//to
    var mn;
    var mx;
    var stp;


    switch (slidername) {

        //case 'bicarb': //This has no conversion, so don't bother to clear the textbox
        //    //Clear the textbox
        //    $('#txtSBicarbinate').val('');

        //    break;
        case 'acratio':
            curUnit = $('#selACRatio option:selected').text();
            $slider = $("#ureaAlbuminSlider").data("ionRangeSlider");
            $slider.destroy();

            //Clear the textbox
            $('#txtACRatio').val('');

            if (curUnit === 'mg/g') {
                fm = 10;
                t = 500;
                mn = 10;
                mx = 3000;
                stp = 100;                
            } else if (curUnit === 'mg/mmol') {
                fm = 1;
                t = 50;
                mn = 1;
                mx = 300;
                stp = 50;               
            }
            $("#ureaAlbuminSlider").ionRangeSlider({
                type: "double", grid: true, grid_snap: true, from: fm, to: t, min: mn, max: mx, step: stp, prettify_enabled: true, keyboard: true,
                onChange: function (data) {
                    $('#txtACRatio').val('');                    
                    showTangriGraphOnSliderChange();                   
                }
            });
            $("#ureaAlbuminSlider").attr('step', stp);
            $('#txtACRatio').attr('min', mn).attr('max', mx); //Set the validation text      

            //Show correct range for this unit
            $('#ACRationRange').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');


            var ureaAlbuminSlider = $("#ureaAlbuminSlider").data("ionRangeSlider");
            ureaAlbuminSlider.update({ to: t, from: fm });
            
            break;
        case 'calcium':
            curUnit = $('#selSCalcium option:selected').text();
            $slider = $("#calciumSlider").data("ionRangeSlider");
            $slider.destroy();

            //Clear the textbox
            $('#txtSCalcium').val('');

            if (curUnit === 'mg/dL') {
                fm = 8.4;
                t = 10.2;
                mn = 7.5;
                mx = 10.5;
                stp = .5;
            } else if (curUnit === 'mmol/L') {
                fm = 2.1;
                t = 2.5;
                mn = 1.87;
                mx = 2.6;
                stp = .2;
            }

            $("#calciumSlider").ionRangeSlider({
                type: "double", grid: true, grid_snap: true, from: fm, to: t, min: mn, max: mx, step: stp, prettify_enabled: true, keyboard: true,
                onChange: function (data) {
                    $('#txtSCalcium').val('');                    
                    showTangriGraphOnSliderChange();
                }
            });
            $("#calciumSlider").attr('step', stp);
            $('#txtSCalcium').attr('min', mn).attr('max', mx); //Set the validation text


            var calciumSlider = $("#calciumSlider").data("ionRangeSlider");
            calciumSlider.update({ to: t, from: fm });

            //Show correct range for this unit
            $('#spnSCal').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');

            break;
        case 'phosphate':
            curUnit = $('#selSPhosphate option:selected').text();
            $slider = $("#phosSlider").data("ionRangeSlider");
            $slider.destroy();

            //Clear the textbox
            $('#txtSPhosphate').val('');

            //console.log('just changed phosphate ddl');
           

            if (curUnit === 'mg/dL') {
                console.log('curUnit is: mg/dL');
                fm = 3;
                t = 4.5;
                mn = 3;
                mx = 6.5;
                stp = .5;                
            } else if (curUnit === 'mmol/L') {
                console.log('curUnit is: mmol/L');
                fm = .96;
                t = 1.45;
                mn = .96;
                mx = 2.09;
                stp = .1;
            }
            $("#phosSlider").ionRangeSlider({
                type: "double", grid: true, grid_snap: true, from: fm, to: t, min: mn, max: mx, step: stp, prettify_enabled: true, keyboard: true,
                onChange: function (data) {
                    $('#txtSPhosphate').val('');                    
                    showTangriGraphOnSliderChange();
                }
            });
            $("#phosSlider").attr('step', stp);
            $('#txtSPhosphate').attr('min', mn).attr('max', mx); //Set the validation text

            var phosSlider = $("#phosSlider").data("ionRangeSlider");
            phosSlider.update({ to: t, from: fm });

            //Show correct range for this unit
            $('#spnPhosphate').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');

            break;
        case 'bicarbonate':

            //Just update the range label
            curUnit = $('#selSBicarbinate option:selected').text();
            $('#spnBiCarb').text('(Range: 15 - 28 ' + curUnit + ')');

            break;
        case 'albumin':

            curUnit = $('#selSAlbumin option:selected').text();
            $slider = $("#albSlider").data("ionRangeSlider");
            $slider.destroy();

            //Clear the textbox
            $('#txtSAlbumin').val('');

            if (curUnit === 'g/dL') {
                fm = 2;
                t = 4;
                mn = 1;
                mx = 4;
                stp = .5;                
            } else if (curUnit === 'g/L') {
                fm = 20;
                t = 40;
                mn = 10;
                mx = 40;
                stp = 5;                
            }
            $("#albSlider").ionRangeSlider({
                type: "double", grid: true, grid_snap: true, from: fm, to: t, min: mn, max: mx, step: stp, prettify_enabled: true, keyboard: true,
                onChange: function (data) {
                    $('#txtSAlbumin').val('');                    
                    showTangriGraphOnSliderChange();
                }
            });
            $("#albSlider").attr('step', stp);
            $('#txtSAlbumin').attr('min', mn).attr('max', mx); //Set the validation text

            var albSlider = $("#albSlider").data("ionRangeSlider");
            albSlider.update({ to: t, from: fm });

            
            //Show correct range for this unit
            $('#spnSAlbumin').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');

            break;
    }

    //console.log('to:' + t + ', from:' + fm + ',min:' + mn + ',max:' + mx);    

    //Make all slider handles 'focussable'
    $('.irs-slider').attr('tabindex', '0');

    //Adjustments for CSS
    fixSliderExceptions();

    //Show changes
    showTangriGraphOnSliderChange();


    //Add a toolip instructions for the sliders
    addToolTipInstructions();

    return false;
}

function addToolTipInstructions() {
    $('.irs-with-grid').attr('title', 'Click and drag the left and right sliders to the desired interval.  Entering a value in the box above the sliders will automatically move both sliders to that value.');
}

function updateSlider(slidername, val) {
    //console.log("inside Update Slider");
    //If a value is added to a textbox, the sliders should honor the new value

    //http://ionden.com/a/plugins/ion.rangeSlider/demo_interactions.html -- see (Range slider public methods)
    var $slider;

    switch (slidername) {
        case 'egfr':
            $("#eGFRSlider").ionRangeSlider({ type: "double", grid: true, grid_snap: true, from: val, to: val, min: 10, max: 60, step: 3, prettify_enabled: true, keyboard: true });
            $slider = $("#eGFRSlider").data("ionRangeSlider");
            break;
        case 'acratio':
            $("#ureaAlbuminSlider").ionRangeSlider({ type: "double", grid: true, grid_snap: true, from: val, to: val, min: 10, max: 3000, step: 100, prettify_enabled: true, keyboard: true });
            $slider = $("#ureaAlbuminSlider").data("ionRangeSlider");
            break;
        case 'calcium':
            $("#calciumSlider").ionRangeSlider({ type: "double", grid: true, grid_snap: true, from: val, to: val, min: 7.5, max: 10.5, step: .5, prettify_enabled: true, keyboard: true });
            $slider = $("#calciumSlider").data("ionRangeSlider");
            break;
        case 'phosphate':
            $("#phosSlider").ionRangeSlider({ type: "double", grid: true, grid_snap: true, from: val, to: val, min: 3, max: 6.5, step: .5, prettify_enabled: true, keyboard: true });
            $slider = $("#phosSlider").data("ionRangeSlider");
            break;
        case 'bicarb':
            $("#biCarbSlider").ionRangeSlider({ type: "double", grid: true, grid_snap: true, from: val, to: val, min: 15, max: 28, step: 2, prettify_enabled: true, keyboard: true });
            var $slider = $("#biCarbSlider").data("ionRangeSlider");
            break;
        case 'albumin':
            $("#albSlider").ionRangeSlider({ type: "double", grid: true, grid_snap: true, from: val, to: val, min: 1, max: 4, step: .5, prettify_enabled: true, keyboard: true });
            $slider = $("#albSlider").data("ionRangeSlider");
            break;
    }

    $slider.update({ to: val, from: val, keyboard: true });

    //Make all slider handles 'focussable'
    $('.irs-slider').attr('tabindex', '0');

    fixSliderExceptions();

    //Run the short  or long version if there is enough info
    showTangriGraphOnSliderChange();

    //Add a toolip instructions for the sliders
    addToolTipInstructions();
}



