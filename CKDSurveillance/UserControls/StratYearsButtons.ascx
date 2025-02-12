<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StratYearsButtons.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.StratYearsButtons" %>

<%--****************--%>
<%--*Control Styles*--%>
<%--****************--%>
<style type="text/css">
    /*Containing Div*/
    .stratButtonsContainingDiv
    {        
        width: 175px;
        background-color: #f6fbff;
        padding: 3px 3px 3px 3px;
        margin-top: .7em;
        margin-bottom: 1em;
    }

    .YearButtonsContainingDiv
    {
        width: 175px;
        background-color: #f6fbff;
        padding: 3px 3px 3px 3px;
        margin-bottom: 1em;
    }

    /*Strat Table*/
    .stratTable
    {
        width: 173px;
        margin-left: 2px;
    }

    .stratTableLeftColumn
    {
        width: 21%;
        padding-bottom: 7px;
    }

    .stratTableRightColumn
    {
        max-width: 78%;
        padding-bottom: 7px;
        padding-right: 1px;
    }

    /*Year Table*/
    .yearTable
    {
        width: 173px;
        margin-left: 2px;
    }

    .yearTableLeftColumn
    {
        width: 20%;
        padding-bottom: 7px;
    }

    .yearTableRightColumn
    {
        width: 79%;
        padding-bottom: 7px;
    }

    .sybFieldSet
    {
        margin-left: 2px;
    }
</style>




<asp:Panel ID="pnlQuintileRanges" CssClass="ccolstyle" ClientIDMode="Static" runat="server">
    <%--************************--%>
    <%--*Quintile Color Choices*--%>
    <%--************************--%>
    <div class="stratButtonsContainingDiv roundMe widgetBorder">
        <h3 class="widgetTitleH3" style="width: 99%; margin-left: -.17em; margin-top: -.2em; font-size: 1.1em; border-bottom: solid .1em silver; font-family: Poppins;">
            <strong>Define Ranges</strong>&emsp;&emsp;<img id="imgHelpColors" src="images/help_transBG.png" alt="Description of map color options" title="Description of color options" />
        </h3>

        <br />


        <table class="stratTable">
            <tr>
                <td valign="top" class="stratTableLeftColumn">
                    <asp:ImageButton ID="btnColorRangesAllCharts" ClientIDMode="Static" runat="server" ImageUrl='~/images/Go_Clicked.png' AlternateText="GO" ToolTip='' OnClientClick="$('#OverlayModal').modal('show');" OnClick="btnColorRangesAllCharts_Click" />
                </td>

                <td valign="top" class="stratTableRightColumn">
                    <asp:Literal ID="litAllCharts" ClientIDMode="Static" runat="server" Text='Across All Years'></asp:Literal>
                </td>
            </tr>
            <tr>
                <td valign="top" class="stratTableLeftColumn">
                    <asp:ImageButton ID="btnColorsOneYear" ClientIDMode="Static" runat="server" ImageUrl='~/images/Go.png' AlternateText="GO" ToolTip='' OnClientClick="$('#OverlayModal').modal('show');" OnClick="btnColorsOneYear_Click" />
                </td>

                <td valign="top" class="stratTableRightColumn">
                    <asp:Literal ID="litChosenYear" ClientIDMode="Static" runat="server" Text='Chosen Year'></asp:Literal>
                </td>
            </tr>            
        </table>

    </div>
</asp:Panel>


<%--<div id="divStratButtonOuter" class="stratButtonsContainingDiv roundMe widgetBorder">--%>

    <%--********--%>
    <%--*Strats*--%>
    <%--********--%>
    <asp:Repeater ID="rptStratButtons" runat="server" OnItemDataBound="rptStratButtons_ItemDataBound">
        <HeaderTemplate>
            <%--<fieldset>--%>
                <h3 class="widgetTitleH3" style="width: 99%; margin-left: -.17em; margin-top: -.2em; font-size: 1.1em; border-bottom: solid .1em silver ;font-family: Poppins;">
                    <strong>View Data By:</strong>
                </h3>
                <br />
                <table class="stratTable">
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td valign="top" class="stratTableLeftColumn">
                    <asp:HyperLink ID="hlStratNav" runat="server" NavigateUrl='<%# Eval("link") %>' Text="">
                        <span class="accessibleHide"><%# Eval("ViewBy") %></span>
                        <asp:Image ID="imgStratnav" runat="server" ImageUrl='<%#Eval("buttonLink") %>' AlternateText="GO" ToolTip='<%# Eval("ViewBy") %>' />
                    </asp:HyperLink>
                </td>
                <td valign="top" class="stratTableRightColumn">
                    <asp:Literal ID="litStratText" runat="server" Text='<%# Eval("ViewBy") %>'></asp:Literal>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </table>
            
            <%--</fieldset>--%>
        </FooterTemplate>
    </asp:Repeater>
<%--</div>--%>



<asp:Panel ID="pnlYears" CssClass="ccolstyle" runat="server">
    <div id="divYearButtonOuter" class="YearButtonsContainingDiv roundMe widgetBorder" style="margin-top: 0em;">

        <%--*******--%>
        <%--*Years*--%>
        <%--*******--%>

        <asp:Repeater ID="rptYearButtons" runat="server" OnItemDataBound="rptYearButtons_ItemDataBound">
            <HeaderTemplate>
                <br />
                <%--<fieldset>--%>

                    <h3 class="widgetTitleH3" style="width: 99.5%; margin-left: -.23em; margin-top: -1.65em; font-size: 1.1em; border-bottom: solid .1em silver; border-top: solid .1em silver; font-family: Poppins;">
                        <strong>View Data For:</strong>
                    </h3>

                    <br />

                    <table class="yearTable">
            </HeaderTemplate>

            <ItemTemplate>
                <tr>
                    <td valign="top" class="yearTableLeftColumn">
                        <asp:HyperLink ID="hlYearNav" runat="server" NavigateUrl='<%# Eval("link") %>' Text="">
                            <span class="accessibleHide"><%# Eval("Year") %></span>
                            <asp:Image ID="imgYearnav" runat="server" ImageUrl='<%# Eval("buttonLink") %>' AlternateText="GO" ToolTip='<%# Eval("Year") %>' />
                        </asp:HyperLink>
                    </td>
                    <td valign="top" class="yearTableRightColumn">
                        <asp:Literal ID="litYearText" runat="server" Text='<%# Eval("Year") %>'></asp:Literal>
                    </td>
                </tr>
            </ItemTemplate>

            <FooterTemplate>
                </table>
                <%--</fieldset>--%>
            </FooterTemplate>
        </asp:Repeater>

    </div>
</asp:Panel>

<asp:HiddenField ID="hfCSVYears" runat="server" ClientIDMode="Static" Value="" />
