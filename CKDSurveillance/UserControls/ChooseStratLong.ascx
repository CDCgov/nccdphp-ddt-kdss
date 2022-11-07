<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChooseStratLong.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.ChooseStratLong" %>

<style type="text/css">
    .headerDiv
    {
        font-size:16px;
        font-weight:bold;

        color:#1a7aa2;
        background-color:#c5ded6;
        
        border-top-left-radius:10px;
        border-top-right-radius:10px;
        
        padding-top:3px;
        padding-bottom:3px;
    }
    .stratLongDiv
    {
        /*padding-left:5px;
        padding-top:2px;
        padding-right:2px;
        padding-bottom:2px;*/
    }
    /*td span{display:table-cell; text-align:center; white-space:nowrap;}*/
</style>

<br />
<br />

<div class="roundMe widgetBorder stratLongDiv">
    
    <%--<h3 class="widgetTitleH3" style="width: 99%; margin-left: -.17em; margin-top: -.2em; font-size: 1.1em; border-bottom: solid .1em silver">--%>
            <div class="headerDiv">
                <strong>&nbsp;&nbsp;Choose Specific Stratifications And Years</strong>&emsp;&emsp;<img id="imgHelpColors" src="images/help_transBG.png" alt="Choose a subset of available stratifications and years" title="Choose a subset of available stratifications and years" />
            </div>
    <%--</h3>--%>
    
    <table style="padding-left:5px; width:100%;" class="table">

        <tbody>
            <tr>
                <th scope="row" style="background-color:whitesmoke; text-align:left; border:solid 1px silver;">&nbsp;Strats</th>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnlStrats" runat="server">
                        <table class="table" style="padding-left:5px; width:100%;">
                            <tr>
                                <td>All Strats</td>
                                <td>Unmeasured</td>
                                <td>eGFR 90+</td>
                                <td>eGFR 60-89</td>
                                <td>CKD Stage 3</td>
                                <td>CKD Stage 4</td>
                                <td>CKD Stage 5</td>
                                <td>Dialysis</td>
                                <td>Transplant</td>
                            </tr>
                            <tr>
                                <td><asp:CheckBox ID="cbAllStrats" class="allStratsCB" dbField="All Strats" ClientIDMode="Static" runat="server" Text=""/></td>
                                <td><asp:CheckBox ID="cbUnmeasured" CssClass="stratCB" dbField="unmeasured" runat="server" Text="" /></td>
                                <td><asp:CheckBox ID="cbeGFR90" CssClass="stratCB" dbField="eGFR 90+" runat="server" Text="" /></td>
                                <td><asp:CheckBox ID="cbeGFR6089" CssClass="stratCB" dbField="eGFR 60-89" runat="server" Text="" /></td>
                                <td><asp:CheckBox ID="cbStage3" CssClass="stratCB" dbField="CKD Stage 3" runat="server" Text="" /></td>
                                <td><asp:CheckBox ID="cbStage4" CssClass="stratCB" dbField="CKD Stage 4" runat="server" Text="" /></td>
                                <td><asp:CheckBox ID="cbStage5" CssClass="stratCB" dbField="CKD Stage 5" runat="server" Text="" /></td>
                                <td><asp:CheckBox ID="cbDialysis" CssClass="stratCB" dbField="Dialysis" runat="server" Text="" /></td>
                                <td><asp:CheckBox ID="cbTransplant" CssClass="stratCB" dbField="Transplant" runat="server" Text="" /></td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>                
            </tr>
            <tr>
                <th scope="row" style="background-color:whitesmoke; text-align:left; border:solid 1px silver;">&nbsp;Years</th>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnlYearsCBs" runat="server">
                        <table class="table" style="padding-left:5px; width:100%;">
                            <tr>
                                <td>All Years</td>
                                <td>2011</td>
                                <td>2010</td>
                                <td>2009</td>
                                <td>2008</td>
                                <td>2007</td>
                                <td>2006</td>
                                <td>2005</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><asp:CheckBox ID="cbAllYears" class="allYearsCB" dbField="All Years" ClientIDMode="Static" runat="server" Text=""/></td>
                                <td><asp:CheckBox ID="cb2011" class="yearCB" dbField="2011" runat="server" ClientIDMode="Static" Text="" /></td>
                                <td><asp:CheckBox ID="cb2010" class="yearCB" dbField="2010" runat="server" ClientIDMode="Static" Text="" /></td>
                                <td><asp:CheckBox ID="cb2009" class="yearCB" dbField="2009" runat="server" ClientIDMode="Static" Text="" /></td>
                                <td><asp:CheckBox ID="cb2008" class="yearCB" dbField="2008" runat="server" ClientIDMode="Static" Text="" /></td>
                                <td><asp:CheckBox ID="cb2007" class="yearCB" dbField="2007" runat="server" ClientIDMode="Static" Text="" /></td>
                                <td><asp:CheckBox ID="cb2006" class="yearCB" dbField="2006" runat="server" ClientIDMode="Static" Text="" /></td>
                                <td><asp:CheckBox ID="cb2005" class="yearCB" dbField="2005" runat="server" ClientIDMode="Static" Text="" /></td>
                                <td></td> 
                            </tr>
                        </table>
                    
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td colspan="9" style="text-align:left;">
                    <asp:Button ID="btnSubmitStratChoices" runat="server" Text="Submit Choices" ClientIDMode="Static" CssClass="btn btn-medium" OnClick="btnSubmitStratChoices_Click" />
                </td>
            </tr>
        </tbody>
        
    </table>


<%--*Dynamic Table*--%>

<%--    <table style="padding-left:5px; width:100%;" class="table">
        
        <!--*Strats*-->
        <tr>
            <th scope="row" style="background-color:whitesmoke; text-align:left; border:solid 1px silver;">&nbsp;Strats</th>
        </tr>        
        <tr>
            <asp:Repeater ID="rptChooseStrats" runat="server">        
                <ItemTemplate>
                    <td  style="text-align:center; justify-content:center;">
                        <%# Container.DataItem.ToString() %>
                        <br />
                        <asp:CheckBox ID="cbStrats" runat="server" dbField='<%# Container.DataItem.ToString() %>' class="stratCB" />
                    </td>
                </ItemTemplate>        
            </asp:Repeater>
        </tr>--%>
        

<%--        <!--*Years*-->
        <tr>
            <th scope="row" style="background-color:whitesmoke; text-align:left; border:solid 1px silver;">&nbsp;Years</th>
        </tr>
        <tr>
            <asp:Repeater ID="rptChooseYears" runat="server">        
                <ItemTemplate>
                    <td style="text-align:center; justify-content:center;">
                        <%# Container.DataItem.ToString() %>
                        <br />
                        <asp:CheckBox ID="cbYears" runat="server" dbField='<%# Container.DataItem.ToString() %>' class="yearCB" />
                    </td>
                </ItemTemplate>        
            </asp:Repeater>
        </tr>
    </table>--%>


</div>
<br />
<br />