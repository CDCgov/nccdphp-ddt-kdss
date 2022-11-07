<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Bibliography.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.Bibliography" %>

<style type="text/css">

    .liParagraphs
    {
        /*line-height:65%;*/
    }

    #wrapper
    {
        border-top:none;
    }

        /*#wrapper .external
        {
            margin-left: 5px !important;
        }*/

</style>
<script type="text/javascript">
    //$(document).ready(function () {
    //    //adding the external link classes to all bibliography links
    //    $("#lblBibliographyLink a").addClass("tp-link-policy tp-external-link-fix");
    //    $("#wrapper span a").append("<a href='//www.cdc.gov/Other/disclaimer.html' class='external tp-link-policy' title='External Web Site Icon' aria-label='External Web Site Icon'></a>");
        
    //});
    
</script>

        <h2>Bibliography</h2>
        <br />                
            
            <%--*******************--%>
            <%--*Bibliography Data*--%>
            <%--*******************--%>            
            <asp:Repeater ID="rptBib" runat="server">
                     <headertemplate>
                        <ul>
                    </headertemplate>
                    <itemtemplate>
                        <li>       
                            <p id="wrapper" class="liParagraphs">
                                <asp:label id="lblBibliographyMainText" CssClass="mainText" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"BibliographyText").ToString() %>'></asp:label>
                                &nbsp;
                                <asp:label id="lblBibliographyLink" runat="server" text='<%# DataBinder.Eval(Container.DataItem,"BibliographyLink").ToString() %>'></asp:label>                                                                                        
                            </p>
                                               
                            <br />
                        </li>
                    </itemtemplate>
                    <footertemplate>
                        </ul>
                    </footertemplate>
            </asp:Repeater>   