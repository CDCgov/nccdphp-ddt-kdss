<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainNav.ascx.cs" Inherits="CKDSurveillance_RD.MainNav" %>
<%--<%@ OutputCache Duration="86400" VaryByParam="none"%>--%>

<style type="text/css">
    .dropdown-menu { /*IE fix*/
        width: 100%;
        top: 0;
    }

    .menudivider {
        flex: 1;
        max-width: 2px;
        background-color: #BBB;
        margin: 0px !important;
    }


    .btn-primary:hover, .show > .hoverclass {
        color: #1a7aa2;
        background-color: #eee !important;
        border-bottom-color: #eee !important;
        background-position: 0 -40px !important;
        text-decoration: none;
    }

    .hoverclass {
        color: #1a7aa2 !important;
        background-color: #EEE !important;
        border-bottom-color: #EEE !important;
        background-position: 0 -40px !important;
    }

    .btn.btn-primary.selectedclass {
        color: #1a7aa2 !important;
        background-color: #eee !important;
        border-color: #F4791F !important;
        border-width: 2px;
        border-bottom-color: #DDD !important;
        background-position: 0 -40px !important;
    }

    .selectedTopic {
        border-color: #F4791F !important;
        border-width: 2px;
    }

    .dropdown-menu {
        margin-top: 0px;
        background-color: #EEE;
        position: relative;
        border-top: #EEE;
        text-align: left;
        -webkit-animation-name: example; /* Safari 4.0 - 8.0 */
        -webkit-animation-duration: 4s; /* Safari 4.0 - 8.0 */
        -webkit-animation-delay: 2s; /* Safari 4.0 - 8.0 */
        animation-name: example;
        animation-duration: 4s;
        animation-delay: 2s;
    }

    .measureHeader {
        color: #1a7aa2;
    }

    .MeasureTextTD {
        padding: 2px 2px 2px 4px;
        color: #1a7aa2;
        font-weight: bold;
        font-size:16px !important;
    }

    .IndicatorTD {
        font-size: 12pt;
    }

    .dropdown-menu li {
        padding: 0px !important;
    }

    .dropdown-menu ul {
        padding: 0px !important;
    }

    .siteNavUL li {
        padding: 2px !important;
        margin: 0px !important;
        /*list-style-type:disc;*/
    }


    .TopicHomeTextTD {
        padding: 4px 4px 4px 4px;
        margin-top: 1px;
        border: solid 3px #1a7aa2;
        background-color: #c5ded6;
        border-radius: 5px;
        text-align: center;
        font-weight: bold;
        font-size:17px !important;
        width: 100%;
    }

    .row.TopicHomeDiv {
        padding-left: 20px !important;
        padding-right: 20px !important;
        padding-bottom: 10px !important;
    }

    .selectedIndicator {
        border: solid 2px #F4791F !important;
        border-radius: 5px;
        padding: 2px 0px 2px 2px !important;
        background-color: #F5F0DD;
        margin-right: 4px;
    }

    a {
        text-decoration: none !important;
    }

        a:hover {
            text-decoration: underline !important;
        }

    .hideElement {
        display: none;
    }

    ul {
        margin-bottom: 0 !important;
    }

    .btn-primary {
        background-color: #1a7aa2 !important;
        border-color: #1a7aa2 !important;
        color: #FFF !important;
    }

    .btn-megamenu {
        background-color: #1a7aa2 !important;
        color: #fff;
        padding-top: 5px;
        padding-bottom: 1px;
        width: 100%;
        height: 100%;
    }

    .buttontext {
        font-size: 16px;
        font-family: Verdana !important;
        font-weight: bold;
    }

    .navbar {
        float: none;
        margin: 0 auto;
        display: block;
        text-align: center;
        padding: 0px !important;
    }

    .MMButton {
        background-color: #1a7aa2 !important;
        height: 60px;
        padding-left: 5px;
        padding-right: 5px;
                
        display: flex;
        justify-content: center;
        align-items: center;
                
        font-size: 17px !important;
        font-family: Verdana !important;        
    }

    .tpcBtn {
        cursor: pointer;
        font-size: 17px !important;
    }

    @media (min-width: 1200px) {
        #nav_desktop {
            display: flex;
        }

        #nav_mobile {
            display: none;
        }
    }

    @media (max-width: 1199px) {
        #nav_desktop {
            display: none;
        }

        #nav_mobile {
            display: flex;
        }
    }
    /*IMPORTANT - hover is controlled in the theme.css line 1291*/
