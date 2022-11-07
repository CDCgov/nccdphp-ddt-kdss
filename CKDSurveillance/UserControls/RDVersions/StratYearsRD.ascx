<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StratYearsRD.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.RDVersions.StratYearsRD" %>
    
    <div class="btn-group ddlStrats col-lg-12 pull-left">
        <asp:HiddenField id="hfCurrentStrat" ClientIDMode="Static" runat="server" Value="" />   
        <asp:Repeater ID="rptViewDataBy" runat="server">
             <HeaderTemplate>
                 <a class="btn dropdown-toggle" data-toggle="dropdown" href="#" style="text-decoration:none; cursor:pointer;">View Data By: <span id="spanCSS"></span><span class="caret"></span></a>
                <ul class="dropdown-menu">
            </HeaderTemplate>

            <ItemTemplate>            
                <li style="margin-left:.3em;">
                    <asp:HyperLink ID="hlStratNav" ClientIDMode="AutoID" runat="server" NavigateUrl='<%# Eval("link") %>' Text='<%# Eval("ViewBy") %>' style="text-decoration:none;" />
                </li>
            </ItemTemplate>
            
            <FooterTemplate>
                </ul>
            </FooterTemplate>

        </asp:Repeater>

    </div>

    <br />

    <div class="btn-group ddlYears col-lg-12 pull-left">
            <asp:HiddenField id="hfCurrentYear" ClientIDMode="Static" runat="server" Value="" />
            <asp:Repeater ID="rptViewDataFor" runat="server">
             <HeaderTemplate>
                 <a class="btn dropdown-toggle" data-toggle="dropdown" href="#" style="text-decoration:none; cursor:pointer;">View Data For: <span id="spanCYR"></span><span class="caret"></span></a>
                <ul class="dropdown-menu">
            </HeaderTemplate>
            
                <ItemTemplate>            
                <li style="margin-left:.3em; text-decoration:none;">
                    <asp:HyperLink ID="hlYearNav" ClientIDMode="AutoID" runat="server" NavigateUrl='<%# Eval("link") %>' Text='<%# Eval("Year") %>' style="text-decoration:none;"/>
                </li>
            </ItemTemplate>
            
                <FooterTemplate>
                </ul>                        
            </FooterTemplate>

        </asp:Repeater>


    </div>



<script type="text/javascript">

    $(document).ready(function () {
        //Set the DDL text to include current Data Source
        var hfs = $('#hfCurrentStrat').val();
        var hfy = $('#hfCurrentYear').val();
        $('#spanCSS').text(" (" + hfs + ")");
        $('#spanCYR').text(" (" + hfy + ")");
    });

</script>