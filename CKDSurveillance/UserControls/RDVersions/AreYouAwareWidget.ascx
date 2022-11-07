<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AreYouAwareWidget.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.AreYouAwareWidget" %>

<style type="text/css">
    .tickerDate
    {
        color: #1a7aa2;

        font-weight:bold;
    }

    .ckd-accordion-header-label {
         text-decoration:none;
        color:#000;  
    }

    .ckd-accordion-header-label:hover
    {
        color:#c5ded6;                
        cursor:pointer;
        /*font-weight:bold;*/
        text-decoration:none;        
    }

    .articleLink
    {
        text-decoration:none;
        color:#000;    
    }
    .articleLink:hover
    {
        /*color:#c5ded6;*/                
        cursor:pointer;
        /*font-weight:bold;*/
        text-decoration:none;        
    }

    .articlelinkdiv {
        padding-left:5px !important;
        margin-right:-1px !important;
        margin-left:-1px !important;
    }

    .ckd-accordion-header-title {
        font-weight:bold;
        font-family:Verdana;
        font-size:10pt;
        /*padding-left:9px !important;*/
        padding-top:5px !important;
        margin-left:-10px;
    }

    .ckd-accordion-header-label:hover  {
        color: Black; text-decoration: none;
    }

        /* 10/30/2019 From Thach @ CDC */
    .nccd-modA h3 {
        background-color: #c5ded6 !important;
        color: #1a7aa2 !important;
        font-family: Verdana;
        font-size: 16px;
        font-weight: bold;
        padding: 5px 10px;
    }

    .accordion .card-header .card-title {
        padding-right:10px;
    }


    
    
</style>


<div class="nccd-modA CornerMe" id="homePageDiv" runat="server">

    <%--**************--%>
    <%--*Widget Title*--%>
    <%--**************--%>
    <h3>
        Are You Aware?
       <%--Quick Facts About Kidney Disease--%>
    </h3>

    <div ><%--id="AYAScroller"--%>
        <ul >
            <li><a href="AreYouAware.aspx?emailDate=November_2020" class="articleLink"><span class="tickerDate">November 2020</span> - Awareness of Chronic Kidney Disease in US Adults With Diabetes Remains Low</a></li>
            <li><a href="AreYouAware.aspx?emailDate=September_2020" class="articleLink"><span class="tickerDate">September 2020</span> - Chronic Kidney Disease Prevalence Is Higher in Older Adults </a></li>
            <li><a href="AreYouAware.aspx?emailDate=August_2020" class="articleLink"><span class="tickerDate">August 2020</span> - Sleep Problems Are More Common in Adults With Chronic Kidney Disease</a></li>
            
            
          
            
                              
            <br />
            <a href="AreYouAware.aspx?emailDate=November_2020" class="articleLink">View All</a>
            <%--<li><a href="AreYouAware.aspx?emailDate=3_23_2016" class="articleLink"><span class="tickerDate">March 23, 2016</span> - Reported Causes of Kidney Failure in Children, Adolescents, and Adults</a></li>
            <li><a href="AreYouAware.aspx?emailDate=3_3_2016" class="articleLink"><span class="tickerDate">March 3, 2016</span> - Chronic Kidney Disease and Smoking</a></li>
            <li><a href="AreYouAware.aspx?emailDate=2_26_2016" class="articleLink"><span class="tickerDate">February 26, 2016</span> -  Cardiovascular Disease and Chronic Kidney Disease</a></li>
            <li><a href="AreYouAware.aspx?emailDate=1_11_2016" class="articleLink"><span class="tickerDate">January 11, 2016</span> - Awareness of Chronic Kidney Disease (CKD) in the United States is Low</a></li>
            <li><a href="AreYouAware.aspx?emailDate=blog" class="articleLink"><span class="tickerDate">CKD Blog</span> - Hypertension Prevalence in CKD Population</a></li>--%>
        </ul>
    </div>
  
</div>


