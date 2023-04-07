<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AYA.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.AYA" %>
       

<style type="text/css">
    .aya {
        margin-top:75px;
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

<div>
    <div class="row aya">
        <div class="col-md-6">
            <div class="aya-title">ARE YOU AWARE?</div>

            <div><h2 class="aya-subtitle">Kidney Disease Awareness is Improving, but<br /><u class="aya-underline">Rem</u>ains Low in the US</h2></div>
            <div class="aya-text">Awareness of chronic kidney disease (CKD) has been very low in the US, with only 1 out of 10 individuals with CKD being aware of having it. Using nationally representative data, the overall awareness of CKD Stages 3-4 in the United States has risen overall from 11.2% to 20% between 2001 and 2020. Awareness is higher among individuals with more advanced CKD. Continued efforts to raise awareness in earlier stages of CKD can prevent progression to later stages, including end-stage kidney disease (ESKD), and can reduce related complications and early death associated with CKD.</div>

            <div class="row aya-botton-box">
                <%--<div class="col-sm-3 aya-button">View Spotlight</div>--%>
                <asp:Literal ID="litBtnMore" runat="server" ClientIDMode="Static" />
                <div class="aya-link-div"><a href="AreYouAware.aspx?emailDate=October_2022#refreshPosition" class="aya-link"><span style="color: contrast(4.5);">Awareness Archive</span><i class="fa fa-angle-right right-angle-arrow"></i></a></div>
            </div>
        </div>
        <div class="col-md-6 aya-image">
            <img src="/ckd/images/Mask_Group_33.png" style="margin-left:15px;" alt=""/>
        </div>
        <div class="col-md-6 aya-image-mobile">
            <img src="/ckd/images/Mask_Group_33_mobile.png"  style="width:100%;margin-top:15px" alt=""/>
        </div>
    </div>
</div>