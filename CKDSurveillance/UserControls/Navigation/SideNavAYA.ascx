<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SideNavAYA.ascx.cs" Inherits="CKDSurveillance_RD.SideNavAYA" %>
<%--<%@ OutputCache Duration="86400" VaryByParam="none"%>--%>


<style type="text/css">
    /*.accordion .card-header:after {
        content: "\f068";
        float: right; 
    }
    .accordion .card-header.collapsed:after {*/
        /* symbol for "collapsed" panels */
        /*content: "\f067"; 
    }*/

    .navbodyTitle{
			/*font: normal normal 600 38px/42px Open Sans;*/
			text-align: left;
			font-family: Open Sans;
			font-size:38px;
			letter-spacing: -0.38px;
			color: #29434E;
			opacity: 1;
		}
	.navbody{
		/*font: normal normal normal 17px/24px Open Sans;*/
		text-align: left;
		font-family: Open Sans;
		font-size:17px;
		letter-spacing: 0px;
		color: #000000;
		opacity: 1;
	}
	.navhomebreadcrumb{
		/*font: normal normal normal 14px/24px Open Sans;*/
		text-align: left;
		text-decoration: underline;			
		letter-spacing: 0px;
		color: #005EAA;
		font-family: Open Sans;
		font-size:14px;
	}
	.navbodybreadcrumb{
		/*font: normal normal normal 14px/24px Open Sans;*/
		text-align: left;			
		font-family: Open Sans;
		font-size:14px;
		letter-spacing: 0px;
		color: #000000;
	}		
	.navBoldHeader{   /*Prevalence & Incidence*/
		/*font: normal normal 600 17px/48px Open Sans;*/
		letter-spacing: 0px;			
		text-align:left;
		font-family: Open Sans, Semibold;
		font-weight:bold;
		font-size:17px;
		color: #007C91;
		opacity: 1;	
		background: #F5F5F5 0% 0% no-repeat padding-box;
		border-left: 4px solid;
        border-top:0px;
		border-color:#006778; /*0% 0% no-repeat padding-box;*/
		border-bottom: 1px dashed #e0e0e0;
	}
    .navNormalHeader{   /*Prevalence & Incidence*/
		/*font: normal normal 600 17px/48px Open Sans;*/
		letter-spacing: 0px;			
		text-align:left;
		font-family: Open Sans, Semibold;
		font-size:17px;
		color: #007C91;
		opacity: 1;	
		background: #F5F5F5 0% 0% no-repeat padding-box;
		border-left: 4px solid;
		border-color:#006778; /*0% 0% no-repeat padding-box;*/
		border-bottom: 1px dashed #e0e0e0;
        border-top:0px;
	}
	.navSectionLinks{
		/*font: normal normal normal 17px/20px Open Sans;*/
		text-align: left;			
		font-family: Open Sans;
		font-size:17px;
		letter-spacing: 0px;
		color: #000000;
		opacity: 1;
        cursor:pointer;
		/*background: #006778 0% 0% no-repeat padding-box;*/
		/*border-left: 4px solid;
		border-color:#006778; */
	}
	.navSectionLinkSelected{
		/*font: normal normal normal 17px/20px Open Sans;*/
		text-align: left;			
		font-family: Open Sans Semibold;
		font-size:17px;
		letter-spacing: 0px;
		color: #000000;
		opacity: 1;
		border-left: 4px solid;
		border-color:#006778; /*0% 0% no-repeat padding-box;*/
	}
	.navSectionSublinks{
		/*font: normal normal 600 15px/18px Open Sans;*/
		text-align: left;			
		font-family: Open Sans;
		font-size:15px;
		letter-spacing: 0px;
		color: #007C91;
		opacity: 1;
		text-decoration:none;
		list-style-type:none;
		border-left: 4px solid;
		border-color:#65B0BD; /*0% 0% no-repeat padding-box;*/
		border-bottom: 1px dashed #e0e0e0;
        border-top:0px;
		margin-bottom: 0px !important;
	}
	/*Additional Resources and General Information*/
	.navSectionHeading{
		text-align: left;
		/*font: normal normal 600 21px/34px Open Sans;*/
		font-family: Open Sans;
		font-size:21px;
		letter-spacing: -0.21px;
		color: #242424;
		text-transform: capitalize;
		opacity: 1;		
        margin-top: 20px;
	}
	.navARandGIlinks{
		text-align: left;
		/*font: normal normal normal 17px/23px Open Sans;*/
		font-family: Open Sans;
		font-size:17px;
		letter-spacing: 0px;
		color: #00778C !important;
		opacity: 1;
		text-decoration: none;
		padding-left:10px;
	 
	}
	.navARbottomline{
		padding: 10px 8px;
		border-left: 4px solid #fff;
		border-bottom: 1px dashed #e0e0e0;
	}
	.navARtopline{
		border-top: 1px dashed #e0e0e0;
	}
	.downloadImg{
		/*background: transparent url('img/Group 1776.png') 0% 0% no-repeat padding-box;*/
		opacity: 1;
		height: 25px; /*29.25px;*/
		width: 25px; /*29.25px;*/
	}
	.HealthyPeopleImg{
		/*background: transparent url('img/Group 151.png') 0% 0% no-repeat padding-box;*/
		opacity: 1;
		height:19.54px;
		width:19.51px;
	}
	.navlist li{
		text-decoration: none !important;
		list-style-type:none !important;
		list-style: none;			
	}
	.logoImg{
		background: transparent url('/images/CKDLeftNavLogo.png') 0% 0% no-repeat padding-box;
		opacity: 1;
		width: 100%; /*330px;*/
		height: 100%; /*128px;*/
		background-size: contain;
		background-repeat: no-repeat;
		background-position: center;
        box-shadow: 0px 0px 5px #0000002e;
	}
    .selectedLink {
        text-align: left;
        font: normal normal 600 15px/18px Open Sans;
        letter-spacing: 0px;
        color: #00768A;
        opacity: 1;
        background: #F5F5F5 0% 0% no-repeat padding-box;
    }


