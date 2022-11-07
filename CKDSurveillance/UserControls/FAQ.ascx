<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FAQ.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FAQ" %>


            <h2 class="foc">FAQs</h2>
            <br />

            <%--***********--%>
            <%--*Questions*--%>
            <%--***********--%>           
            <a href="#answers" class="skippy" title="Skip to Answers">Skip to Answers</a>            
            <div class="module roundem faqs">
	            <div class="inner">
                <h4>On this page</h4>
                <asp:Repeater ID="rptQuestions" runat="server">
                     <headertemplate>
                        <table>
                    </headertemplate>
                    <itemtemplate>
                        <tr>
                            <td valign="top" style="padding: 4px 4px 2px 0px;"><asp:literal id="litNumber" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"RowNumber").ToString() + ". " %>' /></td>
                            <td valign="top" style="padding: 4px 4px 2px 0px;"><a href="#<%# DataBinder.Eval(Container.DataItem,"RowNumber").ToString()  %>"><asp:literal id="litQuestionLink" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"FAQQuestion").ToString() %>' /></a></td>
                        </tr>
                    </itemtemplate>
                    <footertemplate>
                        </table>
                    </footertemplate>
                </asp:Repeater>
                </div>
             </div>

            <br />

            <%--*********--%>
            <%--*Answers*--%>
            <%--*********--%>
            <a id="answers"></a>           
            <asp:Repeater ID="rptAnswers" runat="server">                
                     <headertemplate>
                        <ul style='list-style-type:none;'>
                    </headertemplate>
                    <itemtemplate>
                    <p>
                        <a id='<%# DataBinder.Eval(Container.DataItem,"RowNumber").ToString() %>'></a> 
                    </p>
                        <li>                              
                            <p>
                                <strong>                                                                          
                                    <asp:label id="lblQuestion" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"RowNumber").ToString() + ". " %>'></asp:label>
                                    <asp:label id="LblQuest" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"FAQQuestion").ToString() %>'></asp:label>
                                </strong>
                            </p>                            
                            
                            <asp:label id="lblAnswer" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"FAQAnswer").ToString() %>'></asp:label>                                                        

                            <br />
                            <a href="#nav-container" class="back-to-top">Back to Top</a>
                            <br />
                        </li>
                    </itemtemplate>
                    <footertemplate>
                        </ul>
                    </footertemplate>
            </asp:Repeater>
