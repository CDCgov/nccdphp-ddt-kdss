<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AYA.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.AYA" %>
       

<style type="text/css">
    .aya {
        margin-top:40px;
        margin-bottom:50px;
    }
    .aya-title {
        text-align: left;
        font: normal normal 600 20px/34px Nunito;
        letter-spacing: -0.4px;
        color: #242424;
        text-transform: uppercase;
        opacity: 1;       
    }
    .aya-subtitle {
        text-align: left;
        font: normal normal 600 30px/34px Nunito;
        letter-spacing: -0.6px;
        color: #000000;
        opacity: 1;
        margin-top:15px;
        border: none;
    }
    .aya-text {
        text-align: left;
        font: normal normal normal 18px/25px Nunito;
        color: #000000;
        opacity: 1;
        padding-top: 15px;
        padding-bottom: 15px;
        padding-right:5px;
    }
    .aya-button {
        background: #FBAB18 0% 0% no-repeat padding-box;
        border-radius: 5px;
        opacity: 1;
        width: 164px;
        height:48px;
        text-align: center;
        font: normal normal 600 17px/23px Nunito;
        letter-spacing: 0px;
        color: #000000;
        opacity: 1;
        padding:12px;
        text-decoration: none;
    }
    .aya-link-div {
        padding-top: 10px;
        padding-bottom: 3px;
        width:50%;
    }
    .aya-link {
        text-align: left;
        font: normal normal normal 17px/23px Nunito;
        letter-spacing: 0px;
        color:#005fa3 !important; /*color: #00778C;*/
        opacity: 1;
        text-decoration:none;
        margin-left:15px;
    }
    .aya-image {

        /*background: transparent url('/images/Mask_Group_33.png') 0% 0% no-repeat padding-box;*/
        opacity: 1;
        /*width: 652px;
        height: 313px;  */   
        display:block;
    }
    .aya-image-mobile {
        display:none;
    }
    .aya-botton-box {
        padding-left:15px;
    }

    .aya-underline {
        text-decoration-color: #005ea2; /*#00695C;*/
        text-underline-offset: 15px;
        text-decoration-thickness: 3px;
    }

    .areYouAwareMsg {        
        background-color: #f6fbff;      
        /*text-align: justify;*/
        font: normal normal normal 18px/25px Nunito;
        opacity: 1;
        padding-top: 25px;
        padding-bottom: 25px;
        padding-left: 20px;
        padding-right: 10px;
        line-height: normal;
        margin-left: 0px;
    }
/*    .justify-to-center {
            justify-content: center;
            width: 75%;
    }*/

    @media (max-width: 767px) {
        .aya-underline {
            text-decoration-color: #005ea2; /*#00695C;*/
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
            font: normal normal 600 30px/32px Nunito;
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

                  <img src="/images/AYA_theme_version-t5.jpg" style="margin-left:0%; width:99%; margin-top:0%; margin-bottom:0% " alt="Click to view awareness topic archive"/>
                </a>
            </div>
             <div style="height:50%; width:98%; display:table-cell; padding-right: 18px; word-spacing: normal;" class ="areYouAwareMsg">

                <b><i>Are You Aware? </i></b> is designed to raise  <%--<br /> --%>                                             
                awareness about important topics relevant to <%-- <br />--%>
                kidney disease surveillance and prevention.
            </div>
        </div>
        <div class="col-md-6 aya-image-mobile">
            <%--<img src="/ckd/images/Mask_Group_33_mobile.png"  style="width:100%;margin-top:15px" alt=""/>--%>
            <a href="TopicHome/AwarenessArchive.aspx?topic=25">
                <img src="../images/AYA_theme_version-t5.jpg" style="width:100%;margin-top:15px" alt="Click to view awareness topic archive"/> 
            </a>
       </div>

        <div class="col-md-7">
            <%--<div class="aya-title">ARE YOU AWARE?</div>--%>

            <div>
                <h2 class="aya-subtitle" style="font-family: Poppins;"><i>Nocturia May Indicate Chronic Kidney Disease or Other Conditions</i></h2>   <%--<br /><u class="aya-underline">Low</u>--%>
            </div>

            <div class="aya-text">
                Nocturia is defined as waking from sleep at night to urinate more than once. It is one of the most common urinary symptoms and occurs more often as people age. Nocturia is almost twice as common among U.S. adults with chronic kidney disease (CKD) stages 3–5 than those without CKD (~50% among CKD stages 3–5 vs. ~25% among those without CKD, in the 2017–March 2020, based on NHANES data). Nocturia can be a sign of more serious underlying conditions such as urinary obstruction or chronic kidney disease, and it is important for people to contact their healthcare provider if they regularly experience this symptom.
                <br /><br />                
            </div>

            <div class="row aya-botton-box">
                <%--<div class="col-sm-3 aya-button">View Spotlight</div>--%>
                <asp:Literal ID="litBtnMore" runat="server" ClientIDMode="Static" />
                <div class="aya-link-div"><a href="TopicHome/AwarenessArchive.aspx?topic=25" class="aya-link"><span style="color: contrast(4.5);">Archive</span><i class="fa fa-angle-right right-angle-arrow"></i></a></div>
            </div>
        </div>
        
    </div>
</div>