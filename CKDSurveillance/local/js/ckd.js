
/*
*
*
*/
function popupWindow(url, width, height) {

    var popup;
    var windowwidth;
    var windowheight;

    var winOptions = "help=no, center=yes, scrollbars=yes, " +
		"width=" + width + "px, " +
		"height=" + height + "px, " +
		"resizable=yes, status=off, unadorned=yes";

    var ua = navigator.userAgent;
    var isIE = (document.all || document.getElementById);
    var isFirefox = (ua != null && ua.indexOf("Firefox/") != -1);
    var isNetscape = (ua != null && ua.indexOf("Netscape/") != -1);

    popup = window.open(url, "CKD", winOptions);

    if (popup != null && !popup.closed) {
        popup.focus();
    }
    else {
        if (isIE && !isFirefox && !isNetscape) {
            windowwidth = document.documentElement.offsetWidth;
            windowheight = document.documentElement.offsetHeight;
        }
        else if (isNetscape || isFirefox) {
            windowwidth = window.innerWidth;
            windowheight = window.innerHeight;
        }
        else {
            windowwidth = document.body.clientWidth;
            windowheight = document.body.clientHeight;
        }

        var ckd_left = (windowwidth - width) / 2;
        var ckd_top = Math.min((windowheight - height) / 2, 150);

        var fragment = "<div id=\"ckd_window\" style=\"position: absolute; overflow: auto; left:" + ckd_left + "px; top:" + ckd_top
			+ "px; z-index:1; border:0; visibility:hidden; filter:revealTrans(Duration=0.5, Transition=23);\">"
			+ "<iframe id=\"cframe\" src=" + "\"" + url + "\" width=" + width + " height=" + height + "></iframe></div>";
        document.write(fragment);

    }
    return false;
}