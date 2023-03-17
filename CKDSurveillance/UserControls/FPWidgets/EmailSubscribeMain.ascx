<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EmailSubscribeMain.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.EmailSubscribeMain" %>

<style>
    .emailmain {
        margin-top: 30px;
        margin-bottom:30px;
        display: inline-flex;        
    }
    .emailmain-label {
        text-align: left;
        font: normal normal 500 20px/34px Open Sans;
        letter-spacing: -0.4px;
        color: #FFFFFF;
        text-transform: uppercase;
        opacity: 1;
        padding-top: 0.5rem;
        margin-right: 1rem;
    }
    .emailmain-textbox {
        width: 400px;
        height: 48px !important;
        background: #FFFFFF 0% 0% no-repeat padding-box;
        border: 1px solid #AAAAAA;
        border-radius: 5px;
        text-align: left;
        font: normal normal 300 18px/24px Open Sans;
        letter-spacing: 0px;
        color: #727272;
        opacity: 1;
        padding-left: 0.5rem;
    }
    .emailmain-btn {
        width: 99px;
        height: 48px;
        background: #007C91 0% 0% no-repeat padding-box !important;
        border-radius: 5px;
        opacity: 1;
        font: normal normal normal 17px/23px Open Sans;
        letter-spacing: 0px;
        color: #FFFFFF !important;
    }
    @media (max-width: 767px) {
        .emailmain {
            display:table;
            flex-direction:column;
        }
        .emailmain-label {
            font: normal normal 500 18px/34px Open Sans;
            padding-top: 0.2rem;
            margin-right: 3rem;
        }
        .emailmain-textbox {
            width: 200px;
            padding-left: 0.3rem;
        }
        .emailmain-btn {
            width: 100px;
            margin-top:-0.4rem;
        }
    }
</style>
    <div class="nccd-modb emailupdates " style="text-align: center;margin-bottom:0px !important">
        <form name="govdelivery" action="https://public.govdelivery.com/accounts/USCDC/subscribers/qualify">
            <fieldset>
                <div class="emailmain">
                    <label for="gov-d-email" class="emailmain-label">SIGN UP FOR EMAIL UPDATES&nbsp;&nbsp;</label>
                    <input id="gov-d-email" name="email" type="email" class="emailmain-textbox" placeholder="Email Address" /><%-- required="required">--%>
                    <button id="btnSubmitEmailSubscription" class="btn emailmain-btn">Submit</button>
                </div>
            </fieldset>
        </form>
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