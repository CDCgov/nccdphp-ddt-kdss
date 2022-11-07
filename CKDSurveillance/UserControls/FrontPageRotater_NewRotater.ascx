<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FrontPageRotater_NewRotater.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FrontPageRotater_NewRotater" %>

<%--*Javascript*--%>
<%--See NCCDWide.Master--%>


<%--*CSS*--%>
<style type="text/css">
    .firstPanel{display:block;}
    .RotatingPanel{width:940px;height:200px; padding-bottom:5px; margin:0 auto;border:solid 2px #e5e5e5;  display:none; border-radius:5px;}    /*box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); */
    .RotatingPanelShort{width:940px;height:200px; margin:0 auto;border:solid 2px #e5e5e5; display:none; border-radius:5px;} /*box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); */
    .RotatingPanelLeft{float: left; width: 430px; height:200px;}
    .RotatingPanelRight{float: right; width: 530px;height:200px;}
    
    /*.RotatingText1{font-family: arial; font-size: 20px; color: #000000; white-space: pre-wrap; text-align: left;font-style:italic;padding:1em 0 1em 1em;}*/
    /*.RotatingText2{font-family: arial; font-size: 24px; color: #000000; white-space: pre-wrap; text-align: center;padding:1em 0 1em 0;}*/
    /*.RotatingText3{font-family: arial; font-size: 15px; color: #000000; white-space: pre-wrap; text-align: center;padding:1em 0 1em 0;}*/    
    /*.RotatingText4{font-family:Georgia;font-style: italic; font-size: 24px;  color: #000000; white-space: pre-wrap; text-align: center; bottom:5px; height:25px;}*/
    /*.RotatingText5{font-family: arial; font-size: 12px; line-height:12px; color: #000000; white-space: pre-wrap; text-align:center; bottom:5px;}*/

    /*.imageClass{width:940px; height:200px;}*/
    
    /* pager */
    .cycle-pager {
        position:relative;
        z-index: 1000; 
        top:-4em;
        right:.7em;
        height:.03em;
        text-align:right;
    } /* overflow: hidden; */

    .cycle-pager span {font-family: arial; font-size: 50px; width: 16px; height: 16px; display: inline-block; color: silver; cursor: pointer;}
    .cycle-pager span.cycle-pager-active { color: #1a7aa2;}
    .cycle-pager > * { cursor: pointer;}

     .RotatingPanel { width:99%; height:99%;}


</style>

<script>

    $(document).ready(function () { 
        
        var mathrand = Math.random();
        var num = Math.floor(mathrand * 5);
        $(".cycle-slideshow").attr("data-cycle-starting-slide", num); //randomly selecting the first image of the rotator
        
    });

</script>


<div id="divOuterCycle">

    <div class="cycle-slideshow" 
        data-cycle-fx="fadeout" 
        data-cycle-speed="1250"
        data-cycle-timeout="10000" 
        data-cycle-pause-on-hover="true"
        data-cycle-next="#next"
        data-cycle-prev="#prev"
        data-cycle-pager="#pager"
        data-cycle-slides="> div"
        
        >

            <%--*********--%>
            <%--*Slide 1*--%>
            <%--*********--%>
             <div class="RotatingPanel" id="rp1">
                <div style="text-align:center;">
                    <asp:Image ID="imgCKDDef" ImageURL="~/images/ImageCarousel_V2-01.png" CssClass="img-fluid" alt="Chronic Kidney Disease (CKD) is a condition in which your kidneys are damaged and cannot filter blood as well as healthy kidneys. Because of this, wastes from the blood remain in the body and may cause other health problems." runat="server" />
                </div>
            </div>


            <%--*********--%>
            <%--*Slide 2*--%>
            <%--*********--%>
            <div class="RotatingPanel" id="rp2">   
                             
                <%--*Image*--%>
                <div style="text-align:center;">
                    <asp:Image ID="imgAdultDiabetes" ImageUrl="~/images/ImageCarousel_V2-03.png" CssClass="img-fluid" alt="Adults With diabetes or high blood pressure have a higher risk of developing CKD" runat="server" />
                </div>
            </div>



            <%--*********--%>
            <%--*Slide 3*--%>
            <%--*********--%>
            <div class="RotatingPanel" id="rp3">
    
                <%--*Image*--%>
                <div style="text-align:center;">
                    <asp:Image ID="imgNotAware" ImageUrl="~/images/ImageCarousel_V2-02.png" CssClass="img-fluid" alt="Most people with CKD are not aware of their disease and do not seek appropriate treatment" runat="server"/>
                </div>    
            </div>



            <%--*********--%>
            <%--*Slide 4*--%>
            <%--*********--%>
             <div class="RotatingPanel" id="rp4">
            
                <div style="text-align:center;">                
                    <asp:Image ID="imgTests" ImageURL="~/images/ImageCarousel_V2-04.png" CssClass="img-fluid" alt="The only way to find out for sure whether you have CKD is through specifc blood and urine tests" runat="server" />
                </div>
            </div>

        <%--*********--%>
            <%--*Slide 5*--%>
            <%--*********--%>
            <div class="RotatingPanel" id="rp5">
                <div style="text-align:center;">
                    <asp:Image ID="img1in7" ImageURL="~/images/ImageCarousel_V2-05.png" CssClass="img-fluid" alt="ore than 1 in 7 US adults are estimated to have CKD - that is about 30 million people" runat="server" />
                </div>
            </div>
    </div>

    <%--*******--%>
    <%--*Pager*--%>
    <%--*******--%>
    <div class="cycle-pager" id="pager"></div>

</div> 
