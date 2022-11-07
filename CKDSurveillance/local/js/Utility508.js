var Utility508 = {};

Utility508.MakeCompliantNullImages = function () {    
    Utility508.NullAltText(" ");
    Utility508.NullAltText("bullet");
    Utility508.NullAltText("divider");
    Utility508.NullAltText("Content Area");
    Utility508.NullAltText("printer friendly icon");
}

Utility508.NullAltText = function (alt_selector) {    
    $("img[alt='" + alt_selector + "']").attr("alt", "");
}

Utility508.MakeCompliantSkipNavigation = function () {    
    var skipNav = $('a[href="#content_area"]');
    if (skipNav) {
        skipNav.addClass("accessibleHide");
        skipNav.text("Skip to content");
        skipNav.prependTo("body");
    }
}

Utility508.MakeCompliantCDCHeading = function () {    
    var CDCHeading = $("td.PageHeading");
    if (CDCHeading) {
        var title = CDCHeading.text();
        CDCHeading.html("<h2 class='PageHeading heading'>" + title + "</h2>");
    }
}
Utility508.MakeCompliantLeftNavHeader = function () {    
    var leftNav = $("td.secHeading");
    if (leftNav) {
        var title = leftNav.text();
        leftNav.html("<h2 class='secHeading heading nav'>" + title + "</h2>");
    }
}

$(function () {
    Utility508.MakeCompliantNullImages();
    Utility508.MakeCompliantSkipNavigation();
    Utility508.MakeCompliantCDCHeading();
    Utility508.MakeCompliantLeftNavHeader();

    $(".facebookRecommend").prepend("<span class='accessibleHide'>Recommend</span>").attr("title", "Facebook");
    $(".twitterTweet").prepend("<span class='accessibleHide'>Tweet</span>").attr("title", "Twitter");
	
	$("input[src='images/collapse.gif']").attr("title", "Collapse section").attr("alt", "Collapse");
	$("input[src='images/expand.gif']").attr("title", "Expand section").attr("alt", "Expand");
})

