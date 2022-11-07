<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DetailCategoryControl.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.DetailCategoryControl" %>

<style type="text/css">

.selectRounder
{
    min-width: 85%;
    max-width: 85%;
}

</style>

<div class="row roundMe" style="background-color: #c5ded6; border:solid .1em silver;">
    <div class="col-xl-12">
        

        <%--*This was moved to here from the UserControl SelectIndicatorControlSameLine.ascx*--%> 
        <%--*********************--%>
        <%--*Drop Down Selectors*--%>
        <%--*********************--%>
        <asp:UpdatePanel ID="pnlInputs" runat="server" UpdateMode="Conditional" RenderMode="Block">
            <ContentTemplate>

                <%--******--%>
                <%--*LEFT*--%>
                <%--******--%>
                <div class="row">

                    <%--*Categories / Topics / Measures*--%>                            
                    <div class="span11 leftDDL">
                               
                         <%--*Topic/Measure Label*--%>
                        <p>
                            <asp:Label style="display:none" ID="lblTest" runat="server" text="You will be able to choose an indicator after you select a topic"></asp:Label>                    
                            <asp:Label ID="lblIndicatorCategory" runat="server" CssClass="ckd-select-indicator-label" Text="Topic:" AssociatedControlID="RadComboBoxCategories"></asp:Label>
                        </p>                        

                        <%--*Topic / Measure Drop Down*--%>
                        <p>
                            &nbsp;<asp:DropDownList ID="RadComboBoxCategories" runat="server" AutoPostBack="true" CssClass="selectRounder" onchange="$('#hideContent').show();$('#hideContent').offset($('#divOuter').offset());$('#hideContent').css('margin-top', '35px'); $('.overlayContainer').show();" OnSelectedIndexChanged="RadComboBoxCategories_SelectedIndexChanged" >
                            </asp:DropDownList>
                        </p>
                    </div>
                


                    <%--*******--%>
                    <%--*RIGHT*--%>
                    <%--*******--%>
                        <div class="span11 rightDDL">
                                    
                            <%--*Indicator Drop Down Label*--%>
                            <p>
                                <asp:Label ID="lblIndicatorDisplay"  runat="server" Text="Indicator:" CssClass="ckd-select-indicator-label" AssociatedControlID="RadComboBoxIndicators"></asp:Label>
                            </p>                         
                            
                            <%--*Indicator Dropdown*--%>
                            <p>                                
                                &nbsp;<asp:DropDownList ID="RadComboBoxIndicators" runat="server"  OnSelectedIndexChanged="RadComboBoxIndicators_SelectedIndexChanged" OnDataBound="RadComboBoxIndicators_DataBound" AutoPostBack="true" CssClass="selectRounder" style="max-width:410px;" onchange="$('#hideContent').show();$('#hideContent').offset($('#hideContent').offset());$('#hideContent').css('margin-top', '35px'); $('.overlayContainer').show();">
                                    <asp:ListItem Text="Please select an indicator to continue ..." Value="-1" />
                                </asp:DropDownList>   
                            </p>
                                                              
                        </div>


                    <%--*GO Button*--%>
                        <div class="span2 btnSpan" style="text-align:left;">
                            <br />
                            <p>
                                &nbsp;<asp:ImageButton ID="cmdFindHealthData" runat="server" ImageUrl="~/images/disabled_go.gif" Width="41px" Height="23px" Enabled="false" CssClass="DisabledGoButton" AlternateText="Go" ToolTip="Make a Selection" Text="Go" OnClientClick="$('.overlayContainer, #hideContent').hide(); $('#OverlayModal').modal('show');" OnClick="cmdFindHealthData_Click1" />                                    
                            </p>
                        </div>
                </div> 


                <%--*Cancel Selection pop-up*--%>
                 <div id="cancelSelection" style="position:absolute; display:none; top:100px; left:877px; z-index:988888; background-color:#dfdfdf; opacity: 0.75; filter: alpha(opacity=75);">                         
                    <asp:ImageButton ID="btnClose" runat="server" ImageUrl="~/images/close.gif" ToolTip="Revert to previous selection" AlternateText="Revert to previous selection" OnClick="btnClose_Click"/>
                 </div>

                
            </ContentTemplate>
        </asp:UpdatePanel>

        <asp:HiddenField ID="hfIndicatorsDirty" runat="server" ClientIDMode="Static" Value="0" />
        <asp:HiddenField ID="hfTopicsDirty" runat="server" ClientIDMode="Static" Value="0" />
        


        <%--****************--%>
        <%--*Progress Panel*--%>
        <%--****************--%>
<%--        <asp:UpdateProgress ID="upIndicator" DynamicLayout="true" AssociatedUpdatePanelID="pnlInputs" runat="server">
            <ProgressTemplate>
                <div id="divWetBlanket" style="top: 0px; height: 5000px; padding-top: 180px; padding-left: 380px; margin: auto;
                    background-color: White; opacity: 0.75; filter: alpha(opacity=75); vertical-align: middle;
                    left: 0px; z-index: 999999; width: 2000px; position: absolute;">
                    <strong style="font-size: x-large">
                        <asp:Image ID="imgProgress" runat="server" AlternateText="Work Progress" ImageUrl="~/images/web20.gif" />
                        Please Wait... 
                    </strong>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>--%>



            <%--</div>--%>

    </div>
</div>

<br />


