<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CurrentTopics.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.CurrentTopics" %>

<%--****************--%>
<%--*Current Topics*--%>
<%--****************--%>
<div class="row">
    <div class="col-12">
        <div class="card card-multi ds-5 border-0 mb-3 bg-white ds-8">            
            <div class="card-title h4 mb text-left bt-4 bt-orange-p tighterCardHeader">Trending News | Emerging Topics</div>
            <div class="row" style="margin-right: 5px; margin-left: 5px; padding-top: 10px;">

                <%--***************--%>
                <%--*Trending News*--%>
                <%--***************--%>
                <div class="pr-md-0 col-sm-2">
                    <img src="./images/Newspaper.png" align="left" alt="Trending News" style="width: 48px; height: 48px; margin-right: 10px;" class="card-img-top img-fluid p-0">
                </div>
                <div class="col-sm-10">
                    <span style='font-weight: bold;'>Trending: Race and Kidney Disease:</span>
                    <br />

                    Interim Report from the NKF-ASN Task Force - published in 
                    <strong><a href="https://www3.kidney.org/e/219342/10-1681-ASN-2021010039/n83nsv/1252058817?h=97sLRLSdhqhuIq5eRyYDtLVGz4vFs6MGragAjmdRwdk" target="_blank">JASN</a></strong>
                    or 
                    <strong><a href="https://www.ajkd.org/article/S0272-6386(21)00506-0/fulltext" target="_blank">AJKD</a></strong>.
                    
                    <br />
                    <br />                    

                    <%--*****************--%>
                    <%--*Emerging Topics*--%>
                    <%--*****************--%>
                    <p>
                        <span style='font-weight: bold;'>Emerging Topics in CKD:</span>
                        <a href="data.aspx?CategoryID=22" target="_blank">APOL1, Cancer, Dietary Acid Load, Obesity and Periodontal Disease.</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
