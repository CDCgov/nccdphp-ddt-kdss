<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainNavNew.ascx.cs" Inherits="CKDSurveillance_RD.MainNavNew" %>
<%--<%@ OutputCache Duration="86400" VaryByParam="none"%>--%>

<style type="text/css">
:root {
  --bs-btn-active-color: #000000;
  --bs-btn-active-bg:#ffffff;
  --bs-btn-active-border-color:#ffffff;
  --colors-blue-cool-vivid-5:#f6fbff;
  --bs-btn-hover-color:#ffffff;
  --bs-btn-hover-bg:var(--colors-blue-dark);
}
.mainNavMenu {
    width: 85%;
    justify-content: center;
    font-size:large;
	justify-content: center;
}
.btn:hover {
  /*background: var(--colors-blue-dark);*/
  background-color: var(--colors-cdc-blue);
  color:#ffffff;
}
</style>
<div id="navbarSupportedContentMobile" style="background: linear-gradient(to right, #4c2b64, #0061a2, #0081a1);" class="showPhoneOnly navbar-collapse overlay collapse ">
	<div class="container overlay-content" id="cdc-meganav-bar"  style="display:block !important;background:linear-gradient(to right, #4c2b64, #0061a2, #0081a1)" data-title="CKD Menu">
		<nav class="navbar navbar-expand-xl yamm tmp-meganav-bar">
			<ul class="nav navbar-nav nav-justified w-100">
				<li class="nav-item nav-home ckd-nav-home">
					<a href="<%=ConfigurationManager.AppSettings["DirPath"]%>default.aspx" class="nav-link ckd-nav-home-link" id="ckd-nav-home-link4">
						<span class="cdc-fa-house x24 cdc-icon-home-lg-alt-light"></span>
						Home
					</a>
				</li>
				<li class="nav-item dropdown">
						<a class="nav-link bodybreadcrumb" data-menu-id="2091" href="<%=ConfigurationManager.AppSettings["DirPath"]%>TopicHome/PrevalenceIncidence.aspx?topic=1">
							Prevalence & Incidence </a>
				</li>
                <li class="nav-item dropdown">
						<a class="nav-link bodybreadcrumb" data-menu-id="2091" href="<%=ConfigurationManager.AppSettings["DirPath"]%>TopicHome/Awareness.aspx?topic=3">
							Awareness</a>
				</li>
				<li class="nav-item dropdown">
						<a class="nav-link bodybreadcrumb" data-menu-id="4591" href="<%=ConfigurationManager.AppSettings["DirPath"]%>TopicHome/BurdenOfRiskFactors.aspx?topic=4" >
						Risk Factors</a>
				</li>
				<li class="nav-item dropdown">
						<a class="nav-link bodybreadcrumb" data-menu-id="2797" href="<%=ConfigurationManager.AppSettings["DirPath"]%>TopicHome/HealthConsequences.aspx?topic=5" >
							Outcomes</a>
				</li>
				<li class="nav-item dropdown">
						<a class="nav-link bodybreadcrumb" data-menu-id="2093" href="<%=ConfigurationManager.AppSettings["DirPath"]%>TopicHome/QualityOfCare.aspx?topic=6" >
							Quality of Care</a>
				</li>
				<li class="nav-item dropdown">
						<a class="nav-link bodybreadcrumb" data-menu-id="2095" href="<%=ConfigurationManager.AppSettings["DirPath"]%>TopicHome/SocialDeterminantsOfHealth.aspx?topic=24" >
							Social Determinants</a>
				</li>
			</ul>
		</nav>
	</div>
</div>

