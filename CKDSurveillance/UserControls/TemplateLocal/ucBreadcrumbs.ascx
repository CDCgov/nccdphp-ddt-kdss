<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucBreadcrumbs.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.TemplateLocal.ucBreadcrumbs" %>

<div class="bread-crumb" style="width:100%;">
    <span class="">
        <a class="no-link" href="http://www.cdc.gov/diabetes/programs/initiatives/kidney.html">Chronic Kidney Disease Home</a>
    </span>

    <span class="CKDHome" style="visibility:visible;">
        >&nbsp;<a id="defaultlink" class="no-link" href="../Default.aspx">CKD Surveillance Home</a>
    </span>

    <span class="ByTopic" style="visibility:visible;">
        >&nbsp;<a id="datalink" class="no-link" href="../data.aspx">Browse By Topic</a>
    </span> 

    <asp:Literal ID="litExtraCrumbs" runat="server" ClientIDMode="Static" Text="" />
</div>

<script type="text/javascript">

    $(document).ready(function () {

        var URL = window.location.pathname; // Gets page name
        var page = URL.substring(URL.lastIndexOf('/') + 1);

        switch (page.trim().toLowerCase()) {
            case 'default.aspx':
                $('.CKDHome').css('visibility', 'hidden');
                $('.ByTopic').css('visibility', 'hidden');
                break;
            case 'factorsofinterest.aspx':
                $('.ByTopic').css('visibility', 'hidden');
                break;
            case 'data.aspx':
                $('.ByTopic').css('visibility', 'hidden');
                break;
            case "detail.aspx":
                $('.ByTopic').css('visibility', 'hidden').text('');
                break;
        }        

            
        var document_href = document.location.href;

        if (document_href.toLowerCase().indexOf("topichome") > -1)
        {
            $('#defaultlink').attr("href", "../default.aspx");
            $('#datalink').attr("href", "../data.aspx");
        }            
        else
        {
            $('#defaultlink').attr("href", "default.aspx");
            $('#datalink').attr("href", "data.aspx");
        }                 
    });


</script>