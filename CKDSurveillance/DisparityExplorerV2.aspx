<%@ Page Language="C#" MasterPageFile="~/MasterPages/ResponsiveContentLeftNavNew.Master" AutoEventWireup="true" CodeBehind="DisparityExplorerV2.aspx.cs" Inherits="CKDSurveillance_RD.DisparityExplorerV2" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .error-line {
            stroke: #777;            
        }

        .error-cap {
            stroke: #777;
            stroke-width: 2px;
        }

        div.tooltip {
            position: absolute;
            text-align: left;
            width: 140px;
            height: 55px;
            padding: 4px;
            font: bold 12px Nunito !important; /*sans-serif*/
            background: #DDD;
            border: 0px;
            border-color: #888;
            border-radius: 8px;
            pointer-events: none;
            display: none;
            opacity: 1;
        }

        .tick {
            font-size: 14px;
            font-family: Arial;
        }

        .axis--y > .tick > line {
            stroke: #aaa;
        }

        .axis--x > path { /*coloring the X axis bar to match the tick lines*/
            stroke: #aaa;
        }

        .axis--y > path { /*hiding the top line created by the y-axis, also hides the Y axis bar*/
            stroke: #fff;
        }

        .hidecheckbox {
            display: none;
        }

        .showcheckbox {
            display: block;
        }

        .intro {
            padding: 10px;            
            border: solid 1px silver;
            border-bottom-left-radius: 10px;
            border-bottom-right-radius: 10px;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
            font-size: 17px;
        }

        .cbarraydata {
            width: 15px !important;
        }

        .cbarraydata_label {
            display: block;
            width: 185px;
            text-align: left;
        }

        .cbcolorlbl {
            font-size: 10px;
        }

        .adjustlblcell {
            height: 25px;
        }

        .adjustlbl {
            font-weight: bold;
        }



        #spnViewDataTable {
            font-weight: bold;
            font-size: 16px;
            margin-left: 15px;
            margin-right: 15px;
            margin-top: 10px;
            margin-bottom: 10px;
            color: navy; /*#1a7aa2;*/
        }

            #spnViewDataTable:hover {
                cursor: pointer;
                text-decoration: underline;
            }

        .ulNoIndent {
            background-color: #f6fbff;
            border-bottom-left-radius: 5px;
            border-bottom-right-radius: 5px;
        }

            .ulNoIndent li {
                margin-bottom: 3px;
                padding-left: 12px !important;
                font-family: Verdana !important;
            }

        .ulNoIndent {
            padding-bottom: 5px;
        }

        li strong {
            font-family: Verdana !important;
        }

        .ckd-details-dynamic-table th, .ckd-details-dynamic-table td
        {
            padding-bottom:5px;
            padding-top:5px;
            padding-left:5px;
            padding-right:5px;
        }

        .tab-pane 
        {
            min-height:128px !important;
        }
    </style>


