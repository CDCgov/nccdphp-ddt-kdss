<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TopicHomeContent.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.TopicHomeContent" %>
<%@ Register Src="~/UserControls/Navigation/SideNav.ascx" TagPrefix="uc1" TagName="SideNav" %>


<%--*Plotly Charting Tool*--%>
    <script src="../scripts/plotly-latest.min.js"></script>

<style>
    #hovertooltip {
            display:none;
            background-color: #fff;
            border-radius: 10px;
            /*-moz-border-radius: 10px;
            -webkit-border-radius: 10px;
            -khtml-border-radius: 10px;
            
            -webkit-box-shadow: 3px 3px 3px 3px rgba(0, 0, 0, 0.2);
            box-shadow: 3px 3px 3px 3px rgba(0, 0, 0, 0.2);*/
            padding:2px;
            border: 2px solid #BBB;
            max-width:300px;
            /*height:30px;*/
            color: #333;
            position:absolute;
            z-index:10002;
        } 

     .THPMeasure {
            padding: 2px 2px 2px 4px;
            font-size:16px;
            color: #000;/*#1a7aa2;*/
            /*font-weight:bold;*/
        }

        .THPTitle {
            padding: 10px 2px 10px 2px;
            border-radius:5px;
            text-align:center;
            font-size:28px;
            font-style:italic;
            font-weight:bold;
            /*background-color:#9dc3e6;
            color: #FFF;*/
            background-color:#c5ded6;
            color:#1a7aa2;
        }

        .THPSubDesc {
            background-color:#deebf7;
            border: 1px solid #1a7aa2;
            padding: 4px 10px 4px 10px ;
            border-bottom-left-radius: 5px;
            border-top-left-radius: 5px;
            border-bottom-right-radius: 5px;
            border-top-right-radius: 5px;*/
        }


		.PIbodyTitle{
			/*font: normal normal 600 38px/42px Open Sans;*/
			text-align: left;
			font-family: Open Sans;
			font-size:38px;
			letter-spacing: -0.38px;
			color: #29434E;
			opacity: 1;
		}
		.PIbody{
			/*font: normal normal normal 17px/24px Open Sans;*/
			text-align: left;
			font-family: Open Sans;
			font-size:17px;
			letter-spacing: 0px;
			color: #000000;
			opacity: 1;
		}
		.PIhomebreadcrumb{
			/*font: normal normal normal 14px/24px Open Sans;*/
			text-align: left;
			text-decoration: underline;			
			letter-spacing: 0px;
			color: #005EAA;
			font-family: Open Sans;
			font-size:14px;
		}
		.PIbodybreadcrumb{
			/*font: normal normal normal 14px/24px Open Sans;*/
			text-align: left;			
			font-family: Open Sans;
			font-size:14px;
			letter-spacing: 0px;
			color: #000000;
		}		
		.PInavHeader{   /*Prevalence & Incidence*/
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
			border-color:#006778; /*0% 0% no-repeat padding-box;*/
			border-bottom: 1px dashed #e0e0e0;
		}
		.PInavSectionLinks{
			/*font: normal normal normal 17px/20px Open Sans;*/
			text-align: left;			
			font-family: Open Sans;
			font-size:17px;
			letter-spacing: 0px;
			color: #000000;
			opacity: 1;			
			/*background: #006778 0% 0% no-repeat padding-box;*/
			/*border-left: 4px solid;
			border-color:#006778; */
		}
		.PInavSectionLinkSelected{
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
		.PInavSectionSublinks{
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
			margin-bottom: 0px !important;
		}

		/*Additional Resources and General Information*/
		.PInavSectionHeading{
			text-align: left;
			/*font: normal normal 600 21px/34px Open Sans;*/
			font-family: Open Sans;
			font-size:21px;
			letter-spacing: -0.21px;
			color: #242424;
			text-transform: capitalize;
			opacity: 1;			
		}

		.PInavARandGIlinks{
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
		.PInavARbottomline{
			padding: 10px 8px;
			border-left: 4px solid #fff;
			border-bottom: 1px dashed #e0e0e0;
		}
		.PInavARtopline{
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
		}

		.div-table {
		  display: table;         
		  border-spacing: 5px; 
		}

		.div-table-row {
		  display: table-row;
		  /*border: 1px solid red; */
		  /*clear: both;*/		   
		}

		.div-table-col {
		  float: left; 
		  display: grid;   
		  margin-right:5%;
		  
		   /*columns: 2; 
		   -webkit-columns:2; 
		   -moz-columns: 2;*/	
		   /*column-gap:30px;*/
		   /* border: 1px solid orange;   */
		}
		.div-table-col-width {
			width:40%;
		}
	.dateformat {
             text-align: left;
             /*font: normal normal bold 17px/24px Open Sans;*/
             text-align: left;
             font-family: Open Sans !important;
             font-size: 14px !important;
             font-weight: bold;
             letter-spacing: 0px;
             color: #747474;
             opacity: 1;
    }

	.ayaTitle {
		text-align: left;
		font-family: Open Sans;
		letter-spacing: -0.22px;
		color: #000000;
		opacity: 1;
	}
    .areYouAwareMsg {        
        font: normal normal normal 18px/25px Open Sans;
        opacity: 1;
        padding-top: 65px;
        padding-bottom: 25px;
        padding-left: 30px;
        padding-right: 10px;
        line-height: normal;
        margin-left: 0px;
		height:0%; width:40%
    }
	.ayatopimg {
		width:40%;
	}
	.vl {
	    border-left: 1px solid lightgray;
		height: 140px;
		margin-top: 30px;
		margin-left: 40px;
	    margin-right: 40px;
	}
	.ayatoprow {
		display: flex;
		flex-wrap: wrap;
		margin-right: -15px;
		margin-left: -15px;
	}

	@media screen and (max-width: 1200px) {
        .ayatoprow {
            display: block;
        }
		.vl {
			display:none;
		}
		.ayatopimg {
			width: 80%;
		}
		.areYouAwareMsg {
			width: 80%;
		}
    }
	/*	ul {
			 columns: 2;
			 -webkit-columns: 2;
			 -moz-columns: 2;
		   }*/
		
</style>


<!-- Page Content Wrap -->
	<div class="container d-flex flex-wrap body-wrapper bg-white">

			<!-- Content -->
			<main id="PImainbody"   class="col-xl-9 order-xl-2"  role="main" aria-label="Main Content Area">
					<div id="PIdivbody" class="row">
						<div  class="col content">										
							<div class="cdc-2020-bar container">
								<div class="row no-gutters">
									<div class="bar-item">
											<a href="../default.aspx"  style="border-top:#2B8277" id="ckd-nav-home-link7" class="ckd-nav-home-link">										
											<span class="PIhomebreadcrumb"><u>Home</u></span> </a> 
										    <span id="bcTopic" class="PIbodybreadcrumb" runat="server">  </span>  <%--selected topic from top nav --%>
											<span id="bcSelListItem" class="PIbodybreadcrumb">  </span>  <%--selected list item from left nav --%>
											<%--<span id="bcPIlinks" class="PIbodybreadcrumb">  > </span>--%>
									</div>
								</div>
							</div>
							 <div id="ayatop" class="ayatoprow" runat="server" visible="false">
								<div class="ayatopimg">
									<%--<img src="/ckd/images/AYA_theme_version_1.jpg" style="margin-left:15px;" alt=""/> <img src="/ckd/images/Mask_Group_33.png" style="margin-left:15px;" alt=""/>--%>
									<img src="../../images/AYA_theme_version.jpg" style="margin-left:0%; width:99%; margin-top:1%; margin-bottom:5% " alt=""/>
								</div>
								<div class="vl"></div>
								<div class ="areYouAwareMsg">
									<b><i>Are You Aware?&nbsp;</i></b> is designed to raise                                              
									awareness about important topics relevant to
									kidney disease surveillance and prevention.
								</div>
							</div>
							<div>
								<h1 id="content" class="PIbodyTitle "><span id="topicTitle"><asp:Literal ID="Lit_TopicTitle" runat="server"></asp:Literal></span> </h1>								
							</div>
							<p>                   
								<span class="PIbody"><asp:Literal ID="Lit_Desc" runat="server"></asp:Literal></span>
							</p>

                            <hr style="border: 1px solid #707070; opacity: 0.39;" runat="server" id="hrline"/>

							<div>
								<asp:Literal ID="Lit_IndicatorBody" runat="server" visible="true"></asp:Literal>
							</div>
						</div>	
					</div>
			</main>

			<!-- Left / Bottom Nav -->
			<div class="col-xl-3 order-xl-1 leftnav-wrapper">
				<nav role="navigation" aria-label="Left Navigation Menu" style="border-bottom-color:white">
					<div id="cdc-left-nav-menu-topichome" >
						<br />	
						<uc1:sidenav runat="server" id="SideNav" />
					</div>	
				</nav>
			</div>
	</div>

<br /><br />
   

	<%--*****************--%>

   <asp:Literal ID="Lit_IndicatorText" runat="server" visible="false"></asp:Literal>
   <%-- <asp:Literal ID="Lit_TopicTitle" runat="server"></asp:Literal>  --%>

    <div id="hovertooltip"><span class="hovertoolspan"></span></div>
      <asp:HiddenField ID="HF_SmallChart1Hover" runat="server" />
    <asp:HiddenField ID="HF_SmallChart2Hover" runat="server" />
        <asp:HiddenField ID="HF_SmallChart1URL" runat="server" />
    <asp:HiddenField ID="HF_SmallChart2URL" runat="server" />

    <asp:HiddenField ID="HF_HC_TopicText" runat="server" />
    <asp:HiddenField ID="hfShowCI" runat="server" Value="false" />
	<asp:HiddenField ID="HF_Topic" runat="server" />
 <script>

            $(document).ready(function () {


                //$("#skipchartlink").prop("style","");
                //$("#skipdatatablelink").prop("style","");
                //$("#skippagedetailslink").prop("style", "");

                ////fix for IE
                //$("#skipchartlink").attr("style", "");
                //$("#skipdatatablelink").attr("style", "");
                //$("#skippagedetailslink").attr("style", "");

               
				var topicBC = document.getElementById("topicTitle").innerText;

				if (topicBC == "") {
					topicBC =  document.getElementById("HF_Topic").value;
				}

                var topicTag = document.getElementById("bcTopic");
                topicTag.innerHTML = " > " + topicBC;
				
			});

     function navClick() {
        
         $(document).on('click', 'a', function () {
             var aID = this.id
             var aTitle = this.title
    
             var PItag = document.getElementById("bcSelListItem");
             PItag.innerHTML = " > " + aTitle;
            
         });
     };


            var document_href = document.location.href.toLowerCase();
            document_href = document_href.substring(0, document_href.indexOf("topichome"));
            console.log("dhref=" + document_href);
            console.log("chart url=" + $("#HF_ChartURL").val());
     

            $("#svgchart_small1").mousemove(function (event) {

                var left = event.pageX + 10;
                var top = event.pageY - 400;
                console.log("left=" + left + " - top=" + top + " - eventx=" + event.pageX + " - eventy=" + event.pageY);
                $("#hovertooltip").css({ top: top, left: left }).show();
                $(".hovertoolspan").text($("[id$=HF_SmallChart1Hover]").val());
                
            });
            $("#svgchart_small1").mouseout(function () { $("#hovertooltip").hide(); });
            $("#svgchart_small1").click(function () { window.location.href = document_href + $("[id$=HF_SmallChart1URL]").val() });

            $("#svgchart_small2").mousemove(function (event) {

                var left = event.pageX + 10;
                var top = event.pageY - 400;
                console.log("left=" + left + " - top=" + top + " - eventx=" + event.pageX + " - eventy=" + event.pageY);
                $("#hovertooltip").css({ top: top, left: left }).show();
                $(".hovertoolspan").text($("[id$=HF_SmallChart2Hover]").val());
                
            });
            $("#svgchart_small2").mouseout(function () { $("#hovertooltip").hide(); });
            $("#svgchart_small2").click(function () { window.location.href = document_href + $("[id$=HF_SmallChart2URL]").val() });

           
 </script>

    <style>
        #svgchart {
            cursor:pointer;
        }
        #svgchart_small1 {
            cursor:pointer;
        }
        #svgchart_small2 {
            cursor:pointer;
        }
        .hovertoolspan {
            padding:4px;
        }
    </style>
    

<script>
    $(".accordion .card.bar .card-title").on("keypress", function (a) { a.preventDefault() }), $(".accordion .card.bar .card-header:not(.ckd-accordion-subcat-header) .card-title").on("keyup", function (a) { 13 == a.which && $(this).click() }), $(".ckd-accordion-subcat-header .card-title").on("keyup", function (a) { "block" == $(this).parent().next().css("display") ? ($(this).parent().removeClass("collapsed"), $(this).parent().attr("aria-expanded", "true")) : ($(this).parent().addClass("collapsed"), $(this).parent().attr("aria-expanded", "false")) });
</script>