<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SuggestedCitationControl.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.SuggestedCitationControl" %>


<div class="ckd-suggested-citation">
    
    <div style=" font-family:Verdana; font-size: 10pt;font-weight:bold;">
        <strong>Suggested Citation:</strong>
    </div>

    <div class="citation-block">
        <asp:Literal ID="litCitation" runat="server" />
    </div>

</div>

<script type="text/javascript">
   // $('.ckd-suggested-citation').corner();
</script>