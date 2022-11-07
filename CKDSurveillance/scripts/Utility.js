

function sendScreenDimensions(width, pth) {   
    $.ajax({
        type: "POST",        
        url: pth + "/JSHandler.ashx",
        data: "message=[width]" + width,
        success: function (data) {
            //alert("message sent!!!");
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //alert(jqXHR + "status:" + textStatus);
        }
    });
}

function addCommas(nStr) {
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}

function RoundIt() {
    $(".ckd-curvy-tab").corner({
        tl: { radius: 20 },
        tr: { radius: 20 },
        bl: { radius: 0 },
        br: { radius: 0 },
        antiAlias: true,
        autoPad: false,
        validTags: ["div"]
        
    });
}

function cleanTabOff() {
    $("div.tabOff .ckd-tab-datasource-type").each(function() {
        var txt = $(this).html();
        $(this).html(txt.replace("Source:", ""));
    });
}


function Toggle(HideOrShow) {
    var ele = document.getElementById("hideContent");
    //var w = $(window).width();


    if (HideOrShow == "S") { //&& ele.style.display != "block") {
        ele.style.display = "block"
        
        try {
            $('#hideContent').offset($('#divOuter').offset());
            $('#hideContent').css('margin-top', '30px');
            $('#hideContent').show();
            $('.overlayContainer').show();            
        }
        catch (err) {
            var error = err.Description
        }               
    }
    else if (HideOrShow == "H") {        
        ele.style.display = "none";
        $('.overlayContainer').hide();
    }
}

function checkForOverlayOnChange() {
    var shouldShow = false;

    if ($('#hfTopicsDirty').val() == "1") {
        shouldShow = true;
    }
    else if($('#hfIndicatorsDirty').val() == "1") {
        shouldShow = true;
    }

    if (shouldShow == true) {
        $('#hideContent').offset($('#divOuter').offset());
        $('#hideContent').css('margin-top', '30px');
        $('#hideContent').show();
        $('.overlayContainer').show();
    }
}


function titleCaseDropDowns() {
    $("option").each(function() {

        //*Build the cap-cased string*
        var capCased = $(this).text().replace(/\w\S*/g, function(txt) { return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase(); }).replace("Egfr", "eGFR");

        //*Clear the text*
        $(this).text("");

        //*Replace the text*
        $(this).text(capCased);
    });
}