</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">
    

    <%--*Plotly Charting Tool*--%>
    <script src="scripts/plotly-latest.min.js"></script>


    <asp:Panel ID="pnlPlotly" runat="server" ClientIDMode="Static">
        <%--************************--%>
        <%--*  BEGIN Plotly Chart  *--%>
        <%--************************--%>

        <style type="text/css">
            .modebar-btn tp-link-policy {
                background-color: none !important;
            }

            .yerror {
                stroke: #bbb !important;
            }
        </style>

        <script type="text/javascript">
            $(function () {

                $('.modebar-group').each(function () {
                    $(this).find('[data-title="Produced with Plotly"]').parent.remove();//removing this anchor tag so that Plotly becomes 508 compliant.                                        
                });

                $(".main-svg").append("<desc>" + $('meta[name=description]').attr("content") + "</desc>");
                $(".main-svg").attr("alt", $('meta[name=description]').attr("content"));
            })

        </script>

        <%--************************--%>
        <%--*   END Plotly Chart   *--%>
        <%--************************--%>
    </asp:Panel>


    <script src="scripts/d3.v4.min.js"></script>
    <%--************************--%>
    <%--*      D3 Chart        *--%>
    <%--************************--%>


    <asp:HiddenField ID="HF_D3Data" runat="server" />
    <asp:HiddenField ID="HF_PlotlyData_NHW" runat="server" />
    <asp:HiddenField ID="HF_PlotlyData_NHB" runat="server" />
    <asp:HiddenField ID="HF_PlotlyData_OTH" runat="server" />
    <div class="Pagetitle">Disparity Explorer</div>

    <br />

    <div class="row-fluid">
        <div class="col-12 intro">
            Health disparities are differences in health outcomes that are seen across segments of the population. In some cases, apparent disparities may be explained by one or more factors. The disparities explorer allows you to explore evidence of disparity in CKD outcomes.
        </div>
    </div>

    <br />

    <div id="divPlotly" class="ChartArea">
        <asp:Literal ID="Lit_Plotly" runat="server"></asp:Literal>
        <div id="svgchart" class="svgchartclass" style="width: 100%;"></div>
    </div>
    <div class="row-fluid">
        <div class="col-12 intro">
            <div style="display: table;">
                <div style="display: table-row">
                    <!--first level-->
                    <div class="firstlevel" style="width: 25%; display: table-cell; vertical-align: top;">
                        <div style="display: table;">
                            <div style="display: table-row">
                                <div style="display: table-cell;" class="adjustlblcell">
                                    <label id="firstleveladjlbl" class="adjustlbl">Adjust for</label>
                                </div>
                            </div>
                            <div style="display: table-row">
                                <div style="display: table-cell">
                                    <input type="radio" id="firlev_1" name="firstlevelcb" class="cbarraydata" value="Age" style="float: left;" />
                                    <label for="firlev_1" class="cbarraydata_label" style="float: right">Age</label>
                                </div>
                            </div>
                            <div style="display: table-row">
                                <div style="display: table-cell">
                                    <input type="radio" id="firlev_2" name="firstlevelcb" class="cbarraydata" value="Year" style="float: left;" />
                                    <label for="firlev_2" class="cbarraydata_label" style="float: right">Year</label>
                                </div>
                            </div>
                            <div style="display: table-row">
                                <div style="display: table-cell">
                                    <input type="radio" id="firlev_3" name="firstlevelcb" class="cbarraydata" value="Sex" style="float: left;" />
                                    <label for="firlev_3" class="cbarraydata_label" style="float: right">Sex</label>
                                </div>
                            </div>
                            <div style="display: table-row">
                                <div style="display: table-cell">
                                    <input type="radio" id="firlev_4" name="firstlevelcb" class="cbarraydata" value="Diabetes" style="float: left;" />
                                    <label for="firlev_4" class="cbarraydata_label" style="float: right">Diabetes</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--end first level-->

                    <!--second level-->
                    <div class="secondlevel" style="width: 25%; display: table-cell; vertical-align: top;">

                        <div style="display: table;">
                            <div style="display: table-row">
                                <div style="display: table-cell;" class="adjustlblcell">
                                    <label id="secondleveladjlbl" class="adjustlbl">Adjust for</label>
                                </div>
                            </div>
                            <div style="display: table-row">
                                <div style="display: table-cell">
                                    <input type="radio" id="slev_1" name="secondlevelcb" class="cbarraydata" value="Age, Year" style="float: left;" />
                                    <label for="slev_1" class="cbarraydata_label" style="float: right">Age, Year</label>
                                </div>
                            </div>
                            <div style="display: table-row">
                                <div style="display: table-cell">
                                    <input type="radio" id="slev_2" name="secondlevelcb" class="cbarraydata" value="Age, Sex" style="float: left;" />
                                    <label for="slev_2" class="cbarraydata_label" style="float: right">Age, Sex</label>
                                </div>
                            </div>
                            <div style="display: table-row">
                                <div style="display: table-cell">
                                    <input type="radio" id="slev_3" name="secondlevelcb" class="cbarraydata" value="Age, Diabetes" style="float: left;" />
                                    <label for="slev_3" class="cbarraydata_label" style="float: right">Age, Diabetes</label>
                                </div>
                            </div>
                            <div style="display: table-row">
                                <div style="display: table-cell">
                                    <input type="radio" id="slev_4" name="secondlevelcb" class="cbarraydata" value="Year, Sex" style="float: left;" />
                                    <label for="slev_4" class="cbarraydata_label" style="float: right">Year, Sex</label>
                                </div>
                            </div>
                            <div style="display: table-row">
                                <div style="display: table-cell">
                                    <input type="radio" id="slev_5" name="secondlevelcb" class="cbarraydata" value="Year, Diabetes" style="float: left;" />
                                    <label for="slev_5" class="cbarraydata_label" style="float: right">Year, Diabetes</label>
                                </div>
                            </div>
                            <div style="display: table-row">
                                <div style="display: table-cell">
                                    <input type="radio" id="slev_6" name="secondlevelcb" class="cbarraydata" value="Sex, Diabetes" style="float: left;" />
                                    <label for="slev_6" class="cbarraydata_label" style="float: right">Sex, Diabetes</label>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!--end second level-->

                    <!--third level-->
                    <div class="thirdlevel" style="width: 25%; display: table-cell; vertical-align: top;">
                        <div style="display: table;">
                            <div style="display: table-row">
                                <div style="display: table-cell;" class="adjustlblcell">
                                    <label id="thirdleveladjlbl" class="adjustlbl">Adjust for</label>
                                </div>
                            </div>
                            <div style="display: table-row">
                                <div style="display: table-cell">
                                    <input type="radio" id="tlev_1" name="thirdlevelcb" class="cbarraydata" value="Age, Year, Sex" style="float: left;" />
                                    <label for="tlev_1" class="cbarraydata_label" style="float: right">Age, Year, Sex</label>
                                </div>
                            </div>
                            <div style="display: table-row">
                                <div style="display: table-cell">
                                    <input type="radio" id="tlev_2" name="thirdlevelcb" class="cbarraydata" value="Age, Year, Diabetes" style="float: left;" />
                                    <label for="tlev_2" class="cbarraydata_label" style="float: right">Age, Year, Diabetes</label>
                                </div>
                            </div>
                            <div style="display: table-row">
                                <div style="display: table-cell">
                                    <input type="radio" id="tlev_3" name="thirdlevelcb" class="cbarraydata" value="Age, Sex, Diabetes" style="float: left;" />
                                    <label for="tlev_3" class="cbarraydata_label" style="float: right">Age, Sex, Diabetes</label>
                                </div>
                            </div>
                            <div style="display: table-row">
                                <div style="display: table-cell">
                                    <input type="radio" id="tlev_4" name="thirdlevelcb" class="cbarraydata" value="Year, Sex, Diabetes" style="float: left;" />
                                    <label for="tlev_4" class="cbarraydata_label" style="float: right">Year, Sex, Diabetes</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--end third level-->

                    <!--fourth level-->
                    <div class="fourthlevel" style="width: 25%; display: table-cell;">
                        <div style="display: table;">
                            <div style="display: table-row">
                                <div style="display: table-cell;" class="adjustlblcell">
                                    <label id="fourthleveladjlbl" class="adjustlbl">Adjust for</label>
                                </div>
                            </div>
                            <div style="display: table-row">
                                <div style="display: table-cell">
                                    <input type="radio" id="flev_1" name="fourthlevelcb" class="cbarraydata" value="Age, Year, Sex, Diabetes" style="float: left;" /><label for="flev_1" class="cbarraydata_label" style="float: right"> Age, Year, Sex, Diabetes</label>
                                </div>
                                <br />
                            </div>
                        </div>
                    </div>
                    <!--end fourth level-->
                </div>
                <div style="display: table-row">
                    <input type="button" class="btn" id="resetRadioBtn" value="Reset">
                </div>
            </div>
        </div>
    </div>

    <br />
    <br />
    <br />

    <!-- ************ -->
    <!-- *Data Table* -->
    <!-- ************ -->
    <div class="tableHeaderBar">

        <div style="float: left">
            <span id="spnViewDataTable" tabindex="0" onclick="toggleTable();" onkeyup="toggleTableKeyBoard(event);">+ View Data Table</span>
        </div>
    </div>
    <div class="tableContainer" style="display: none;" vis="0">
        <div style="overflow: auto;" class="printTable">
            <asp:GridView ID="gvData" Width="100%" runat="server" CssClass="ckd-details-dynamic-table" UseAccessibleHeader="true" DataRowBound="gvData_DataRowBound">
            </asp:GridView>
        </div>
    </div>

    <br />
    <br />

    <!-- ************** -->
    <!-- *Content Tabs* -->
    <!-- ************** -->
    <div class="row">

        <div class="col-xl-12">
            <div id="divContentTabs" class="tabs-module">
                <ul class="nav nav-tabs no-syndicate" id="tabs-3" role="tablist">
                    <li class="nav-item"><a class="nav-link active" data-toggle="tab" role="tab" href="#tab-KeyPoints">Key Points</a></li>
                    <li class="nav-item"><a class="nav-link " data-toggle="tab" role="tab" href="#tab-ChartDescription">Description</a></li>
                    <li class="nav-item"><a class="nav-link " data-toggle="tab" role="tab" href="#tab-Methods">Methods</a></li>
                    <li class="nav-item"><a class="nav-link " data-toggle="tab" role="tab" href="#tab-RefDataSources">References</a></li>
                </ul>
                <div class="tab-content">

                    <div class="tab-pane active" role="tabpanel" id="tab-KeyPoints">
                        <div class="ct-row">

                            <%--*KP/Methods Content*--%>
                            <div class="kptext">
                                When a graphical presentation shows a difference  in health outcomes across segments of the population, a logical next step is to ask if they represent disparities for those populations,
                                or if they are explained by other factors. This graphic shows differences in outcomes by race, but allows you to see if those difference remain if you adjust for other factors; for example , 
                                do those differences remain even if we assume that for each race, people have similar ages – if they do, then the observed differences are more likely to represent a true disparity. 
                                This “disparities explorer” allows you to quickly adjust for single or multiple variables to come to your own conclusions.

                                    <asp:Literal ID="litKPText" runat="server"></asp:Literal>
                            </div>

                        </div>
                    </div>

                    <div class="tab-pane" role="tabpanel" id="tab-ChartDescription">
                        <div class="ct-row">

                            <!--*******************-->
                            <!--*Chart Explanation*-->                            
                            <!--*******************-->
                            <%--Spacing is managed on the server-side--%>
                            Disparities explorer: Health disparities are differences in health outcomes that are seen across segments of the population. 
                            In some cases, apparent disparities may be explained by one or more factors. 
                            The disparities explorer allows us to explore evidence of disparity in CKD outcomes. 
                            The explorer uses a regression model to associate the prevalence of CKD with multiple factors, and identify the most important associations.
                                <asp:Label ID="lblExplanationHeader" runat="server" Text=""></asp:Label>
                            <asp:Label ID="lblExplanationBody" runat="server" />

                        </div>
                    </div>

                    <div class="tab-pane" role="tabpanel" id="tab-Methods">
                        <div class="ct-row">
                            <div id="methodsDiv">

                                <%--*Methods Description*--%>
                                    We use National Health and Nutrition Examination Survey (NHANES) data from 1988-1994 through 2011-2012 to predict prevalence of CKD. 
                                Multiple models are run, for all combinations of covariates. The regression coefficients from each model are then used to calculate 
                                expected values of the prevalence of CKD, with adjustment for that (combination of) factors. 
                                    <asp:Literal ID="litMethodsDesc" runat="server"></asp:Literal>

                            </div>
                        </div>
                    </div>


                    <div class="tab-pane" role="tabpanel" id="tab-RefDataSources">
                        <div class="ct-row">
                            <asp:Panel ID="pnlReferences" runat="server" Style="" class="printReferences">
                                <div class="tabbyDiv">

                                    <%--<div style="font-weight: bold; font-size: .9em; font-weight: bold; margin-left: .5em; margin-top: .4em; margin-bottom: .4em;">References and Sources:</div>--%>

                                    <sup>1</sup> CDC health disparities and inequalities report—United States, 2011. MMWR Suppl 2011;60(Suppl; January 24, 2011).

                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">

        var tempdataarray;
        var displaydata = "";
        var clickedarray;
        var firststrat = "";
        var secondstrat = "";
        var thirdstrat = "";
        var fourthstrat = "";
        var firststrattext = "";
        var secondstrattext = "";
        var thirdstrattext = "";
        var fourthstrattext = "";
        var colorselection = "";

        var sourcedataarray = eval($("#HF_D3Data").val());//[{ secondary : 'Unadjusted',values: [{ datapoint: 7.2800000000, series:'Non-Hispanic White'},{ datapoint: 7.0500000000, series:'Non-Hispanic White'},{ datapoint: 7.5100000000, series:'Non-Hispanic White'}{ datapoint: 5.2900000000, series:'Non-Hispanic Black'}{ datapoint: 5.0500000000, series:'Non-Hispanic Black'}{ datapoint: 5.5300000000, series:'Non-Hispanic Black'}{ datapoint: 2.9700000000, series:'Other'}{ datapoint: 2.7500000000, series:'Other'}{ datapoint: 3.2000000000, series:'Other'}]},{ secondary : 'Age',values: [{ datapoint: 4.6800000000, series:'Non-Hispanic White'}{ datapoint: 4.5600000000, series:'Non-Hispanic White'}{ datapoint: 4.7900000000, series:'Non-Hispanic White'}{ datapoint: 5.3000000000, series:'Non-Hispanic Black'}{ datapoint: 5.0900000000, series:'Non-Hispanic Black'}{ datapoint: 5.5000000000, series:'Non-Hispanic Black'}{ datapoint: 3.7800000000, series:'Other'}{ datapoint: 3.5500000000, series:'Other'}{ datapoint: 4.0100000000, series:'Other'}]}];

        $(".secondlevel").hide();
        $(".thirdlevel").hide();
        $(".fourthlevel").hide();

        var tooltipdiv = d3.select("div[id='contentArea']").append("div")
            .attr("class", "tooltip");

        $(".cbcolors").click(function () {
            colorselection = $(this).val();            
            callHandler(firststrat, secondstrat, thirdstrat, fourthstrat, firststrattext.trim(), secondstrattext.trim(), thirdstrattext.trim(), fourthstrattext.trim(), colorselection);//calling the ajax postback when a radiobutton has been checked
        });

        $("#resetRadioBtn").click(function () {
            $("input:radio").each(function () { this.checked = false; });
            firststrat = "";
            firststrattext = "";
            secondstrat = "";
            secondstrattext = "";
            thirdstrat = "";
            thirdstrattext = "";
            fourthstrat = "";
            fourthstrattext = "";

            $("#firstleveladjlbl").show();
            $(".secondlevel").hide();
            $(".thirdlevel").hide();
            $(".fourthlevel").hide();


            callHandler(firststrat, secondstrat, thirdstrat, fourthstrat, firststrattext.trim(), secondstrattext.trim(), thirdstrattext.trim(), fourthstrattext.trim(), colorselection);//calling the ajax postback when a radiobutton has been checked
        });

        $(".cbarraydata").click(function () {
            tempdataarray = sourcedataarray;
            displaydata = "";//reset the displaydata


            var clickedval = $(this).val();
            var clickedtext = $('label[for=' + $(this).attr("id") + ']').text();

            var rbName = $(this).attr("name");

            if (rbName == "firstlevelcb") {
                $("input:radio[name=firstlevelcb]").each(function () {
                    if ($(this).val() != clickedval) {
                        this.checked = false;
                    }
                    else
                        firststrat = clickedval;
                });

                secondstrat = "";//resetting the child strats
                thirdstrat = "";
                fourthstrat = "";

                $("input:radio[name=secondlevelcb]").each(function () { this.checked = false; }); //unchecking all children checkboxes
                $("input:radio[name=thirdlevelcb]").each(function () { this.checked = false; });
                $("input:radio[name=fourthlevelcb]").each(function () { this.checked = false; });

                if ($(this).is(":checked")) {                    
                    secondstrattext = clickedtext.replace(" ", "");//replacing spaces                    
                    $("input:radio[name=secondlevelcb]").each(function () { //filtering only the relevant checkboxes that pertain to the parent selection
                        if ($(this).val().indexOf(clickedval) > -1) {

                            var thistext = $('label[for=' + $(this).attr("id") + ']').html();
                            thistext = thistext.replace(clickedval, "").replace(",", "").replace(" ", "");

                            var newtext = firststrat + ", " + thistext;

                            $('label[for=' + $(this).attr("id") + ']').html(newtext);

                            $(this).show();
                            $('label[for=' + $(this).attr("id") + ']').show();
                        }
                        else {
                            $(this).hide();
                            $('label[for=' + $(this).attr("id") + ']').hide();
                        }
                    });
                }
                else {
                    $("input:radio[name=secondlevelcb]").each(function () { //if the checkbox has been unchecked, then hide all children
                        $(this).hide();
                        $('label[for=' + $(this).attr("id") + ']').hide();
                    });

                }


                $("#secondleveladjlbl").show();
                $("#firstleveladjlbl").hide();
                $(".secondlevel").show();
                $(".thirdlevel").hide();
                $(".fourthlevel").hide();
            }
            else if (rbName == "secondlevelcb") {

                $("input:radio[name=secondlevelcb]").each(function () {

                    if ($(this).val() != clickedval) {
                        this.checked = false;
                    }
                    else
                        secondstrat = clickedval;
                });

                thirdstrat = "";//resetting the child strats
                fourthstrat = "";

                $("input:radio[name=thirdlevelcb]").each(function () { this.checked = false; });//unchecking all children checkboxes
                $("input:radio[name=fourthlevelcb]").each(function () { this.checked = false; });


                if ($(this).is(":checked")) {
                    secondstrattext = clickedtext.substring(clickedtext.indexOf(",") + 1).replace(" ", "");

                    $("input:radio[name=thirdlevelcb]").each(function () {

                        var allmatch = true;
                        var splitString = clickedval.split(',');//looking only at the values that are in the second cbox list
                        for (var i = 0; i < splitString.length; i++) {

                            var strmatch = false;
                            var stringPart = splitString[i];
                            if ($(this).val().indexOf(stringPart) > -1)//checking each string fragment
                                strmatch = true;
                            else
                                strmatch = false;

                            if (strmatch == false)//if any string fragment didn't match, then set the allmatch variable to false
                                allmatch = false;
                        }

                        if (allmatch == true) {
                            var thistext = $('label[for=' + $(this).attr("id") + ']').html();
                            var cleanclickedval = clickedval.replace(" ", "").replace(" ", "");//removing all of the spaces which caused issues with the split
                            splitString = cleanclickedval.split(',');
                            for (var i = 0; i < splitString.length; i++) {
                                thistext = thistext.replace(splitString[i], "").replace(",", "").replace(" ", "");
                            }

                            var newtext = firststrat + ", " + secondstrattext + ", " + thistext;

                            $('label[for=' + $(this).attr("id") + ']').html(newtext);
                            $(this).show();
                            $('label[for=' + $(this).attr("id") + ']').show();
                        }
                        else {
                            $(this).hide();
                            $('label[for=' + $(this).attr("id") + ']').hide();
                        }
                    });

                }
                else {
                    $("input:radio[name=thirdlevelcb]").each(function () { //if the checkbox has been unchecked, then hide all children
                        $(this).hide();
                        $('label[for=' + $(this).attr("id") + ']').hide();
                    });

                }

                $(".thirdlevel").show();
                $(".fourthlevel").hide(); //hiding the children

                $("#thirdleveladjlbl").show();
                $("#secondleveladjlbl").hide();
                $("#firstleveladjlbl").hide();
            }
            else if (rbName == "thirdlevelcb") {

                $("input:radio[name=thirdlevelcb]").each(function () {

                    if ($(this).val() != clickedval) {
                        this.checked = false;
                    } else {
                        thirdstrat = clickedval;
                    }
                });

                fourthstrat = "";//resetting the child strats

                if ($(this).is(":checked")) {

                    var firsttrim = clickedtext.substring(clickedtext.indexOf(",") + 1);
                    thirdstrattext = firsttrim.substring(firsttrim.indexOf(",") + 1).replace(" ", "");

                    $("input:radio[name=fourthlevelcb]").each(function () {
                        this.checked = false;

                        var cleanclickedval = clickedval.replace(" ", "").replace(" ", "").replace(" ", "");//removing all of the spaces which caused issues with the split
                        var splitString = cleanclickedval.split(',');
                        var thistext = $('label[for=' + $(this).attr("id") + ']').html();

                        for (var i = 0; i < splitString.length; i++) {
                            thistext = thistext.replace(splitString[i], "").replace(",", "").replace(" ", "");
                        }

                        fourthstrattext = thistext;
                        var newtext = firststrat + ", " + secondstrattext + ", " + thirdstrattext + ", " + fourthstrattext;//reordering the label text

                        $('label[for=' + $(this).attr("id") + ']').html(newtext);

                        $(this).show();
                        $('label[for=' + $(this).attr("id") + ']').show();
                    });//unchecking all children checkboxes
                }
                else {
                    $("input:radio[name=fourthlevelcb]").each(function () {
                        $(this).hide();
                        $('label[for=' + $(this).attr("id") + ']').hide();
                    });//if the checkbox has been unchecked, then hide all children
                }

                $("#thirdleveladjlbl").hide();
                $("#secondleveladjlbl").hide();
                $("#firstleveladjlbl").hide();
                $("#fourthleveladjlbl").show();
                $(".fourthlevel").show();
            }
            else if (rbName == "fourthlevelcb") {
                fourthstrat = clickedval;
                $("#fourthleveladjlbl").hide();
            }
            
            callHandler(firststrat, secondstrat, thirdstrat, fourthstrat, firststrattext.trim(), secondstrattext.trim(), thirdstrattext.trim(), fourthstrattext.trim(), colorselection);//calling the ajax postback when a radiobutton has been checked
        });

        function callHandler(p_firststrat, p_secondstrat, p_thirdstrat, p_fourthstrat, p_firststrat_text, p_secondstrat_text, p_thirdstrat_text, p_fourthstrat_text, colorselection) {            

            $.ajax({
                type: "POST",
                url: "Handlers/DisparityExplorer_Handler.ashx",
                data: "firststrat=" + p_firststrat + "^secondstrat=" + p_secondstrat + "^thirdstrat=" + p_thirdstrat + "^fourthstrat=" + p_fourthstrat + "^textfirststrat=" + p_firststrat_text + "^textsecondstrat=" + p_secondstrat_text + "^textthirdstrat=" + p_thirdstrat_text + "^textfourthstrat=" + p_fourthstrat_text + "^colorselection=" + colorselection,
                success: function (response) {                    
                    createPlotlyChart(response)
                },
                error: function (jqXHR, textStatus, errorThrown) {                    
                    alert("textStatus=" + textStatus + " -- DE AJAX callHandler Error:" + errorThrown);
                }
            });
        }        


        function createPlotlyChart(returndata) {
            var d3 = Plotly.d3;
            var WIDTH_IN_PERCENT_OF_PARENT = 100, HEIGHT_IN_PERCENT_OF_PARENT = 70;
            
            eval(returndata);

            var layout = {
                title: '', titlefont: { size: 12 },
                barmode: 'group', hovermode: 'closest', hoverinfo: 'none',
                xaxis: { tickangle: 20, tickfont: { size: 10 }, linecolor: '#bdbdbd', title: '' },
                yaxis: { linecolor: '#bdbdbd', title: 'Percentage per 100 population (percentage prevalence)', titlefont: { size: 12 } },
                annotations: [{ x: -0.05, y: 1.2, sizex: 1, sizey: 1, yref: 'paper', xref: 'paper', align: 'left', text: '<b>Prevalence of Chronic Kidney Disease Stages 3-4 By Race/Ethnicity,with adjustment for other factors<br>-National Health and Nutrition Examination Survey', showarrow: false }]
            };
            var gd4 = d3.select('#svgchart').style({
                width: WIDTH_IN_PERCENT_OF_PARENT + '%', 'margin-left': (100 - WIDTH_IN_PERCENT_OF_PARENT) / 2 + '%',
                height: HEIGHT_IN_PERCENT_OF_PARENT + 'vh'
            });
            var graphdiv = gd4.node();

            Plotly.newPlot(graphdiv, dataitems, layout, { displayModeBar: false, displaylogo: false, modeBarButtonsToRemove: ['sendDataToCloud', 'lasso2d', 'toggleSpikelines', 'select2d'] }); //{ modeBarButtonsToRemove: ['sendDataToCloud', 'lasso2d', 'toggleSpikelines'] }
            
            window.onresize = function () { Plotly.Plots.resize(graphdiv); };
        }


        $(document).ready(function () {
            $("#colorone").prop("checked", true);
            callHandler("", "", "", "", "", "", "", "", "1");

            //Initiate the content tabs
            CDC.Gadgets.Tabs.init();            
            

            //adding tabindex
            $('a[data-title="Download plot as a png"]').attr("tabIndex", 0);
            $('a[data-title="Zoom"]').attr("tabIndex", 0);
            $('a[data-title="Pan"]').attr("tabIndex", 0);
            $('a[data-title="Zoom in"]').attr("tabIndex", 0);
            $('a[data-title="Zoom out"]').attr("tabIndex", 0);
            $('a[data-title="Autoscale"]').attr("tabIndex", 0);
            $('a[data-title="Reset axes"]').attr("tabIndex", 0);
            $('a[data-title="Toggle show closest data on hover"]').attr("tabIndex", 0);
            $('a[data-title="Show closest data on hover"]').attr("tabIndex", 0);
            $('a[data-title="Compare data on hover"]').attr("tabIndex", 0);

            //adding alt tags
            $('a[data-title="Download plot as a png"]').attr("alt", "Download plot as a png");
            $('a[data-title="Zoom "]').attr("alt", "Zoom");
            $('a[data-title="Pan"]').attr("alt", "Pan");
            $('a[data-title="Zoom in"]').attr("alt", "Zoom in");
            $('a[data-title="Zoom out"]').attr("alt", "Zoom out");
            $('a[data-title="Autoscale"]').attr("alt", "Autoscale");
            $('a[data-title="Reset axes"]').attr("alt", "Reset axes");
            $('a[data-title="Toggle show closest data on hover"]').attr("alt", "Toggle show closest data on hover");
            $('a[data-title="Compare data on hover"]').attr("alt", "Compare data on hover");



            $('a:not([href])').attr("background-color", "none");
            //adding keypress check to account for the enter button being pressed           
            $('a[data-title="Download plot as a png"]').keypress(
                function () {
                    downloadBtn = $('a[data-title="Download plot as a png"]')[0]
                    downloadBtn.click();                    
                }
            );

            $('a[data-title="Zoom"]').keypress(
                function () {
                    zoomBtn = $('a[data-title="Zoom"]')[0]
                    zoomBtn.click();                    
                }
            );

            $('a[data-title="Pan"]').keypress(
                function () {
                    panBtn = $('a[data-title="Pan"]')[0]
                    panBtn.click();                    
                }
            );
            
            $('a[data-title="Zoom in"]').keypress(
                function () {
                    zoominBtn = $('a[data-title="Zoom in"]')[0]
                    zoominBtn.click();
                }
            );
            
            $('a[data-title="Zoom out"]').keypress(
                function () {
                    zoomoutBtn = $('a[data-title="Zoom out"]')[0]
                    zoomoutBtn.click();
                }
            );

            $('a[data-title="Autoscale"]').keypress(
                function () {
                    autoscaleBtn = $('a[data-title="Autoscale"]')[0]
                    autoscaleBtn.click();                    
                }
            );
            
            $('a[data-title="Reset axes"]').keypress(
                function () {
                    resetBtn = $('a[data-title="Reset axes"]')[0]
                    resetBtn.click();
                }
            );
            
            $('a[data-title="Toggle show closest data on hover"]').keypress(
                function () {
                    toggleBtn = $('a[data-title="Toggle show closest data on hover"]')[0]
                    toggleBtn.click();
                }
            );

            $('a[data-title="Compare data on hover"]').keypress(
                function () {
                    compareBtn = $('a[data-title="Compare data on hover"]')[0]
                    compareBtn.click();                    
                }
            );

            //end keypress functionality            
            $(".main-svg").append("<desc>" + $('meta[name=description]').attr("content") + "</desc>");
            $(".main-svg").attr("alt", $('meta[name=description]').attr("content"));
            //end 508 compliance updates for Plotly

        });

        function toggleTable() {

            //Executes on click of span #spnViewDataTable to hide/show table contents
            var showing = $('.tableContainer').attr('vis');

            switch (showing) {
                case '0':
                    $('.tableContainer').slideDown(1000);
                    $('.tableContainer').attr('vis', '1');
                    $('#spnViewDataTable').html('&mdash; Hide Data Table');
                    break;
                case '1':
                    $('.tableContainer').slideUp(1000);
                    $('.tableContainer').attr('vis', '0');
                    $('#spnViewDataTable').text('+ View Data Table');
                    break;
            }
        }

        function toggleTableKeyBoard(e) {

            var kc = e.keyCode;
            //If visitor pressed <ENTER>, toggle the table
            if (kc === 13) {
                toggleTable(); // see immediately above - function on page
            }
        }   

    </script>

    <%--************************--%>
    <%--*    END D3 Chart      *--%>
    <%--************************--%>
</asp:Content>




