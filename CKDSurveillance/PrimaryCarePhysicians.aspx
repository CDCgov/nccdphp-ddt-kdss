<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrimaryCarePhysicians.aspx.cs" Inherits="CKDSurveillance_RD.PrimaryCarePhysicians" MasterPageFile="~/MasterPages/ResponsiveContentLeftNavNew.Master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">

    <style>
        .PageDesc {
            background-color:#deebf7;
            border: 1px solid #1a7aa2;
            padding: 4px 10px 4px 10px ;
            border-bottom-left-radius: 5px;
            border-top-left-radius: 5px;
            border-bottom-right-radius: 5px;
            border-top-right-radius: 5px;*/
        }

    </style>
     <div class="row">
        <div class="col-xl-12">

            <div class="Pagetitle">Primary Care and Prevention Indicators</div>
            <br />
        </div>
    </div>
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <div class="PageDesc">                    
                Many patients with chronic kidney disease (CKD) are managed in the primary care setting. Current estimates of CKD awareness indicate that provider level awareness remains low.  Highlighting topics for primary care providers is vital for their work on risk factor modification to delay CKD progression and prevent complications.
            </div>
        </div>
        <div class="col-md-1"></div>
        
    </div>
    
     <div class='row'><br /><br /></div>
    <div class='row'>
        <div class="col-xl-3"></div>
        <div class="col-xl-6"><b><u>Prevalence</u></b></div>
        <div class="col-xl-3"></div>
    </div>
    <div class="row">
        <div class="col-xl-3"></div>
        <div class="col-xl-6">
            <ul>
	            <li><a href="detail.aspx?Qnum=Q8#refreshPosition">CKD Stages Among U.S. Adults, 1988-1994 vs. 1999-2006 vs. 2007-2014 vs. 2015-2016</a></li>
	        </ul>
        </div>
        <div class="col-xl-3"></div>
    </div>

    <div class='row'>
        <div class="col-xl-3"></div>
        <div class="col-xl-6"><b><u>Awareness</u></b></div>
        <div class="col-xl-3"></div>
    </div>
    <div class="row">
        <div class="col-xl-3"></div>
        <div class="col-xl-6">
            <ul>
	            <li><a href="detail.aspx?Qnum=Q98#refreshPosition">Awareness of CKD Among U.S. Adults with CKD Stage 3 or 4</a></li>
	            <li><a href="detail.aspx?Qnum=Q114#refreshPosition">Physicians' Reporting of Perceived CKD Risk Factors</a></li>
	            <li><a href="detail.aspx?Qnum=Q115#refreshPosition">Influencing Physicians Treatment of CKD by Guidelines</a></li>
	            <li><a href="detail.aspx?Qnum=Q268#refreshPosition">Correctly Identifying CKD and Recommending Referral to Nephrologist</a></li>
            </ul>
        </div>
        <div class="col-xl-3"></div>
    </div>

    <div class='row'>
        <div class="col-xl-3"></div>
        <div class="col-xl-6"><b><u>Burden Of Risk Factors</u></b></div>
        <div class="col-xl-3"></div>
    </div>
    <div class="row">
        <div class="col-xl-3"></div>
        <div class="col-xl-6">
            <ul>
	            <li><a href="detail.aspx?Qnum=Q135#refreshPosition">Hypertension Awareness, Treatment, And Control in U.S. Adults</a></li>
	            <li><a href="detail.aspx?Qnum=Q122&Strat=Awareness#refreshPosition">Diabetes Awareness, Treatment, And Control in U.S. Adults</a></li>
            </ul>
        </div>
        <div class="col-xl-3"></div>
    </div>

     <div class='row'>
        <div class="col-xl-3"></div>
        <div class="col-xl-6"><b><u>Quality of Care</u></b></div>
        <div class="col-xl-3"></div>
    </div>
    <div class="row">
        <div class="col-xl-3"></div>
        <div class="col-xl-6">
            <ul>
                <li><a href="detail.aspx?Qnum=Q700#refreshPosition">Prescribed NSAIDs Use Among U.S. Adults</a></li>
	            <li><a href="detail.aspx?Qnum=Q605#refreshPosition">ACE/ARB Use Among Veterans with CKD</a></li>
	            <li><a href="detail.aspx?Qnum=Q348#refreshPosition">Blood Pressure Treatment and Control Among Adults with CKD </a></li>
	            <li><a href="detail.aspx?Qnum=Q642#refreshPosition">Serum Creatinine Testing in U.S. Veterans</a></li>
	            <li><a href="detail.aspx?Qnum=Q640#refreshPosition">Albuminuria Testing Among U.S. Veterans</a></li>
	            <li><a href="detail.aspx?Qnum=Q602#refreshPosition">Serum Creatinine Testing Following Discharge Among Veterans with In-hospital AKI</a></li>
	            <li><a href="detail.aspx?Qnum=Q603#refreshPosition">Albuminuria Testing Following Discharge Among Veterans with In-hospital AKI</a></li>
            </ul>
        </div>
        <div class="col-xl-3"></div>
    </div>

    <div class='row'>
        <div class="col-xl-3"></div>
        <div class="col-xl-6"><b><u>Health Care System Capacity</u></b></div>
        <div class="col-xl-3"></div>
    </div>
    <div class="row">
        <div class="col-xl-3"></div>
        <div class="col-xl-6">
            <ul>
                <li><a href="detail.aspx?Qnum=Q237#refreshPosition">Primary Care Physicians by Specialty in the U.S.</a></li>
	            <li><a href="detail.aspx?Qnum=Q600#refreshPosition">Primary Care Physicians by U.S. State</a></li>
            </ul>
        </div>
        <div class="col-xl-3"></div>
    </div>

   
    <div class='row'>
        <div class="col-xl-3"></div>
        <div class="col-xl-6"><b><u>Prediction Tools</u></b></div>
        <div class="col-xl-3"></div>
    </div>
    <div class="row">
        <div class="col-xl-3"></div>
        <div class="col-xl-6">
            <ul>
                <li><a href="Calculators.aspx">Prediction and Progression Calculators</a></li>	
            </ul>
        </div>
        <div class="col-xl-3"></div>
    </div>
     <br /><br /><br />
</asp:Content>