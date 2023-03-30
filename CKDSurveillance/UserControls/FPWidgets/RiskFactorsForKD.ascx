<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RiskFactorsForKD.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.RiskFactorsForKD" %>

<%--<link href="App_Themes/bootstrap.min.css" rel="stylesheet" />   --%>    

<style type="text/css">

    .rfkd-left-margin {
        /*background: transparent linear-gradient(290deg, #007C91 0%, #00695C 100%) 0% 0% no-repeat padding-box;*/
        opacity: 0.9;
        padding-left:0px !important;
        padding-right:0px !important;
    }
    .rfkd-right-margin {
       /* background: transparent linear-gradient(290deg, #007C91 0%, #00695C 100%) 0% 0% no-repeat padding-box;*/
        opacity: 0.9;
        padding-left:0px !important;
        padding-right:0px !important;
    }
    .rfkd-center-content { 
        /*background: transparent linear-gradient(299deg, #007C91 0%, #00695C 100%) 0% 0% no-repeat padding-box;
        opacity: 1;
       */
     padding-top: 150px;
     padding-bottom:20px;
     padding-left:55px;
    }
    .rfkd-center-content:nth-child(1) { 
        margin-right:20px;
    }
    
    .rfkd-title1 {  /*Risk Factors*/
        text-align: left;
        font: normal normal 600 30px/34px Open Sans;
        letter-spacing: -0.6px;
        color: #FCCF7D;
    }
    .rfkd-title2 { /*for Kidney Disease*/
        text-align: left;
        font: normal normal 600 30px/34px Open Sans;
        letter-spacing: -0.6px;
        color: #FFFFFF;
    }

    .rfkd-text {
        text-align: left;
        font: normal normal 300 18px/24px Open Sans;
        letter-spacing: 0px;
        color: #FFFFFF;
        opacity: 1;
        padding-top:30px;
    }

    .rfkd-button {
        background: #FBAB18 0% 0% no-repeat padding-box;
        border-radius: 5px;
        opacity: 1;
        /*width: 164px;*/
        text-align: center;
        font: normal normal 600 17px/23px Open Sans;
        letter-spacing: 0px;
        color: #29434E;
        opacity: 1;
        padding:5px;
        text-decoration: none;
    }
    .rfkd-image {
        background: transparent url('./images/DataCharts/Diabetes_RiskFactorsOfKD.jpg') 0% 0% no-repeat padding-box;
        opacity: 1;        
        background-size:auto;
        width: 100%;
    }
    .rfkd-botton-box {
       padding-left:5px;
       padding-right:5px;
       width: 100%;
        height: 61px;
        background: #29434E 0% 0% no-repeat padding-box;
        opacity: 1;
    }
    .a-formatView {
         color: #29434E !important;
         background-color: transparent !important;
         text-decoration: none !important;
    }
    .a-formatDownload {
        color: #29434E !important;
        background-color: transparent !important;
        text-decoration: none !important;
        padding-left:20px;
        /*float: right;
        padding-right: 10px;*/
    }
    .rfkd-link-text {
        text-align: center;
        font: normal normal normal 18px/24px Open Sans;
        letter-spacing: 0px;
        color: #FFFFFF;
        opacity: 1;
        padding-left:3px;
        padding-right:3px;
        pointer-events: none;
        text-decoration:none;
    }
    .rfkd-img-rightarrow{
        height: 17px; 
        /*background: transparent url('img/Repeat Grid 23.png') 0% 0% no-repeat padding-box;*/
        opacity: 1;        
        padding-right:10px;
    }
    .rfkd-img-download {
        width: 29.25px;
        height: 29.25px;
        /*background: transparent url('img/Group 1776.png') 0% 0% no-repeat padding-box;*/
        opacity: 1;
        /*padding-left:10px;*/
    }
    .hideContent{
        display:none; 
    }
    .showContent{
        display:block; 
    }

    .accordionContent{
       /*height:120px;
        overflow: hidden;
        transition:all 0.4s ease-out;
        transform:scaleY(1);
        transform-origin:top;*/
    }
    .accordionTitle{
        display:flex;
        justify-content:space-between;
        align-items:center;
    }
    .accordionTitle, .accordionTitle h3{
        text-align: left;
        font: normal normal 600 17px/23px Open Sans;
        letter-spacing: 0px;
        color: #FFFFFF;
        text-transform: uppercase;
        opacity: 1;

        cursor:pointer;
        -moz-user-select:none;
        -webkit-user-select: none; 
        -ms-user-select: none;
        user-select: none;        
    }
    .accordionTitle h3{
        margin:0;
    }
    .accordionTitle + .accordionContent {
        display: none;
    }
    .accordionTitle.is-open + .accordionContent {
        display:block;
    }
    .accordionHr {
        border: 1px dashed #C1C1C1;
        opacity: 0.47; /*0.87;*/
        background: transparent linear-gradient(299deg, #007C91 0%, #00695C 100%) 0% 0% no-repeat padding-box;
    }
    .rfkd-main{
        background: transparent linear-gradient(299deg, #007C91 0%, #00695C 100%) 0% 0% no-repeat padding-box !important;
        opacity: 1 !important;
        /*padding: 20px 0;*/
        padding-right: 20px;
        padding-top: 45px;
        padding-bottom: 55px;
        padding-left:-50px !important;
        margin-left:-65px;
        margin-right:-65px;
        display:flex;
        flex-wrap: wrap;        
    }
    .img-size{
        width:100%;
        height:100%;
        border: 18px solid white;    
        background: white;
    }

    @media screen and (max-width: 767px) {
        .rfkd-center-content {
            padding-top: 20px;
        }
    }
    @media screen and (max-width: 767px)
    {
        .rfkd-bottonbox-padding {
            padding-left: 0px !important;
            padding-right:0px !important;
        }
    }
    @media screen (min-width: 768px) {
        .rfkd-bottonbox-padding {
            padding-left: 0px !important;
            padding-right: 0px !important;
        }
    }

    @media screen and (max-width: 767px) {
        .rfkd-main {
            margin-right: -45px;
        }
    }

    @media screen and (max-width: 767px) {
        .a-formatDownload {
            float: right;
            padding-right: 10px;
            /*padding-left:5px;*/
        }
    }
    @media screen and (max-width: 767px) {
        .a-formatView {
            padding-left: 5px;
        }
    }
</style>


<%--*****--%>
<%--*RiskFactorsForKD*--%>
<%--*****--%> 

<div class="col-12">   <%--p-0--%>
    <div class="rfkd-main">
            
        <%--LEFT Margin--%>
       <%-- <div  class="rfkd-left-margin col-sm-1"></div>  --%>

      <%--CENTER content--%>  

        <div  class="col-12 col-md-5 rfkd-center-content" style="padding-top:20px;" > 
           
                    <div id="hdrRF">   <h2>
                        <span class="rfkd-title1">Risk Factors </span>        
                        <span class="rfkd-title2">for Kidney Disease</span>   </h2> 
                        <div><hr style="border: 2px solid #FFFFFF; background:#FFFFFF; width: 56px; opacity: 1; margin-bottom: 0em;" /></div>
                    </div>                 
                                    
                    <div  id="divDiabetes" style="padding-top: 30px;">
                        <div class="rfkd-image">                        
                            <img id="imgDiabetes" class="img-size" src="./images/DataCharts/Diabetes_RiskFactorsOfKD.jpg" alt="Diabetes - Risk Factors for KD" /> 
                           </div>
                         <div class="rfkd-botton-box ">
                            <asp:Literal ID="litBtnViewPage" runat="server" ClientIDMode="Static" />
                            <div style="padding-top: 15px">
                                <a href="detail.aspx?Qnum=Q763&topic=4#refreshPosition" class="a-formatView"> <%--target="_blank"--%>
                                    <span class="rfkd-link-text rfkd-bottonbox-padding" style="padding-left:15px">View Page</span>
                                    <img class="rfkd-img-rightarrow" src="./images/DataCharts/RightArrowIcon.jpg" alt="View Diabetes Details Page" />
                                </a>                                  
                                <a href="./Documents/CKD_Stages_1-4_Diabetes.xlsx" class="a-formatDownload">
                                    <img class="rfkd-img-download" src="./images/DataCharts/DownloadIcon.jpg" alt="Download Data - Diabetes" />
                                    <span class="rfkd-link-text rfkd-bottonbox-padding">Download Data</span>
                                </a>
                            </div>
                        </div>
                    </div>  

                    <div  id="divHypertension" style="padding-top: 30px;">
                        <div class="rfkd-image ">                  
                            <img id="imgHypertension" class="img-size" src="./images/DataCharts/Hypertension_RiskFactorsOfKD.jpg" alt="Hypertension - Risk Factors for KD" /> 
                           
                         <div class="rfkd-botton-box">
                            <asp:Literal ID="Literal1" runat="server" ClientIDMode="Static" />
                            <div style="padding-top: 15px">
                                <a href="detail.aspx?Qnum=Q764&topic=4#refreshPosition" class="a-formatView"> <%--target="_blank"--%>
                                    <span class="rfkd-link-text rfkd-bottonbox-padding" style="padding-left:15px">View Page</span>
                                    <img class="rfkd-img-rightarrow" src="./images/DataCharts/RightArrowIcon.jpg" alt="View Hypertension Details Page" />
                                </a>
                                <a href="./Documents/CKD_Stages_1-4_Hypertension.xlsx" class="a-formatDownload">
                                    <img class="rfkd-img-download" src="./images/DataCharts/DownloadIcon.jpg" alt="Download Data - Hypertension" />
                                    <span class="rfkd-link-text rfkd-bottonbox-padding">Download Data</span>
                                </a>
                            </div>
                        </div>
                    </div></div>
            
                    <div  id="divAge" style="padding-top: 30px;">
                        <div class="rfkd-image ">                 
                            <img id="imgAge" class="img-size" src="./images/DataCharts/Age_RiskFactorsOfKD.jpg" alt="Age - Risk Factors for KD" /> 
                           
                         <div class="rfkd-botton-box">
                            <asp:Literal ID="Literal2" runat="server" ClientIDMode="Static" />
                            <div style="padding-top: 15px">
                                <a href="detail.aspx?Qnum=Q762&topic=4#refreshPosition" class="a-formatView"> <%--target="_blank"--%>
                                    <span class="rfkd-link-text rfkd-bottonbox-padding" style="padding-left:15px">View Page</span>
                                    <img class="rfkd-img-rightarrow" src="./images/DataCharts/RightArrowIcon.jpg" alt="View Age Details Page" />
                                </a>
                                <a href="./Documents/CKD_Stages_1-4_Age.xlsx" class="a-formatDownload">
                                    <img class="rfkd-img-download" src="./images/DataCharts/DownloadIcon.jpg" alt="Download Data - Age" />
                                    <span class="rfkd-link-text rfkd-bottonbox-padding">Download Data</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>                   
            </div>
        
          <%-- <div class="col-md-1"></div> --%>
           
           <%--RIGHT section with text--%>
           
              <%--<div class="accordion-body col-md-5 rfkd-center-content" >--%>
                  <div class="rfkd-center-content col-12 col-md-6">        
                            
                         <div class="accordionItem" id="lnkDiabetes">
                            <div id=titleDiabetes class="accordionTitle diabetes" tabindex="0" role="button" aria-pressed="false" ><h3>Diabetes </h3>
                                 <span><i class="fa fa-plus" ></i></span>
                            </div>
                            <div id="rfkdDiabetes" class="rfkd-text accordionContent"> 
                                Diabetes is a leading risk factor for chronic kidney disease (CKD). Persons with diabetes make up the fastest growing group of kidney dialysis and transplant recipients in the United States. The prevalence of CKD among adults with diabetes has decreased from 42.3% in the 2001-2004 National Health and Nutrition Examination Survey (NHANES) to 38.5% in the 2017-March 2020 survey.
                            </div>
                        </div>
                        <hr class="accordionHr">

                        <div class="accordionItem" id="lnkHypertension" >
                            <div id=titleHypertension class="accordionTitle hypertension" tabindex="0" role="button" aria-pressed="false"><h3>Hypertension</h3>
                                 <span><i class="fa fa-plus"></i></span>
                            </div>
                            <div id="rfkdHypertension" class="rfkd-text accordionContent">  
                                Hypertension is the second leading risk factor for CKD. CKD can also lead to the development of hypertension through multiple mechanisms. The prevalence of CKD among adults with hypertension has remained stable, representing 26.6% in the 2001-2004 National Health and Nutrition Examination Survey (NHANES) to 26.3% in the 2017-March 2020 survey.
                            </div>
                        </div>
                        <hr class="accordionHr">

                        <div class="accordionItem" id="lnkAge">
                              <div id=titleAge class="accordionTitle age" tabindex="0" role="button" aria-pressed="false"><h3>Age</h3>
                                  <span><i class="fa fa-plus"></i></span>
                              </div>
                            <div id="rfkdAge" class="rfkd-text accordionContent">  
                              Although kidney disease can occur at any age, CKD is more frequently associated with older age. In the National Health and Nutrition Examination Survey (NHANES) of 2017-March 2020, the prevalence of CKD among those aged 18-39 years old was 6.0%; in those aged 40-59 years old, 11.2%; in those aged 60-69 years old, 20.1%; and in those 70 years of age and older, it was 42.6%.
                            </div>                
                        </div>
                        <hr  class="accordionHr">
                      
                </div>
       <%-- </div>--%>

        <%--RIGHT Margin--%>
       <%-- <div class="rfkd-right-margin  col-sm-1"></div>--%>

    </div>
</div>


  <script type="text/javascript">

      window.onload = function () {
          $("#divDiabetes").show();
          $("#divHypertension").hide();
          $("#divAge").hide();

          // Open the first accordion
          $(".accordionTitle:first").trigger("click");
      };

      function accordDescPerTitle() {
          let accordianTitles = document.querySelectorAll(".accordionTitle");
          let accTitlesWithIsOpen = document.querySelectorAll(".is-open");
          let icon = document.querySelectorAll(".accordionTitle span i");
          accordianTitles.forEach((accordionTitle) => {
              accordionTitle.setAttribute('tabindex', '0');              
          });

          $(".accordionTitle").on("click", function () {
                if($(this).hasClass("is-open")) {
                        $(this).removeClass("is-open")
                } else {
                    $(".is-open").removeClass("is-open");
                    $(this).addClass("is-open")
                }               
          })         
      };

      accordDescPerTitle();

      $(".accordionTitle").on("click", function () {

          $(this).children("span").children("i").toggleClass("fa-plus fa-times");
          $(".accordionTitle").not($(this)).children("span").children("i").removeClass("fa-times");
          $(".accordionTitle").not($(this)).children("span").children("i").addClass("fa-plus");

          $("#lnkDiabetes").on("click", function () {
              $("#divDiabetes").show();
              $("#divHypertension").hide();
              $("#divAge").hide();
          });

          $("#lnkHypertension").on("click", function () {
              $("#divDiabetes").hide();
              $("#divHypertension").show();
              $("#divAge").hide();              
          });
                  
          $("#lnkAge").on("click", function () {  
              $("#divDiabetes").hide();
              $("#divHypertension").hide();
              $("#divAge").show();              
          });                    
      });
      
      $(".accordionTitle").on("keydown", function (e) {
            let key = e.key;
            if(key === "Enter") { 
                e.preventDefault();
                $(this).toggleClass("is-open");
          
                $(this).children("span").children("i").toggleClass("fa-plus fa-times");
                $(".accordionTitle").not($(this)).children("span").children("i").removeClass("fa-times");
                $(".accordionTitle").not($(this)).children("span").children("i").addClass("fa-plus");
            }

          $("#lnkDiabetes").on("keydown", function (e) {
                let key = e.key;
             if(key === "Enter") {
                  $("#divDiabetes").show();
                  $("#divHypertension").hide();
                  $("#divAge").hide();

                    if($(this).find(".diabetes").hasClass("is-open")) {
                        $(this).find(".diabetes").removeClass("is-open")
                    } else {
                        $(".is-open").removeClass("is-open");
                        $(this).find(".diabetes").addClass("is-open")
                    } 
                    if($("#lnkDiabetes").find(".accordionTitle").hasClass("is-open")) {
                        $("#lnkDiabetes").find(".accordionTitle").removeClass("is-open")
                    } else {
                        $(".is-open").removeClass("is-open");
                        $("#lnkDiabetes").find(".accordionTitle").addClass("is-open")
                    } 
              }
          });

          $("#lnkHypertension").on("keydown", function (e) {
               let key = e.key;
               if(key === "Enter") {
                    $("#divDiabetes").hide();
                    $("#divHypertension").show();
                    $("#divAge").hide();

                    if($(this).find(".hypertension").hasClass("is-open")) {
                        $(this).find(".hypertension").removeClass("is-open")
                    } else {
                        $(".is-open").removeClass("is-open");
                        $(this).find(".hypertension").addClass("is-open")
                    }
                    if($("#lnkHypertension").find(".accordionTitle").hasClass("is-open")) {
                        $("#lnkHypertension").find(".accordionTitle").removeClass("is-open")
                    } else {
                        $(".is-open").removeClass("is-open");
                        $("#lnkHypertension").find(".accordionTitle").addClass("is-open")
                    }                    
                }              
          });

          $("#lnkAge").on("keydown", function (e) { 
              let key = e.key;
              if(key === "Enter") {              
                    $("#divDiabetes").hide();
                    $("#divHypertension").hide();
                    $("#divAge").show(); 

                    if($(this).find(".age").hasClass("is-open")) {
                        $(this).find(".age").removeClass("is-open")
                    } else {
                        $(".is-open").removeClass("is-open");
                        $(this).find(".age").addClass("is-open")
                    }
                    if($("#lnkAge").find(".accordionTitle").hasClass("is-open")) {
                        $("#lnkAge").find(".accordionTitle").removeClass("is-open")
                    } else {
                        $(".is-open").removeClass("is-open");
                        $("#lnkAge").find(".accordionTitle").addClass("is-open")
                    } 
                }            
          });     

      });

  </script>