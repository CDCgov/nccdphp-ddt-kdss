<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HealthyPeopleControlLong.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.HealthyPeopleControlLong" %>

  
<div class="module widgetBorder CornerMe" >    
        
    <h3 class="widgetTitleH3" style="font-size:1.2em; font-family: Poppins;">
        <em>Healthy People 2020</em>
    </h3>

    <div class="subc" style="width:98%;">
            
            <div class="description">
                <p>                                           
                    Healthy People 2020 provides national objectives for improving the health of all Americans.
                    Fourteen (14) objectives focus on kidney disease, including end-stage renal disease (ESRD). 
                    Several indicators from the CKD Surveillance System provide related information for these objectives.                        
                </p>
            </div>

            <div class="more-link oneColumn" style="width:97%; padding: 10px 20px 2px 20px;">
                <%--*****************************--%>
                <%--*HP Indicator And Site Links*--%>
                <%--*****************************--%>                        

                <%--*Link to Internal Indicators*--%>                                                             
                <asp:hyperlink id="lnkIndicators" runat="server" navigateurl="~/data.aspx?categoryId=67" text="View Surveillance System Indicators related to Healthy People 2020 objectives">
                </asp:hyperlink>

             </div> 

                                                            
            <div id="divHP2020">
                        
                        <%--*Linked Image*--%>
                        <div style="float:left; display:inline-block;">
                            <a href="http://www.healthypeople.gov/2020/topics-objectives/topic/chronic-kidney-disease/objectives" target="_blank">
                                <asp:image id="imgHealthyPeople" runat="server" imageurl="~/images/healthyPeople.jpg" alternatetext="Healthy People 2020" cssclass="ckd-healthy-people" />
                            </a>
                        </div>

                        <%--*Out Icon*--%>
                        <div style="float:left; width:10px; height:50px;">
                            <a href="http://www.cdc.gov/Other/disclaimer.html" target="_blank" style="text-decoration:none;">
                                <asp:Image ID="ingOutImage" runat="server" AlternateText="Healthy People 2020 Open an External Web Site" ToolTip="External Web Site" ImageUrl="~/images/icon_out.png" Width="10px" />
                            </a>
                        </div>
                                                         
                                
                        <%--*Linked Text *--%>
                        <div style="float:left; width:300px; height:50px;">
                            <br style="height:10px;" />
                            <a href="http://www.healthypeople.gov/2020/topics-objectives/topic/chronic-kidney-disease/objectives" target="_blank">Go to official Healthy People 2020 Web Site</a>
                        </div>

              </div>                                                                                                  
        </div>
    <%--</div>--%>
</div>