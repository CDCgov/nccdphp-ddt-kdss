<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AccordionIndicatorControlSearch.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.AccordionIndicatorControlSearch" %>



<asp:literal id="LitParentMeasure" runat="server" Text="" />
<asp:repeater id="rptIndicators" runat="server">

    <headertemplate>        
    </headertemplate>

    <itemtemplate>
        <tr class="ckd-accordion-indicator-row1">
            <th class="ckd-accordion-indicator-table-col1" scope="row">
                <div class="ckd-accordion-indicator-hover-area">
                    <asp:hyperlink id="lnkIndicator" runat="server" cssclass="ckd-accordion-indicator" navigateurl='<%#Eval("URL")%>'>                        
                        <asp:literal id="Literal1" runat="server" text='<%#Eval("QuestionText")%>'></asp:literal>
                    </asp:hyperlink>
                </div>
            </th>
            <td class="ckd-accordion-indicator-table-col2 text-center hide512">
                 <%#Eval("Most Recent Year")%>                
            </td>
            <td class="ckd-accordion-indicator-table-col3 hide767">
                <%#Eval("DataSources")%>                
            </td>
        </tr>
    </itemtemplate>


    <alternatingitemtemplate>
        <tr class="ckd-accordion-indicator-row2">
            <th class="ckd-accordion-indicator-table-col1" scope="row">
                <div class="ckd-accordion-indicator-hover-area">
                    <asp:hyperlink id="lnkIndicator" runat="server" cssclass="ckd-accordion-indicator" navigateurl='<%#Eval("URL")%>'>
                        <asp:literal id="Literal1" runat="server" text='<%#Eval("QuestionText")%>'></asp:literal>
                    </asp:hyperlink>                    
                </div>
            </th>
            <td class="ckd-accordion-indicator-table-col2 text-center hide512">
                <%#Eval("Most Recent Year")%>                
            </td>
            <td class="ckd-accordion-indicator-table-col3 hide767">
                <%#Eval("DataSources")%>                
            </td>
        </tr>
    </alternatingitemtemplate>
    <footertemplate>
        </table>
    </footertemplate>


</asp:repeater>