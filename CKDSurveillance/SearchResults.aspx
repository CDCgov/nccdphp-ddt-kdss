<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ResponsiveContentLeftNav.Master" AutoEventWireup="true" CodeBehind="SearchResults.aspx.cs" Inherits="CKDSurveillance_RD.SearchResults" %>

<%@ Register Src="~/UserControls/SuggestedCitationControl.ascx" TagPrefix="uc1" TagName="SuggestedCitationControl" %>



<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .Pagetitle, .citationFooter {
            padding-left: 30px;
        }        

        .HintContent {
            font-size: 14px;
            padding: 1em;
            text-align: left;
            display: none;
            overflow: visible;
        }

            .HintContent:hover {
                background-color: #C8D5E4;
            }

        .HintToggle {
            text-decoration: underline;
            cursor: pointer;
        }

        .hintCloser {
            cursor: pointer;
            padding-left: 8px;
            padding-right: 8px;
            padding-top: 3px;
            padding-bottom: 3px;
        }

            .hintCloser:hover {
                background: #1A7AA2;
                color: white;
                font-weight: bold;
                border-radius: 3px;
            }

        .HintTable, .HintTable td {
            border-collapse: collapse;
            border: solid 1px silver;
        }

        #hint-link {
            clear: right;
            float: right;
            padding-right: .5em;
        }

        .searchBox {
            padding-Top: 4px;
            padding-bottom: 4px;
        }

        @media screen and (max-width:977px) {
            .ckd-faq-glossary-area {
                display: none;
            }
        }

        .accordion-table-header {
            text-align: center;
            font-weight: bold;
            color: #1a7aa2;
            font-size: 16px;
        }
    </style>
</asp:Content>


<asp:Content ID="ContentJS" ContentPlaceHolderID="CustomJavaScript" runat="server">
</asp:Content>


