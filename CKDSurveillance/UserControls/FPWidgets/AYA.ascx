<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AYA.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.AYA" %>
       

<style type="text/css">
    .aya {
        margin-top:40px;
        margin-bottom:50px;
    }
    .aya-title {
        text-align: left;
        font: normal normal 600 20px/34px Open Sans;
        letter-spacing: -0.4px;
        color: #242424;
        text-transform: uppercase;
        opacity: 1;       
    }
    .aya-subtitle {
        text-align: left;
        font: normal normal 600 30px/34px Open Sans;
        letter-spacing: -0.6px;
        color: #000000;
        opacity: 1;
        margin-top:15px;
    }
    .aya-text {
        text-align: left;
        font: normal normal normal 18px/25px Open Sans;
        color: #000000;
        opacity: 1;
        padding-top: 15px;
        padding-bottom: 15px;
        padding-right:15px;
    }
    .aya-button {
        background: #FBAB18 0% 0% no-repeat padding-box;
        border-radius: 5px;
        opacity: 1;
        width: 164px;
        height:48px;
        text-align: center;
        font: normal normal 600 17px/23px Open Sans;
        letter-spacing: 0px;
        color: #000000;
        opacity: 1;
        padding:12px;
        text-decoration: none;
    }
    .aya-link-div {
        padding-top: 10px;
        padding-bottom: 3px;
    }
    .aya-link {
        text-align: left;
        font: normal normal normal 17px/23px Open Sans;
        letter-spacing: 0px;
        color: #00778C;
        opacity: 1;
        text-decoration:none;
        margin-left:15px;
    }
    .aya-image {

        /*background: transparent url('/images/Mask_Group_33.png') 0% 0% no-repeat padding-box;*/
        opacity: 1;
        width: 652px;
        height: 313px;     
        display:block;
    }
    .aya-image-mobile {
        display:none;
    }
    .aya-botton-box {
        padding-left:15px;
    }

    .aya-underline {
        text-decoration-color:#00695C;
        text-underline-offset: 15px;
        text-decoration-thickness: 3px;
    }

    .areYouAwareMsg {        
        background-color: #EBF5F6;      
        /*text-align: justify;*/
        font: normal normal normal 18px/25px Open Sans;
        opacity: 1;
        padding-top: 25px;
        padding-bottom: 25px;
        padding-left: 20px;
        padding-right: 10px;
        line-height: normal;
        margin-left: 0px;
    }

    @media (max-width: 767px) {
        .aya-underline {
            text-decoration-color:#00695C;
            text-underline-offset: 5px;
        }
        .aya-image {
            display:none;
        }
        .aya-image-mobile {
            display:contents;
            width:100%;
        }
        .aya-subtitle {
            text-align: left;
            font: normal normal 600 30px/32px Open Sans;
            letter-spacing: -0.6px;
            color: #000000;
            opacity: 1;
        }
    }
</style>


<%--*****--%>
<%--*AYA*--%>
<%--*****--%> 

<div style="background-color:white">
    <div class="row aya" >

        <div class="col-md-4 aya-image">
            <div style="height=50%; width:99%">
                <%--<img src="/ckd/images/AYA_theme_version_1.jpg" style="margin-left:15px;" alt=""/> <img src="/ckd/images/Mask_Group_33.png" style="margin-left:15px;" alt=""/>--%>
                <a href="TopicHome/AwarenessArchive.aspx?topic=25">
                    <img src="images/AYA_theme_version.jpg" style="margin-left:0%; width:99%; margin-top:1%; margin-bottom:5% " alt=""/>
                </a>
            </div>
            <div style="height:25%; width:98%"></div>
            <div style="height:50%; width:98%; display:table-cell; padding-right: 18px; word-spacing: normal;" class ="areYouAwareMsg">
                <b><i>Are You Aware? </i></b> is designed to raise  <%--<br /> --%>                                             
                awareness about important topics relevant to <%-- <br />--%>
                kidney disease surveillance and prevention.
            </div>
        </div>
        <div class="col-md-6 aya-image-mobile">
            <%--<img src="/ckd/images/Mask_Group_33_mobile.png"  style="width:100%;margin-top:15px" alt=""/>--%>
            <a href="TopicHome/AwarenessArchive.aspx?topic=25">
                <img src="/ckd/images/AYA_theme_version.png" style="width:100%;margin-top:15px" alt=""/> 
            </a>
       </div>

        <div class="col-md-7">
            <%--<div class="aya-title">ARE YOU AWARE?</div>--%>

            <div>
                <h2 class="aya-subtitle"><i>Trends in Daily Dietary Sodium and Potassium Intake Among Adults With Chronic Kidney Disease</i></h2>   <%--<br /><u class="aya-underline">Low</u>--%>
            </div>

            <div class="aya-text">
                An appropriate intake of sodium and potassium is necessary for maintaining optimal health. Among people with chronic kidney disease (CKD), excess intake of sodium and low intake of potassium may worsen health outcomes. 
                <br /><br />                
                National survey data show that recommended sodium consumption (less than 2,300 mg/day) was more common among adults with CKD than adults without CKD. However, the percentage of adults with CKD meeting sodium intake recommendations declined from 2005–2008 (38.4%) to March of 2017 (32.8%). 
                <br /><br />
                The recommended minimum potassium intake for the general population is at least 3,400 mg/day for men and 2,600 mg/day for women. Fewer adults with CKD met the recommended potassium intake (29%) than adults without CKD (35%), without significant changes over time. These data suggest that about two-thirds of the U.S. adult population do not meet recommended daily sodium and potassium intake. Dietary monitoring and counseling are important aspects of CKD management to prevent complications (e.g., hypertension, hyper- or hypokalemia). 
            </div>

            <div class="row aya-botton-box">
                <%--<div class="col-sm-3 aya-button">View Spotlight</div>--%>
                <asp:Literal ID="litBtnMore" runat="server" ClientIDMode="Static" />
                <div class="aya-link-div"><a href="TopicHome/AwarenessArchive.aspx?topic=25" class="aya-link"><span style="color: contrast(4.5);">Archive</span><i class="fa fa-angle-right right-angle-arrow"></i></a></div>
            </div>
        </div>
        
    </div>
</div>