<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FocusOnRiskFactors.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.FocusOnRiskFactors" %>

<%--***********************--%>
<%--*Focus on Risk Factors*--%>
<%--***********************--%>
<div class="card card-multi mb-3 ds-5 border-0 ">
    <div class="card-multi h6 bt-blue-p bt-4 mb-3 tighterCardHeader">Focus on CKD Risk Factors and Themes</div>
    <div class="card-body bg-white p-0">
        <div class="card">
            <div class="card-body bg-white">
                <div class="row">
                    <div class="pr-md-0 col-sm-2">
                        <img src="./images/RiskFactors_Blue.png" alt="Risk Factors and Themes of Chornic Kidney Disease" class="card-img-top img-fluid p-0 bg-white tinyNounImage">
                    </div>
                    <div class="col-sm-10">
                        <a id="hlFactors" href="FactorsOfInterest.aspx?type=Age">Age</a>,
                        <a id="A4" href="FactorsOfInterest.aspx?type=Diabetes">Diabetes</a>,                                    
                        <a id="A5" href="FactorsOfInterest.aspx?type=Hypertension">Hypertension</a>,
                        <a id="A6" href="FactorsOfInterest.aspx?type=Race/Ethnicity">Race/Ethnicity</a>,
                        <a id="A7" href="FactorsOfInterest.aspx?type=AKI">Acute Kidney Injury (AKI)</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
