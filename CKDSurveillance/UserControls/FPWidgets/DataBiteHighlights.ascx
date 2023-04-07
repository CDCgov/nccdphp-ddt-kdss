<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DataBiteHighlights.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.DataBiteHighlights" %>
       

<style type="text/css">
    
    .popup-container {
        width:600px;
        height:600px;
        background: border-box;
        display: flex;
        align-items: center;
        justify-content:center;
    }

    .btn-HealthyPeople {
        background-color:#007C91;
    }

    .btn-close {
        padding: 10px 10px 10px 10px;
        border: 0;
        outline: none;
        cursor: pointer; 
        font-size: 22px;
        font-weight:  500;
        border-radius: 10px;
        vertical-align:central;
        text-align:center;
        background-color:#050A30; 
        color:white; 
        width:120px; 
        height:60px;
        float:right;
    }

    .btn-disclaimer{
        color: #00778C; /*#007C91; */
        /*padding-left:40px; 
        padding-right: 40px; */
        vertical-align:central; 
        vertical-align:bottom
    }

    .disclaimer-icon{
        width:100px;
        margin-top: -50px;
        border-radius: 50%;
        box-shadow: 0 2px 5px rgba(0,0, 0, 0.2);
    }

    .popup-message {
        width: 600px;
        border:thin;
        border-color:gainsboro;
        background: #fff;
        border-radius:6px;
        position:absolute;
        top: 0;
        left: 50%;
        /*transform: translate(-50%, -50%) scale(0.1);*/
        text-align:left;
        padding: 0 30px 30px;
        color: #333;
        visibility:hidden;
    }

    .open-popup-message{
        visibility: visible;
        top:60%;
        transform: translate(-40%, -40%) scale(1);
        width: 700px;
        background: #fff;
        border-radius:6px;
        position:absolute;
        text-align:left;
        padding: 0 30px 30px;
        color: #333;
    }

    .popup-msg-format{
        font-size:18px; 
        font-family:Open Sans, Regular;
    }

    .databites-msg-header{
        font-size:20px; 
        font-family:Open Sans, Semibold;
        font-weight: bold;
    }

    .databites-msg-subheader{
        font: normal normal normal 18px/25px Open Sans;
        /*font-size:18px; 
        font-family:  Open Sans;*/ /* Semibold;*/
        /*font-weight: normal;*/ /* bold;*/
        line-height:25px;
    }

       .dbh-center-content { 
          padding-top: 20px;
          padding-bottom:20px;
          padding-left:15px;
          padding-right:15px;
        }
       .dbh-main{
          padding: 55px 0;
          display:flex;
          flex-wrap: wrap;
          margin-left: -15px;
          margin-right: -15px;
       }
       .dbh-Title{
           font-weight: bold; 
           font:Open Sans, Semibold; 
           font-size:30px;
       }
       .dbh-image-desc1{
            text-align: left;
            font: normal normal normal 24px/28px Open Sans;
            letter-spacing: -0.24px;
            color: #29434E;
            opacity: 1;
            background-color:white;
            padding-top:5px;
            padding-bottom:5px;
            padding-left:10px;
            padding-right:10px;
       }
       .dbh-image-desc2{
            text-align: left;
            font: normal normal normal 16px/21px Open Sans;
            letter-spacing: 0px;
            color: #000000;
            opacity: 1;
            background-color:white;
            padding-top:5px;
            padding-bottom:5px;
            padding-left:10px;
            padding-right:10px;
       }
       .dbh-image-info{
            text-align: left;
            font: italic normal normal 14px/21px Roboto;
            letter-spacing: 0px;
            color: #6D6D6D;
            opacity: 1;
            background-color:white;
            padding-top:5px;
            padding-bottom:5px;
            padding-left:10px;
            padding-right:10px;
       }
       .dbh-image-border{
           padding-left:2px;
           padding-right:2px;
           background-color:white;
       }
       .image-thickborder {
           padding-left: 9px;
           padding-right: 9px;
       }

    .prev-img-box {
        background: #FFFFFF 0% 0% no-repeat padding-box;
        box-shadow: 0px 3px 6px #00000029;
        border: 1px solid #CFCFCF;
        opacity: 1;
        padding-top:25px;
        cursor: pointer;
    }
    .prev-img-card {
        box-shadow: inset 0px 3px 6px #00000029;
        opacity: 1;                
    }
    .prev-img {
        width:100%;
        height: 100%;
    }
    .prev-subtitle {
        text-align: left;
        font: normal normal normal 24px/28px Open Sans;
        letter-spacing: -0.24px;
        color: #29434E;
        opacity: 1;
        margin-top:5px;        
    }
    .prev-text {
        text-align: left;
        font: normal normal normal 16px/21px Open Sans;
        letter-spacing: 0px;
        color: #000000;
        opacity: 1;
        margin-top:5px;        
    }
    .prev-footer {
        text-align: left;
        font: italic normal normal 14px/21px Roboto;
        letter-spacing: 0px;
        color: #6D6D6D;
        opacity: 1;
        margin-top:10px;
    }
    .dbh-image {
        padding-top:100px !important;
    }
    .dbh-leftcontent {
        padding-left: 0px;
        padding-right: 10px;
        vertical-align: top;
    }

    @media screen and (max-width: 767px){
        .dbh-leftcontent {
            padding-right: 0px;
        }
    }

    @media screen and (max-width: 767px) {
        .dbh-main {
            margin-right: -15px;
        }
    }

       @media screen and (max-width: 768px) {
            .dbh-image {
                padding-top: 10px !important;
            }             
        }

        @media screen and (min-width: 768px) {
            .dbh-leftimage {
                padding-right: 0px;
            }             
        }
        @media screen and (min-width: 768px) {
            .dbh-rightimage {
                padding-left: 0px;
            }             
        }

        @media (min-width: 1201px) {
        .prev-img-card {
            height: 60%;
        }
        .prev-subtitle {
            height: 15%;
        }
        .prev-text {
            height: 10%;
        }
    }
         @media (max-width: 1500px) {
        .prev-subtitle {
            margin-top:0px;
            font:normal normal normal 18px Open Sans;
        }
        .prev-footer {
            margin-top:0px;
            margin-bottom:10px;
        }
    }
