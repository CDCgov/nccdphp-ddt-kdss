<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SuggestedCitationAndVersioning.ascx.cs" Inherits="CKDSurveillance_RD.UserControls.FPWidgets.SuggestedCitationAndVersioning" %>

<%--***********************************--%>
<%--*Suggested Citation and Versioning*--%>
<%--***********************************--%>

<div class="row">
    <div class="col-12">
        <div class="card card-multi border-0 mb-3 bg-white-l3">
            <br />
            <%--<div class="card-multi bt-4 bt-gray-d1 mb-3 h6" style="padding-left: 10px;">Citation And Version</div>--%>
            <div class="row" style="margin-left: 10px; margin-right: 10px;">
                <div class="col-sm-12">

                    <%--  <ul>
                        <li><em>Date Site Last Updated: </em><strong>
                            <asp:Label ID="lblLastUpdateDate" runat="server" /></strong></li>
                        <li><em>Current Site Version: </em><strong>
                            <asp:Label ID="lblCurrentVersion" runat="server" /></strong></li>
                    </ul>--%>

                    <em>Last Updated:</em>
                    <strong><asp:Label ID="lblLastUpdateDate" runat="server" /></strong>
                    <br />
                    <em>Site Version: </em>
                    <strong><asp:Label ID="lblCurrentVersion" runat="server" /></strong>
                    <br />
                    <hr />
                    <div style="padding-top: 2px;">
                        <p>
                            Centers for Disease Control and Prevention. Chronic Kidney Disease Surveillance System—United States.
                        </p>
                        <p>
                            website: <a href="https://nccd.cdc.gov/CKD/">https://nccd.cdc.gov/CKD/</a>
                        </p>
                    </div>

                    <br />
                </div>
            </div>
        </div>
    </div>
</div>
