<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DataSourceDDLsRD.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.DataSourceDDLsRD" %>

<%--*Data Source Drop Downs (phone only)*--%>
<div id="divDataSourceHeader" style="background-color:#c5ded6; border:solid .1em silver;">Data Sources</div>
<div id="divDDLDatasources">        
        <asp:HiddenField id="hfCurrentDS" ClientIDMode="Static" runat="server" Value="" />        
        <div class="btn-group">
            <asp:Repeater ID="rptDDLDataSources" ClientIDMode="Static" runat="server">
                    <HeaderTemplate>
                        <a id="DSAnchor" class="btn dropdown-toggle" data-toggle="dropdown" href="#" style="text-decoration:none; cursor:pointer;">Data Sources:<span id="spanCDS"></span><span class="caret"></></a>
                    <ul class="dropdown-menu">
                </HeaderTemplate>
                <ItemTemplate>
            
                    <li style="margin-left:.3em;">
                        <asp:HyperLink ID="hlDataSourceNav" ClientIDMode="AutoID" runat="server" NavigateUrl='<%# Eval("Link") %>' Text='<%# Eval("DataSourceShortName") %>' style="text-decoration:none;" />
                    </li>
                </ItemTemplate>
                <FooterTemplate>
                    </ul>
                </FooterTemplate>

            </asp:Repeater>

        </div>    
</div>

<script type="text/javascript">

    $(document).ready(function () {
        //Set the DDL text to include current Data Source
        var hf = $('#hfCurrentDS').val();                
        $('#spanCDS').text(" (" + hf + ")");
    });

</script>

    