<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SpecialPopulations.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.SpecialPopulations" %>

<%--**************--%>
<%--*Special Pops*--%>
<%--**************--%>

<div class="row">
    <div class="col-12">
        <div class="card card-multi ds-5 border-0 mb-3 bg-gray-l3 ds-8">            
            <div class="card-title h4 mb text-left bt-4 bt-blue-p tighterCardHeader" style="padding-left: 10px;">Focus on Populations, Risk Factors</div>
            <div class="row" style="margin-left: 10px; margin-right: 10px; padding-top:10px;padding-bottom:10px;">
                <div class="pr-md-0 col-sm-2">
                    <img src="./images/SpecialPops2_Green.png" alt="Links To Resources On Special Populations In The CKD Surveillance Project" class="card-img-top img-fluid p-0 bg-gray-l3 tinyNounImage">
                </div>
                <div class="col-sm-10">
                    <span style="font-weight:bold;">Special Populations</span>
                    <br />
                    <a id="lnkIndicator" class="ckd-accordion-indicator" href="Data.aspx?CategoryID=8#refreshPosition">Children and Adolescents</a>,                                        
                        <a id="A1" class="ckd-accordion-indicator" href="Data.aspx?CategoryID=9#refreshPosition">Solid Organ Transplant Population</a>,    
                        <a id="A2" class="ckd-accordion-indicator" href="Data.aspx?CategoryID=14#refreshPosition">Native Americans</a>,  
                        <a id="A3" class="ckd-accordion-indicator" href="Data.aspx?CategoryID=16#refreshPosition">Polycystic Kidney Disease Population</a>
                    <br />
                    <br />
                    <span style="font-weight:bold;">CKD Risk Factors</span>
                    <br />
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