</style>



<%--*Navigate to here after page refresh*--%>
<a id="refreshPosition" name="refreshPosition"></a>


<div class="container-fluid" style="padding-bottom: 20px; padding-top: 20px; text-align: center; width: 100%">
    <div class="row " style="margin-left: 0px; text-align: center;" id="nav_desktop">


        <%--**************************--%>
        <%--*Prevalence and Incidence*--%>
        <%--**************************--%>

        <div class="col-md-2 tpcBtn">
            <div class="dropdown" onkeydown="checkTabKeyPresses(event,'pi');" onfocus="showHideMenu('s','pi');" tabindex="0" onclick="handleTopicLandingPageSelectionNavigation('pi');" onmouseenter="showHideMenu('s','pi');" onmouseleave="showHideMenu('h','pi');">
                <div class="btn-megamenu card ds-5 ds-8 mb-3 noLinking noDecoration" data-flip="false" type="button" id="dropdownMenuButton_Prevalence" data-toggle="dropdown" data-topicid="1" data-topicpage="PrevalenceIncidence" aria-haspopup="true" aria-expanded="false">
                    <div class="MMButton">
                        <div class="card-title h6 text-center MMButton">Prevalence and Incidence</div>
                    </div>
                    <img id="imgPI" src="./images/Prev. and Inc_r2_rs2.jpg" alt="Image Button to show Prevalence and Incidence indicators and questions" class="img-fluid" />
                </div>
            </div>
        </div>

        <%--***********--%>
        <%--*Awareness*--%>
        <%--***********--%>
        <div class="col-md-2 tpcBtn">
            <div id="divBtnAW" class="dropdown" onkeydown="checkTabKeyPresses(event,'aw');" onfocus="showHideMenu('s','aw');" tabindex="0" onclick="handleTopicLandingPageSelectionNavigation('aw');" onmouseenter="showHideMenu('s','aw');" onmouseleave="showHideMenu('h','aw');">
                <div class="btn-megamenu card ds-5 ds-8 mb-3 noLinking noDecoration" data-flip="false" type="button" id="dropdownMenuButton_Awareness" data-toggle="dropdown" data-topicid="3" data-topicpage="Awareness" aria-haspopup="true" aria-expanded="false">
                    <div class="MMButton">
                        <div class="card-title h6 text-center MMButton">Awareness</div>
                    </div>
                    <img id="imgAW" src="./images/Awareness_r2_rs2.jpg" alt="Image Button to show awareness indicators and questions" />

                </div>
            </div>
        </div>


        <%--************************--%>
        <%--*Burden of Risk factors*--%>
        <%--************************--%>
        <div class="col-md-2 tpcBtn">
            <div id="divBtnRF" class="dropdown" tabindex="0" onkeydown="checkTabKeyPresses(event,'rf');"  onfocus="showHideMenu('s','rf');" onclick="handleTopicLandingPageSelectionNavigation('rf');" onmouseenter="showHideMenu('s','rf');" onmouseleave="showHideMenu('h','rf');">
                <div class="btn-megamenu card ds-5 ds-8 mb-3 noLinking noDecoration" data-flip="false" type="button" id="dropdownMenuButton_Burden" data-toggle="dropdown" data-topicid="3" data-topicpage="Awareness" aria-haspopup="true" aria-expanded="false">
                    <div class="MMButton">
                        <div class="card-title h6 text-center MMButton">Burden of Risk Factors</div>
                    </div>
                    <img id="imgBORF" src="./images/Burden_r2_re2.jpg" alt="Image button to show burden of risk factors indicators and questions" class="img-fluid" />
                </div>
            </div>
        </div>


        <%--*********************--%>
        <%--*Health Consequences*--%>
        <%--*********************--%>
        <div class="col-md-2 tpcBtn">
            <div id="divBtnHC" class="dropdown" tabindex="0" onkeydown="checkTabKeyPresses(event,'hc');" onfocus="showHideMenu('s','hc');" onclick="handleTopicLandingPageSelectionNavigation('hc');" onmouseenter="showHideMenu('s','hc');" onmouseleave="showHideMenu('h','hc');">
                <div class="btn-megamenu card ds-5 ds-8 mb-3 noLinking noDecoration" data-flip="false" type="button" id="dropdownMenuButton_HealthConsequences" data-toggle="dropdown" data-topicid="3" data-topicpage="Awareness" aria-haspopup="true" aria-expanded="false">
                    <div class="MMButton">
                        <div class="card-title h6 text-center MMButton">Health Consequences</div>
                    </div>
                    <img id="imgHC" src="./images/Health_Cons_r2_rs2.jpg" alt="Image button to show health consequences indicators and questions" class="img-fluid" />
                </div>
            </div>
        </div>


        <%--*****************--%>
        <%--*Quality of Care*--%>
        <%--*****************--%>
        <div class="col-md-2 tpcBtn">
            <div id="divBtnQC" class="dropdown" tabindex="0" onkeydown="checkTabKeyPresses(event,'qc');" onfocus="showHideMenu('s','qc');" onclick="handleTopicLandingPageSelectionNavigation('qc');" onmouseenter="showHideMenu('s','qc');" onmouseleave="showHideMenu('h','qc');">
                <div class="btn-megamenu card ds-5 ds-8 mb-3 noLinking noDecoration" data-flip="false" type="button" id="dropdownMenuButton_Quality" data-toggle="dropdown" data-topicid="3" data-topicpage="Awareness" aria-haspopup="true" aria-expanded="false">
                    <div class="MMButton">
                        <div class="card-title h6 text-center MMButton">Quality of Care</div>
                    </div>
                    <img id="imgQOC" src="./images/Qual of Care_r2_rs2.jpg" alt="Image button to show quality of care indicators and questions" class="img-fluid" />
                </div>
            </div>
        </div>



        <%--************************--%>
        <%--*Health System Capacity*--%>
        <%--************************--%>
        <div class="col-md-2 tpcBtn">
            <div id="divBtnHSC" class="dropdown" tabindex="0" onkeydown="checkTabKeyPresses(event,'hsc');" onfocus="showHideMenu('s','hsc');" onclick="handleTopicLandingPageSelectionNavigation('hsc');" onmouseenter="showHideMenu('s','hsc');" onmouseleave="showHideMenu('h','hsc');">
                <div class="btn-megamenu card ds-5 ds-8 mb-3 noLinking noDecoration" data-flip="false" type="button" id="dropdownMenuButton_HealthSystem" data-toggle="dropdown" data-topicid="3" data-topicpage="Awareness" aria-haspopup="true" aria-expanded="false">
                    <div class="MMButton">
                        <div class="card-title h6 text-center MMButton">Health System Capacity</div>
                    </div>
                    <img id="imgHSC" src="./images/Health System_r2_rs2.jpg" alt="Image button to show health system capacity indicators and questions" class="img-fluid" />
                </div>
            </div>
        </div>
    </div>


    <div class="row" style="margin-left: 0px; margin-top: -15px; text-align: center; position: absolute;" id="divMMIndicatorsList">
        <%--*************************--%>
        <%--*Measures and Indicators*--%>
        <%--*************************--%>
        <div class="col-12">

            <%--*Prev and Inc.*--%>             
            <div id="ddmPrevalenceAndIncidence" class="dropdown-menu showOnTop" aria-labelledby="dropdownMenuButton_Prevalence" onmouseenter="$(this).show();" onmouseleave="$(this).hide();">
                <a name="anchor_pi"></a>
                <div class="row TopicHomeDiv">
                    <div class="TopicHomeTextTD" data-topicid="1" tabindex="0" data-topicpage="PrevalenceIncidence">View Prevalence and Incidence Summary</div>
                </div>
                <div class="row dropdownrow" style="align-items: stretch;">
                    <asp:Literal ID="litPrevalenceIndicators" runat="server"></asp:Literal>
                </div>
                <a name="anchor_pi_end" onblur="$('#divBtnAW').focus();"></a>
            </div>


            <%--*Awareness*--%>
            <div id="ddmAwareness" class="dropdown-menu" aria-labelledby="dropdownMenuButton_Awareness" onmouseenter="$(this).show();" onmouseleave="$(this).hide();">
                <a name="anchor_aw"></a>
                <div class="row TopicHomeDiv">
                    <div class="TopicHomeTextTD" data-topicid="3"  tabindex="0" data-topicpage="Awareness">View Awareness Summary</div>
                </div>
                <div class="row dropdownrow" style="align-items: stretch;">
                    <asp:Literal ID="litAwarenessIndicators" runat="server"></asp:Literal>
                </div>
                <a name="anchor_aw_end" onblur="$('#divBtnRF').focus();"></a>
            </div>


            <%--*Burden of rf*--%>
            <div id="ddmBurden" class="dropdown-menu" aria-labelledby="dropdownMenuButton_Burden" onmouseenter="$(this).show();" onmouseleave="$(this).hide();">
                <a name="anchor_rf"></a>
                <div class="row TopicHomeDiv">
                    <div class="TopicHomeTextTD" tabindex="0" data-topicid="4" data-topicpage="BurdenOfRiskFactors">View Burden of Risk Factors Summary</div>
                </div>
                <div class="row dropdownrow" style="align-items: stretch;">
                    <asp:Literal ID="litBurdenIndicators" runat="server"></asp:Literal>
                </div>
                <a name="anchor_rf_end" onblur="$('#divBtnHC').focus();"></a>
            </div>


            <%--*Health Consequences*--%>
            <div id="ddmConsequences" class="dropdown-menu" aria-labelledby="dropdownMenuButton_HealthConsequences" onmouseenter="$(this).show();" onmouseleave="$(this).hide();">
                <a name="anchor_hc"></a>
                <div class="row TopicHomeDiv">
                    <div class="TopicHomeTextTD" tabindex="0" data-topicid="5" data-topicpage="HealthConsequences">View Health Consequences Summary</div>
                </div>
                <div class="row dropdownrow" style="align-items: stretch;">
                    <asp:Literal ID="litHealthConsequencesIndicators" runat="server"></asp:Literal>
                </div>
                <a name="anchor_hc_end" onblur="$('#divBtnQC').focus();"></a>
            </div>
           

            <%--*Quality of Care*--%>
            <div id="ddmQuality" class="dropdown-menu" aria-labelledby="dropdownMenuButton_Quality" onmouseenter="$(this).show();" onmouseleave="$(this).hide();">
                 <a name="anchor_qc"></a>
                <div class="row TopicHomeDiv">
                    <div class="TopicHomeTextTD" tabindex="0" data-topicid="6" data-topicpage="QualityOfCare">View Quality of Care Summary</div>
                </div>
                <div class="row dropdownrow" style="align-items: stretch;">
                    <asp:Literal ID="litQualityIndicators" runat="server"></asp:Literal>
                </div>
                <a name="anchor_QC_end" onblur="$('#divBtnHSC').focus();"></a>
            </div>
            

            <%--*Health care System Capacity*--%>
            <div id="ddmCapacity" class="dropdown-menu" aria-labelledby="dropdownMenuButton_HealthSystem" onmouseenter="$(this).show();" onmouseleave="$(this).hide();">
                <a name="anchor_hsc"></a>
                <div class="row TopicHomeDiv">
                    <div class="TopicHomeTextTD" tabindex="0" data-topicid="7" data-topicpage="HealthCareSystemCapacity">View Health Care System Capacity Summary</div>
                </div>
                <div class="row dropdownrow" style="align-items: stretch;">
                    <asp:Literal ID="litHealthSystemIndicators" runat="server"></asp:Literal>
                </div>
                 <a name="anchor_HSC_end" onfocus="$('.dropdown-menu').hide();" tabindex="0"></a> <%--onblur="$('.dropdown-menu').hide(); jump('escape');"--%>
            </div>
        </div>
    </div>

   

    <div class="row" style="margin-left: 0px; text-align: center;" id="nav_mobile">
        <div class="col-xl-1"></div>
        <div class="col-xl-10">
            <div class="accordion indicator-plus accordion-white" aria-multiselectable="true" role="tabpanel">
                <asp:Literal ID="litMobileIndicators" runat="server"></asp:Literal>
            </div>
        </div>
        <div class="col-xl-1"></div>
    </div>     

