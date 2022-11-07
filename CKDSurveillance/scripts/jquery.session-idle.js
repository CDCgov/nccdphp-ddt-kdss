
var idleTime = 180000; // number of miliseconds until the user is considered idle
var initialSessionTimeoutMessage = 'Your session will expire in <span id="sessionTimeoutCountdown"></span>&nbsp;seconds.<br/><br />Click on <strong>OK</strong> to continue your session.';
var sessionTimeoutCountdownId = 'sessionTimeoutCountdown';
var redirectAfter = 120; // number of seconds to wait before redirecting the user
var redirectTo = 'SessionTimeout.aspx'; // URL to relocate the user to once they have timed out
var keepAliveURL = 'SessionKeepAlive.aspx'; // URL to call to keep the session alive
var expiredMessage = 'Your session has expired.  You are being logged out for security reasons.'; // message to show user when the countdown reaches 0
var running = false; // var to check if the countdown is running
var timer; // reference to the setInterval timer so it can be stopped

function initializeSessionTimer() {
    // create the warning window and set autoOpen to false
    var sessionTimeoutWarningDialog = $("#sessionTimeoutWarning");
    $(sessionTimeoutWarningDialog).html(initialSessionTimeoutMessage);
    $(sessionTimeoutWarningDialog).dialog({
        title: 'Session Expiration Warning',
        autoOpen: false, // set this to false so we can manually open it
        closeOnEscape: false,
        draggable: false,
        width: 460,
        minHeight: 50,
        modal: true,
        buttons: {
            OK: function () {

                // close dialog
                clearInterval(timer);
                
                // stop countdown
                running = false;

                // ajax call to keep the server-side session alive
                $.ajax({
                    url: keepAliveURL,
                    async: false
                });

                // start the idle timer
                $.idleTimer(idleTime);

                $(this).dialog('close');
            }
        },
        resizable: false,
        open: function () {
            // scrollbar fix for IE
            $('body').css('overflow', 'hidden');
        },
        close: function () {
            // reset overflow
            $('body').css('overflow', 'auto');
        }
    });    // end of dialog


    // start the idle timer
    $.idleTimer(idleTime);

    // bind to idleTimer's idle.idleTimer event
    $(document).bind("idle.idleTimer", function () {
        // if the user is idle and a countdown isn't already running
        if ($.data(document, 'idleTimer') === 'idle' && !running) {
            var counter = redirectAfter;
            running = true;

            // intialisze timer
            $('#' + sessionTimeoutCountdownId).html(redirectAfter);
            // open dialog
            $(sessionTimeoutWarningDialog).dialog('open');

            // create a timer that runs every second
            timer = setInterval(function () {
                counter -= 1;

                // if the counter is 0, redirect the user
                if (counter === 0) {
                    $(sessionTimeoutWarningDialog).html(expiredMessage);
                    $(sessionTimeoutWarningDialog).dialog('disable');
                    window.location = redirectTo;
                } else {
                    $('#' + sessionTimeoutCountdownId).html(counter);
                };
            }, 1000);
        };
    }); 

}



$(document).ready(function () {
    initializeSessionTimer();

});

//This will handle any partial page post back from the Update panel
var prm = Sys.WebForms.PageRequestManager.getInstance();
prm.add_endRequest(function () {
    initializeSessionTimer();
});

