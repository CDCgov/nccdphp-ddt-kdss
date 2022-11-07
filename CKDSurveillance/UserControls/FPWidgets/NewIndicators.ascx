<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewIndicators.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.NewIndicators" %>

<div class="card card-multi mb-3 border-0 ds-5">
    <div class="card-multi h6 bt-4 bt-blue-p mb-3 tighterCardHeader">New Indicators</div>
    <div class="card-body bg-white p-0">
        <div class="card">
            <div class="card-body bg-white p-0">
                <div class="row">
                    <div class="col-sm-12">
                        
                        <div style="padding-left:10px; padding-right:10px;padding-top:15px; padding-bottom:15px;">
                            New indicators of CKD have recently been added to the resources on this site
                        </div>

                        <ul class="mb-0 block-list" style="padding-right:10px;">
                            <li>
                                <%--<a class="list-title mb-1" href="detail.aspx?QNum=Q711&Strat=Year,%20Gender,%20Age">Age of Patients</a>--%>
                                 <a class="list-title mb-1" href="detail.aspx?QNum=Q711&Strat=Year,%20Gender,%20Age">Age (Medicaid)</a>
                            </li>
                            <li>
                                <%--<a class="list-title mb-1" href="detail.aspx?QNum=Q710&Strat=Year,%20Gender,%20Age">Percentage of Patients with a Diagnosis of Diabetes</a>--%>
                                <a class="list-title mb-1" href="detail.aspx?QNum=Q710&Strat=Year,%20Gender,%20Age">Diabetes (Medicaid)</a>
                            </li>
                            <li>
                                <%--<a class="list-title mb-1" href="detail.aspx?QNum=Q709&Strat=Year,%20Gender,%20Age">Percentage of Patients with a Diagnosis of Hypertension</a>--%>
                                <a class="list-title mb-1" href="detail.aspx?QNum=Q709&Strat=Year,%20Gender,%20Age">Hypertension (Medicaid)</a>
                            </li>
                            <li>

                                <%--<a class="list-title mb-1" href="detail.aspx?QNum=Q708&Strat=Race/Ethnicity,%20Age">Percentage of Patients by Race/Ethnicity</a>--%>
                                <a class="list-title mb-1" href="detail.aspx?QNum=Q708&Strat=Race/Ethnicity,%20Age">Race/Ethnicity (Medicaid)</a>

                            </li>
                            <li>
                                <%--<a class="list-title mb-1" href="detail.aspx?QNum=Q704&amp;Strat=Year,%20CKD%20Stage%20in%202018,%20CKD%20Stage%20in%202017" target="_blank">One-year Progression of CKD in U.S. Veterans</a>--%>
                                <a class="list-title mb-1" href="detail.aspx?QNum=Q704&amp;Strat=Year,%20CKD%20Stage%20in%202018,%20CKD%20Stage%20in%202017" target="_blank">Progression of CKD (VA)</a>
                            </li>
                            <li>
                                <%--<a class="list-title mb-1" href="detail.aspx?QNum=Q706&amp;Strat=Year,%20Diabetes,%20Age" target="_blank">Percentage of Patients with an ICD-9-CM or ICD-10-CM Code Indicating CKD</a>--%>
                                <a class="list-title mb-1" href="detail.aspx?QNum=Q706&amp;Strat=Year,%20Diabetes,%20Age" target="_blank">CKD Prevalence (Medicaid)</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="card-footer bt-0 pt-0 bg-white pl-0 pr-0 pull-right text-right">
                <div class="row">
                    <%--<div class="col-sm-6"></div>--%>
                    <div class="col-sm-11 float-right"><a href="data.aspx" class="btn btn-primary b-primary float-right">All Indicators</a></div>
                    <div class="col-sm-1"></div>
                </div>                
            </div>

            <br />
            <br />           
        </div>
    </div>
</div>