</style>


<div class="container d-flex flex-wrap body-wrapper bg-white">
    




<asp:Literal ID="Lit_TopicTitle" runat="server"></asp:Literal>      

		<!-- Left / Bottom Nav -->
			<nav role="navigation" aria-label="Left Navigation Menu" style="border-bottom-color:white">
				<div id="cdc-left-nav-menu" >
					<br />
					<div ><%--<img src="../../images/CKDLeftNavLogo.png" class="logoImg" />--%>
                        <img src="../../images/KDLeftNavlogo.jpg" class="logoImg" alt="Kidney Disease Surveillance System logo" />
					</div>
					<br />
				
					<asp:Literal ID="Lit_IndicatorText" runat="server" Visible="false"></asp:Literal>

                   
                    <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                    <%--AYA Side Nav list start--%>
                       

                    
                    <div><%-- class="card-header nav-section-home navSectionLinks navlist"--%>
                    <div  class="navBoldHeader nav-section-home d-sm-block" aria-multiselectable="true" role="tabpanel"><%-- class="card-header nav-section-home navSectionLinks navlist"--%>
                        Are You Aware Topics          
                    </div>
                    <div ><%--style="padding-left:1px;padding-right:1px;"--%>
                        <div class="accordion indicator-plus accordion-white" aria-multiselectable="true" role="tabpanel">


                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                            <%--Awareness--%>
                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                           <%-- <div class="card bar " style="padding-left:0px;">
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
                            </div>--%>

                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                            <%--Children and Adolescents--%>
                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                           <%-- <div class="card bar " style="padding-left:0px;">
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
                            </div>--%>

                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                            <%--Health care system capacity--%>
                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                            <%-- <div class="card bar " style="padding-left:0px;">
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
                            </div>--%>

                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                            <%--Health consequences--%>
                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                           <%-- <div class="card bar " style="padding-left:0px;">
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
                            </div>--%>

                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                            <%--Prevalence--%>
                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                           <%-- <div class="card bar " style="padding-left:0px;">
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
                            </div>--%>

                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                            <%--Quality of Care--%>
                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                           <%-- <div class="card bar " style="padding-left:0px;">
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
                            </div>--%>
                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                            <%--Risk Factors – Cardiovascular Disease--%>
                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                           <%-- <div class="card bar " style="padding-left:0px;">
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
                            </div>--%>

                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                            <%--Risk Factors – Diabetes--%>
                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                            <div  style="padding-left:0px; background-color: none !important;"> <%-- class="card bar "--%>
                                <div class="card-header collapsed nav-section-home navSectionLinks navlist" id="accordion-4i-card-17" data-target="#accordion-4i-collapse-17" data-toggle="collapse" role="tab" aria-expanded="false"  style="background-color: none !important;">
                                    <a id="RiskFactorsDiabetes" title="Risk Factors – Diabetes" style="display:inline; background-color: none !important;"  tabindex="0" data-controls="accordion-4i-collapse-17"> <%--class="card-title"--%>
                                       <i class="fi cdc-icon-minus nav-minus"  style = "float: right; background-color: none !important;" id="navplusicon"></i>Risk Factors – Diabetes</a>
                                </div>
                                <div aria-labelledby="accordion-4i-card-17" class="collapse" id="accordion-4i-collapse-17" role="tabpanel">
                                    <div >  <%--class="card body"--%>
                                        <div class="row" style="padding-bottom:2px">
                                            <div class="col-12" style="padding-left:20px;">
                                                <div id="link_October_2022"   data-parentid="17" >  <%--class="row articlelinkdiv"--%>
                                                    <ul>                                                        
                                                        <li class="nav-section-home navSectionSublinks navlist selectedLink" style="margin-left:25px;" >
                                                            <a href="javascript:changeContent('October_2022')" class="articleLink">Chronic Kidney Disease Is Prevalent Among Adults with Prediabetes or Undiagnosed Diabetes - October 2022.</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                      <%--  <div class="row" style="padding-bottom:2px">
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
                                        </div>--%>

                                    </div>
                                </div>
                            </div>

                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                            <%--Risk Factors – Food Insecurity--%>
                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                           <%-- <div class="card bar " style="padding-left:0px;">
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
                            </div>--%>

                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                            <%--Risk Factors – Hypertension--%>
                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                           <%-- <div class="card bar " style="padding-left:0px;">
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
                            </div>--%>

                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                            <%--Risk Factors – Obesity--%>
                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                          <%--  <div class="card bar " style="padding-left:0px;">
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
                            </div>--%>

                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                            <%--Risk Factors – Smoking--%>
                            <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
                            <%--<div class="card bar " style="padding-left:0px;">
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
                            </div>--%>

                        </div>
                      </div>
                    </div>
                
                    </div>

                    <%--AYA Side Nav List end--%>
                    <%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>

					<br />
					<div class="navSectionHeading ">						
						<span style="font-weight:600;" >Additional Resources </span><div style="height:7px;"></div>
						<div>
