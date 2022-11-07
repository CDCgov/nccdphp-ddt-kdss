<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucOmniture.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.TemplateLocal.ucOmniture" %>

<!-- xxxxxxxxxxxxxxxxxx METRICS code begins here xxxxxxxxxxxxxxxxxxxxxxxxxxx-->
<div id="metrics">

    <!-- Begin Google Analytics Class Definition Code -->
    <script src="/JScript/metrics/google/google-cdc-a.js"></script>
    <!-- End Google Analytics Class Definition Code -->

    <!-- SiteCatalyst code version: H.21. -->
    <script src="/JScript/metrics/topic_levels.js"></script>
    <%--<script src="/JScript/metrics/s_code_v21_cdcgov.js"></script>--%>
    <script src="/JScript/metrics/adobe/analytics_cdcgov.js"></script>
    <script>

        enquire.register(CDC.Global.selectors.vp1, function () {
            s.prop49 = 1;
        });
        enquire.register(CDC.Global.selectors.vp2, function () {
            s.prop49 = 2;
        });
        enquire.register(CDC.Global.selectors.vp3, function () {
            s.prop49 = 3;
        });
        enquire.register(CDC.Global.selectors.vp4, function () {
            s.prop49 = 4;
        });

        s.pageName = document.title;
        s.channel = '<% Response.Write(ConfigurationManager.AppSettings["OmnitureApp"].ToString()); %>';

        siteCatalyst.setLevel1("Chronic");
        siteCatalyst.setLevel2("OD");
        siteCatalyst.setLevel3("Chronic");

        s.prop2 = window.location.href.toLowerCase();
        s.prop26 = document.title;
        s.prop30 = document.title;
        s.prop31 = window.location.href.toLowerCase();
        s.prop46 = window.location.href.toLowerCase();
        s.server = window.location.hostname;


        // Simplified URL
        s.prop73 = window.location.href.split('?')[0].split('#')[0].toLowerCase();

        // Update the level variables here.
        updateVariables(s);

        /************* DO NOT ALTER ANYTHING BELOW THIS LINE ! **************/
        var s_code = s.t(); if (s_code) document.write(s_code);//--></script>
    <script type="text/javascript"><!--
    if (navigator.appVersion.indexOf('MSIE') >= 0) document.write(unescape('%3C') + '\!-' + '-');
    //--></script>
    <noscript>
        <a href="http://www.omniture.com">
            <img
                src="http://mtrics.cdc.gov/b/ss/cdcgov/1/H.21--NS/0"
                height="1" width="1" alt="Web Analytics" /></a>
    </noscript>
    <!--/DO NOT REMOVE/-->
    <!-- End SiteCatalyst code version: H.21. -->
    <!-- Begin Google Analytics Execution Code -->
    <script type="text/javascript" src="/JScript/metrics/google/google-cdc-c.js"></script>
    <!-- End Google Analytics Execution Code -->
</div>
<!-- xxxxxxxxxxxxxxxxxx METRICS code ends here xxxxxxxxxxxxxxxxxxxxxxxxxxx-->
<script>if (typeof page_timing !== 'undefined') { page_timing.metrics_end = Date.now(); }</script>


<script>
<!--//
    $(document).ready(function () {
        var cdcLeftNav = new CDC.LeftNav("nav-primary");
        cdcLeftNav.render();
    });
    //-->
</script>