<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">

    <%--************--%>
    <%--*Page Title*--%>
    <%--************--%>
    <div class="row">
        <div class="col-lg-10">
            <div id="top-container">
                <div class="Pagetitle" runat="server" id="_dvPageTitle">
                    <asp:Literal ID="litBrowseLabel" runat="server" Text="CKD Surveillance Search Results"></asp:Literal>
                </div>
            </div>
        </div>
        <div class="col-lg-2"></div>
    </div>


    <br />
    


    <%--******************--%>
    <%--*search-term-area*--%>
    <%--******************--%>
    <div id="divCombineLogoCopy" class="row">
        <div class="col-lg-3"></div>
        <div class="col-lg-5">

            <%--*Row*--%>
            <div class="row">
                <br />

                <%--*Main Search Box*--%>
                <div class="col-xl-12">
                    <asp:Label ID="lblSearch" AssociatedControlID="txtSearch" runat="server" Text="Search Term(s):" />
                    <br />
                    <div class="input-group mb-3" style="cursor: pointer;">
                        <asp:TextBox ID="txtSearch" class="searchbox form-control" onkeypress="checkTXTForSubmit(event);" CssClass="form-control" runat="server" ToolTip="Submitted Search Terms" MaxLength="200" />
                        <div class="input-group-append">
                            <span class="input-group-text btn-primary" id="basic-addon2" tabindex="0" onkeypress="checkTXTForSubmit(event,'submitArea');" onclick="triggerSearch();" style="max-height:40px;">
                                <asp:LinkButton ID="btnSearch2" runat="server" ClientIDMode="Static" CssClass="btn btn-link" ForeColor="White" ToolTip="Submit new keyword search" AlternateText="submit new keyword search" OnClick="btnSearch_Click" Text="<i class='fi cdc-icon-magnify x24' aria-hidden='true'></i>" />  <%--Text="<i class='fa fa-search'></i>" />--%>
                            </span>
                        </div>
                    </div>

                    <%--*Search Hints (Toggler)*--%>
                    <div style="text-align: right; font-size: 14px;">
                        <a href="" class="HintToggle" style="text-align: right;" onkeypress="manageKeyboardToggle(event,this);" onclick="$('.HintContent').slideToggle(500); return false;"><em>Search Hints</em></a>
                    </div>

                </div>
            </div>

        </div>
        <div class="col-md-4"></div>
    </div>


    <%--*******--%>
    <%--*HINTS*--%>
    <%--*******--%>
    <div class="row">
        <div class="col-lg-3"></div>
        <div class="col-lg-5 hints HintContent">

            <%--*Close*--%>
            <div class="float-right hintCloser" tabindex="0" onkeypress="manageKeyboardToggle(event,this);" onclick="$('.HintContent').slideToggle('500'); return false;">X</div>

            <%--*Hints*--%>            
             Try double quotes " " around multiple terms to search for an exact phrase.                                             
            <ul>
                <li>(<em>e.g.,</em><strong>"Acute Kidney Injury"</strong>)</li>
            </ul>

            <br />

            Use <strong>OR</strong> to search for pages with <em>any</em> of the provided terms. 
            <ul>
                <li>(<em>e.g.,</em><strong>"AKI"</strong> or <strong>"Acute Kidney Injury"</strong>)</li>
            </ul>

        </div>
        <div class="col-lg-4"></div>
    </div>

    <br />
    <br />
    <br />    

    <%--**********************************--%>
    <!--*Regular Questions and Indicators*-->
    <%--**********************************--%>
    <div id="bottom-container">
        <div class="container resultFrameWork">
            <div class="row" style="padding-bottom: 10px;">
                <div class="col-md-8"></div>
                <div class="col-md-3 col-sm-12 text-right">
                    <button class="openall btn btn-primary" onclick="expandAllTopics(); return false;">&nbsp;Expand All&nbsp;</button>
                    <button class="closeall btn btn-primary" onclick="collapseAllTopics(); return false;">&nbsp;Collapse All&nbsp;</button>
                </div>

            </div>
            <div class="row">
                <div class="col-xl-1"></div>
                <div class="col-xl-10">
                    <div class="row ckd-accordion-table-header-row">
                        <div class="col-7 accordion-table-header">Indicators From Search Results</div>
                        <div class="col-2 accordion-table-header">Most Recent Year</div>
                        <div class="col-3 accordion-table-header">Data Source</div>
                    </div>
                </div>
                <div class="col-xl-1"></div>
            </div>
            <div class="row">
                <div class="col-xl-1"></div>
                <div class="col-xl-10">
                    <div class="accordion indicator-plus accordion-white searchResultsPane" aria-multiselectable="true" role="tabpanel">
                        <asp:Literal ID="litIndicators" runat="server"></asp:Literal>
                    </div>
                </div>
                <div class="col-xl-1"></div>
            </div>
        </div>



        <%--*****************--%>
        <%--*Results message*--%>
        <%--*****************--%>
        <div class="row">
            <div class="col-xl-4"></div>
            <div class="col-xl-4">
                <asp:Label ID="lblNoResults" runat="server" Text="<p style='color:maroon; font-weight:bold;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No results were found for this search term.</p>" Visible="false" />
            </div>
            <div class="col-xl-4"></div>
        </div>

        <br />
        <br />
        <br />
        <br />

        <%--********************--%>
        <%--*Suggested Citation*--%>
        <%--********************--%>
        <div class="citationFooter">
            <uc1:SuggestedCitationControl runat="server" ID="SuggestedCitationControl" />
        </div>

        <br />
        <br />

        
        <script type="text/javascript">

            $(document).ready(function () {

                //Check for no results
                formatForNoResults();

            });

            function manageKeyboardToggle(event, src) {
                var chCode = ('charCode' in event) ? event.charCode : event.keyCode;
                if (chCode == 13 || chCode == 32) {
                    $('.HintContent').slideToggle('500');

                    event.preventDefault();

                    return false;
                }
            }

            function checkTXTForSubmit(event, src) {

                //get code
                var chCode = ('charCode' in event) ? event.charCode : event.keyCode;

                if (src == 'submitArea') {
                    //Pressed Enter or space
                    if (chCode == 13 || chCode == 32) {
                        triggerSearch();
                    }
                } else {
                    //Pressed Enter
                    if (chCode == 13) {
                        triggerSearch();
                    }
                }

                return false;
            }

            function formatForNoResults() {

                //If the "no results" message is visible - hide the framework for the accordion
                if ($('#lblNoResults').is(':visible')) {
                    $('.resultFrameWork').hide();
                } else {
                    $('.resultFrameWork').show();
                }
            }

            function collapseAllTopics() {
                //*[Collapse all] button calls this*

                //[Indicators]
                $('.searchResultsPane [id^=accordion-4i-card]').each(function () {
                    var expanded = $(this).attr('aria-expanded');
                    if (expanded == "true") {
                        $(this).click();
                    }
                });

                //[Topics and measures]
                $('.searchResultsPane [id^=accordion-4m-card]').each(function () {
                    var expanded = $(this).attr('aria-expanded');
                    if (expanded == "true") {
                        $(this).click();
                    }
                });
            }
            function expandAllTopics() {
                //*[Expand all] button calls this*

                //[Indicators]
                $('.searchResultsPane [id^=accordion-4i-card]').each(function () {
                    var expanded = $(this).attr('aria-expanded');
                    if (expanded == "false") {
                        $(this).click();
                    }
                });

                //[Topics and measures]
                $('.searchResultsPane [id^=accordion-4m-card]').each(function () {
                    var expanded = $(this).attr('aria-expanded');
                    if (expanded == "false") {
                        $(this).click();
                    }
                });
            }

            function triggerSearch() {
                __doPostBack('ctl00$MainContentPlaceHolder$btnSearch2', '');
            }

            //Manage the subcat headers when keyboarding
            $('.ckd-accordion-subcat-header').on('keypress', function () {
                var chCode = ('charCode' in event) ? event.charCode : event.keyCode;
                if (chCode == 13 || chCode == 32) {
                    $(this).click();
                }
            });
        </script>
    </div>
</asp:Content>