<%--							<div class="navARbottomline navARtopline"><a href="/Help.aspx?section=F" class="navARandGIlinks"  target="popup"  onclick="window.open('/help.aspx?section=F','popup','width=800,height=600'); return false;" >Frequently Asked Questions</a></div>--%>
<%--							<div class="navARbottomline"><a href="/data.aspx" class="navARandGIlinks" >Complete Indicators List</a></div>--%>
							<div class="navARbottomline"><a href="https://health.gov/healthypeople" class="navARandGIlinks">Healthy People &nbsp;</a>
                                <%--<img class="HealthyPeopleImg" src="../../images/DataCharts/HPArrow.jpg" />--%>
							</div>
							<div class="navARbottomline"><a href="/Help.aspx?section=G" class="navARandGIlinks"  target="popup"  onclick="window.open('/help.aspx?section=G','popup','width=800,height=600'); return false;" >Glossary</a></div>	
							<div class="navARbottomline"><a href="/Help.aspx?section=D" class="navARandGIlinks" target="popup"  onclick="window.open('/help.aspx?section=D','popup','width=800,height=600'); return false;">Data Sources</a></div>
						</div>							

					</div>
					<br />
					<div class="navSectionHeading ">						
						<span style="font-weight:600;" >General Information </span><br />
						<div style="padding-top:10px";>
							<a href="/Documents/Chronic-Kidney-Disease-in-the-US-2021-h.pdf" class="navARandGIlinks" style= "padding-left:1px !important;" alt="Download CKD Fact Sheet" download>
                                <img class="downloadImg" src="../../images/DataCharts/DownloadCyan.jpg" alt="Download CKD Fact Sheet" />
                                <span class="navARandGIlinks">Download CKD Fact Sheet</span>
                            </a>
						</div>
					</div>				
			</nav>
    <%--</main>--%>
    <%--  TODO: uncomment --%>
	</div>	

