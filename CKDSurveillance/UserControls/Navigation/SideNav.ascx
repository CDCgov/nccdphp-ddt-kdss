<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SideNav.ascx.cs" Inherits="CKDSurveillance_RD.SideNav" %>
<%--<%@ OutputCache Duration="86400" VaryByParam="none"%>--%>


<style type="text/css">
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
	.navBoldHeader{ 
		/*font: normal normal 600 17px/48px Open Sans;*/
		letter-spacing: 0px;			
		text-align:left;
		font-family: Open Sans, Semibold;
		font-weight:bold;
		font-size:17px;
		color: #00768A;
		opacity: 1;	
		background: #F5F5F5 0% 0% no-repeat padding-box;
		border-left: 4px solid;
		border-top:0px;
		border-color:#006778; /*0% 0% no-repeat padding-box;*/
		border-bottom: 1px dashed #e0e0e0;
	}
    .navNormalHeader{
		/*font: normal normal 600 17px/48px Open Sans;*/
		letter-spacing: 0px;			
		text-align:left;
		font-family: Open Sans, Semibold;
		font-weight:bold;
		font-size:17px;
		color: #000000;
		opacity: 1;	
		background: #FFFFFF 0% 0% no-repeat padding-box;
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
		border-top:0px;
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
		background: transparent url('/ckd/images/CKDLeftNavLogo.png') 0% 0% no-repeat padding-box;
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
        color: #00768A!important;
        opacity: 1;
        background: #F5F5F5 0% 0% no-repeat padding-box;
    }

	.nav-selected-header {
		text-align: left;
		font: normal normal 600 17px/20px Open Sans;
		letter-spacing: 0px;
		color: #000000;
		opacity: 1;
	}
</style>


<div class="container d-flex flex-wrap body-wrapper bg-white">
    

