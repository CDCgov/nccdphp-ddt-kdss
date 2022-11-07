<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EmailSubscribe.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.EmailSubscribe" %>


<%--*****************--%>
<%--*Email Subscribe*--%>
<%--*****************--%>
<div class="card tp-gov-d mb-3">
    <div class="card-multi h6 bt-blue-p bt-4 mb-3">
        <div class="h6" style="margin-top: 5px; margin-left: 5px;">
            &nbsp;&nbsp;Get Email Updates
        </div>
    </div>

    <div class="card-body">
        
            <div class="form-row">
                <div class="col-md-2" style="display:flex; justify-content:center; align-items:center;">
                    <svg class="icon x48" xmlns="http://www.w3.org/2000/svg" id="Layer_1" data-name="Layer 1" viewBox="0 0 48 48" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path d="M9.42,27.77h-3a5.23,5.23,0,0,1-2.6-.63A5.16,5.16,0,0,1,1,22.45C1,17.06,1,11.67,1,6.28A5.32,5.32,0,0,1,6.27,1c9.08,0,18.17,0,27.25,0A5.42,5.42,0,0,1,39,6.41q0,8,0,15.93a5.38,5.38,0,0,1-5.48,5.43H24.31a1.55,1.55,0,0,0-.93.28L6.93,39.19a1.2,1.2,0,0,1-2-.78,2,2,0,0,1,.22-.92q2-4.64,4.09-9.28Zm6.1-14,3.62,2.68a1.26,1.26,0,0,0,1.7,0l3.08-2.29.52-.38.16.17,4.31,5.19,4.14,5a.8.8,0,1,0,1.21-1l-6.73-8.11L25.74,12.8l.24-.19,8.62-6.4a1.28,1.28,0,1,0-1.53-2q-6.36,4.72-12.72,9.45a.5.5,0,0,1-.72,0q-5-3.77-10.11-7.51c-.91-.68-1.82-1.36-2.74-2a1.23,1.23,0,0,0-1.61.06,1.22,1.22,0,0,0-.3,1.51,2.1,2.1,0,0,0,.57.61l8.37,6.22.4.31-.21.28L6.26,22.4c-.22.27-.46.53-.66.81a.79.79,0,0,0,1.2,1A3,3,0,0,0,7,24l6.16-7.42Z" style="fill:#005eaa;"></path><!--fill-govd -->
                    </svg>
                </div>
                <div class="form-group col-md-10">
                    <p>To receive updates about CKD topics, enter your email address:</p>   
                    <label for="gov-d-email" class="sr-only">Email Address</label>
                    <input id="gov-d-email" name="email" type="email" class="form-control" placeholder="Email Address" /><%-- required="required">--%>
                </div>
            </div>
            <div class="form-row">
                <div class="col-6">
                    <a class="explain" href="//www.cdc.gov/emailupdates/">What's this</a>
                </div>
                <div class="col-6 text-right">
                <button id="btnSubmitEmailSubscription" class="btn btn-primary">Submit</button>
                </div>
            </div>
            <input id="gov-d-topic" name="topic_id" type="hidden" value="USCDC_974">
            <input id="gov-d-origin" name="origin" type="hidden" value="">
            <input id="gov-d-pop" name="pop" type="hidden" value="t">
    </div>
</div>
<script>
    //subscription submit and redirect
    document.getElementById("btnSubmitEmailSubscription").onclick = function (e) {
        e.preventDefault();
        var topicID = 'USCDC_974',
            govEmail = encodeURIComponent(document.getElementById('gov-d-email').value),
            govOrigin = '',
            govPop = 't',
            fullUrl = "https://tools.cdc.gov/campaignproxyservice/subscriptions.aspx?email=" + govEmail + '&topic_id=' + topicID + '&origin=' + govOrigin + '&pop=' + govPop;
        
        window.open(fullUrl, '_blank');
    };
</script>