<br /><br />      


<asp:HiddenField ID="HF_TopicText" runat="server" />

<script type="text/javascript">
    $(document).ready(function () {
        // Add minus icon for collapse element which is open by default
        $(".collapse.show").each(function () {
            $(this)
                .prev(".card-header")
                .find(".fi")
                .addClass("cdc-icon-minus")
                .removeClass("cdc-icon-plus");
        });

        // Toggle plus minus icon on show hide of collapse element
        $(".collapse")
            .on("show.bs.collapse", function () {
                $(this)
                    .prev(".card-header")
                    .find(".fi")
                    .removeClass("cdc-icon-plus")
                    .addClass("cdc-icon-minus");
            })
            .on("hide.bs.collapse", function () {
                $(this)
                    .prev(".card-header")
                    .find(".fi")
                    .removeClass("cdc-icon-minus")
                    .addClass("cdc-icon-plus");
            });
    });

   

    //$(document).ready(function () {

    //    //Ensure images are same size
    //    equalizeImageSizes();

    //    //navigate to the topic home pages on click
    //    handleTopicHomeMouseEventsAndNav();

    //    //Names, spaces and Selections
    //    handleSelectionFormatting();

    //    //Only show topic images on home page        
    //    hideTopicButtonsIfNecessary();

    //    //IE11 needs special attention
    //    handleIE11();

    //    //If there is a selected Indicator...
    //    selectTopicButton();

    //    //If they resize the page - ensure the images are equally sized
    //    window.addEventListener("resize", equalizeImageSizes);
    //});



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
            case 'sd':
                answer += 'SocialDeterminantsOfHealth.aspx';
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
                case 'ddmSocialDeterminants':
                    $('#dropdownMenuButton_SocialDeterminants').addClass('selectedTopic');
                    break;
            }
        }
    }

    function equalizeImageSizes() {

        $('#imgPI').height($('#imgHC').height()).width($('#imgHC').width());
        $('#imgAW').height($('#imgHC').height()).width($('#imgHC').width());
    }

    function showHideMenu(showHide, topic) {

        //TODO - Put back in the fades and handle timing problem of vigorous mouse activity
        if (topic == 'pi') {
            if (showHide === 's') {
                $('#ddmPrevalenceAndIncidence').show();//.fadeIn(300);
            } else {
                $('#ddmPrevalenceAndIncidence').hide();
            }
        } else {
            $('#ddmPrevalenceAndIncidence').hide();
        }


        if (topic === 'aw') {
            if (showHide === 's') {
                $('#ddmAwareness').show();//.fadeIn(300);
            } else {
                $('#ddmAwareness').hide();
            }
        } else {
            $('#ddmAwareness').hide();
        }


        if (topic === 'rf') {
            if (showHide === 's') {
                $('#ddmBurden').show();//.fadeIn(300);
            } else {
                $('#ddmBurden').hide();
            }
        } else {
            $('#ddmBurden').hide();
        }


        if (topic === 'hc') {
            if (showHide === 's') {
                $('#ddmConsequences').show();//.fadeIn(300);
            } else {
                $('#ddmConsequences').hide();
            }
        } else {
            $('#ddmConsequences').hide();
        }


        if (topic === 'qc') {
            if (showHide === 's') {
                $('#ddmQuality').show();//.fadeIn(300);
            } else {
                $('#ddmQuality').hide();
            }
        } else {
            $('#ddmQuality').hide();
        }


        if (topic === 'hsc') {
            if (showHide === 's') {
                $('#ddmCapacity').show();//.fadeIn(300);
            } else {
                $('#ddmCapacity').hide();
            }
        } else {
            $('#ddmCapacity').hide();
        }

        if (topic === 'sd') {
            if (showHide === 's') {
                $('#ddmSocialDeterminants').show();//.fadeIn(300);
            } else {
                $('#ddmSocialDeterminants').hide();
            }
        } else {
            $('#ddmSocialDeterminants').hide();
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
