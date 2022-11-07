<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FrontPageRotater.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FrontPageRotater" %>


<%--*Javascript*--%>
<%--See NCCDWide.Master--%>


<%--*CSS*--%>
<style type="text/css">
    .firstPanel{display:block;}
    .RotatingPanel{width:940px;height:200px; margin:0 auto;border:solid 1px silver; background-color:#c5ded6; display:none;}    
    .RotatingPanelShort{width:940px;height:200px; margin:0 auto;border:solid 1px silver; background-color:#c5ded6; display:none;}
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
        top:-2em;
        left:.75em;
        height:.03em;
    } /* overflow: hidden; */

    .cycle-pager span {font-family: arial; font-size: 50px; width: 16px; height: 16px; display: inline-block; color: silver; cursor: pointer;}
    .cycle-pager span.cycle-pager-active { color: #1a7aa2;}
    .cycle-pager > * { cursor: pointer;}

     .RotatingPanel { width:99%; height:99%;}


</style>


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
             <div class="RotatingPanel firstPanel">
                <div style="text-align:left;">
                    <asp:Image ID="imgCKDDef" ImageURL="~/images/CKD5.6.jpg" CssClass="imageClass" alt="Chronic Kidney Disease (CKD) is a condition in which your kidneys are damaged and cannot filter blood as well as healthy kidneys." runat="server" />
                </div>
            </div>


            <%--*********--%>
            <%--*Slide 2*--%>
            <%--*********--%>
            <%--<div class="RotatingPanel">  --%>

                <%--*Image*--%>
                <%--<div style="text-align:center;">                
                    <asp:Image ID="imgOneInTen" ImageUrl="~/images/CKD1.2.jpg" CssClass="imageClass" alt="1 in 10 people have Chronic Kidney Disease" runat="server" />
                </div>--%>
            
            <%--</div>--%>



            <%--*********--%>
            <%--*Slide 3*--%>
            <%--*********--%>
            <div class="RotatingPanel">   
                             
                <%--*Image*--%>
                <div style="text-align:center;">
                    <asp:Image ID="imgAdultDiabetes" ImageUrl="~/images/CKD2.2.jpg" CssClass="imageClass" alt="Adults With diabetes or high blood pressure have a higher risk of developing CKD" runat="server" />
                </div>
            </div>



            <%--*********--%>
            <%--*Slide 4*--%>
            <%--*********--%>
            <div class="RotatingPanel">
    
                <%--*Image*--%>
                <div style="text-align:center;">
                    <asp:Image ID="imgNotAware" ImageUrl="~/images/CKD3.2.JPG" CssClass="imageClass" alt="Most people with CKD are not aware of their disease and do not seek appropriate treatment" runat="server"/>
                </div>    
            </div>



            <%--*********--%>
            <%--*Slide 5*--%>
            <%--*********--%>
             <div class="RotatingPanel">
            
                <div style="text-align:center;">                
                    <asp:Image ID="imgTests" ImageURL="~/images/CKD4.2.jpg" CssClass="imageClass" alt="The only way to find out for sure whether you have CKD is through specifc blood and urine tests" runat="server" />
                </div>
            </div>
    </div>

    <%--*******--%>
    <%--*Pager*--%>
    <%--*******--%>
    <div class="cycle-pager" id="pager"></div>

</div> 