<asp:Literal ID="Lit_TopicTitle" runat="server"></asp:Literal>      

		<!-- Left / Bottom Nav -->
			<nav role="navigation" aria-label="Left Navigation Menu" style="border-bottom-color:white">
				<div id="cdc-left-nav-menu" >
					<div ><%--<img src="../../images/CKDLeftNavLogo.png" class="logoImg" />--%>
						<asp:HyperLink ID="hlLogo" runat="server" NavigateUrl="~/Default.aspx">
							<img src="/ckd/images/KDLeftNavlogo.jpg" class="logoImg" alt="Kidney Disease Surveillance System logo" />
						</asp:HyperLink>
					</div>
					<br />
				
					<asp:Literal ID="Lit_IndicatorText" runat="server"></asp:Literal>
					
					  
                    <div><%-- class="card-header nav-section-home navSectionLinks navlist"--%>
						<div id="divAYA" runat="server"  class="navBoldHeader nav-section-home d-sm-block" style="background:white !important;"  role="tabpanel"><%-- class="card-header nav-section-home navSectionLinks navlist"--%>
							Are You Aware Topics          
						</div>
						<div id="divAYARF" runat="server"><%--style="padding-left:1px;padding-right:1px;"--%>


							<%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
							<%--Prevalence--%>
							<%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
								<div class="accordion indicator-plus accordion-white" role="tabpanel">
									<div  style="padding-left:0px; background-color: none !important;" role="tablist"> <%-- class="card bar "--%>
										<div class="card-header collapsed nav-section-home navSectionLinks navlist" id="accordion-4i-card-20" data-target="#accordion-4i-collapse-20" data-toggle="collapse" role="tab" aria-expanded="false"  style="background-color: white !important;">
											<div class="card-title">
											<a id="Prevalence" title="Prevalence" style="display:inline; background-color: white !important; font-family:Open Sans !important; font-size:17px !important; font-weight:600;"  tabindex="0" data-controls="accordion-4i-collapse-20"> <%--class="card-title"--%>
											   <i class="fi cdc-icon-plus nav-plus"  style = "float: right; background-color: white !important;" id="navplusicon4"></i>Prevalence</a>
											</div>
										</div>
										<div aria-labelledby="accordion-4i-card-20" class="collapse" id="accordion-4i-collapse-20" role="tabpanel">
											<div >  <%--class="card body"--%>
												<div class="row" style="padding-bottom:2px">
													<div class="col-12" style="padding-left:20px;">
														<div id="link_August_2023"   data-parentid="20" >  <%--class="row articlelinkdiv"--%>
															<ul>                                                        
																<li class="nav-section-home navSectionSublinks navlist selectedLink" style="margin-left:25px;" >
																	<a href="javascript:changeContent('August_2023')" class="articleLink" style="color:#00768A !important">Chronic Kidney Disease Among Older Adults Varies Across US Counties - August 2023</a>
																</li>
															</ul>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
	

							<%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
							<%--Awareness--%>
							<%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
								<div id="div1" runat="server"><%--style="padding-left:1px;padding-right:1px;"--%>
								<div class="accordion indicator-plus accordion-white" role="tabpanel">
									<div  style="padding-left:0px; background-color: none !important;" role="tablist"> <%-- class="card bar "--%>
										<div class="card-header collapsed nav-section-home navSectionLinks navlist" id="accordion-4i-card-18" data-target="#accordion-4i-collapse-18" data-toggle="collapse" role="tab" aria-expanded="false"  style="background-color: white !important;">
											<div class="card-title">
											<a id="Awareness" title="Awareness" style="display:inline; background-color: white !important; font-family:Open Sans !important; font-size:17px !important; font-weight:600;"  tabindex="0" data-controls="accordion-4i-collapse-18"> <%--class="card-title"--%>
											   <i class="fi cdc-icon-plus nav-plus"  style = "float: right; background-color: white !important;" id="navplusicon2"></i>Awareness</a>
											</div>
										</div>
										<div aria-labelledby="accordion-4i-card-18" class="collapse" id="accordion-4i-collapse-18" role="tabpanel">
											<div >  <%--class="card body"--%>
												<div class="row" style="padding-bottom:2px">
													<div class="col-12" style="padding-left:20px;">
														<div id="link_April_2023"   data-parentid="18" >  <%--class="row articlelinkdiv"--%>
															<ul>                                                        
																<li class="nav-section-home navSectionSublinks navlist selectedLink" style="margin-left:25px;" >
																	<a href="javascript:changeContent('April_2023')" class="articleLink" style="color:#00768A !important">Awareness of Kidney Disease in the U.S. is Increasing, but Remains Low - April 2023</a>
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


							<%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
							<%--Risk Factors --%>
							<%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
								<div class="accordion indicator-plus accordion-white" role="tabpanel">
									<div  style="padding-left:0px; background-color: none !important;" role="tablist"> <%-- class="card bar "--%>
										<div class="card-header collapsed nav-section-home navSectionLinks navlist" id="accordion-4i-card-17" data-target="#accordion-4i-collapse-17" data-toggle="collapse" role="tab" aria-expanded="false"  style="background-color: white !important;">
											<div class="card-title">
											<a id="RiskFactorsDiabetes" title="Risk Factors" style="display:inline; background-color: white !important; font-family:Open Sans !important; font-size:17px !important; font-weight:600;"  tabindex="0" data-controls="accordion-4i-collapse-17"> <%--class="card-title"--%>
											   <i class="fi cdc-icon-plus nav-plus"  style = "float: right; background-color: white !important;" id="navplusicon1"></i>Risk Factors</a>
											</div>
										</div>
										<div aria-labelledby="accordion-4i-card-17" class="collapse" id="accordion-4i-collapse-17" role="tabpanel">
											<div >  <%--class="card body"--%>
												<div class="row" style="padding-bottom:2px">
													<div class="col-12" style="padding-left:20px;">
														<div id="link_October_2022"   data-parentid="17" >  <%--class="row articlelinkdiv"--%>
															<ul>                                                        
																<li class="nav-section-home navSectionSublinks navlist selectedLink" style="margin-left:25px;" >
																	<a href="javascript:changeContent('October_2022')" class="articleLink" style="color:#00768A !important">Chronic Kidney Disease Is Prevalent Among Adults with Prediabetes or Undiagnosed Diabetes - October 2022</a>
																</li>
															</ul>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>

							<%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
							<%--Social Determinants --%>
							<%--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--%>
								<div class="accordion indicator-plus accordion-white" role="tabpanel">
									<div  style="padding-left:0px; background-color: none !important;" role="tablist"> <%-- class="card bar "--%>
										<div class="card-header collapsed nav-section-home navSectionLinks navlist" id="accordion-4i-card-19" data-target="#accordion-4i-collapse-19" data-toggle="collapse" role="tab" aria-expanded="false"  style="background-color: white !important;">
											<div class="card-title">
											<a id="SocialDeterminants" title="Social Determinants" style="display:inline; background-color: white !important; font-family:Open Sans !important; font-size:17px !important; font-weight:600;"  tabindex="0" data-controls="accordion-4i-collapse-19"> <%--class="card-title"--%>
											   <i class="fi cdc-icon-plus nav-plus"  style = "float: right; background-color: white !important;" id="navplusicon3"></i>Social Determinants</a>
											</div>
										</div>
										<div aria-labelledby="accordion-4i-card-19" class="collapse" id="accordion-4i-collapse-19" role="tabpanel">
											<div >  <%--class="card body"--%>
												<div class="row" style="padding-bottom:2px">

													<div class="col-12" style="padding-left:20px;">
														<div id="link_October_2023" data-parentid="19" >  <%--class="row articlelinkdiv"--%>
															<ul>                                                        
																<li class="nav-section-home navSectionSublinks navlist selectedLink" style="margin-left:25px;" >
																	<a href="javascript:changeContent('October_2023')" class="articleLink" style="color:#00768A !important">Rising Household Food Insecurity Among Adults With Chronic Kidney Disease in the United States - October 2023</a>
																</li>
															</ul>
														</div>
													</div>

													<div class="col-12" style="padding-left:20px;">
														<div id="link_June_2023" data-parentid="19" >  <%--class="row articlelinkdiv"--%>
															<ul>                                                        
																<li class="nav-section-home navSectionSublinks navlist selectedLink" style="margin-left:25px;" >
																	<a href="javascript:changeContent('June_2023')" class="articleLink" style="color:#00768A !important">Revealing Geographic Patterns: Mapping Poverty and Chronic Kidney Disease in the United States - June 2023</a>
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

					<br />
                
					<div id="divARandGI" runat="server">
					<div class="navSectionHeading ">						
						<span style="font-weight:600;" >Additional Resources </span><div style="height:7px;"></div>
						<div><div>
							<div class="navARbottomline"><a href="<%=ConfigurationManager.AppSettings["DirPath"]%>data.aspx?categoryID=67" <%--href="https://health.gov/healthypeople"--%> class="navARandGIlinks">Healthy People &nbsp;</a></div>
							<div class="navARbottomline"><a href="<%=ConfigurationManager.AppSettings["DirPath"]%>Help.aspx?section=G" class="navARandGIlinks"  target="popup"  onclick="window.open('<%=ConfigurationManager.AppSettings["DirPath"]%>help.aspx?section=G','popup','width=800,height=600'); return false;" >Glossary</a></div>
							<div class="navARbottomline"><a href="<%=ConfigurationManager.AppSettings["DirPath"]%>Help.aspx?section=D" class="navARandGIlinks" target="popup"  onclick="window.open('<%=ConfigurationManager.AppSettings["DirPath"]%>help.aspx?section=D','popup','width=800,height=600'); return false;">Data Sources</a></div>
						</div>
						</div>							

					</div>
					<br />
					<div class="navSectionHeading ">						
						<span style="font-weight:600;line-height:normal!important" >General Information </span>
						<div>
							<a href="<%=ConfigurationManager.AppSettings["DirPath"]%>Documents/CKD_FactSheet_2023.pdf" class="navARandGIlinks" style= "padding-left:1px !important" alt="Download CKD Fact Sheet" download>
                                <img class="downloadImg" src="/ckd/images/DataCharts/DownloadCyan.jpg" alt="Download CKD Fact Sheet" role="presentation"/>
                                <span class="navARandGIlinks">Download CKD Fact Sheet</span>
                            </a>
						</div>
						</div>	
					</div>

				</div>
			</nav>
    <%--</main>--%>
    <%--  TODO: uncomment --%>
	</div>

<br /><br />      


<asp:HiddenField ID="HF_SN_TopicText" runat="server" />

<script type="text/javascript">
	$(document).ready(function () {
        $('.card-title').bind('keypress', function (e) {
			if (e.keyCode == 13) {
				if ($(this).parent().hasClass("collapsed")) {
					$(this).parent().removeClass("collapsed");
					$(this).parent().attr("aria-expanded", "true");
					$(this).parent().next().addClass("show");
                    $(this).parent()
                        .find(".fi")
                        .addClass("cdc-icon-minus")
                        .removeClass("cdc-icon-plus");
				} else {
                    $(this).parent().addClass("collapsed");
                    $(this).parent().attr("aria-expanded", "false");
					$(this).parent().next().removeClass("show");
                    $(this).parent()
                        .find(".fi")
                        .addClass("cdc-icon-plus")
                        .removeClass("cdc-icon-minus");
				}
            }
		});

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

</script>