<div id="navbarSupportedContent"  class="phoneNoShow" style="background:linear-gradient(to right, #4c2b64, #0061a2, #0081a1);">
	<div class="container" id="cdc-meganav-bar"  style="display:block !important;background:none;padding-left:0; padding-right:0; margin-top:0%;" data-title="CKD Menu">
		<nav class="navbar navbar-expand-xl yamm tmp-meganav-bar" style="justify-content: center">
			<ul class="nav navbar-nav nav-justified w-100">
				<li class="nav-item" style="border:0px !important;">
					<a href="<%=ConfigurationManager.AppSettings["DirPath"]%>default.aspx" class="btn btn-outline-white mainNavMenu" id="ckd-nav-home-link5">
						<span class="cdc-fa-house x24 cdc-icon-home-lg-alt-light"></span> &nbsp;
						Home
					</a>
				</li>
				<li class="nav-item dropdown" style="border:0px !important;">
						<a class="btn btn-outline-white mainNavMenu" data-menu-id="2091" href="<%=ConfigurationManager.AppSettings["DirPath"]%>TopicHome/PrevalenceIncidence.aspx?topic=1" id="nav-PI">
							Prevalence & Incidence</a>
				</li>
                <li class="nav-item dropdown" style="border:0px !important;">
						<a class="btn btn-outline-white mainNavMenu" data-menu-id="2091" href="<%=ConfigurationManager.AppSettings["DirPath"]%>TopicHome/Awareness.aspx?topic=3" id="nav-AR">
							Awareness</a>
				</li>
				<li class="nav-item dropdown" style="border:0px !important;">
						<a class="btn btn-outline-white mainNavMenu" data-menu-id="4591" href="<%=ConfigurationManager.AppSettings["DirPath"]%>TopicHome/BurdenOfRiskFactors.aspx?topic=4" id="nav-RF">
						Risk Factors</a>
				</li>
				<li class="nav-item dropdown" style="border:0px !important;">
						<a class="btn btn-outline-white mainNavMenu" data-menu-id="2797" href="<%=ConfigurationManager.AppSettings["DirPath"]%>TopicHome/HealthConsequences.aspx?topic=5"id="nav-HC">
							Outcomes</a>
				</li>
				<li class="nav-item dropdown" style="border:0px !important;">
						<a class="btn btn-outline-white mainNavMenu" data-menu-id="2093" href="<%=ConfigurationManager.AppSettings["DirPath"]%>TopicHome/QualityOfCare.aspx?topic=6" id="nav-QC">
							Quality of Care</a>
				</li>
				<li class="nav-item dropdown" style="border:0px !important;">
						<a class="btn btn-outline-white mainNavMenu" data-menu-id="2095" href="<%=ConfigurationManager.AppSettings["DirPath"]%>TopicHome/SocialDeterminantsOfHealth.aspx?topic=24" id="nav-SDOH">
							Social Determinants</a>
				</li>
			</ul>
		</nav>
	</div>
</div>


<script>
	$(document).ready(function () {
		var topic = getParameterByName('topic'); 
		var qnum = getParameterByName('Qnum');

		if (qnum == null) qnum = ""; 

		if (topic == 1 || qnum.toUpperCase() == "Q372"
			|| qnum.toUpperCase().replace("Q", "").replace("S", "") == "9"
			|| qnum.toUpperCase() == "Q702"
			|| qnum.toUpperCase() == "Q756"
			|| qnum.toUpperCase() == "Q705") {
			var a = document.getElementById("nav-PI");
			a.classList.add("active");
		} else if (topic == 3 || qnum.toUpperCase() == "Q98" || qnum.toUpperCase() == "Q759") {
			var a = document.getElementById("nav-AR");
			a.classList.add("active");
		} else if (topic == 4 || qnum.toUpperCase() == "Q762" || qnum.toUpperCase() == "Q763" || qnum.toUpperCase() == "Q764") {
			var a = document.getElementById("nav-RF");
			a.classList.add("active");
		} else if (topic == 5 || qnum.toUpperCase() == "Q185" || qnum.toUpperCase() == "Q364" || qnum.toUpperCase() == "Q703") {
			var a = document.getElementById("nav-HC");
			a.classList.add("active");
		} else if (topic == 6 || qnum.toUpperCase() == "Q640"
			|| qnum.toUpperCase() == "Q700"
			|| qnum.toUpperCase() == "Q605"
			|| qnum.toUpperCase() == "Q719") {
			var a = document.getElementById("nav-QC");
			a.classList.add("active");
		} else if (topic == 24 || qnum.toUpperCase() == "Q760" || qnum.toUpperCase() == "Q761" || qnum.toUpperCase() == "Q783") {
			var a = document.getElementById("nav-SDOH");
			a.classList.add("active");
		} else {
            var a = document.getElementById("ckd-nav-home-link5");
            a.classList.add("active");
		}
	});
    function getParameterByName(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, '\\$&');
        var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, ' '));
    }

</script>
