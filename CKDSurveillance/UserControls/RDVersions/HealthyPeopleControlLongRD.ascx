<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HealthyPeopleControlLongRD.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.HealthyPeopleControlLongRD" %>


<div class="nccd-modA CornerMe">
     
     <%--**************--%>
     <%--*Widget Title*--%>
     <%--**************--%>
    <h3 style="font-family: Poppins;">
       <em>Healthy People 2020</em>
    </h3>

    <div class="description" style="padding-bottom:0px;">
                <p>                                           
                    Healthy People 2020 provides national objectives for improving the health of all Americans.
                    Fourteen (14) objectives focus on kidney disease, including end-stage renal disease (ESRD). 
                    Several indicators from the CKD Surveillance System provide related information for these objectives.                        
                </p>
     </div>

    <%--*Link to Internal Indicators*--%>                                                             
    <p>    
        <asp:hyperlink id="lnkIndicators" runat="server" navigateurl="~/data.aspx?categoryId=67" text="View Surveillance System Indicators related to Healthy People 2020 objectives">
        </asp:hyperlink>
    </p>



    <%--*Linked Image*--%>    
        <a href="http://www.healthypeople.gov/2020/topics-objectives/topic/chronic-kidney-disease/objectives" target="_blank">
            <img id="imgHealthyPeople"  src="images/healthyPeople.jpg" alt="Healthy People 2020" align="left" />
        </a>    
    

    <%--*Linked Text *--%>
    <div>        
        <a href="http://www.healthypeople.gov/2020/topics-objectives/topic/chronic-kidney-disease/objectives" target="_blank">Go to official Healthy People 2020 Web Site</a>
    </div>

</div>