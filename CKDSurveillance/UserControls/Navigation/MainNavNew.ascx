<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MainNavNew.ascx.cs" Inherits="CKDSurveillance_RD.MainNavNew" %>
<%--<%@ OutputCache Duration="86400" VaryByParam="none"%>--%>

<div id="navbarSupportedContent" style="background-color:#2B8277" class="showPhoneOnly navbar-collapse overlay collapse ">
	<div class="container overlay-content" id="cdc-meganav-bar"  style="display:block !important;background-color:#2B8277" data-title="CKD Menu">
		<nav class="navbar navbar-expand-xl yamm tmp-meganav-bar">
			<ul class="nav navbar-nav nav-justified w-100">
				<li class="nav-item nav-home" id="ckd-nav-home">
					<a href="/default.aspx" class="nav-link" style="border-top:#2B8277" id="ckd-nav-home-link">
						<span class="x24 cdc-icon-home-lg-alt-light"></span>
						Home
					</a>
				</li>
				<li class="nav-item dropdown">
						<a class="nav-link" data-menu-id="2091" href="/TopicHome/PrevalenceIncidence.aspx?topic=1" style="border-top:#2B8277">
							Prevalence & Incidence</a>
				</li>
                <li class="nav-item dropdown">
						<a class="nav-link" data-menu-id="2091" href="/TopicHome/Awareness.aspx?topic=3" style="border-top:#2B8277">
							Awareness</a>
				</li>
				<li class="nav-item dropdown">
						<a class="nav-link" data-menu-id="4591" href="/TopicHome/BurdenOfRiskFactors.aspx?topic=4" style="border-top:#2B8277">
						Risk Factors</a>
				</li>
				<li class="nav-item dropdown" id="meganav-col-cases-data">
						<a class="nav-link" data-menu-id="2797" href="/TopicHome/HealthConsequences.aspx?topic=5" style="border-top:#2B8277">
							Outcomes</a>
				</li>
				<li class="nav-item dropdown">
						<a class="nav-link" data-menu-id="2093" href="/TopicHome/QualityOfCare.aspx?topic=6" style="border-top:#2B8277" >
							Quality of Care</a>
				</li>
				<li class="nav-item dropdown">
						<a class="nav-link" data-menu-id="2095" href="/TopicHome/SocialDeterminantsOfHealth.aspx?topic=24" style="border-top:#2B8277">
							Social Determinants</a>
				</li>
			</ul>
		</nav>
	</div>
</div>

<div id="navbarSupportedContent" style="background-color:#2B8277" class="phoneNoShow">
	<div class="container" id="cdc-meganav-bar"  style="display:block !important;background-color:#2B8277" data-title="CKD Menu">
		<nav class="navbar navbar-expand-xl yamm tmp-meganav-bar">
			<ul class="nav navbar-nav nav-justified w-100">
				<li class="nav-item nav-home" id="ckd-nav-home">
					<a href="/default.aspx" class="nav-link" style="border-top:#2B8277" id="ckd-nav-home-link">
						<span class="x24 cdc-icon-home-lg-alt-light"></span>
						Home
					</a>
				</li>
				<li class="nav-item dropdown">
						<a class="nav-link" data-menu-id="2091" href="/TopicHome/PrevalenceIncidence.aspx?topic=1" style="border-top:#2B8277"  id="nav-PI">
							Prevalence & Incidence</a>
				</li>
                <li class="nav-item dropdown">
						<a class="nav-link" data-menu-id="2091" href="/TopicHome/Awareness.aspx?topic=3" style="border-top:#2B8277"  id="nav-AR">
							Awareness</a>
				</li>
				<li class="nav-item dropdown">
						<a class="nav-link" data-menu-id="4591" href="/TopicHome/BurdenOfRiskFactors.aspx?topic=4" style="border-top:#2B8277" id="nav-RF">
						Risk Factors</a>
				</li>
				<li class="nav-item dropdown" id="meganav-col-cases-data">
						<a class="nav-link" data-menu-id="2797" href="/TopicHome/HealthConsequences.aspx?topic=5" style="border-top:#2B8277" id="nav-HC">
							Outcomes</a>
				</li>
				<li class="nav-item dropdown">
						<a class="nav-link" data-menu-id="2093" href="/TopicHome/QualityOfCare.aspx?topic=6" style="border-top:#2B8277" id="nav-QC">
							Quality of Care</a>
				</li>
				<li class="nav-item dropdown">
						<a class="nav-link" data-menu-id="2095" href="/TopicHome/SocialDeterminantsOfHealth.aspx?topic=24" style="border-top:#2B8277" id="nav-SDOH">
							Social Determinants</a>
				</li>
			</ul>
		</nav>
	</div>
</div>


<script>
	$(document).ready(function () {
		var topic = getParameterByName('topic'); 
		if (topic == 1) {
            var a = document.getElementById("nav-PI");
			a.classList.add("active");
        } else if (topic == 3) {
			var a = document.getElementById("nav-AR");
            a.classList.add("active");
        } else if (topic == 4) {
            var a = document.getElementById("nav-RF");
            a.classList.add("active");
        }else if (topic == 5) {
            var a = document.getElementById("nav-HC");
            a.classList.add("active");
        } else if (topic == 6) {
            var a = document.getElementById("nav-QC");
            a.classList.add("active");
        } else if (topic == 24) {
            var a = document.getElementById("nav-SDOH");
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
