<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DataSources.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.DataSources" %>



            <h2>Data Sources</h2>
            <br />

            <%--***********--%>
            <%--*Questions*--%>
            <%--***********--%>           
            <a href="#answers" class="skippy" title="Skip to Answers">Skip to Answers</a>            
            <div class="module roundem faqs">
	            <div class="inner">
                <h4>On this page</h4>
                <asp:Repeater ID="rptLabels" runat="server">
                     <headertemplate>
                        <table>
                    </headertemplate>
                    <itemtemplate>
                        <tr>                            
                            <td valign="top" style="padding: 4px 4px 2px 0px;"><a href="#<%# DataBinder.Eval(Container.DataItem,"DataSourceID").ToString()  %>"><asp:literal id="litQuestionLink" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"DatasourceAbbrText").ToString() %>' /></a></td>
                        </tr>
                    </itemtemplate>
                    <footertemplate>
                        </table>
                    </footertemplate>
                </asp:Repeater>
                </div>
             </div>


               <br />
               <br />

            <%--*********--%>
            <%--*Answers*--%>
            <%--*********--%>
            <a id="answers"></a>           
            <asp:Repeater ID="rptDesc" runat="server">                
                     <headertemplate>
                        <ul>
                    </headertemplate>
                    <itemtemplate>
                        <li>
                            <a id='<%# DataBinder.Eval(Container.DataItem,"DataSourceID").ToString() %>'></a>                                        
                            <strong>
                                <asp:label id="lblQuestion" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"DatasourceAbbrText").ToString() + ". " %>'></asp:label>                                    
                            </strong>                                                     
                            
                            <asp:label id="lblAnswer" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"DataSourceDescription").ToString() %>'></asp:label>

                            <br />
                            <a href="#nav-container" class="back-to-top">Back to Top</a>
                            <br />
                        </li>
                    </itemtemplate>
                    <footertemplate>
                        </ul>
                    </footertemplate>
            </asp:Repeater>