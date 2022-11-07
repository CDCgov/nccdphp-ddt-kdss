<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Glossary.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.Glossary" %>

<style type="text/css">

</style>

        <h2>Glossary</h2>
        <br />

        <div class="module roundem glossary">
	        <div class="inner">
		        <h4>On this page</h4>
		        <a href="#jump_AF">[A - F]</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#jump_GL">[G - L]</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#jump_MR">[M - R]</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#jump_SZ">[S - Z]</a>		        
            </div>
        </div>
            
            <%--*****--%>
            <%--*A-F*--%>
            <%--*****--%>
            <a name="jump_AF"></a>
            <h3 style="color:#1a7aa2">A-F</h3>
            <div class="glossaryAnswer">
            <asp:Repeater ID="rptGlossaryAF" runat="server">
                     <headertemplate>
                        <ul>
                    </headertemplate>
                    <itemtemplate>
                        <li>
                            <asp:Literal ID="litAnchorAF" runat="server"></asp:Literal>
                            
                            <strong>
                                <asp:label id="lblGlossaryTerm" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"GlossaryTerm").ToString() + ": " %>'></asp:label>
                            </strong>

                            <asp:label id="lblGlossaryDescription" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"GlossaryText").ToString() %>'></asp:label>                                                        
                            <br />                         
                        </li>
                    </itemtemplate>
                    <footertemplate>
                        </ul>
                    </footertemplate>
            </asp:Repeater>
            </div>
            <a href="#nav-container" class="back-to-top">Back to Top</a>

            <br />
            <br />


            <%--*****--%>
            <%--*G-L*--%>
            <%--*****--%>
            <a name="jump_GL"></a>
            <h3 style="color:#1a7aa2">G-L</h3>
            <div class="glossaryAnswer">
            <asp:Repeater ID="rptGlossaryGL" runat="server">
                     <headertemplate>
                        <ul>
                    </headertemplate>
                    <itemtemplate>
                        <li>
                            <asp:Literal ID="litAnchorGL" runat="server"></asp:Literal>
                            <strong><asp:label id="lblGlossaryTermGL" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"GlossaryTerm").ToString() + ": " %>'></asp:label></strong>
                            <asp:label id="lblGlossaryDescriptionGL" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"GlossaryText").ToString() %>'></asp:label>                            
                            <br />                            
                        </li>
                    </itemtemplate>
                    <footertemplate>
                        </ul>
                    </footertemplate>
            </asp:Repeater>
            </div>
            <a href="#nav-container" class="back-to-top">Back to Top</a>

            <br />
            <br />


            <%--*****--%>
            <%--*M-R*--%>
            <%--*****--%>
            <a name="jump_MR"></a>
            <h3 style="color:#1a7aa2">M-R</h3>
            <div class="glossaryAnswer">
            <asp:Repeater ID="rptGlossaryMR" runat="server">
                     <headertemplate>
                        <ul>
                    </headertemplate>
                    <itemtemplate>
                        <li>
                            <asp:Literal ID="litAnchorMR" runat="server"></asp:Literal>
                            <strong><asp:label id="lblGlossaryTermMR" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"GlossaryTerm").ToString() + ": " %>'></asp:label></strong>
                            <asp:label id="lblGlossaryDescriptionMR" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"GlossaryText").ToString() %>'></asp:label>                            
                            <br />                            
                        </li>
                    </itemtemplate>
                    <footertemplate>
                        </ul>
                    </footertemplate>
            </asp:Repeater>
            </div>
            <a href="#nav-container" class="back-to-top">Back to Top</a>

            <br />
            <br />


            <%--*****--%>
            <%--*S-Z*--%>
            <%--*****--%>
            <a id="jump_SZ" name="jump_SZ"></a>
            <h3 style="color:#1a7aa2">S-Z</h3>
            <div class="glossaryAnswer">
            <asp:Repeater ID="rptGlossarySZ" runat="server">
                     <headertemplate>
                        <ul>
                    </headertemplate>
                    <itemtemplate>
                        <li>
                            <asp:Literal ID="litAnchorSZ" runat="server"></asp:Literal>
                            <strong><asp:label id="lblGlossaryTermSZ" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"GlossaryTerm").ToString() + ": " %>'></asp:label></strong>
                            <asp:label id="lblGlossaryDescriptionSZ" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"GlossaryText").ToString() %>'></asp:label>                            
                            <br />                            
                        </li>
                    </itemtemplate>
                    <footertemplate>
                        </ul>
                    </footertemplate>
            </asp:Repeater>
            </div>
            <a href="#nav-container" class="back-to-top">Back to Top</a>   

            <br />
            <br />



            <%--***********--%>
            <%--*Footnotes*--%>
            <%--***********--%>
            <strong>Definitions adapted in part or in full from the following sources:</strong>

            <br />
            <br />
            <div class="FAQSources">
                <asp:Repeater ID="rptSources" runat="server">
                         <headertemplate>                        
                        </headertemplate>
                        <itemtemplate>                        
                                <p>
                                    <asp:label id="lblGlossaryFootnote" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"GlossaryFootnoteHTML").ToString() %>'></asp:label>                                    
                                </p>
                        </itemtemplate>
                        <footertemplate>                        
                        </footertemplate>
                </asp:Repeater>                
            </div>