</style>


<%--**********************--%>
<%--*Data Bite Highlights*--%>
<%--**********************--%> 

    <div class="col-12 col-md-12 p-0">
        <div class="dbh-main">
            
          <%--LEFT Margin--%>
           <%--<div  class="col-sm-1"></div>  --%>

          <%--CENTER content--%>  
            <div  class="col-12 col-md-4 dbh-center-content"> 
                                  
                <%--First section (out of 3)--%>
                <div>                             
                        <h2><span class="dbh-Title">Data Bite Highlights</span></h2>
                        <div><hr style="border: 1.5px solid #00695C; background:#00695C; width: 56px; opacity: 1;" /></div>  
                </div>
                <div class="col-md-12 dbh-leftcontent">                                      
                    
                    <div style="padding-top:30px">
                        <span class="databites-msg-header">HEALTHY PEOPLE 2030</span>
                        <br /><br />
                        <span class="databites-msg-subheader">
                           <a href="https://health.gov/healthypeople" alt="Healthy People 2030" style="text-decoration:none">Healthy People 2030</a> (HP2030) sets data-driven national objectives to improve health and well-being over the next decade. There are 14 goals related to kidney disease, 10 of which are about chronic kidney disease. Goals are tracked using several data sources  
                            <br /> <br /> 
                            In addition, the Kidney Disease Surveillance System tracks these goals. Click on the Healthy People 2030 button below to see all the surveillance system indicators related to HP2030.
                        </span>
                        <br /><br />
                        <div> 
                            <span class="btn-HealthyPeople" >            
                                <a href="data.aspx?categoryID=67" alt="Healthy People 2030" style="background-color:#00778C; padding-right:20px; padding-left:20px;" class="btn btn-primary specialLinkIconLeft float-left" > <%--target="_blank"--%>
                                    Healthy People 2030
                                </a>
                            </span>
                            <%--&nbsp;&nbsp;--%>    
                            <div> <%--class="popup-container">--%>	                           
                                  <button type="button" class="btn popup-msg-format btn-disclaimer" data-toggle="modal" data-target="#myModal">  <%--onclick="openDisclaimerMessage()"--%>
                                        <img id="imgdisclaimerinfosmall" src="./images/DataCharts/disclaimer-info-small.jpg" alt="Disclaimer Information" style="width:24px; height:24px" />
                                        Disclaimer      
                                  </button>

                                  <!-- Modal -->
                                  <div class="modal fade" id="myModal" role="dialog">
                                    <div class="modal-dialog modal-md">    
                                      <!-- Pop-up message - Modal content-->
                                      <div class="modal-content">
                                            <div >  <%--class="modal-header"--%>
                                              <button type="button" class="close" data-dismiss="modal">
                                                  <%--<span style="font-size: 25px; " >&times;</span>--%>
                                                  <img id="imgClose_window" src="./images/DataCharts/Close_window.jpg" alt="Close" style="width:55px; height:45px; float:right"   />   <%--onclick="closeDisclaimerMessage()"--%>
                                              </button>
                                              <h3 style="font:Open Sans, Regular; padding-left:15px">Healthy People 2030 Disclaimer </h3>
                                            </div>
                                            <div class="modal-body"> 
                                                    <hr /><%-- Draw Line--%> <%--<br />--%>                                            
                                                    <p class="popup-msg-format">Statistics provided here are adapted from the <a href="https://health.gov/healthypeople" style="height: 66px;text-decoration:none" target="_blank">Healthy People 2030</a> (HP2030) measures and created from a variety of data sources. The Kidney Disease Surveillance System is not the official HP2030 source but tracks indicators related to HP2030.
                                            </div>
                                            <div class="modal-footer">
                                              <button type="button" class="btn-close" data-dismiss="modal">Close</button>  <%-- onclick="closeDisclaimerMessage()"--%>
                                            </div>
                                      </div>      
                                    </div>
                                  </div>  
                            </div>
                        </div>                           
                    </div>

                </div>
           </div>    
            
                <%--Second section (out of 3)--%>           
                <div class="col-md" style="padding:10px !important">
                    <div class="col-md dbh-image"></div>
                    <div class="prev-img-box mr-1 ml-1 p-3" role="button" onclick="location.href='./detail.aspx?Qnum=Q372';" tabindex="0" onkeydown="checkTabKeyPresses(event,'DBHcard1');" >
                        <div class="prev-img-card"> <img id="imgStages1to4" src="./images/DataCharts/DataBites_Stages1to4.jpg" class="prev-img" alt="Prevalence of CKD Stages 1-4 by Year"/> </div>
                        <div class="prev-subtitle">Prevalence of CKD Among U.S. <br />Adults, by Stage </div>
                        <%--<div class="prev-text">For 2015-2016, the unadjusted prevalence of CKD <br />stages 1-4 was approximately 14.2%.  </div>--%>
                        <div class="prev-footer">Source of information: NHANES  </div>
                    </div>
                </div>

                <%--Third section (out of 3)--%>
                <div class="col-md" style="padding:10px !important; padding-right: 0px !important">
                    <div class="col-md dbh-image"></div>
                    <div class="prev-img-box mr-1 ml-1 p-3" role="button" onclick="location.href='./detail.aspx?Qnum=Q98&Strat=CKD+Stage#refreshPosition';" tabindex="0" onkeydown="checkTabKeyPresses(event,'DBHcard2');" >
                        <div class="prev-img-card"> <img id="imgStages3or4" src="./images/DataCharts/DataBites_Stages3or4.jpg" class="prev-img" alt="% with CKD Stage 3 or 4 who were aware of their disease"/> </div>
                        <div class="prev-subtitle">Kidney Disease Awareness Among <br />U.S. Adults with CKD Stages 3-4 </div>
                        <%--<div class="prev-text">During 2015-2016, prevalence of CKD in the U.S. <br />was 14.2%. </div>--%>
                        <div class="prev-footer">Source of information: NHANES  </div>
                    </div>
                </div>

            <%--RIGHT Margin--%>
            <%--<div class="col-sm-1"></div>--%>

          </div>
    </div>


<script type="text/javascript">

    let popup = document.getElementById("popup")

    function openDisclaimerMessage() {
        popup.classList.add("open-popup-message")
    }

    function closeDisclaimerMessage() {
        popup.classList.remove("open-popup-message")
    }

    function checkTabKeyPresses(e, DBHcard) {
        let key = e.key;
        if (key === "Enter") {
            e.preventDefault();

            if (DBHcard === 'DBHcard1') {
                window.location.href = './detail.aspx?Qnum=Q372';
            }
            else if (DBHcard === 'DBHcard2') {
                window.location.href='./detail.aspx?Qnum=Q98&Strat=CKD+Stage#refreshPosition';
            }
        }
    }

</script>