</div>




<asp:HiddenField ID="HF_TopicText" runat="server" />

<script type="text/javascript">

    $(document).ready(function () {

        //Ensure images are same size
        equalizeImageSizes();

        //navigate to the topic home pages on click
        handleTopicHomeMouseEventsAndNav();

        //Names, spaces and Selections
        handleSelectionFormatting();

        //Only show topic images on home page        
        hideTopicButtonsIfNecessary();

        //IE11 needs special attention
        handleIE11();

        //If there is a selected Indicator...
        selectTopicButton();

        //If they resize the page - ensure the images are equally sized
        window.addEventListener("resize", equalizeImageSizes);
    });



    //***********
    //*FUNCTIONS*
    //***********
    function handleTopicHomeMouseEventsAndNav() {

        $('.TopicHomeTextTD').mouseenter(function () { $(this).css('cursor', 'pointer').css('color', '#F4791F'); })
        $('.TopicHomeTextTD').mouseleave(function () { $(this).css('cursor', 'default').css('color', ''); })
        $('.TopicHomeTextTD').click(function () {

            var document_href = document.location.href;
            if (document_href.toLowerCase().indexOf("topichome") > -1)
                location.href = $(this).attr('data-topicpage') + ".aspx?topicid=" + $(this).attr('data-topicid') + "#refreshPosition";
            else
                location.href = "./TopicHome/" + $(this).attr('data-topicpage') + ".aspx?topicid=" + $(this).attr('data-topicid') + "#refreshPosition";
        })
    }
    function handleTopicLandingPageSelectionNavigation(name) {

        //Specifically clicked topic - this determines how to get to the landing page
        var answer = '';
        var folderName = 'TopicHome/';

        //get current URL
        var document_href = document.location.href;

        //Handle whether currently on a topic home page
        if (document_href.toLowerCase().indexOf("topichome") > -1) { answer = './'; } else { answer += folderName; }

        //Build URL
        switch (name) {
            case 'pi':
                answer += 'PrevalenceIncidence.aspx'
                break;
            case 'aw':
                answer += 'Awareness.aspx'
                break;
            case 'rf':
                answer += 'BurdenOfRiskFactors.aspx';
                break;
            case 'hc':
                answer += 'HealthConsequences.aspx';
                break;
            case 'qc':
                answer += 'QualityOfCare.aspx';
                break;
            case 'hsc':
                answer += 'HealthCareSystemCapacity.aspx';
                break;
        }

        //Navigate
        location.href = answer;
    }
    function handleSelectionFormatting() {

        $("button[id^=dropdownMenuButton]").each(function () {

            var btntext = $(this).text().trim();
            var btntext = btntext.replace(/ /g, ''); //replacing spaces that were created by br tags so the compare will work, this is using a global replace
            var hftext = $("input[id*=HF_TopicText]").val().trim();

            var hftext = hftext.replace(/ /g, ''); //replacing spaces so the compare will work          

            console.log(hftext);

            if (hftext.indexOf(btntext) > -1) {
                $(this).addClass("selectedclass");
                $(this).addClass("hoverclass");
                $(this).prop('disabled', false);
            }
        });

    }
    function handleIE11() {

        //Handle IE11 - yay! (position:absolute issues)
        if (!!window.MSInputMethodContext && !!document.documentMode) {
            console.log('making alterations to measures and indicators div because this is IE11');
            $('#divMMIndicatorsList').css('position', 'relative');
        }
    }
    function hideTopicButtonsIfNecessary() {

        //Hide the Topic button images if not on the home page
        if (document.URL.toLowerCase().indexOf('default.aspx') <= 0) {
            $('.btn-megamenu').find('img').hide();

            if (document.URL.toLowerCase().indexOf('aspx') <= 0) {
                $('.btn-megamenu').find('img').show();
            }
        } 
    }
    function selectTopicButton() {

        //Only do this on the detail page
        var urlLocation = document.URL.toLowerCase().indexOf('detail.aspx');
        if (urlLocation <= 0) { return; }

        var id = $('.selectedIndicator').parent().parent().parent().parent().parent().attr('id');

        if (id.length > 0) {
            switch (id) {
                case 'ddmPrevalenceAndIncidence':
                    $('#dropdownMenuButton_Prevalence').addClass('selectedTopic');
                    break;
                case 'ddmAwareness':
                    $('#dropdownMenuButton_Awareness').addClass('selectedTopic');
                    break;
                case 'ddmBurden':
                    $('#dropdownMenuButton_Burden').addClass('selectedTopic');
                    break;
                case 'ddmConsequences':
                    $('#dropdownMenuButton_HealthConsequences').addClass('selectedTopic');
                    break;
                case 'ddmQuality':
                    $('#dropdownMenuButton_Quality').addClass('selectedTopic');
                    break;
                case 'ddmCapacity':
                    $('#dropdownMenuButton_HealthSystem').addClass('selectedTopic');
                    break;
            }
        }
    }

    function equalizeImageSizes() {

        $('#imgPI').height($('#imgHC').height()).width($('#imgHC').width());
        $('#imgAW').height($('#imgHC').height()).width($('#imgHC').width());
    }

    function showHideMenu(showHide,topic) {

        //TODO - Put back in the fades and handle timing problem of vigorous mouse activity
        if(topic == 'pi'){
            if (showHide === 's') {                
                $('#ddmPrevalenceAndIncidence').show();//.fadeIn(300);
            } else {
                $('#ddmPrevalenceAndIncidence').hide();
            }
        } else {
            $('#ddmPrevalenceAndIncidence').hide();
        }


        if(topic === 'aw'){
            if (showHide === 's') {  
                $('#ddmAwareness').show();//.fadeIn(300);
            } else{
                $('#ddmAwareness').hide();
            }
        } else{
            $('#ddmAwareness').hide();
        }


        if(topic === 'rf'){
            if (showHide === 's') {  
                $('#ddmBurden').show();//.fadeIn(300);
            } else{
                $('#ddmBurden').hide();
            }
        } else{
            $('#ddmBurden').hide();
        }


        if(topic === 'hc'){
            if (showHide === 's') {  
                $('#ddmConsequences').show();//.fadeIn(300);
            } else{
                $('#ddmConsequences').hide();
            }
        } else{
            $('#ddmConsequences').hide();
        }


        if(topic === 'qc'){
            if (showHide === 's') {  
                $('#ddmQuality').show();//.fadeIn(300);
            } else{
                $('#ddmQuality').hide();
            }
        } else{
            $('#ddmQuality').hide();
        }


        if(topic === 'hsc'){
            if (showHide === 's') {  
                $('#ddmCapacity').show();//.fadeIn(300);
            } else{
                $('#ddmCapacity').hide();
            }
        } else{
            $('#ddmCapacity').hide();
        }                  
    }
   
    function checkTabKeyPresses(e, topic) {        
        
        /* check if enter key was pressed on the focussed tab*/
        console.log('Button pressed: ' + e.keyCode);

        switch (e.keyCode) {
            case 40:
                //<down arrow> - drop into the visible menu
                jump(topic);
                break;
            case 38:
                //<up arrow>
                showHideMenu('h', topic);
                break;
            case 13:
                //<Enter>                
                handleTopicLandingPageSelectionNavigation(topic);
                break;
        }       
    }

    function jump(topic) {

        //Manage keyboard navigation of menus - (entry specifically)
        var h = 'anchor_' + topic;

        var url = location.href;               //Save down the URL without hash.
        location.href = "#" + h;                 //Go to the target element.
        history.replaceState(null, null, url);   //Don't like hashes. Changing it back.
    }   

</script>