<div class="nccd-modA CornerMe" id="subPageDiv" runat="server">

    <script>
        $(document).ready(function () {


            //$('.ckd-accordion-header-title').focusin(function (e) {
            //    $(this).parent().css('border', 'solid 1px silver');
            //});

            //$('.ckd-accordion-header-title').focusout(function () {
            //    $(this).parent().css('border', 'none');
            //});

            //$('.ckd-accordion-header-title').each(function () {
            //    $(this).next().toggle();
            //});

            //$('.ckd-accordion-header-title').click(function (event) {
            //    console.log("inside click");
            //    $(this).next().toggle();
            //    $(this).find('span.ckd-accordion-header-label').toggleClass('ckd-accordion-plus');
            //    $(this).find('span.ckd-accordion-header-label').toggleClass('ckd-accordion-minus');
                
            //    event.stopPropagation();
            //    return false;
            //});

            
        }
        );
    </script>
    <%--**************--%>
    <%--*Widget Title*--%>
    <%--**************--%>
    <h3>
        Topics
    </h3>
    <div style="padding-left:1px;padding-right:1px;">
        <div class="accordion indicator-plus accordion-white" aria-multiselectable="true" role="tabpanel">

            <div class="card bar " style="padding-left:0px;">
                <div class="card-header collapsed" id="accordion-4i-card-10" data-target="#accordion-4i-collapse-10" data-toggle="collapse" role="tab" aria-expanded="false">
                    <a class="card-title" tabindex="0" data-controls="accordion-4i-collapse-10">Awareness</a>
                </div>
                <div aria-labelledby="accordion-4i-card-10" class="collapse" id="accordion-4i-collapse-10" role="tabpanel">
                    <div class="card body">
                         <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_July_2021" class="row articlelinkdiv"  data-parentid="10" >
                                    <ul>
                                        <li><a  href="javascript:changeContent('July_2021')" class="articleLink" >Only Half of Adults at High Risk of Kidney Failure Know They Have CKD - July 2021.</a></li>
                                    </ul>
                                </div> 
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_November_2020" class="row articlelinkdiv"  data-parentid="10" >
                                    <ul>
                                        <li><a  href="javascript:changeContent('November_2020')" class="articleLink" >Awareness of Chronic Kidney Disease in US Adults With Diabetes Remains Low - November 2020.</a></li>
                                    </ul>
                                </div> 
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_January_2016" class="row articlelinkdiv"  data-parentid="10" >
                                    <ul>
                                        <li><a  href="javascript:changeContent('January_2016')" class="articleLink" >Awareness of Chronic Kidney Disease (CKD) in the United States is Low - January 2016.</a></li>
                                    </ul>
                                </div> 
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
            <div class="card bar " style="padding-left:0px;">
                <div class="card-header collapsed" id="accordion-4i-card-11" data-target="#accordion-4i-collapse-11" data-toggle="collapse" role="tab" aria-expanded="false">
                    <a class="card-title" tabindex="0" data-controls="accordion-4i-collapse-11">Children and Adolescents</a>
                </div>
                <div aria-labelledby="accordion-4i-card-11" class="collapse" id="accordion-4i-collapse-11" role="tabpanel">
                    <div class="card body">
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_July_2017" class="row articlelinkdiv"  data-parentid="11" >
                                    <ul>
                                        <li><a href="javascript:changeContent('July_2017')" class="articleLink">Almost 10,000 Children and Adolescents in United States Are Living with End-Stage Renal Disease - July 2017.</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_March_2016_2" class="row articlelinkdiv" data-parentid="11" >
                                    <ul>
                                        <li><a href="javascript:changeContent('March_2016_2')" class="articleLink">Reported Causes of Kidney Failure in Children, Adolescents, and Adults - March 2016.</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
             <div class="card bar " style="padding-left:0px;">
                <div class="card-header collapsed" id="accordion-4i-card-12" data-target="#accordion-4i-collapse-12" data-toggle="collapse" role="tab" aria-expanded="false">
                    <a class="card-title" tabindex="0" data-controls="accordion-4i-collapse-12">Health care system capacity</a>
                </div>
                <div aria-labelledby="accordion-4i-card-12" class="collapse" id="accordion-4i-collapse-12" role="tabpanel">
                    <div class="card body">
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_March_2019" class="row articlelinkdiv"  data-parentid="12" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('March_2019')" class="articleLink">Nearly 10% of Adults with Advanced CKD Reported Not Having Health Insurance - March 2019.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_August_2016" class="row articlelinkdiv"  data-parentid="12" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('August_2016')" class="articleLink">Number of Nephrologists for Patients with Chronic Kidney Disease in the United States - August 2016.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card bar " style="padding-left:0px;">
                <div class="card-header collapsed" id="accordion-4i-card-13" data-target="#accordion-4i-collapse-13" data-toggle="collapse" role="tab" aria-expanded="false">
                    <a class="card-title" tabindex="0" data-controls="accordion-4i-collapse-13">Health consequences</a>
                </div>
                <div aria-labelledby="accordion-4i-card-13" class="collapse" id="accordion-4i-collapse-13" role="tabpanel">
                    <div class="card body">
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_August_2020" class="row articlelinkdiv"  data-parentid="13" >
                                    <ul>
                                        <li><a  href="javascript:changeContent('August_2020')" class="articleLink">Sleep Problems Are More Common in Adults With Chronic Kidney Disease - August 2020.</a></li>
                                   </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_August_2018" class="row articlelinkdiv"  data-parentid="13" >
                                    <ul>
                                        <li><a  href="javascript:changeContent('August_2018')" class="articleLink">More Laboratories Are Routinely Reporting eGFR - August 2018.</a></li>
                                   </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                 <div id="link_March_2018" class="row articlelinkdiv"  data-parentid="13" >
                                    <ul>
                                        <li><a  href="javascript:changeContent('March_2018')" class="articleLink">More than one-third of male and female Medicare patients with advanced kidney disease are not seeing a kidney doctor before developing kidney failure - March 2018.</a></li>
                                   </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_September_2017" class="row articlelinkdiv"  data-parentid="13" >
                                    <ul>
                                        <li><a  href="javascript:changeContent('September_2017')" class="articleLink">Older Adults with Chronic Kidney Disease (CKD) Report More Disability than Older Adults Without CKD - September 2017.</a></li>
                                   </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_September_2016" class="row articlelinkdiv"  data-parentid="13" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('September_2016')" class="articleLink">High Burden of Sleep Problems Among People with Chronic Kidney Disease - September 2016.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_February_2016" class="row articlelinkdiv"  data-parentid="13" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('February_2016')" class="articleLink">Cardiovascular Disease and Chronic Kidney Disease - February 2016.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card bar " style="padding-left:0px;">
                <div class="card-header collapsed" id="accordion-4i-card-14" data-target="#accordion-4i-collapse-14" data-toggle="collapse" role="tab" aria-expanded="false">
                    <a class="card-title" tabindex="0" data-controls="accordion-4i-collapse-14">Prevalence</a>
                </div>
                <div aria-labelledby="accordion-4i-card-14" class="collapse" id="accordion-4i-collapse-14" role="tabpanel">
                    <div class="card body">
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_September_2020" class="row articlelinkdiv"  data-parentid="14" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('September_2020')" class="articleLink">Chronic Kidney Disease Prevalence Is Higher in Older Adults - September 2020.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_February_2019" class="row articlelinkdiv"  data-parentid="14" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('February_2019')" class="articleLink">Percentage of US Adults With CKD Remains at About 14% - February 2019.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_January_2017" class="row articlelinkdiv"  data-parentid="14" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('January_2017')" class="articleLink">Long-term Trends in the Prevalence of Chronic Kidney Disease in the United States - January 2017.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
            
            </div>
            <div class="card bar " style="padding-left:0px;">
                <div class="card-header collapsed" id="accordion-4i-card-15" data-target="#accordion-4i-collapse-15" data-toggle="collapse" role="tab" aria-expanded="false">
                    <a class="card-title" tabindex="0" data-controls="accordion-4i-collapse-15">Quality of Care</a>
                </div>
                <div aria-labelledby="accordion-4i-card-15" class="collapse" id="accordion-4i-collapse-15" role="tabpanel">
                    <div class="card body">
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_January_2020" class="row articlelinkdiv"  data-parentid="15" >
                                    <ul>
                                        <li><a  href="javascript:changeContent('January_2020')" class="articleLink">Frequency of Testing for Albuminuria Is Low in Clinical Practice - January 2020.</a></li>
                                   </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">     
                                <div id="link_July_2019" class="row articlelinkdiv"  data-parentid="15" >
                                    <ul>
                                        <li><a  href="javascript:changeContent('July_2019')" class="articleLink">Less than 60% of adults with advanced chronic kidney disease in a healthcare system see a kidney doctor - July 2019.</a></li>
                                   </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                 <div id="link_January_2018" class="row articlelinkdiv"  data-parentid="15" >
                                    <ul>
                                        <li><a  href="javascript:changeContent('January_2018')" class="articleLink">About 9% of patients with moderate to severe chronic kidney disease use prescription NSAIDs - January 2018.</a></li>
                                   </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_November_2016" class="row articlelinkdiv"  data-parentid="15" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('November_2016')" class="articleLink">Urine Albumin Testing in Patients with Diabetes - November 2016.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            
           
            
            </div>
            <div class="card bar " style="padding-left:0px;">
                <div class="card-header collapsed" id="accordion-4i-card-16" data-target="#accordion-4i-collapse-16" data-toggle="collapse" role="tab" aria-expanded="false">
                    <a class="card-title" tabindex="0" data-controls="accordion-4i-collapse-16">Risk Factors – Cardiovascular Disease</a>
                </div>
                <div aria-labelledby="accordion-4i-card-16" class="collapse" id="accordion-4i-collapse-16" role="tabpanel">
                    <div class="card body">
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_September_2019" class="row articlelinkdiv"  data-parentid="16" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('September_2019')" class="articleLink">Cardiovascular Disease Is Common in Older US Adults and Is the Leading Cause of Death in People With Chronic Kidney Disease - September 2019.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card bar " style="padding-left:0px;">
                <div class="card-header collapsed" id="accordion-4i-card-17" data-target="#accordion-4i-collapse-17" data-toggle="collapse" role="tab" aria-expanded="false">
                    <a class="card-title" tabindex="0" data-controls="accordion-4i-collapse-17">Risk Factors – Diabetes</a>
                </div>
                <div aria-labelledby="accordion-4i-card-17" class="collapse" id="accordion-4i-collapse-17" role="tabpanel">
                    <div class="card body">
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_October_2022" class="row articlelinkdiv"  data-parentid="17" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('October_2022')" class="articleLink">Chronic Kidney Disease Is Prevalent Among Adults with Prediabetes or Undiagnosed Diabetes - October 2022.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_September_2021" class="row articlelinkdiv"  data-parentid="17" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('September_2021')" class="articleLink">One in Ten Adults With CKD and Diabetes Taking SGLT2s to Lower Blood Sugar and Protect Their Heart and Kidneys - September 2021.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_January_2019" class="row articlelinkdiv"  data-parentid="17" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('January_2019')" class="articleLink">Advanced Stage CKD Is Increasing in Adults With Diagnosed Diabetes - January 2019.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                 <div id="link_October_2018" class="row articlelinkdiv"  data-parentid="17" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('October_2018')" class="articleLink">Diagnosed Diabetes Decreased in Adults Aged 60–64 years in a Commercially Insured Population - October 2018.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                 <div id="link_November_2017" class="row articlelinkdiv" data-parentid="17">
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('November_2017')" class="articleLink">Chronic Kidney Disease Is Rising Among Commercially Insured, Working-Age Adults With Diabetes - November 2017.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_November_2015" class="row articlelinkdiv" data-parentid="17" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('November_2015')" class="articleLink">Chronic Kidney Disease and Diabetes - November 2015.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card bar " style="padding-left:0px;">
                <div class="card-header collapsed" id="accordion-4i-card-21" data-target="#accordion-4i-collapse-21" data-toggle="collapse" role="tab" aria-expanded="false">
                    <a class="card-title" tabindex="0" data-controls="accordion-4i-collapse-21">Risk Factors – Food Insecurity</a>
                </div>
                <div aria-labelledby="accordion-4i-card-21" class="collapse" id="accordion-4i-collapse-21" role="tabpanel">
                    <div class="card body">
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_March_2020" class="row articlelinkdiv"  data-parentid="21" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('March_2020')" class="articleLink">One in Four Adults With Advanced Chronic Kidney Disease Is Food Insecure - March 2020.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card bar " style="padding-left:0px;">
                <div class="card-header collapsed" id="accordion-4i-card-18" data-target="#accordion-4i-collapse-18" data-toggle="collapse" role="tab" aria-expanded="false">
                    <a class="card-title" tabindex="0" data-controls="accordion-4i-collapse-18">Risk Factors – Hypertension</a>
                </div>
                <div aria-labelledby="accordion-4i-card-18" class="collapse" id="accordion-4i-collapse-18" role="tabpanel">
                    <div class="card body">
                       
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                 <div id="link_May_2021" class="row articlelinkdiv" data-parentid="18" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('May_2021')" class="articleLink">More Than Half of US Veterans with Chronic Kidney Disease Being Treated for High Blood Pressure Are Not Meeting Blood Pressure Targets - May 2021.</a>
                                        </li>                
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                 <div id="link_May_2020" class="row articlelinkdiv" data-parentid="18" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('May_2020')" class="articleLink">Fewer Than a Third of Patients With High Blood Pressure Are Tested for Urine Albumin in Clinical Practice - May 2020.</a>
                                        </li>                
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                 <div id="link_May_2019" class="row articlelinkdiv" data-parentid="18" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('May_2019')" class="articleLink">Diagnosis of High Blood Pressure Is Declining Among Adults With Chronic Kidney Disease - May 2019.</a>
                                        </li>                
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_May_2018" class="row articlelinkdiv" data-parentid="18" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('May_2018')" class="articleLink">Chronic kidney disease is 4 times higher in Medicare beneficiaries aged 65 or older with high blood pressure than in those without - May 2018.</a>
                                        </li>                
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                 <div id="link_May_2017" class="row articlelinkdiv" data-parentid="18" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('May_2017')" class="articleLink">Long-term Trends in Prevalence of Chronic Kidney Disease Among People With and Without High Blood Pressure in the United States - May 2017.</a>
                                        </li>                
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_May_2016" class="row articlelinkdiv" data-parentid="18" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('May_2016')" class="articleLink">High Blood Pressure in the US population with Chronic Kidney Disease - May 2016.</a>
                                        </li>                
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card bar " style="padding-left:0px;">
                <div class="card-header collapsed" id="accordion-4i-card-19" data-target="#accordion-4i-collapse-19" data-toggle="collapse" role="tab" aria-expanded="false">
                    <a class="card-title" tabindex="0" data-controls="accordion-4i-collapse-19">Risk Factors – Obesity</a>
                </div>
                <div aria-labelledby="accordion-4i-card-19" class="collapse" id="accordion-4i-collapse-19" role="tabpanel">
                    <div class="card body">
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                 <div id="link_March_2017" class="row articlelinkdiv" data-parentid="19" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('March_2017')" class="articleLink"> Long-term Trends in the Prevalence of Obesity in the United States - March 2017.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card bar " style="padding-left:0px;">
                <div class="card-header collapsed" id="accordion-4i-card-20" data-target="#accordion-4i-collapse-20" data-toggle="collapse" role="tab" aria-expanded="false">
                    <a class="card-title" tabindex="0" data-controls="accordion-4i-collapse-20">Risk Factors – Smoking</a>
                </div>
                <div aria-labelledby="accordion-4i-card-20" class="collapse" id="accordion-4i-collapse-20" role="tabpanel">
                    <div class="card body">
                        <div class="row" style="padding-bottom:2px">
                            <div class="col-12" style="padding-left:20px;">
                                <div id="link_March_2016" class="row articlelinkdiv" data-parentid="20" >
                                    <ul>
                                        <li>
                                            <a href="javascript:changeContent('March_2016')" class="articleLink">Chronic Kidney Disease and Smoking - March 2016.</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </div>
   

    
</div>