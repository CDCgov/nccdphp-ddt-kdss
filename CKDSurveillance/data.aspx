<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Data.aspx.cs" Inherits="CKDSurveillance_RD.Data" MasterPageFile="~/MasterPages/ResponsiveContentLeftNav.Master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    <style>
        .accordion-table-header {
            text-align: center;
            font-weight: bold;
            color: #1a7aa2;
            font-size: 16px;
        }

        .dsList {
            border-radius: 5px;
            border: solid 1px silver;
            background-color: whitesmoke;
            display: none;
            z-index: 1000;
            cursor: pointer;
            display: block;
            position: absolute;
            overflow-y: auto;
            max-height: 400px;
            background-clip: padding-box;
            box-shadow: 0 5px 10px rgba(0,0,0,0.2);
        }

            .dsList ul {
                padding: 0;
                margin: 0;
                list-style: none;
                text-align: left;
            }

        .dsSearch {
            cursor: pointer;
        }
    </style>
    <asp:Panel ID="pnlIndicators" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-xl-1"></div>
                <div class="col-xl-10">
                    <div class="Pagetitle" runat="server" id="_dvPageTitle">
                        <asp:Literal ID="litBrowseLabel" runat="server" Text="Browse Data by Topic"></asp:Literal>
                    </div>
                </div>
                <div class="col-xl-1"></div>
            </div>
        </div>
        <div class="container">
            <div class="row" style="padding-bottom: 10px;">
                <div class="col-md-8"></div>
                <div class="col-md-3 col-sm-12 text-right">
                    <button class="openall btn btn-primary">&nbsp;Expand All&nbsp;</button>
                    <button class="closeall btn btn-primary">&nbsp;Collapse All&nbsp;</button>
                </div>
            </div>
            <div class="row">
                <div class="col-xl-1"></div>
                <div class="col-xl-10">
                    <div class="row ckd-accordion-table-header-row">
                        <div class="col-7 accordion-table-header">Indicators</div>
                        <div class="col-2 accordion-table-header">Most Recent Year</div>
                        <div class="col-3 accordion-table-header">
                            Data Source<a id="btnOpenDS" tabindex="0" class="glyphicon glyphicon-search dsSearch" onclick="toggleDSList(this);">&nbsp;<img id="imgFunnel" src="./images/funnel2.png" style="width: 14px; height: 14px;" alt="filter by data sources" title="Filter By Data Source" /></a>

                            <%--***********************************--%>
                            <%--*List of Data Sources (short name)*--%>
                            <%--***********************************--%>
                            <asp:Literal ID="litDataSources" runat="server" Text="" ClientIDMode="Static" />
                        </div>
                    </div>
                </div>
                <div class="col-xl-1"></div>
            </div>
            <div class="row">
                <div class="col-xl-1"></div>
                <div class="col-xl-10">
                    <div class="accordion indicator-plus accordion-white" aria-multiselectable="true" role="tabpanel">

                        <asp:Literal ID="litIndicators" runat="server"></asp:Literal>
                    </div>
                </div>
                <div class="col-xl-1"></div>
            </div>

            <div class="row" style="padding-top: 10px">
                <div class="col-xl-1"></div>
                <div class="col-xl-10">
                    <div class="row ckd-accordion-table-header-row">
                        <div class="col-7 accordion-table-header">Focus on Populations</div>
                        <div class="col-2 accordion-table-header">Most Recent Year</div>
                        <div class="col-3 accordion-table-header">Data Source</div>
                    </div>
                </div>
                <div class="col-xl-1"></div>
            </div>
            <div class="row">
                <div class="col-xl-1"></div>
                <div class="col-xl-10">
                    <div class="accordion indicator-plus accordion-white" aria-multiselectable="true" role="tabpanel">

                        <asp:Literal ID="litSpecialPops" runat="server"></asp:Literal>
                    </div>
                </div>
                <div class="col-xl-1"></div>
            </div>
        </div>
    </asp:Panel>

    <%--*******************************--%>
    <!--*Show Healthy People 2020 text*-->
    <%--*******************************--%>
    <asp:Panel ID="pnlHP2020" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-xl-1"></div>
                <div class="col-xl-10">
                    <div id="_dvHP2020Description" runat="server" style="clear: both; margin-top: 10px" class="module roundem faqs padcontents10">

                        <div>
                            <%--ML added per Diane's e-mail request 8/27/2013--%>
                            <%--ML Updated per Nilka's request 11/2020--%>
                            <em>Healthy People</em> provides a comprehensive set of 10-year, national goals and objectives for improving the health of all Americans. 
                            For <em>Healthy People 2020</em>, 10 of the 14 objectives that relate to chronic kidney disease are described below with corresponding links to Surveillance System indicators.
                            Click an indicator name to view its charts and tables. 
                                                                                          
                            <div class="" style="margin-top: 10px">
                                <div class="row">
                                    <%--*2020*--%>
                                    <div class="col-lg-6">
                                        <asp:HyperLink
                                            ID="lnkHealthy2020WebSite" runat="server" NavigateUrl="https://www.healthypeople.gov/2020/topics-objectives/topic/chronic-kidney-disease/objectives"
                                            Text="View the CKD objectives for Healthy People 2020" Target="_blank">
                                        </asp:HyperLink>
                                    </div>
                                    <%--*2030*--%>
                                    <div class="col-lg-6">
                                        <asp:HyperLink
                                            ID="lnkHealthy2030Objectives" runat="server" NavigateUrl="https://health.gov/healthypeople/objectives-and-data/browse-objectives/chronic-kidney-disease"
                                            Text="View the CKD objectives for Healthy People 2030" Target="_blank">
                                        </asp:HyperLink>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-1"></div>
            </div>

            <div class="row" style="padding-bottom: 10px; margin-top: 10px;">
                <div class="col-md-8"></div>
                <div class="col-md-4 col-sm-12">
                    <button class="openall btn btn-primary b-primary">&nbsp;Expand All&nbsp;</button>
                    <button class="closeall btn btn-primary b-primary">&nbsp;Collapse All&nbsp;</button>
                </div>
            </div>
            <div class="row">
                <div class="col-xl-1"></div>
                <div class="col-xl-10">
                    <div class="row ckd-accordion-table-header-row">
                        <div class="col-7 accordion-table-header">Indicators Related To <em>Healthy People 2020</em> Objectives</div>
                        <div class="col-2 accordion-table-header">Most Recent Year</div>
                        <div class="col-3 accordion-table-header">Data Source</div>
                    </div>
                </div>
                <div class="col-xl-1"></div>
            </div>
            <div class="row">
                <div class="col-xl-1"></div>
                <div class="col-xl-10">
                    <div class="accordion indicator-plus accordion-white" aria-multiselectable="true" role="tabpanel">

                        <asp:Literal ID="litHp2020" runat="server"></asp:Literal>
                    </div>
                </div>
                <div class="col-xl-1"></div>
            </div>

        </div>

    </asp:Panel>
    <br />
    <br />
    <br />

    <!-- 10/30/2019 From Thach @ CDC -->
    <script type="text/javascript">

        $('#pnlIndicators a.card-title').on('keyup', function (e) { (e.which == 13 ? $(this).click() : "") });


        //DS arrow - keyboard navigable
        $('#btnOpenDS').on('keyup', function (e) { (e.which == 13 ? $(this).click() : "") });


        function toggleDSList(btn) {
            $('.dsList').slideToggle(500);
        }
    </script>

</asp:Content>
