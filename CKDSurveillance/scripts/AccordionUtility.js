
//********************************
//*Expand or Contract Description*
//********************************
function manageViewableContent(expandableDiv, expanderDiv) {

    var newActionText = "";
    var curActionText = $.trim($('#' + expanderDiv).text());

    //*Open or Close the full Contents of the Description*
    if (curActionText == "[Expand Description]") {
        var maxheight = $('#' + expandableDiv)[0].scrollHeight;
        $('#' + expandableDiv).animate({
            height: maxheight
        }, 400);

        newActionText = "[Collapse Description]";
    } else {

        $('#' + expandableDiv).animate({
            height: 36
        }, 400);

        newActionText = "[Expand Description]";
    }


    //*Change the Label to fit Next Action*
    $('#' + expanderDiv).text(newActionText);


    //*Prevent the parent Div's expand/contract action*
    if (!e) var e = window.event;
    e.cancelBubble = true;
    if (e.stopPropagation) e.stopPropagation();

}


//*Misc*
function removeLinksToEmptyDivs() {

    $('.elasticDiv').each(function () {
        var txt = $.trim($(this).text());
        if (txt == '') {
            $(this).parent().parent().find('div[id$=divExpand]').text('');
        }
    });
}

function hideCollapsedTopicDescriptionLinks() {
    $('.ckd-accordion-plus').each(function () {
        var toHide = $(this).parent().parent().parent().find('div[id$="divExpand"]').find('.linkButton').attr('id');
        $('#' + toHide).text('');
    });
}

function manageExpandedDescriptions() {
    $('.ckd-accordion-minus').each(function () {
        var toShow = $(this).parent().parent().parent().find('div[id$="divExpand"]').find('.linkButton').attr('id');
        $('#' + toShow).text('[Expand Description]');
    });
}

function hideFullDescLinks() {

    $('.elasticDiv').each(function () {
        var toShow = $(this).parent().prev().find('div[id$="divExpand"]').find('.linkButton').attr('id');
        var divToCheck = $(this).attr('id');
        var cursize = $('#' + divToCheck).height();
        var maxht = $('#' + divToCheck)[0].scrollHeight;

        //*Hide Link for ALL fully visible Descriptions*
        if (cursize >= maxht) {
            $('#' + toShow).text('');
        }

        //*Hide descriptions without content*                
        if ($.trim($('#' + divToCheck).text()) == '') {
            $('#' + divToCheck).css('height', '0px');
        }
    });
}


//*Remove columns based on screen size*
$(window).resize(function () {
    var colsToShow = 3;
    var wdth = $(window).width();
    if (wdth > 512 && wdth <= 767) { colsToShow = 2; }
    if (wdth <= 512) { colsToShow = 1; }

    $('.peelColHeader').attr('colspan', colsToShow);
});