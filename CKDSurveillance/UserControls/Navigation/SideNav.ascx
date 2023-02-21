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
		color: #007C91;
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
                        <img src="../../images/KDLeftNavlogo.jpg" class="logoImg" alt="Kidney Disease Surveillance System logo" />
					</div>
					<br />
				
					<asp:Literal ID="Lit_IndicatorText" runat="server"></asp:Literal>
					<br />
					<div class="navSectionHeading ">						
						<span style="font-weight:600;" >Additional Resources </span><div style="height:7px;"></div>
						<div>

<%--							<div class="navARbottomline navARtopline"><a href="/Help.aspx?section=F" class="navARandGIlinks"  target="popup"  onclick="window.open('/help.aspx?section=F','popup','width=800,height=600'); return false;" >Frequently Asked Questions</a></div>
							<div class="navARbottomline"><a href="/data.aspx" class="navARandGIlinks" >Complete Indicators List</a></div>--%>
							<div class="navARbottomline"><a href="https://health.gov/healthypeople" class="navARandGIlinks">Healthy People &nbsp;</a>
                                <%--<img class="HealthyPeopleImg" src="../../images/DataCharts/HPArrow.jpg" />--%>
							</div>
							<div class="navARbottomline"><a href="/Help.aspx?section=G" class="navARandGIlinks"  target="popup"  onclick="window.open('/help.aspx?section=G','popup','width=800,height=600'); return false;" >Glossary</a></div>	

							<div class="navARbottomline"><a href="https://health.gov/healthypeople" class="navARandGIlinks">Healthy People &nbsp;</a></div>
							<div class="navARbottomline"><a href="/Help.aspx?section=G" class="navARandGIlinks"  target="popup"  onclick="window.open('/help.aspx?section=G','popup','width=800,height=600'); return false;" >Glossary</a></div>

							<div class="navARbottomline"><a href="/Help.aspx?section=D" class="navARandGIlinks" target="popup"  onclick="window.open('/help.aspx?section=D','popup','width=800,height=600'); return false;">Data Sources</a></div>
						</div>							

					</div>
					<br />
					<div class="navSectionHeading ">						
						<span style="font-weight:600;" >General Information </span>
						<div>
							<a href="/Documents/Chronic-Kidney-Disease-in-the-US-2021-h.pdf" class="navARandGIlinks" style= "padding-left:1px !important" alt="Download CKD Fact Sheet" download>
                                <img class="downloadImg" src="../../images/DataCharts/DownloadCyan.jpg" alt="Download CKD Fact Sheet" />
                                <span class="navARandGIlinks">Download CKD Fact Sheet</span>
                            </a>
						</div>

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
</script>
