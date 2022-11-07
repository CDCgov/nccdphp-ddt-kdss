<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NonDayWidget.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.NonDayWidget" %>


<div class="NDW">     
    <div>       
        <div id="divPlaceHolder" > <!--height:175px; width:300px">-->            
                <a href="https://www.cdc.gov/kidneydisease/prevention-risk/take-care.html" alt="Take Care of Your Kidneys" target="_blank">
                    <img id="imgNDW" src="images/nonDayWidget2.jpg" alt="Take care of your kidneys" style="width:385px;" />                    
                </a>                                          
        </div>
        
        <br />

        <%--<table style="border-collapse:collapse;">
            <tr>
                <td style="padding:4px; vertical-align:top;">
                    <div class="oneColumn bulleted-links WHDLinks">
                        <ul class="list-bullet">
                            <li>
                                <asp:HyperLink ID="hlAgeAdjustedPrevalence" runat="server" CssClass="ckd-faq-link" text="Age-Adjusted Prevalence of CKD Stages 1-4 by Diabetes" NavigateUrl="~/detail.aspx?Qnum=Q10&Strat=Diabetes#refreshPosition" />                                 
                            </li>
                            <li>
                                <asp:HyperLink ID="hlStageDiabetes" runat="server" CssClass="ckd-faq-link" text="Disease Awareness by CKD Stage and Diabetes" NavigateUrl="~/detail.aspx?Qnum=Q98&Strat=CKD+Stage%2c+Diabetes#refreshPosition" />                                 
                            </li>                            
                        </ul>
                    </div>
                </td>
            </tr>
        </table>--%>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        setTimeout(function () {
            $('.NDW').find('.sprite-16-pdf').remove();
        }, 150);

    });
</script>