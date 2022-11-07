<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EmailSubscribeRD.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.EmailSubscribeRD" %>

<div class="nccd-modb emailupdates">

<h4><span class="x32 fill-p cdc-icon-email_02"></span>&nbsp;&nbsp;Get Email Updates</h4>
<p style="padding-bottom:2px !important; margin-bottom:0px !important">To receive email updates about this page, enter your email address:</p>
    <form name="govdelivery" action="https://public.govdelivery.com/accounts/USCDC/subscribers/qualify">
        <fieldset>
            <input name="topic_id" type="hidden" value="USCDC_974" />
            <label>
            <span class="hidden">Enter Email Address</span>
            <input type="text" class="email" name="email" value="" onfocus="this.value=''" />
            </label>
             <br /><a class="explain" href="http://www.cdc.gov/emailupdates/">What's this?</a>
            <a href="javascript:quicksubscribe();return false;" class="btn  btn-secondary">Submit</a>
            <noscript>
               
            <a class="explain" href="http://www.cdc.gov/emailupdates/">What's this?</a>
            <label><span class="hidden">Submit Button</span>
            <input type="submit" class="button submit" name="commit" value="Submit" /></label>
            </noscript>
        </fieldset>
    </form>
</div> 