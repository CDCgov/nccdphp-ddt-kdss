<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Patients.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.Patients" %>



<%--*******************************--%>
<%--*Patient-Focussed User Control*--%>
<%--*******************************--%>
<div class="module CornerMe widgetBorder">
    
    <h3 class="widgetTitleH3" style="font-size:1.2em; font-family: Poppins;">
        <strong>Patient-Focused Information</strong>
    </h3>    
    

    <div class="subc" style="width:95%;">
        <p>
            <asp:image ID="imgHands" ImageUrl="~/images/Hands.png" runat="server"  align="left" AlternateText="Patient Focus - Hands image" style="margin:7px;" />
            The information on this site is designed to provide a picture 
            of CKD in the country and reports aggregate 
            data on various groups of people in the United States.
        </p>
        <p>
            Information for people living with kidney disease, or at risk
            of developing kidney disease, and their friends and family
            members is available from the <a href="http://nkdep.nih.gov/" target="_blank">National Kidney Disease
            Education Program</a>.
        </p>
    </div>

</div>