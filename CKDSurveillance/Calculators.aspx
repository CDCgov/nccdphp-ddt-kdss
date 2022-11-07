<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ResponsiveContentLeftNav.Master" AutoEventWireup="true" CodeBehind="Calculators.aspx.cs" Inherits="CKDSurveillance_RD.Calculators" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%--*CSS*--%>
    <link href="App_Themes/ion.rangeSlider.css?v=202012301107" rel="stylesheet" />
    <link href="App_Themes/ion.rangeSlider.skinModern.css?v=1" rel="stylesheet" />
    <link href="App_Themes/normalize.css?val=202012301107" rel="stylesheet" />
    <link href="App_Themes/Calculators.css?val=22" rel="stylesheet" />


    <%--*JS*--%>
    <%--*Ion Range Slider JS*--%>
    <script src="scripts/ion.rangeSlider.js" type="text/javascript"></script>


    <%--*Plotly*--%>
    <script src="scripts/plotly-latest.min.js" type="text/javascript"></script>

    <style>
        .bang_required_messages {
            padding: 10px;            
        }

        .tangri_required_messages {
            padding: 10px;            
        }

        @media (min-width: 992px) {
            .phoneWarning {
                display: none;
            }

            .tabs-module {
                display: block;
            }
        }

        @media (max-width: 991px) {
            .phoneWarning {
                display: block;
            }

            .tabs-module {
                display: none !important;
            }
        }

        .form-control {
            display: inline !important;
        }

        .valueRange {
            font-style: italic;
            font-size: 14px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">

    <div class="row">
        <div class="col-xl-12">

            <div class="Pagetitle">CKD Risk Calculators</div>

            <br />
            <br />

            <div class="introduction">

                <div><strong>Below are two tools:</strong></div>
                <br />
                <div>
                    <strong><em>Calculator 1:</em> Risk of Chronic Kidney Disease (CKD) in adults</strong>
                    <br />
                    For adults who don’t know if they have chronic kidney disease (CKD), Calculator 1 estimates the probability of having CKD (Bang et al., 2007)
                    <ul>
                        <li>The calculation is based on individual characteristics: age, sex, and 7 comorbidities including hypertension, diabetes and cardiovascular disease.</li>
                    </ul>
                    <br />
                    <strong><em>Calculator 2:</em> Risk of progression of CKD to kidney failure among those who already have CKD </strong>
                    <br />
                    For adults who know they have CKD (estimated glomerular filtration rate [eGFR] <60 mL/min/1.73m<sup>2</sup>), Calculator 2 estimates the probability of progression of CKD to kidney failure in the next two or five years using a 4- or 8-variable equation (Tangri et al., 2011)  
                    <ul>
                        <li>The 4-variable equation is based on individual characteristics: age, sex, eGFR and Urine Albumin to Creatinine Ratio (UACR)
                        </li>
                        <li>The 8-variable equation also includes four laboratory tests (serum calcium, phosphate, bicarbonate, and albumin).
                        </li>
                    </ul>
                </div>
                <p>
                    The intended audience is medical researchers and clinicians; the calculators should only be used by laypersons to begin dialog with their care provider. 
                    These equations should not be used for self-diagnosis or self-management.
                </p>

            </div>

            <br />
            <br />

            <div class="phoneWarning">
                <p style="font-weight: bold; color: red">The CKD Risk Calculators are designed for use on devices with larger displays. Please visit this page on a tablet, laptop, or desktop device.</p>
            </div>

            <div id="divContentTabs" class="tabs-module">
                <ul class="nav nav-tabs no-syndicate" id="tabs-3" role="tablist">
                    <li class="nav-item" style="border-top: 2px solid #ddd; border-left: 2px solid #ddd; border-right: 2px solid #ddd;"><a class="nav-link active" data-toggle="tab" role="tab" href="#tab-Bang">Calculator 1: Probability of CKD</a></li>
                    <li class="nav-item" style="border-top: 2px solid #ddd; border-right: 2px solid #ddd;"><a class="nav-link" data-toggle="tab" role="tab" href="#tab-Tangri">Calculator 2: Progression of CKD</a></li>
                </ul>


                <div class="tab-content">
                    <div class="tab-pane active" role="tabpanel" id="tab-Bang">

                        <div class="ct-row">

                            <%--*BANG CKD RISK Calculator *--%>
                            <div class="kptext">

                                <div class="Pagetitle">
                                    Probability of CKD
                                </div>

                                <br />

                                <div class="description">
                                    <p>
                                        This calculator returns the probability (expressed as a percentage from 0 to 100%) of having Stage 3-5 CKD, defined as an estimated glomerular filtration rate (eGFR) less than 60 mL/min/1.73m<sup>2</sup>, based on nine input variables<sup>1</sup>. 
                                        If one or more of the values is unknown, trying different combinations of the presence or absence of the unknown characteristics will give a range of possible estimates.  
                                        An elevated probability of CKD should prompt individuals to seek more comprehensive medical advice, possibly leading to further medical evaluation, earlier diagnosis and interventions to both manage the condition and slow its progression.
                                    </p>
                                    <p>
                                        Details of the risk equation development (Bang et al, 2007) are available here: <a href='https://www.ncbi.nlm.nih.gov/pubmed/17325299' target='_blank'>https://www.ncbi.nlm.nih.gov/pubmed/17325299</a>. 
                                    </p>
                                </div>
                                <br />
                                <div class="row">
                                    <div class="col-lg-6 bangControls">
                                        <table class="table table-bordered BangTable">

                                            <thead>
                                                <tr>
                                                    <th id="colChar" scope="col">Characteristic</th>
                                                    <th id="colTP" scope="col">This Person</th>
                                                    <th id="colNA" scope="col">U.S. National<br />
                                                        Average</th>
                                                </tr>
                                            </thead>

                                            <tbody>

                                                <%--***************************--%>
                                                <%--*Age and Sex Choice Header*--%>
                                                <%--***************************--%>
                                                <tr>
                                                    <th id="EAAS" scope="row" colspan="3" class="instructionLine"><em>Enter Age and Sex:</em></th>
                                                </tr>


                                                <tr>
                                                    <th id="rowAge" scope="row" headers="EAAS colChar" class="QLabelLeft"><span>Age (required):</span></th>
                                                    <td class="QLabelRight" headers="EAAS colTP rowAge">
                                                        <label for="selBang2" style="color: #FFF; height: 0px;">Age Choices (required)</label>
                                                        <select id="selBang2" class="form-control" onchange="removeRequirement('bage'); submitData('bang');">
                                                            <option value="0">(Please Select)</option>
                                                            <option value="1">20 - 49</option>
                                                            <option value="2">50 - 59</option>
                                                            <%--<option value="2">50 - 59</option>--%>
                                                            <option value="3">60 - 69</option>
                                                            <%--<option value="3">60 - 69</option>--%>
                                                            <option value="4">≥ 70</option>
                                                            <%--<option value="4">≥ 70</option>--%>
                                                        </select>
                                                    </td>
                                                    <td headers="EAAS colNA rowAge"></td>
                                                </tr>

                                                <tr>
                                                    <th id="rowSex" scope="row" headers="EAAS colChar" class="QLabelLeft"><span>Sex (required):</span></th>
                                                    <td class="QLabelRight" headers="EAAS colTP rowSex">
                                                        <fieldset>
                                                            <legend>Sex</legend>
                                                            <input id="rbSexFemale" type="radio" name="rbSex" value="0" class="float-left" onchange="removeRequirement('bsex'); submitData('bang');" />
                                                            <label for="rbSexFemale" class="float-left">Female</label>
                                                            &nbsp;                                                                                             
                                                            <input id="rbSexMale" type="radio" name="rbSex" value="1" class="float-left" onchange="removeRequirement('bsex'); submitData('bang');" />
                                                            <label for="rbSexMale" class="float-left">Male</label>
                                                        </fieldset>
                                                    </td>
                                                    <td headers="EAAS colNA rowSex"></td>
                                                </tr>


                                                <%--****************************--%>
                                                <%--*Radio Button Choice Header*--%>
                                                <%--****************************--%>
                                                <tr>
                                                    <th id="CKDprob" scope="row" colspan="3" class="instructionLine">
                                                        <em>Enter any of the following characteristics that may increase the probability of CKD:</em>
                                                    </th>
                                                </tr>

                                                <tr>
                                                    <th id="rowAnemia" scope="row" class="QLabelLeft" headers="CKDprob colChar">Anemia:</th>
                                                    <td class="QLabelRight" headers="CKDprob colTP rowAnemia">
                                                        <fieldset>
                                                            <legend>Anemia</legend>
                                                            <input id="rbAnemiaNo" type="radio" name="rbAnemia" value="0" class="float-left" onchange="submitData('bang');" checked />
                                                            <label for="rbAnemiaNo" class="float-left">No</label>
                                                            &nbsp;
                                                            <input id="rbAnemiaYes" type="radio" name="rbAnemia" value="1" class="float-left" onchange="submitData('bang');" />
                                                            <label for="rbAnemiaYes" class="float-left">Yes</label>
                                                        </fieldset>
                                                    </td>
                                                    <td headers="CKDprob colNA rowAnemia"></td>
                                                </tr>

                                                <tr>
                                                    <th id="rowHypertension" scope="row" class="QLabelLeft" headers="CKDprob colChar">Hypertension:</th>
                                                    <td class="QLabelRight" headers="CKDprob colTP rowHypertension">
                                                        <fieldset>
                                                            <legend>Hypertension</legend>
                                                            <input id="rbHypertensionNo" type="radio" name="rbHypertension" value="0" class="float-left" onchange="submitData('bang');" checked />
                                                            <label for="rbHypertensionNo" class="float-left">No</label>
                                                            &nbsp;                                               
                                                            <input id="rbHypertensionYes" type="radio" name="rbHypertension" value="1" class="float-left" onchange="submitData('bang');" />
                                                            <label for="rbHypertensionYes" class="float-left">Yes</label>
                                                        </fieldset>
                                                    </td>
                                                    <td headers="CKDprob colNA rowHypertension">(<a target='_blank' href='https://nccd.cdc.gov/ckd/detail.aspx?Qnum=Q652'>41%</a><%--<sup>2</sup>--%>)</td>
                                                </tr>

                                                <tr>
                                                    <th id="rowDiabetes" scope="row" class="QLabelLeft" headers="CKDprob colChar">Diabetes:</th>
                                                    <td class="QLabelRight" headers="CKDprob colTP rowDiabetes">
                                                        <fieldset>
                                                            <legend>Diabetes</legend>
                                                            <input id="rbDiabetesNo" type="radio" name="rbDiabetes" value="0" class="float-left" onchange="submitData('bang');" checked />
                                                            <label for="rbDiabetesNo" class="float-left">No</label>
                                                            &nbsp;
                                                            <input id="rbDiabetesYes" type="radio" name="rbDiabetes" value="1" class="float-left" onchange="submitData('bang');" />
                                                            <label for="rbDiabetesYes" class="float-left">Yes</label>
                                                        </fieldset>
                                                        <div id="diabetesHint" class="float-right">
                                                            <img id="imgDiabetesHint" alt="Dabetes Description Help" title="click for Diabetes Information" src="images/help.jpg" onclick="$('#divDiabetesPopover').fadeIn(500);" />
                                                        </div>
                                                        <div id="divDiabetesPopover" style="display: none; width: 325px;">
                                                            <span class="float-right closeX" onclick="$('#divDiabetesPopover').hide();">X</span>
                                                            <br />
                                                            <p>Having diabetes increases the probability of CKD by about 50%.</p>
                                                            <p>About <a href='https://nccd.cdc.gov/ckd/detail.aspx?Qnum=Q653' target="_blank">10%</a> of the US population has diabetes.</p>
                                                        </div>
                                                    </td>
                                                    <td headers="CKDprob colNA rowDiabetes">(<a target='_blank' href='https://nccd.cdc.gov/ckd/detail.aspx?Qnum=Q653'>10%</a><%--<sup>3</sup>--%>)</td>
                                                </tr>

                                                <tr>
                                                    <th id="rowCVD" scope="row" class="QLabelLeft" headers="CKDprob colChar">Cardiovascular Disease (CVD):</th>
                                                    <td class="QLabelRight" headers="CKDprob colTP rowCVD">
                                                        <fieldset>
                                                            <legend>CVD</legend>
                                                            <input id="rbCVDNo" type="radio" name="rbCVD" value="0" class="float-left" onchange="submitData('bang');" checked />
                                                            <label for="rbCVDNo" class="float-left">No</label>
                                                            &nbsp;
                                                        <input id="rbCVDYes" type="radio" name="rbCVD" value="1" class="float-left" onchange="submitData('bang');" />
                                                            <label for="rbCVDYes" class="float-left">Yes</label>
                                                        </fieldset>
                                                    </td>
                                                    <td headers="CKDprob colNA rowCVD">(<a target='_blank' href='https://nccd.cdc.gov/ckd/detail.aspx?Qnum=Q151'>8%</a><%--<sup>4</sup>--%>)</td>
                                                </tr>

                                                <tr>
                                                    <th id="rowCHF" scope="row" class="QLabelLeft" headers="CKDprob colChar">Congestive Heart Failure (CHF):</th>
                                                    <td class="QLabelRight" headers="CKDprob colTP rowCHF">
                                                        <fieldset>
                                                            <legend>CHF</legend>
                                                            <input id="rbCHFNo" type="radio" name="rbCHF" value="0" class="float-left" onchange="submitData('bang');" checked />
                                                            <label for="rbCHFNo" class="float-left">No</label>
                                                            &nbsp;
                                                            <input id="rbCHF" type="radio" name="rbCHF" value="1" class="float-left" onchange="submitData('bang');" />
                                                            <label for="rbCHF" class="float-left">Yes</label>
                                                        </fieldset>
                                                    </td>
                                                    <td headers="CKDprob colNA rowCHF"></td>
                                                </tr>

                                                <tr>
                                                    <th id="rowPVD" scope="row" class="QLabelLeft" headers="CKDprob colChar">Peripheral Vascular Disease (PVD):</th>
                                                    <td class="QLabelRight" headers="CKDprob colTP rowPVD">
                                                        <fieldset>
                                                            <legend>PVD</legend>
                                                            <input id="rbPVDNo" type="radio" name="rbPVD" value="0" class="float-left" onchange="submitData('bang');" checked />
                                                            <label for="rbPVDNo" class="float-left">No</label>
                                                            &nbsp;
                                                            <input id="rbPVDYes" type="radio" name="rbPVD" value="1" class="float-left" onchange="submitData('bang');" />
                                                            <label for="rbPVDYes" class="float-left">Yes</label>
                                                        </fieldset>
                                                    </td>
                                                    <td headers="CKDprob colNA rowPVD"></td>
                                                </tr>

                                                <tr>
                                                    <th id="rowProteinUria" scope="row" class="QLabelLeft" headers="CKDprob colChar">Proteinuria:<sup>2</sup></th>
                                                    <td class="QLabelRight" headers="CKDprob colTP rowProteinUria">
                                                        <fieldset>
                                                            <legend>Proteinuria</legend>
                                                            <input id="rbProteinuriaNo" type="radio" name="rbProteinuria" value="0" class="float-left" onchange="submitData('bang');" checked />
                                                            <label for="rbProteinuriaNo" class="float-left">No</label>
                                                            &nbsp;
                                                            <input id="rbProteinuriaYes" type="radio" name="rbProteinuria" value="1" class="float-left" onchange="submitData('bang');" />
                                                            <label for="rbProteinuriaYes" class="float-left">Yes</label>
                                                        </fieldset>
                                                    </td>
                                                    <td headers="CKDprob colNA rowProteinUria">(<a target='_blank' href='https://nccd.cdc.gov/ckd/detail.aspx?Qnum=Q11'>10%</a>)</td>
                                                </tr>

                                            </tbody>
                                        </table>

                                        <div class="float-left">
                                            <button id="btnBangReset" class="btn btnSubtle" onclick="return resetChoices('bang');">Reset Choices</button>
                                        </div>

                                        <br />
                                        <br />


                                        <br />
                                        <br />
                                    </div>

                                    <div class="col-lg-6">

                                        <div class="score">
                                            <p>
                                                <strong>Probability of having Stage 3-5 Chronic Kidney Disease (CKD) (expressed as a percentage between 0% and 100%):</strong>
                                            </p>
                                            <%--  <br />--%>

                                            <%--*Required messages*--%> <%--commented out - UM request 11/2019--%>
                                            <div class="bang_required_messages">
                                                In order to show a chart of the calculations, the following are required:
                                        
                                            <ul class="bang_req_list">
                                                <li id="LiBangAge" class="bang_age">Age</li>
                                                <li id="LiBangSex" class="bang_sex">Sex</li>
                                            </ul>
                                            </div>

                                            <%--*Graph BANG Results*--%>
                                            <div id="divBangGraph" class="bangGraph" style="width: 513px;"></div>

                                            <%-- <br />
                                            <br />--%>

                                            <span id="spnBangAnswer"></span>

                                        </div>
                                    </div>

                                </div>

                                <div class="footnote">
                                    <a name="BangFootnote"></a>
                                    <strong><sup>1</sup></strong> Probability (CKD) = 1/[1 + exp(-β’ x X)], where β’ x X = -5.4 + 1.55 x (age of 50-59 years) + 2.31 x (age of 60-69 years) + 3.23 x (age ≥ 70 years) + 0.29 x (female) + 0.93 x (anemia) + 0.45 x (hypertension) + 0.44 x (DM) + 0.59 x (history of CVD) + 0.45 x (history of CHF) + 0.74 x (PVD) + 0.83 x (proteinuria), where (a) is an indicator taking 1 for event a and 0 otherwise. 
                                            In this equation, β and X denote vectors of β-coefficients and risk factors used in this equation, respectively.
                                   <%-- <br />
                                    <br />
                                    <strong><sup>2</sup></strong>Mauris porta est ac eros porttitor aliquam. Mauris rutrum, mi in fringilla eleifend, arcu nisl scelerisque dolor, vel sagittis nulla lorem ac lorem. Phasellus odio orci, faucibus ut porta interdum, aliquet et erat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc et diam quis massa tempor facilisis euismod aliquam augue. Vivamus orci mauris, bibendum vel neque nec, molestie fringilla velit. Nullam aliquam massa in lorem gravida, et pellentesque purus faucibus.                                    
                                      <br />                                    
                                      <br />                                                                       
                                    <strong><sup>3</sup></strong>Nunc gravida at tellus nec tristique. 
                                      <br />
                                    <br />
                                    <strong><sup>4</sup></strong>Ut rutrum consequat dolor congue tempus.--%>
                                    <br />
                                    <br />
                                    <strong><sup>2</sup></strong> Proteinuria is a broad term for leakage of protein in the kidney. Although the Bang et al. paper uses the term proteinuria, the actual measurement was of albuminuria. Albumin is a protein found in the blood. A healthy kidney does not let albumin pass from the blood into the urine. Too much albumin in your urine is called albuminuria. 
                                </div>
                            </div>

                        </div>

                        <br />
                        <br />

                        <div class="references">
                            <p><strong>References and Sources:</strong></p>

                            Bang H, Vupputuri S, Shoham DA, Klemmer PJ, Falk RJ, Mazumdar M, Gipson D, Colindres RE, Kshirsagar AV. SCreening for Occult REnal Disease (SCORED): A simple prediction model for chronic kidney disease. 
                                <em>Arch Intern Med.</em> 2007 Feb 26;167(4):374-81.                
                                <br />
                            <a target="_blank" href="http://www.ncbi.nlm.nih.gov/pubmed/17325299">www.ncbi.nlm.nih.gov/pubmed/17325299</a>

                        </div>
                    </div>
                    <div class="tab-pane" role="tabpanel" id="tab-Tangri">
                        <div class="ct-row">
                            <%--*TANGRI CKD RISK Calculator *--%>
                            <div class="kptext">

                                <div class="Pagetitle">
                                    Progression of CKD
                                </div>

                                <br />

                                <div class="description">
                                    <p>
                                        For patients with chronic kidney disease (i.e., those with estimated glomerular filtration rate (eGFR) less than 60 mL/min/1.73m<sup>2</sup>), this calculator returns an estimated probability of developing kidney failure in the next two or five years (expressed as a percentage, or a range of percentages, from 0% to 100%). 
                                            These probabilities could be used to facilitate patient and provider communication, to heighten awareness and guide optimal disease management for best outcomes. 
                                    </p>
                                    <p>
                                        Two versions of this calculator are provided, one with four input variables, and one with eight input variables. 
                                            Using more variables, when available, will yield a more precise estimate. 
                                            The ‘sliders’ for each laboratory variable in the data entry table below allow a range of values to be selected in case of uncertainty in a single value. 
                                            Details of risk equation development (Tangri et al., 2011) are available here:  <a href='https://www.ncbi.nlm.nih.gov/pubmed/21482743' target='_blank'>https://www.ncbi.nlm.nih.gov/pubmed/21482743</a>.
                                    </p>
                                </div>

                                <br />

                                <div class="row">
                                    <div class="col-lg-6 tangriControls">
                                        <table class="table table-bordered TangriTable">
                                            <tr>
                                                <%--************--%>
                                                <%--*TANGRI AGE*--%>
                                                <%--************--%>
                                                <td class="QLabelLeft">
                                                    <label for="txtAge" title="Required for calculation">Age in years (required):</label>
                                                </td>
                                                <td class="QLabelRight">
                                                    <input id="txtAge" type="number" max="90" min="18" class="form-control" onchange="" onkeyup="removeRequirement('tage'); showTangriGraphOnSliderChange(); limitAgeEntry(); return isNumberKey(event); " style="width: 100px;" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="QLabelLeft" title="Required for calculation">Sex (required):
                                                </td>
                                                <td class="QLabelRight">
                                                    <%--************--%>
                                                    <%--*TANGRI SEX*--%>
                                                    <%--************--%>
                                                    <p class="rbStacker">
                                                        <input id="rbTangriSexFemale" type="radio" name="rbSexTangri" value="0" class="float-left" onclick="removeRequirement('tsex'); showTangriGraphOnSliderChange();" />
                                                        <label for="rbTangriSexFemale" class="float-left">Female</label>
                                                    </p>
                                                    <br />
                                                    <p class="rbStacker">
                                                        <input id="rbTangriSexMale" type="radio" name="rbSexTangri" value="1" class="float-left" onclick="removeRequirement('tsex'); showTangriGraphOnSliderChange();" />
                                                        <label for="rbTangriSexMale" class="float-left">Male</label>
                                                    </p>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td class="QLabelLeft">
                                                    <label for="txtEGFR">eGFR:</label>
                                                </td>
                                                <%--*************--%>
                                                <%--*TANGRI EGFR*--%>
                                                <%--*************--%>
                                                <td class="QLabelRight">
                                                    <input id="txtEGFR" type="number" min="10" max="60" class="form-control" onkeyup="updateSlider('egfr', $(this).val());" onchange="updateSlider('egfr', $(this).val());" onkeypress="return isNumberKey(event);" style="width: 100px;" />
                                                    <div class="float-right">
                                                        <img id="imgrRefreshEGFR" alt="Reset eGFR slider values to original" title="Reset eGFR slider values to original" src="images/Refresh.png" style="width: 16px; height: 16px;" onclick="resetIndividualSlider('egfr');" />
                                                    </div>
                                                    <br />

                                                    <%--*Range Label*--%>
                                                    <span class="valueRange">(Range: 10-60)</span>
                                                    <br />

                                                    <input type="text" id="eGFRSlider" name="eGFRSliderControl" value="" style="max-width: 250px;" title="Click and drag the left and right sliders to the desired interval.  Entering a value in the box above the sliders will automatically move both sliders to that value." />
                                                    <br />
                                                    <div>
                                                        <label for="eGFRSlider">(<strong>mL/min/1.73m<sup>2</sup></strong>)</label>
                                                    </div>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td class="QLabelLeft">
                                                    <label for="txtACRatio">Urine Albumin to Creatinine Ratio:</label><label for="selACRatio" style="color: #FFF">_</label><label for="ureaAlbuminSlider" style="color: #FFF">_</label>
                                                </td>

                                                <td class="QLabelRight">
                                                    <%--*****************--%>
                                                    <%--*TANGRI AC Ratio*--%>
                                                    <%--*****************--%>
                                                    <input id="txtACRatio" type="number" min="10" max="3000" class="form-control" onkeyup="updateSlider('acratio', $(this).val());" onchange="updateSlider('acratio', $(this).val());" onkeypress="return isNumberKey(event);" style="width: 100px;" />

                                                    <div class="float-right">
                                                        <img id="imgACRatio" alt="Reset Albumin/Creatinine slider values to original" title="Reset Albumin/Creatinine slider values to original" src="images/Refresh.png" style="width: 16px; height: 16px;" onclick="resetIndividualSlider('acratio');" />
                                                    </div>
                                                    <br />

                                                    <%--*Range Label*--%>
                                                    <span id="ACRationRange" class="valueRange"></span>
                                                    <br />

                                                    <input type="text" id="ureaAlbuminSlider" name="UASliderControl" value="" style="max-width: 250px;" />
                                                    <br />

                                                    <select id="selACRatio" class="form-control" onchange="unitChange('acratio',$('#selACRatio option:selected').text, $('#txtACRatio').val());" style="width: 135px;">
                                                        <%--<option value="0">(Please Select)</option>--%>
                                                        <option value="1" title="mg/g" selected>mg/g</option>
                                                        <option value="2" title="mg/mmol">mg/mmol</option>
                                                    </select>
                                                </td>
                                            </tr>
                                        </table>

                                        <%--<span class='req'>*</span><span class='inPageNote'>Field is required for a result</span>--%> <%--Commented out in response to comments from UM 11/2019--%>

                                        <%--****************************************--%>
                                        <%--*Divider between short and long version*--%>
                                        <%--****************************************--%>
                                        <button id="btnShowLongerVersion" class="btn float-right" onclick=" $('.TangriAddedFields').fadeIn(300); $('#btnHideLongerVersion').show(); $(this).hide(); setTimeout(function() {showTangriGraphOnSliderChange();}, 500); return false;">8 Variable Equation</button>
                                        <%--Adding a timeout to account for the odd chart redraw in tempalte 4.0--%>
                                        <button id="btnHideLongerVersion" class="btn float-right" style="display: none;" onclick=" $('.TangriAddedFields').fadeOut(300); $('#btnShowLongerVersion').show();  $(this).hide(); setTimeout(function() {showTangriGraphOnSliderChange();}, 500); return false;">4 Variable Equation</button>
                                        <%--Adding a timeout to account for the odd chart redraw in tempalte 4.0--%>


                                        <br />
                                        <br />
                                        <table class="table table-bordered TangriTable TangriAddedFields" style="display: none;">
                                            <tr>
                                                <td class="QLabelLeft">
                                                    <label for="txtSCalcium">Serum Calcium:</label><label for="selSCalcium" style="color: #FFF">_</label><label for="calciumSlider" style="color: #FFF">_</label>
                                                </td>
                                                <%--**********************--%>
                                                <%--*TANGRI SERUM CALCIUM*--%>
                                                <%--**********************--%>
                                                <td class="QLabelRight">
                                                    <input id="txtSCalcium" type="number" min="7.5" max="10.5" onkeypress="return isNumberKey(event);" class="form-control" onchange="updateSlider('calcium', $(this).val());" onkeyup="updateSlider('calcium', $(this).val());" style="width: 100px;" />
                                                    <div class="float-right">
                                                        <img id="imgSCalciumRefresh" alt="Reset serum Calcium slider values to original" title="Reset Serum Calcium slider values to original" src="images/Refresh.png" style="width: 16px; height: 16px;" onclick="resetIndividualSlider('calcium');" />
                                                    </div>
                                                    <br />

                                                    <%--*Range Label*--%>
                                                    <span id="spnSCal" class="valueRange"></span>
                                                    <br />

                                                    <input type="text" id="calciumSlider" name="calciumSliderControl" value="" style="max-width: 250px;" />
                                                    <br />

                                                    <select id="selSCalcium" class="form-control" onchange="unitChange('calcium',$('#selSCalcium option:selected').text, $('#txtSCalcium').val());">
                                                        <%--<option value="0">(Please Select)</option>--%>
                                                        <option value="1" title="mg/dL" selected>mg/dL</option>
                                                        <option value="2" title="mmol/L">mmol/L</option>
                                                    </select>

                                                </td>
                                            </tr>

                                            <tr>
                                                <td class="QLabelLeft">
                                                    <label for="txtSPhosphate">Serum Phosphate:</label><label for="selSPhosphate" style="color: #FFF">_</label><label for="phosSlider" style="color: #FFF">_</label>
                                                </td>
                                                <%--************************--%>
                                                <%--*TANGRI SERUM PHOSPHATE*--%>
                                                <%--************************--%>
                                                <td class="QLabelRight">
                                                    <input id="txtSPhosphate" type="number" min="3" max="6.5" onkeypress="return isNumberKey(event);" class="form-control" onchange="updateSlider('phosphate', $(this).val());" onkeyup="updateSlider('phosphate', $(this).val());" style="width: 100px;" />
                                                    <div class="float-right">
                                                        <img id="imgResetPhosphate" alt="Reset serum phosphate slider values to original" title="Reset Serum phosphate slider values to original" src="images/Refresh.png" style="width: 16px; height: 16px;" onclick="resetIndividualSlider('phosphate');" />
                                                    </div>
                                                    <br />

                                                    <%--*Range Label*--%>
                                                    <span id="spnPhosphate" class="valueRange"></span>
                                                    <br />

                                                    <input type="text" id="phosSlider" name="phostphateSliderControl" value="" style="max-width: 250px;" />
                                                    <br />
                                                    <select id="selSPhosphate" class="form-control" onchange="unitChange('phosphate',$('#selSPhosphate option:selected').text, $('#txtSPhosphate').val());">
                                                        <%--<option value="0">(Please Select)</option>--%>
                                                        <option value="1" title="mg/dL" selected>mg/dL</option>
                                                        <option value="2" title="mmol/L">mmol/L</option>
                                                    </select>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td class="QLabelLeft">
                                                    <label for="txtSBicarbinate">Serum Bicarbonate:</label><label for="selSBicarbinate" style="color: #FFF">_</label><label for="biCarbSlider" style="color: #FFF">_</label>
                                                </td>
                                                <%--**************************--%>
                                                <%--*TANGRI SERUM BICARBONATE*--%>
                                                <%--**************************--%>
                                                <td class="QLabelRight">
                                                    <input id="txtSBicarbinate" type="number" min="15" max="28" onkeypress=" return isNumberKey(event);" class="form-control" onchange="updateSlider('bicarb', $(this).val());" onkeyup="updateSlider('bicarb', $(this).val());" style="width: 100px;" />
                                                    <div class="float-right">
                                                        <img id="imgBiCarb" alt="Reset serum bicarbonate slider values to original" title="Reset Serum bicarbonate slider values to original" src="images/Refresh.png" style="width: 16px; height: 16px;" onclick="resetIndividualSlider('bicarb');" />
                                                    </div>
                                                    <br />


                                                    <%--*Range Label*--%>
                                                    <span id="spnBiCarb" class="valueRange"></span>
                                                    <br />


                                                    <input type="text" id="biCarbSlider" name="biCarbonateSliderControl" value="" style="max-width: 250px;" />
                                                    <br />
                                                    <select id="selSBicarbinate" class="form-control" onchange="unitChange('bicarbonate');">
                                                        <%--<option value="0">(Please Select)</option>--%>
                                                        <option value="1" title="mEq/dL" selected>mEq/L</option>
                                                        <option value="2" title="mmol/L">mmol/L</option>
                                                    </select>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td class="QLabelLeft">
                                                    <label for="txtSAlbumin">Serum Albumin:</label><label for="selSAlbumin" style="color: #FFF">_</label><label for="albSlider" style="color: #FFF">_</label>
                                                </td>
                                                <%--**********************--%>
                                                <%--*TANGRI SERUM ALBUMIN*--%>
                                                <%--**********************--%>
                                                <td class="QLabelRight">
                                                    <input id="txtSAlbumin" type="number" min="1" max="4" onkeypress=" return isNumberKey(event);" class="form-control" onchange="updateSlider('albumin', $(this).val());" onkeyup="updateSlider('albumin', $(this).val());" style="width: 100px;" />
                                                    <div class="float-right">
                                                        <img id="imgSAlbumin" alt="Reset Serum Albumin slider values to original" title="Reset Serum Albumin slider values to original" src="images/Refresh.png" style="width: 16px; height: 16px;" onclick="resetIndividualSlider('albumin');" />
                                                    </div>
                                                    <br />

                                                    <%--*Range Label*--%>
                                                    <span id="spnSAlbumin" class="valueRange"></span>
                                                    <br />

                                                    <input type="text" id="albSlider" name="AluminSliderControl" value="" style="max-width: 250px;" />
                                                    <br />
                                                    <select id="selSAlbumin" class="form-control" onchange="unitChange('albumin',$('#selSAlbumin option:selected').text, $('#txtSAlbumin').val()); ">
                                                        <%--<option value="0">(Please Select)</option>--%>
                                                        <option value="1" title="g/dL" selected>g/dL</option>
                                                        <option value="2" title="g/L">g/L</option>
                                                    </select>
                                                </td>
                                            </tr>

                                        </table>
                                        <%-- <div class="pull-right">
                                                <button id="btnTangriGo" class="btn btnSubtle" onclick="showTangriGraphOnSliderChange(); return false;">Update Graph</button>
                                            </div>--%>
                                        <div class="float-left">
                                            <%--<button id="btnTangriClear" class="btn btnSubtle" onclick="return resetChoices('tangri');resetSliders();">Reset Choices</button>--%>
                                            <button id="Button1" class="btn btnSubtle" onclick=" return resetChoices('tangri'); return false;">Reset Choices</button>
                                        </div>

                                        <br />
                                        <br />
                                        <br />
                                        <br />

                                    </div>

                                    <div class="col-lg-6">

                                        <div class="score">
                                            <strong>Estimated probability of progression to end-stage renal disease (ESRD) in CKD patients at 2 and 5 years (expressed as a percentage between 0% and 100%):</strong>

                                            <br />
                                            <br />

                                            <%--*Required messages*--%><%--Commented out due to edits  from UM 11/2019--%>
                                            <div class="tangri_required_messages">
                                                In order to show a chart of the calculations, the following are required:
                                        
                                                <ul class="tangri_req_list">
                                                    <li id="tage" class="tangri_age">Age</li>
                                                    <li id="tsex" class="tangri_sex">Sex</li>
                                                </ul>
                                            </div>

                                            <%--*Graph TANGRI Results*--%>
                                            <div id='divTangriGraph' style="width: 513px;"></div>


                                            <span id="spnTangriAnswer"></span>

                                        </div>
                                    </div>
                                </div>

                            </div>


                        </div>

                        <br />
                        <br />

                        <div class="references">
                            <p><strong>References and Sources:</strong></p>

                            Tangri, Navdeep, et al. Multinational assessment of accuracy of equations for predicting risk of kidney failure: a meta-analysis <em>JAMA</em> 315.2(2016):164-174. supplement

                                <br />
                            <br />
                            Tangri N, Stevens LA, Griffith J, Tighiouart H, Djurdjev O, Naimark D, Levin A, Levey AS. A predictive model for progression of chronic kidney disease to kidney failure. 
                                <em>JAMA.</em> 2011 Apr 20;305(15):1553-9. doi: 10.1001/jama.2011.451. Epub 2011 Apr 11. 
                                <br />
                            <a href="http://www.ncbi.nlm.nih.gov/pubmed/21482743" target="_blank">www.ncbi.nlm.nih.gov/pubmed/21482743</a>

                        </div>
                    </div>
                </div>





            </div>
        </div>

        <br />
        <br />


    </div>

    </div>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="CustomJavaScript" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {

            //Initiate the content tabs
            //CDC.Gadgets.Tabs.init();
            console.log("initiate Sliders");
            initiateSliders();


            //General cleanup of late formatting
            setTimeout(function () {
                $('#footNoteLinkBang, #footNoteLinkTangri').attr('class', '');
            }, 200);


        });

        //*Events*
        $(document).keydown(function (e) {

            //See Experiment project file: SliderFun.html for keyboard management (508 required)

            var handle = getCurrentSliderHandle();

            if (handle == '0') { return; }
            var txtID = $(':focus').parent().parent().find('.irs-hidden-input').attr('id');

            //*Get the slider*
            var $slider = $('#' + txtID).data('ionRangeSlider');

            //*Get the key pressed*
            if ((e.keyCode || e.which) == 37) {//clicked left arrow        
                moveSlider('d' + handle);
            } else if ((e.keyCode || e.which) == 39) {//clicked right arrow
                moveSlider('a' + handle);
            } else if ((e.keyCode || e.which) == 9) {//Clicked a Tab
                handle = 'b'; //tab
            }


            //Show Graph - if there is enough detail
            showTangriGraphOnSliderChange();


            //Give them all tab-stops
            $('.irs-slider').attr('tabindex', '0');


            //*Reset focus*
            setTimeout(function () {
                switch (handle) {
                    case "f":
                        $('#' + txtID).parent().find('.from').focus();
                        break;
                    case "t":
                        $('#' + txtID).parent().find('.to').focus();
                        break;
                    case "b":
                        //Do nothing - rather, actively DON'T retain the focus. Be free....fly away...
                        break;
                }
            }, 0);

        });


        //*utilites*
        function formatValueForChartText(calculatedValue) {

            var answer;
            //console.log("calc val=" + calculatedValue);
            if (calculatedValue == 0) { calculatedValue = 0.01; }
            if (calculatedValue < 1) { answer = '<1%'; } else { answer = parseFloat(calculatedValue).toFixed(1).toString() + '%'; }


            return answer;
        }
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            if (charCode != 46 && charCode > 31
                && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }
        function limitAgeEntry() {

            //Purpose: Do not permit someone to enter a 3 digit year
            //Location(s): Used on Age field in Tangri Calculator

            var contents = $('#txtAge').val();

            if (contents.length > 2) {
                $('#txtAge').val(contents.substring(0, 2))
            }
        }
        function removeRequirement(name) {

            console.log("inside removeRequirement");
            //Purpose: toggle validation messages on Tangri calculator
            //Location(s): Age and sex fields on Tangri Calculator
            var Tangri_or_Bang = 'b';

            //*Hide the li's*
            switch (name) {
                case 'tage':
                    if ($('#txtAge').val().length > 1) { $('#tage').addClass('hiddenMsg'); }
                    Tangri_or_Bang = 't';
                    break;
                case 'tsex':
                    $('#tsex').addClass('hiddenMsg');
                    Tangri_or_Bang = 't';
                    break;
                case 'bage':
                    $('#LiBangAge').addClass('hiddenMsg');
                    break;
                case 'bsex':
                    $('#LiBangSex').addClass('hiddenMsg');
                    break;
            }

            //*********************
            //*Short cut Variables*
            //*********************
            var isOfAge;
            var maleIsSelected;
            var femaleIsSelected;
            var hasSelectedSex;


            //*************************
            //*Manage Bang Validations*
            //*************************
            if (Tangri_or_Bang == 'b') {

                isOfAge = $('#selBang2').val() > 0;
                femaleIsSelected = $('#rbSexFemale').is(':checked');//console.log('Bang calc female selected: ' + femaleIsSelected);        
                maleIsSelected = $('#rbSexMale').is(':checked');//console.log('Bang calc male selected: ' + maleIsSelected);
                hasSelectedSex = (maleIsSelected == true || femaleIsSelected == true);

                setTimeout(function () {
                    if (isOfAge == true && hasSelectedSex == true) {
                        $('.bang_req_list, .bang_req_list li, .bang_required_messages').addClass('hiddenMsg');
                        $('#divBangGraph').removeClass('hiddenMsg');
                    } else if (isOfAge == false) {
                        $('.bang_req_list, #LiBangAge, .bang_required_messages').removeClass('hiddenMsg');
                        $('#divBangGraph').addClass('hiddenMsg');
                        $('#spnBangAnswer').hide();
                    } else if (hasSelectedSex == false) {
                        $('.bang_req_list, #LiBangSex, .bang_required_messages').removeClass('hiddenMsg');
                        $('#divBangGraph').addClass('hiddenMsg');
                        $('#spnBangAnswer').hide();
                    } else {
                        $('.bang_req_list').addClass('hiddenMsg');
                        $('#divBangGraph').addClass('hiddenMsg');
                    }
                }, 0);
            }


            //***************************
            //*Manage Tangri Validations*
            //***************************
            else if (Tangri_or_Bang == 't') {

                isOfAge = parseInt($('#txtAge').val()) >= 18;
                maleIsSelected = $('#rbTangriSexMale').is(':checked');//console.log('male selected: ' + maleIsSelected);
                femaleIsSelected = $('#rbTangriSexFemale').is(':checked');//console.log('female selected: ' + femaleIsSelected);
                hasSelectedSex = (maleIsSelected == true || femaleIsSelected == true);//console.log('hasSelectedSex selected: ' + hasSelectedSex);


                //*Manage the outer Div*
                setTimeout(function () {
                    if (isOfAge == true && hasSelectedSex == true) {
                        $('.tangri_required_messages').addClass('hiddenMsg');//.hide();
                        $('#divTangriGraph').removeClass('hiddenMsg');//.show();
                    } else if (isOfAge == false) {
                        $('.tangri_required_messages').removeClass('hiddenMsg');//.show();
                        $('#divTangriGraph').addClass('hiddenMsg');//.hide();
                        $('#tage').removeClass('hiddenMsg');//.show();
                    } else if (hasSelectedSex == false) {
                        $('.tangri_required_messages').removeClass('hiddenMsg');//.show();
                        $('#tsex').removeClass('hiddenMsg');//.show();
                        $('#divTangriGraph').addClass('hiddenMsg');//.hide();
                    } else {
                        $('.tangri_required_messages').addClass('hiddenMsg');//.show();
                        $('#divTangriGraph').addClass('hiddenMsg');//.hide();
                    }
                }, 0);
            }
        }
        function resetChoices(calculatorName) {

            switch (calculatorName) {
                case 'bang':
                    $('#selBang2').val(0);
                    $("#rbSexFemale").prop("checked", false);
                    $("#rbSexMale").prop("checked", false);
                    $("#rbAnemiaNo").prop("checked", true);
                    $("#rbHypertensionNo").prop("checked", true);
                    $("#rbDiabetesNo").prop("checked", true);
                    $("#rbCVDNo").prop("checked", true);
                    $("#rbCHFNo").prop("checked", true);
                    $("#rbPVDNo").prop("checked", true);
                    $("#rbProteinuriaNo").prop("checked", true);

                    $('#divBangGraph').html('');
                    $('.bangControls').hide().fadeIn(500);

                    $('#divBangGraph').removeClass('hiddenMsg');
                    $('.bang_req_list, .bang_req_list li, .bang_required_messages').removeClass('hiddenMsg');
                    $('#spnBangAnswer').hide();

                    break;

                case 'tangri':
                    $('#txtAge').text('').val('');
                    $('#rbTangriSexFemale').prop("checked", false);
                    $('#rbTangriSexMale').prop("checked", false);
                    $('#txtEGFR').text('').val('');

                    $('#txtACRatio').text('').val('');
                    $('#selACRatio').val(1);

                    $('#txtSCalcium').text('').val('');
                    $('#selSCalcium').val(1);

                    $('#txtSPhosphate').text('').val('');
                    $('#selSPhosphate').val(1);

                    $('#txtSBicarbinate').text('').val('');
                    $('#selSBicarbinate').val(1);

                    $('#txtSAlbumin').text('').val('');
                    $('#selSAlbumin').val(1);

                    $('#divBangGraph').html('');
                    $('.tangriControls').hide().fadeIn(500);
                    $('#spnTangriAnswer').html('');

                    resetSliders();

                    $('#divTangriGraph').text('').val('');

                    $('#divTangriGraph').removeClass('hiddenMsg');
                    $('.tangri_required_messages, .tangri_required_messages li').removeClass('hiddenMsg');
                    break;
            }

            return false;
        }
        function submitData(calculatorName) {

            console.log("inside submitData " + calculatorName);
            var values = '';


            //*Get the entered values*
            switch (calculatorName) {
                case 'bang':

                    //******************
                    //*NEED Age AND Sex*
                    //******************
                    var selectedAge = $('#selBang2 option:selected').val();
                    var sex = $('input[type=radio][name=rbSex]:checked').val();
                    if (selectedAge == 0 || typeof (sex) == 'undefined') {
                        return;
                    }

                    checkForBangResult();

                    break;
                case 'tangri':
                    graphTangriResults(checkForTangriResult());
            }


            return false;
        }


        //*BANG*
        function checkForBangResult() {

            var answer = 0;


            var selectedAge = $('#selBang2 option:selected').val();
            var sex = $('input[type=radio][name=rbSex]:checked').val();
            var anemia = $('input[type=radio][name=rbAnemia]:checked').val();
            var hypertension = $('input[type=radio][name=rbHypertension]:checked').val();
            var diabetes = $('input[type=radio][name=rbDiabetes]:checked').val();
            var CVD = $('input[type=radio][name=rbCVD]:checked').val();
            var CHF = $('input[type=radio][name=rbCHF]:checked').val();
            var PVD = $('input[type=radio][name=rbPVD]:checked').val();
            var proteinuria = $('input[type=radio][name=rbProteinuria]:checked').val();
            var interceptThingie = -5.4;


            var calcAnswer = 0;
            var scored = 0;
            var general = 15.4;
            var ckd_prob = 0;


            //*****************
            //*Determine score*
            //*****************
            var crude_score = selectedAge + 1;
            crude_score += sex == 0 ? 1 : 0; //add one if female
            crude_score += anemia;
            crude_score += hypertension;
            crude_score += diabetes;
            crude_score += CVD;
            crude_score += CHF;
            crude_score += PVD;
            crude_score += proteinuria;

            var crude_score1 = crude_score >= 4 ? crude_score : 0;


            //************
            //*xB thingie*
            //************
            var xB = interceptThingie;
            switch (selectedAge) {
                case '2':
                    xB += 1.55;
                    break;
                case '3':
                    xB += 2.31;
                    break;
                case '4':
                    xB += 3.23;
                    break;
            }

            if (sex == 0) { xB += .29; }
            xB += anemia * .93;
            xB += hypertension * .45;
            xB += diabetes * .44;
            xB += CVD * .59;
            xB += CHF * .45;
            xB += PVD * .74;
            xB += proteinuria * .83;

            var CKD_Probability = 1 / (1 + Math.exp(xB * -1));
            var ckd_prob_pretty = (CKD_Probability * 100).toFixed(1);


            //***********************
            //*Show text probability*
            //***********************       
            var txt = "<div>U.S. National Average: <a href='https://nccd.cdc.gov/ckd/detail.aspx?Qnum=Q372' target='_blank'>15.4%</a></div>";
            $('#spnBangAnswer').html(txt).show();


            //***************
            //*Graph Results*
            //***************
            graphBangResults(scored, general, ckd_prob_pretty);


            //Visual Alert of change
            $('.svg-container').hide().fadeIn(50);


            return answer;
        }
        function graphBangResults(scored, general, ckd_prob) {


            //*Build Chart
            //var xdata = ['Prevalence<br>of CKD, U.S.', 'CKD Probability<br>(This Person)%'];
            var xdata = ['CKD Probability<br>(This Person)%'];

            //No such thing as 0
            //if (general == 0) { general = 0.01; }
            if (ckd_prob == 0) { ckd_prob = 0.01; }

            //1 significant digit only
            //var ydata = [parseFloat(general).toFixed(1), parseFloat(ckd_prob).toFixed(1)]; //Removed SCORE from Brenda's suggestion
            var ydata = [parseFloat(ckd_prob).toFixed(1)]; //Removed General from Jenn's suggestion (3/15/2019 email)


            //*Add percentage signs to chart text
            //var generalText = formatValueForChartText(general);
            var ckdProbText = formatValueForChartText(ckd_prob);


            var data = [{
                x: xdata,
                y: ydata,
                type: 'bar',
                //text: ydata,
                //text: [generalText,ckdProbText],
                text: [ckdProbText],
                textposition: 'auto',
                hoverinfo: 'none',
                marker: {
                    color: 'rgb(158,202,225)',
                    //opacity: 0.6,
                    line: {
                        color: 'rbg(8,48,107)',
                        width: 1.5
                    }
                }

            }];

            var layout = {
                yaxis: {
                    title: 'Percent',
                    fixedrange: true,
                    range: [0, 100],
                    backgroundcolor: 'rgb(250,250,210)',
                    linecolor: 'rgb(0,0,0,0)',
                    gridcolor: 'rgb(0,0,0,0)'
                },
                xaxis: {
                    fixedrange: true,
                    backgroundcolor: 'rgb(250,250,210)',
                    linecolor: 'rgb(0,0,0,0)'
                },
                plot_bgcolor: 'rgb(255,255,255)',
                paper_bgcolor: 'rgb(250,250,210)',

            };

            Plotly.newPlot('divBangGraph', data, layout);
        }


        //*TANGRI*
        function checkForTangriResult() {

            var answer = 0;

            if ($('.TangriAddedFields').is(':visible')) {
                //Calculate Long Version                
                answer = runTangriLongVersion()
                return answer;
            } else {
                //Calculate Short Version                
                answer = runTangriShortVersion();
                return answer;
            }

            //Visual Alert of change
            $('.svg-container').hide().fadeIn(300);

        }
        function getTangriLongValue(age, sex, egfr, albuminCRRatio, acratioUnits, calcium, calciumUnits, phosphorous, phosphorusUnits, albumin, albuminUnits, bicarbonate, bicarbonateUnits, yearType) {

            //*********************************
            //*Tangri Long version calculation*
            //*********************************

            //*Make sure all values are entered*
            if (typeof (age) != 'undefined' && typeof (sex) != 'undefined' && typeof (egfr) != 'undefined' && typeof (albuminCRRatio) != 'undefined' && typeof (acratioUnits) != 'undefined'
                && typeof (calcium) != 'undefined' && typeof (calciumUnits) != 'undefined'
                && typeof (phosphorous) != 'undefined' && typeof (phosphorusUnits) != 'undefined'
                && typeof (albumin) != 'undefined' && typeof (albuminUnits) != 'undefined'
                && typeof (bicarbonate) != 'undefined' && typeof (bicarbonateUnits) != 'undefined'
            ) {

                var ageX, ageCoeff, ageXBar, ageBetaXBar, ageBetaX;
                var sexX, sexCoeff, sexXBar, sexBetaXBar, sexBetaX;
                var egfrX, egfrCoeff, egfrXBar, egfrBetaXBar, egfrBetaX;
                var ratioX, ratioCoeff, ratioXBar, ratioBetaXBar, ratioBetaX;
                var calciumX, calciumCoeff, calciumXBar, calciumBetaXBar, calciumBetaX;
                var phosX, phosCoeff, phosXBar, phosBetaXBar, phosBetaX;
                var albuminX, albuminCoeff, albuminXBar, albuminBetaXBar, albuminBetaX;
                var biCarbX, biCarbCoeff, biCarbXBar, biCarbBetaXBar, biCarbBetaX;

                //*****
                //*AGE*
                //*****
                ageX = age / 10;
                ageCoeff = -0.1992;
                ageXBar = 7.036;
                ageBetaXBar = ageCoeff * ageXBar;
                ageBetaX = ageCoeff * ageX;
                //console.log('ageBetaXBar: ' + ageBetaXBar);

                //*****
                //*SEX*
                //*****
                sexX = sex;//Whatever sex was chosen - rb0=female, rb1=male
                sexCoeff = 0.1602;
                sexXBar = 0.5642;
                sexBetaXBar = sexCoeff * sexXBar;
                sexBetaX = sexCoeff * sexX;
                //console.log('sexBetaXBar: ' + sexBetaXBar);

                //******
                //*eGFR*
                //******
                egfrX = egfr / 5;
                egfrCoeff = -0.4919;
                egfrXBar = 7.222;
                egfrBetaXBar = egfrCoeff * egfrXBar;
                egfrBetaX = egfrCoeff * egfrX;
                //console.log('egfrBetaXBar: ' + egfrBetaXBar);


                //*******
                //*RATIO*
                //*******
                ratioX = Math.log(albuminCRRatio);
                ratioCoeff = 0.3364;
                ratioXBar = 5.137;
                ratioBetaXBar = ratioCoeff * ratioXBar;
                ratioBetaX = ratioCoeff * ratioX;
                //console.log('ratioBetaXBar: ' + ratioBetaXBar);

                //*********
                //*Calcium*
                //*********
                calciumX = calcium;
                calciumCoeff = -0.2228;
                calciumXBar = 9.355;
                calciumBetaXBar = calciumCoeff * calciumXBar;
                calciumBetaX = calciumCoeff * calciumX;
                //console.log('calciumBetaXBar: ' + calciumBetaXBar);
                //console.log('calciumBetaX: ' + calciumBetaX);

                //*************
                //*Phosphorous*
                //*************
                phosX = phosphorous;
                phosCoeff = 0.2604;
                phosXBar = 3.916;
                phosBetaXBar = phosCoeff * phosXBar;
                phosBetaX = phosCoeff * phosX;
                //console.log('phosBetaXBar: ' + phosBetaXBar);
                //console.log('phosBetaX: ' + phosBetaX);


                //*********
                //*Albumin*
                //*********
                albuminX = albumin;
                albuminCoeff = -0.3441;
                albuminXBar = 3.997;
                albuminBetaXBar = albuminCoeff * albuminXBar;
                albuminBetaX = albuminCoeff * albuminX;
                //console.log('albuminBetaXBar: ' + albuminBetaXBar);
                //console.log('albuminBetaX: ' + albuminBetaX);


                //*************
                //*Bicarbonate*
                //*************
                biCarbX = bicarbonate;
                biCarbCoeff = -0.07354;
                biCarbXBar = 25.57;
                biCarbBetaXBar = biCarbCoeff * biCarbXBar;
                biCarbBetaX = biCarbCoeff * biCarbX;
                //console.log('biCarbBetaXBar: ' + biCarbBetaXBar);
                //console.log('biCarbBetaX: ' + biCarbBetaX);


                var betaXBarTotal = ageBetaXBar + sexBetaXBar + egfrBetaXBar + ratioBetaXBar + calciumBetaXBar + phosBetaXBar + albuminBetaXBar + biCarbBetaXBar;
                //console.log('betaXBar-Total: ' + betaXBarTotal);


                var betaXTotal = ageBetaX + sexBetaX + egfrBetaX + ratioBetaX + calciumBetaX + phosBetaX + albuminBetaX + biCarbBetaX;
                // console.log('betaX-Total: ' + betaXTotal);


                var baseLine = 0.9096; //5-year (defualt)
                if (typeof (yearType) != 'undefined' && yearType == '2') { baseLine = 0.9757; } //2 year

                var risk = 1 - Math.pow(baseLine, Math.exp(betaXTotal - betaXBarTotal));
                var report = Math.min(0.7, risk);

                //console.log('Long version calc = ' + report + ' risk is: ' + risk);
                return (risk * 100).toFixed(1);
            }
        }
        function getTangriShortValue(age, sex, egfr, albuminCRRatio, acratioUnits, yearType) {

            //console.log('albumin val: ' + albuminCRRatio);

            //*Make sure all values are entered*
            if (typeof (age) != 'undefined' && typeof (sex) != 'undefined' && typeof (egfr) != 'undefined' && typeof (albuminCRRatio) != 'undefined' && typeof (acratioUnits) != 'undefined') {

                //if (sex >= 0 && egfr > 0 && albuminCRRatio >= 0 && age > 0 && acratioUnits >= 0) {
                //if (sex >= 0 && albuminCRRatio >= 0 && age > 0 && acratioUnits >= 0) {
                //console.log('Values: ' + age + '|' + sex + '|' + egfr + '|' + albuminCRRatio + '|' + acratioUnits);

                var ageX, ageCoeff, ageXBar, ageBetaXBar, ageBetaX;
                var sexX, sexCoeff, sexXBar, sexBetaXBar, sexBetaX;
                var egfrX, egfrCoeff, egfrXBar, egfrBetaXBar, egfrBetaX;
                var ratioX, ratioCoeff, ratioXBar, ratioBetaXBar, ratioBetaX;


                //*****
                //*AGE*
                //*****
                ageX = age / 10;
                ageCoeff = -0.2201;
                ageXBar = 7.036;
                ageBetaXBar = ageCoeff * ageXBar;
                ageBetaX = ageCoeff * ageX;
                //console.log('ageBetaXBar: ' + ageBetaXBar);

                //*****
                //*SEX*
                //*****
                sexX = sex;//Whatever sex was chosen - rb0=female, rb1=male
                sexCoeff = 0.2467;
                sexXBar = 0.5642;
                sexBetaXBar = sexCoeff * sexXBar;
                sexBetaX = sexCoeff * sexX;
                //console.log('sexBetaXBar: ' + sexBetaXBar);

                //******
                //*eGFR*
                //******
                egfrX = egfr / 5;
                //console.log('egfrX: ' + egfrX);
                egfrCoeff = -0.5567;
                egfrXBar = 7.222;
                egfrBetaXBar = egfrCoeff * egfrXBar;
                egfrBetaX = egfrCoeff * egfrX;
                //console.log('egfrBetaXBar: ' + egfrBetaXBar);
                // console.log('egfrBetaX: ' + egfrBetaX);


                //*******
                //*RATIO*
                //*******
                //curUnit = $('#selACRatio option:selected').text();
                //console.log('unit: ' + curUnit);

                //if (curUnit === 'mg/mmol') { albuminCRRatio = albuminCRRatio * 10; }
                //console.log('***albuCRRation: ' + albuminCRRatio);
                ratioX = Math.log(albuminCRRatio);
                //console.log('ratiox: ' + ratioX);


                ratioCoeff = 0.4510;
                ratioXBar = 5.317;
                ratioBetaXBar = ratioCoeff * ratioXBar;
                ratioBetaX = ratioCoeff * ratioX;
                //console.log('ratioBetaXBar: ' + ratioBetaXBar);


                var betaXBarTotal = ageBetaXBar + sexBetaXBar + egfrBetaXBar + ratioBetaXBar;
                //console.log('betaXBar-Total: ' + betaXBarTotal);


                var betaXTotal = ageBetaX + sexBetaX + egfrBetaX + ratioBetaX;
                //console.log('betaX-Total: ' + betaXTotal);


                //var st = 0.963370;                    
                var baseLine = 0.8996; //5-year (default)
                if (typeof (yearType) != 'undefined' && yearType == '2') { baseLine = 0.9751; } //2 year

                var risk = 1 - Math.pow(baseLine, Math.exp(betaXTotal - betaXBarTotal));
                var report = Math.min(0.7, risk);

                //console.log('Short version calc = ' + report + ' risk is: ' + risk);
                return (risk * 100).toFixed(1);
                //}
            }
        }
        function graphTangriResults(twoYrData, fiveYrData) {
            //console.log("graphTangriResults");
            //Using the Ben S model (s:\mlipham\Bens\plotlyML.html)
            var xData = ['Two Year<br />Risk of Progression', 'Five Year<br />Risk of Progression'];

            var twoYrZero = parseFloat(twoYrData[0]);
            var fiveYrZero = parseFloat(fiveYrData[0]);
            var twoYrOne = parseFloat(twoYrData[1]);
            var fiveYrOne = parseFloat(fiveYrData[1]);

            var twoyeartext;
            var fiveyeartext;

            if (typeof (twoYrData[1]) === "undefined") {
                twoYrOne = 0;
                twoyeartext = formatValueForChartText(twoYrOne);
            }
            else { twoyeartext = formatValueForChartText(twoYrZero) + ' - ' + formatValueForChartText(twoYrOne); }  //text above the bar should contain a range, unless the value is <1%

            if (typeof (fiveYrData[1]) === "undefined") {
                fiveYrOne = 0;
                fiveyeartext = formatValueForChartText(fiveYrOne);
            }
            else { fiveyeartext = formatValueForChartText(fiveYrZero) + ' - ' + formatValueForChartText(fiveYrOne); } //text above the bar should contain a range, unless the value is <1%

            var textList = [twoyeartext, fiveyeartext];
            var yData = [twoYrOne, fiveYrOne];

            //console.log('xdata:' + xData);
            //console.log('textlist:' + textList);
            //console.log('ydata:' + yData);

            //console.log('2year:' + twoYrData);
            //console.log('5year:' + fiveYrData);

            //*Base*
            var trace1 = {
                x: xData,
                y: [twoYrData[0], fiveYrData[0]],
                text: '',
                marker: {
                    color: 'rgba(61,15,132,0.0)' //purple
                },
                type: 'bar',
                hoverinfo: 'skip'
            };


            //*Lowest Risk*
            var trace2 = {
                x: xData,
                y: [twoYrData[1] - twoYrData[0], 0],//total - trace1 y[i] (put in first slot only - nothing in second series placeholder)
                type: 'bar',
                text: ['Upper Risk:' + twoYrData[1] + '<br>Lower Risk:' + twoYrData[0], ''],
                marker: {
                    //color: 'rgba(255, 153, 51,1)',
                    color: 'rgba(211, 211, 211, 1)', //gray
                    line: {
                        color: 'rgba(0, 0, 0,1.0)',
                        width: 1
                    }
                },
                name: ''
            };

            //*Highest Risk*
            var trace3 = {
                x: xData,
                y: [0, fiveYrData[1] - fiveYrData[0]],//total - trace1 y[i] (put in second slot only - nothing in first series placeholder)
                type: 'bar',
                text: ['', 'Upper Risk:' + fiveYrData[1] + '<br>Lower Risk:' + fiveYrData[0]],
                marker: {
                    //color: 'rgba(153, 204, 255, 1)',
                    color: 'rgba(211, 211, 211, 1)', //gray
                    line: {
                        color: 'rgba(0, 0, 0, 1.0)',
                        width: 1
                    }
                },
                name: ''
            };

            var data = [trace1, trace2, trace3];

            var shapesArray;
            if (typeof (twoYrData[1]) === "undefined" || typeof (fiveYrData[1]) === "undefined") //if the second value of the array is undefined, then don't display the blue/orange lines
            {
                shapesArray = "";
            }
            else {
                shapesArray = "[ " +//drawing line borders to represent the upper and lower risks
                    " {" + //two year upper risk
                    "type: 'line'," +
                    "xref: 'paper'," +
                    "x0: 0.05," +
                    "y0: twoYrData[1]," +
                    "x1: 0.45," +
                    "y1: twoYrData[1]," +
                    "line: {" +
                    //"    color: 'rgb(153, 204, 255)'," + //Light Blue
                    "    color: 'rgb(128, 0, 0)'," + //Maroon
                    "    width: 4," +
                    "    dash: 'solid'" +
                    "}" +
                    "}," +
                    "{" +   //two year lower risk
                    "type: 'line'," +
                    "xref: 'paper'," +
                    "x0: 0.05," +
                    "y0: twoYrData[0]," +
                    "x1: 0.45," +
                    "y1: twoYrData[0]," +
                    "line: {" +
                    //"    color: 'rgb(255, 153, 51)'," + //Orange
                    "    color: 'rgb(102, 178 ,102 )'," + //Green
                    "    width: 4," +
                    "    dash: 'solid'" +
                    "}" +
                    "}," +

                    "{ " +//five year upper risk
                    "type: 'line'," +
                    "xref: 'paper'," +
                    "x0: 0.55," +
                    "y0: fiveYrData[1]," +
                    "x1: 0.95," +
                    "y1: fiveYrData[1]," +
                    "line: {" +
                    //"    color: 'rgb(153, 204, 255)'," + //light blue
                    "    color: 'rgb(128, 0, 0)'," + //Maroon
                    "    width: 4," +
                    "    dash: 'solid'" +
                    "}" +
                    "}," +
                    "{ " + //five year lower risk 
                    "type: 'line'," +
                    "xref: 'paper'," +
                    "x0: 0.55," +
                    "y0: fiveYrData[0]," +
                    "x1: 0.95," +
                    "y1: fiveYrData[0]," +
                    "line: {" +
                    //"    color: 'rgb(255, 153, 51)'," + //Orange
                    "    color: 'rgb(102, 178 ,102 )'," + //Green
                    "    width: 4," +
                    "    dash: 'solid'" +
                    "}" +
                    "}]";
            }

            //console.log("sa=" + shapesArray);

            var layout = {
                title: '',
                barmode: 'stack',
                paper_bgcolor: 'rgba(245,246,249,1)', //Light gray
                plot_bgcolor: 'rgba(245,246,249,1)', //Light gray
                width: 500,
                height: 500,
                text: '',
                showlegend: false,
                hovermode: 'closest',
                displayModeBar: false,
                annotations: [],
                yaxis: {
                    title: 'Percent',
                    fixedrange: true,
                    range: [0, 105],
                    backgroundcolor: 'rgb(250,250,210)',
                    linecolor: 'rgb(0,0,0,0)',
                    gridcolor: 'rgb(205,205,205,0)'
                },
                shapes: eval(shapesArray)
            };

            for (var i = 0; i < 2; i++) { //displays the text above the bar
                var y_int = parseFloat(yData[i]);
                var y_int_pos = 0;
                y_int_pos = y_int + 3;

                //console.log("y_int_pos=" + y_int_pos);
                var result = {
                    x: xData[i],
                    y: y_int_pos,
                    text: textList[i],
                    font: {
                        family: 'Arial',
                        size: 14,
                        color: 'rgba(0,0,0,1)' //Black
                    },
                    showarrow: false
                };
                layout.annotations.push(result);
            };

            Plotly.newPlot('divTangriGraph', data, layout, { displaylogo: false });

            //$('.modebar-group').each(function () {
            //    $(this).find('[data-title="Produced with Plotly"]').parent.remove();//removing this anchor tag so that Plotly becomes 508 compliant.
            //});

            //$('.gradients').append("<linearGradient id='mygradient'><stop offset='0%' stop-color='rgb(255, 255, 0)' stop-opacity='1'></stop><stop offset='100%' stop-color='rgb(44, 88, 44)' stop-opacity='1'></stop></linearGradient>");
            //$(".point").find("path").css({ 'fill': '' });
            ////$(".points").empty();
            //$(".point").find("path").css({ 'fill': 'url(#mygradient)' });
        }

        function runTangriLongVersion(yrType) {

            // console.log("runTangriLongVersion=" + yrType);
            //setTimeout(function () { console.log("after timeout"); }, 3000);
            //********************************
            //*TODO: Double check conversions*
            //********************************

            //*Get variables*
            var age;
            var sex;
            var egfrMin, egfrMax;
            var albuminCRRatioMin, albuminCRRatioMax;
            var acratioUnits;
            var calciumMin, calciumMax;
            var calciumUnits;
            var phosphorousMin, phosphorousMax;
            var phosphorusUnits;
            var albuminMin, albuminMax;
            var albuminUnits;
            var bicarbonateMin, bicarbonateMax;
            var bicarbonateUnits;

            age = $('#txtAge').val();
            sex = $('input[type=radio][name=rbSexTangri]:checked').val();


            //******
            //*eGFR* -- these are reversed on purpose (negative coefficient)
            //******    
            egfrMin = getSliderValue('egfr', 'to');
            egfrMax = getSliderValue('egfr', 'from');


            //*****
            //*ACR*
            //*****
            albuminCRRatioMin = getSliderValue('acratio', 'from');
            albuminCRRatioMax = getSliderValue('acratio', 'to');
            acratioUnits = $('#selACRatio').val();
            if (acratioUnits == 2) {
                //[Urine albumin to creatinine ratio] mg/g to mg/mmol multiply by 0.113        
                albuminCRRatioMin /= 0.113;
                albuminCRRatioMax /= 0.113;
            }


            //*********
            //*Calcium* -- these are reversed on purpose (negative coefficient)
            //*********
            calciumMin = getSliderValue('calcium', 'to');
            calciumMax = getSliderValue('calcium', 'from');
            calciumUnits = $('#selSCalcium').val();
            if (calciumUnits == 2) {
                //serum Calcium mg.dL to mmol/L multiply by 0.2495
                calciumMin /= .2495;
                calciumMax /= .2495;
            }


            //*************
            //*Phosphorous* (positive coeff - reversed)
            //*************
            phosphorousMin = getSliderValue('phosphate', 'from');
            phosphorousMax = getSliderValue('phosphate', 'to');
            phosphorusUnits = $('#selSPhosphate').val();
            if (phosphorusUnits == '2') {
                //Serum Phosphate - mg/dL to mmol/L - multiply by .3229
                phosphorousMin /= .3229;
                phosphorousMax /= .3229;

                //console.log('(mmol/L) PhosphorousMin:' + phosphorousMin);
                //console.log('(mmol/L) PhosphorousMax:' + phosphorousMax);
            }


            //*************
            //*BiCarbonate* (negative coeff - reversed)
            //*************
            bicarbonateMin = getSliderValue('bicarb', 'to');
            bicarbonateMax = getSliderValue('bicarb', 'from');
            bicarbonateUnits = $('#selSBicarbinate').val(); //-- no conversion(?)


            //*********
            //*Albumin* (negative coeff)
            //*********    
            albuminMin = getSliderValue('albumin', 'to');
            albuminMax = getSliderValue('albumin', 'from');
            albuminUnits = $('#selSAlbumin').val();
            if (albuminUnits == 2) {
                albuminMin /= 10;
                albuminMax /= 10;
            }

            // console.log('runTangriLongVersion - after getting values');
            //console.log('age:' + age);
            //console.log('sex:' + sex);
            //console.log('egfrMin:' +egfrMin );
            //console.log('albuminCRRationMin:' + albuminCRRatioMin);
            //console.log('AcratioUnits:' + acratioUnits);
            //console.log('calciumMin:' + calciumMin);
            //console.log('calciumUnits:' + calciumUnits);
            //console.log('PhosphorousMin:' + phosphorousMin);
            //console.log('albuminMin:' + albuminMin);
            //console.log('albuminUnits:' + albuminUnits);
            //console.log('bicarbMin:' + bicarbonateMin);
            //console.log('bicarbUnits:' + bicarbonateUnits);


            //Min
            var minAnswer = getTangriLongValue(age, sex, egfrMin, albuminCRRatioMin, acratioUnits, calciumMin, calciumUnits, phosphorousMin, phosphorusUnits, albuminMin, albuminUnits, bicarbonateMin, bicarbonateUnits, yrType);
            //console.log('minAnswer: ' + minAnswer);
            //Max
            var maxAnswer = getTangriLongValue(age, sex, egfrMax, albuminCRRatioMax, acratioUnits, calciumMax, calciumUnits, phosphorousMax, phosphorusUnits, albuminMax, albuminUnits, bicarbonateMax, bicarbonateUnits, yrType);
            //console.log('maxAnswer: ' + maxAnswer);

            var answer = [minAnswer, maxAnswer];

            return answer;

            //Draw the graph
            //graphTangriResults(minAnswer, maxAnswer);
        }
        function runTangriShortVersion(yrType) {

            //*Get variables*
            var age;
            var sex;
            var egfrMin, egfrMax;
            var albuminCRRatioMin, albuminCRRatioMax;
            var acratioUnits;


            //*Basics*
            age = $('#txtAge').val();
            sex = $('input[type=radio][name=rbSexTangri]:checked').val();


            //*eGFR* -- these are reversed on purpose
            egfrMax = getSliderValue('egfr', 'from');
            egfrMin = getSliderValue('egfr', 'to');

            // if (egfrMin == 0) { egfrMin = 1; }
            //if (egfrMax == 0) { egfrMax = 1; }

            //*ACR*
            albuminCRRatioMin = getSliderValue('acratio', 'from');
            albuminCRRatioMax = getSliderValue('acratio', 'to');


            //*Units*
            //Urine albumin to creatinine ratio (mg/g)	from:mg/g	to:mg/mmol	multiply	0.113
            acratioUnits = $('#selACRatio').val();
            if (acratioUnits == 2) {
                //albuminCRRatio *= 0.113; old
                //albuminCRRatioMin *= 0.113;
                //albuminCRRatioMax *= 0.113;
                albuminCRRatioMin /= 0.113;
                albuminCRRatioMax /= 0.113;
            }


            //*******
            //*Debug*
            //*******
            //console.log('egfr min: ' + egfrMin);
            //console.log('egfr max: ' + egfrMax);
            //console.log('albuminCR min: ' + albuminCRRatioMin);
            //console.log('albuminCR max: ' + albuminCRRatioMax);
            //console.log('acratio units: ' + acratioUnits);


            //Min
            var minAnswer = getTangriShortValue(age, sex, egfrMin, albuminCRRatioMin, acratioUnits, yrType);
            //console.log('min answer: ' + minAnswer);

            //Max
            var maxAnswer = getTangriShortValue(age, sex, egfrMax, albuminCRRatioMax, acratioUnits, yrType);
            //console.log('max answer: ' + maxAnswer);

            var answer = [minAnswer, maxAnswer];
            //console.log('answer: ' + answer);
            return answer;

            //Draw the graph
            //graphTangriResults(minAnswer, maxAnswer);


            //console.log('Min Answer: ' + minAnswer + ', MAXaNSWER: ' + maxAnswer);
        }
        function runTangriShortVersion_TwoandFiveYear() {
            // console.log("inside runTangriShortVersion_TwoandFiveYear");
            var twoYearShort = runTangriShortVersion(2);
            var fiveYearShort = runTangriShortVersion(5);


            //Duplicate each value so as to eliminate the whiskers
            var twoYearFloatyBar = [twoYearShort[0], twoYearShort[0], twoYearShort[1], twoYearShort[1]];
            var fiveYearFloatyBar = [fiveYearShort[0], fiveYearShort[0], fiveYearShort[1], fiveYearShort[1]];


            //Pass ranges to graphing method
            //graphTangriResults(twoYearFloatyBar, fiveYearFloatyBar);
            graphTangriResults(twoYearShort, fiveYearShort);

        }
        function runTangriLongVersion_TwoandFiveYear() {

            // console.log("runTangriLongVersion_TwoandFiveYear");
            var twoYearLong = runTangriLongVersion(2);
            var fiveYearLong = runTangriLongVersion(5);

            //Duplicate each value so as to eliminate the whiskers
            var twoYearFloatyBar = [twoYearLong[0], twoYearLong[0], twoYearLong[1], twoYearLong[1]];
            var fiveYearFloatyBar = [fiveYearLong[0], fiveYearLong[0], fiveYearLong[1], fiveYearLong[1]];


            //Pass ranges to graphing method
            //graphTangriResults(twoYearFloatyBar, fiveYearFloatyBar);
            graphTangriResults(twoYearLong, fiveYearLong);

        }
        function showTangriGraphOnSliderChange() {

            // console.log('inside showTangriGraphOnSliderChange');
            //**********************************
            //*Gather details for loading graph*
            //**********************************
            var age = $('#txtAge').val();
            var female = $('#rbTangriSexFemale').is(':checked');
            var male = $('#rbTangriSexMale').is(':checked');
            var hasGender = (female == true || male == true);

            //**************
            //*Update Graph*
            //**************
            if (age.length > 0 && hasGender == true) {
                //Using short version
                if ($('#btnShowLongerVersion').is(':visible')) {
                    runTangriShortVersion_TwoandFiveYear();
                    console.log('Running Short version.');
                } else {
                    runTangriLongVersion_TwoandFiveYear();
                    console.log('Running Long version.');
                }
            }
        }


        //*Sliders*
        function fixSliderExceptions() {

            //Set up classes for CSS purposes on sliders
            $('span.irs-from').addClass('min');
            $('span.irs-to').addClass('max');


            //*****************************************
            //*Fix exceptions to above min/max classes*
            //*****************************************
            //eGFR
            $('#txtEGFR').parent().find('.irs-from').addClass('max').removeClass('min');
            $('#txtEGFR').parent().find('.irs-to').addClass('min').removeClass('max');

            //Serum Calcium
            $('#txtSCalcium').parent().find('.irs-from').addClass('max').removeClass('min');
            $('#txtSCalcium').parent().find('.irs-to').addClass('min').removeClass('max');

            //BiCarbonate
            $('#txtSBicarbinate').parent().find('.irs-from').addClass('max').removeClass('min');
            $('#txtSBicarbinate').parent().find('.irs-to').addClass('min').removeClass('max');

            //Albumin
            $('#txtSAlbumin').parent().find('.irs-from').addClass('max').removeClass('min');
            $('#txtSAlbumin').parent().find('.irs-to').addClass('min').removeClass('max');

        }
        function getCurrentSliderHandle() {

            //assume a slider doesn't have the focus
            var answer = '0';
            var $objMitDemFocus = $(':focus');


            //*Is a slider*
            if ($objMitDemFocus.hasClass('irs-slider')) {
                if ($objMitDemFocus.hasClass('from')) {
                    answer = 'f';
                } else if ($objMitDemFocus.hasClass('to')) {
                    answer = 't';
                }
            }

            return answer;
        }
        function getSliderValue(sliderID, tofrom) {
            //Obtain the value of the requested slider (handle)

            var $slider;
            var from;
            var to;
            var answer = '';

            switch (sliderID) {
                case 'egfr':
                    $slider = $('#eGFRSlider').data('ionRangeSlider');
                    break;
                case 'acratio':
                    $slider = $('#ureaAlbuminSlider').data('ionRangeSlider');
                    break;
                case 'calcium':
                    $slider = $('#calciumSlider').data('ionRangeSlider');
                    break;
                case 'phosphate':
                    $slider = $('#phosSlider').data('ionRangeSlider');
                    break;
                case 'bicarb':
                    $slider = $('#biCarbSlider').data('ionRangeSlider');
                    break;
                case 'albumin':
                    $slider = $('#albSlider').data('ionRangeSlider');
                    break;
            }


            switch (tofrom) {
                case 'to':
                    to = $slider.old_to;
                    answer = to;
                    break;
                case 'from':
                    from = $slider.old_from;
                    answer = from;
                    break;
                case 'both':
                    to = $slider.old_to;
                    from = $slider.old_from;
                    answer = to + '|' + from;
                    break;
            }

            //console.log('slider answer: ' + answer);
            return answer;
        }
        function initiateSliders() {
            //console.log("initiateSliders");
            //Permitted highs and lows (validation)
            var mn, mx, curUnit;

            //****************
            //*Slider(s) code*
            //****************            
            var eGFRFrom = 15;
            var eGFRTo = 60;
            mn = 10;
            mx = 60;
            $("#eGFRSlider").ionRangeSlider({
                type: "double", grid: true, grid_snap: true, from: eGFRFrom, to: eGFRTo, min: mn, max: mx, step: 3, prettify_enabled: true, keyboard: true,
                onChange: function (data) {
                    $('#txtEGFR').val('');
                    showTangriGraphOnSliderChange();
                }
            });
            $("#eGFRSlider").attr('step', '3');
            $('#txtEGFR').attr('min', mn).attr('max', mx);


            //**************
            //*Urea Albumin*
            //**************
            var uaFrom = 10;
            var usTo = 500;
            mn = 10;
            mx = 3000;
            $("#ureaAlbuminSlider").ionRangeSlider({
                type: "double", grid: true, grid_snap: true, from: uaFrom, to: usTo, min: mn, max: mx, step: 100, prettify_enabled: true, keyboard: true,
                onChange: function (data) {
                    $('#txtACRatio').val('');
                    showTangriGraphOnSliderChange();
                }
            });
            $("#ureaAlbuminSlider").attr('step', '50');
            $('#txtACRatio').attr('min', mn).attr('max', mx);
            curUnit = $('#selACRatio option:selected').text();
            //Show correct range for this unit
            $('#ACRationRange').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');

            //***************
            //*Serum Calcium*
            //***************
            var calciumFrom = 8.4;
            var calciumTo = 10.2;
            mn = 7.5;
            mx = 10.5;
            $("#calciumSlider").ionRangeSlider({
                type: "double", grid: true, grid_snap: true, from: calciumFrom, to: calciumTo, min: mn, max: mx, step: .5, prettify_enabled: true, keyboard: true,
                onChange: function (data) {
                    $('#txtSCalcium').val('');
                    showTangriGraphOnSliderChange();
                }
            });
            $("#calciumSlider").attr('step', '.5');
            $('#txtSCalcium').attr('min', mn).attr('max', mx);
            curUnit = $('#selSCalcium option:selected').text();

            //Show correct range for this unit
            $('#spnSCal').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');


            //*****************
            //*Serum Phosphate*
            //*****************
            var phosFrom = 3;
            var phosTo = 4.5;
            mn = 3;
            mx = 6.5;
            $("#phosSlider").ionRangeSlider({
                type: "double", grid: true, grid_snap: true, from: phosFrom, to: phosTo, min: mn, max: mx, step: .5, prettify_enabled: true, keyboard: true,
                onChange: function (data) {
                    $('#txtSPhosphate').val('');
                    showTangriGraphOnSliderChange();
                }
            });
            $("#phosSlider").attr('step', '.5');
            $('#txtSPhosphate').attr('min', mn).attr('max', mx);
            curUnit = $('#selSPhosphate option:selected').text();
            //Show correct range for this unit
            $('#spnPhosphate').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');


            //*******************
            //*Serum BiCarbonate*
            //*******************
            var biCarbFrom = 22;
            var biCarbTo = 28;
            mn = 15;
            mx = 28;
            $("#biCarbSlider").ionRangeSlider({
                type: "double", grid: true, grid_snap: true, from: biCarbFrom, to: biCarbTo, min: mn, max: mx, step: 2, prettify_enabled: true, keyboard: true,
                onChange: function (data) {
                    $('#txtSBicarbinate').val('');
                    showTangriGraphOnSliderChange();
                }
            });
            $("#biCarbSlider").attr('step', '2');
            $('#txtSBicarbinate').attr('min', mn).attr('max', mx);
            curUnit = $('#selSBicarbinate option:selected').text();
            //Show correct range for this unit
            $('#spnBiCarb').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');

            //***************
            //*Serum ALBUMIN*
            //***************
            var albFrom = 2.5;
            var albTo = 54;
            mn = 1;
            mx = 4;
            $("#albSlider").ionRangeSlider({
                type: "double", grid: true, grid_snap: true, from: albFrom, to: albTo, min: mn, max: mx, step: .5, prettify_enabled: true, keyboard: true,
                onChange: function (data) {
                    $('#txtSAlbumin').val('');
                    showTangriGraphOnSliderChange();
                }
            });
            $("#albSlider").attr('step', '.5');
            $('#txtSAlbumin').attr('min', mn).attr('max', mx);
            curUnit = $('#selSAlbumin option:selected').text();
            //Show correct range for this unit
            $('#spnSAlbumin').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');


            //Make all slider handles 'focussable'
            $('.irs-slider').attr('tabindex', '0');


            //ADjustments to get CSS working correctly
            fixSliderExceptions();


            //Add a toolip instructions for the sliders
            addToolTipInstructions();

        }
        function moveSlider(dir) {

            //Which has the focus?
            var $objMitDemFocus = $(':focus');

            //Get txtBox
            var txtID = $(':focus').parent().parent().find('.irs-hidden-input').attr('id');

            var $slider = $('#' + txtID).data('ionRangeSlider');
            var fromxzor = $slider.old_from;//$('.irs-from').text();
            var toxzor = $slider.old_to;//$('.irs-to').text();

            //*STEP*
            var step = 1;
            if (typeof ($('#' + txtID).attr('step')) != 'undefined') {
                step = parseFloat($('#' + txtID).attr('step'));
            }

            //console.log('step: ' + step);

            switch (dir) {
                case "df":
                    fromxzor -= step;
                    $slider.update({ from: fromxzor });
                    break;
                case "af":
                    fromxzor += step;
                    $slider.update({ from: fromxzor });
                    break;
                case "dt":
                    toxzor -= step;
                    $slider.update({ to: toxzor });
                    break;
                case "at":
                    toxzor += step;
                    $slider.update({ to: toxzor });
                    break;
            }
        }
        function resetIndividualSlider(sliderName) {

            //*Gets called when the refresh image near each slider is pressed*

            switch (sliderName) {
                case 'egfr':
                    //console.log('egfr reset');
                    var $egfr = $("#eGFRSlider");
                    var $slider1;
                    try {
                        $slider1 = $egfr.data("ionRangeSlider");
                        $slider1.destroy();

                        $egfr.parent().find('.from, .to').text('');
                        $egfr.parent().find('span').remove();

                    } catch (ex) {
                        console.log('Encountered problems resetting eGFR: ' + ex.message);
                    }

                    $egfr.ionRangeSlider({
                        type: "double", grid: true, grid_snap: true, from: 15, to: 60, min: 10, max: 60, step: 3, prettify_enabled: true, keyboard: true,
                        onChange: function (data) {
                            //Clear textbox
                            $('#txtEGFR').val('');
                            //console.log('changing eGFR slider from resetIndividualSlider');
                            showTangriGraphOnSliderChange();
                        }
                    });

                    //Set it back to original spot(s)
                    $slider1 = $egfr.data("ionRangeSlider");
                    $slider1.update({ to: 60, from: 15, keyboard: true });
                    $egfr.attr('step', '3');
                    $('#txtEGFR').text('').val('');
                    break;

                case 'acratio':
                    unitChange('acratio');
                    $('#txtACRatio').text('').val('');
                    //console.log('changing acratio slider from resetIndividualSlider');
                    break;
                case 'calcium':
                    unitChange('calcium');
                    $('#txtSCalcium').text('').val('');
                    break;
                case 'phosphate':
                    unitChange('phosphate');
                    $('#txtSPhosphate').text('').val('');
                    //console.log('changing phosphate slider from resetIndividualSlider');
                    break;
                case 'bicarb':
                    var $bicarb = $("#biCarbSlider");
                    var $sliderbc;
                    try {
                        $sliderbc = $bicarb.data("ionRangeSlider");
                        $sliderbc.destroy();

                        $bicarb.parent().find('.from, .to').text('');
                        $bicarb.parent().find('span').remove();
                    } catch (ex) {
                        console.log('Encountered problems resetting biCarbonate: ' + ex.message);
                    }

                    $bicarb.ionRangeSlider({
                        type: "double", grid: true, grid_snap: true, from: 22, to: 28, min: 15, max: 28, step: 2, prettify_enabled: true, keyboard: true,
                        onChange: function (data) {
                            // fired on every range slider update
                            showTangriGraphOnSliderChange();
                        }
                    });

                    //Set it back to original spot(s)
                    $sliderbc = $bicarb.data("ionRangeSlider");
                    $sliderbc.update({ to: 28, from: 22, keyboard: true });
                    $('#txtSBicarbinate').text('').val('');
                    //console.log('changing bicarb slider from resetIndividualSlider');
                    break;
                case 'albumin':
                    unitChange('albumin');
                    $('#txtSAlbumin').text('').val('');
                    //console.log('changing albumin slider from resetIndividualSlider');
                    break;
            }

            //Adjust sliders for proper CSS
            fixSliderExceptions();

            //Now update graph
            showTangriGraphOnSliderChange();

        }
        function resetSliders() {

            // console.log("inside reset Slider");
            //****************
            //*Slider(s) code*
            //****************
            try {
                var slider1 = $("#eGFRSlider").data("ionRangeSlider");
                slider1.destroy();
                $("#eGFRSlider").parent().find('.from, .to').text('');
            } catch (ex) {

            }
            $("#eGFRSlider").ionRangeSlider({
                type: "double", grid: true, grid_snap: true, from: 15, to: 60, min: 0, max: 120, step: 3, prettify_enabled: true, keyboard: true,
                onChange: function (data) {

                    $('#txtEGFR').val('');
                    console.log('resetting slider for eGFR');

                    // fired on every range slider update
                    showTangriGraphOnSliderChange();
                }
            });
            $("#eGFRSlider").attr('step', '3');


            //all other sliders
            unitChange('acratio');
            unitChange('calcium');
            unitChange('phosphate');
            unitChange('albumin');


            //ADjustments to get CSS working correctly
            fixSliderExceptions();


            return false;
        }
        function unitChange(slidername) {

            var curUnit;
            var $slider;
            var fm;
            var t;//to
            var mn;
            var mx;
            var stp;


            switch (slidername) {

                //case 'bicarb': //This has no conversion, so don't bother to clear the textbox
                //    //Clear the textbox
                //    $('#txtSBicarbinate').val('');

                //    break;
                case 'acratio':
                    curUnit = $('#selACRatio option:selected').text();
                    $slider = $("#ureaAlbuminSlider").data("ionRangeSlider");
                    $slider.destroy();

                    //Clear the textbox
                    $('#txtACRatio').val('');

                    if (curUnit === 'mg/g') {
                        fm = 10;
                        t = 500;
                        mn = 10;
                        mx = 3000;
                        stp = 100;
                    } else if (curUnit === 'mg/mmol') {
                        fm = 1;
                        t = 50;
                        mn = 1;
                        mx = 300;
                        stp = 50;
                    }
                    $("#ureaAlbuminSlider").ionRangeSlider({
                        type: "double", grid: true, grid_snap: true, from: fm, to: t, min: mn, max: mx, step: stp, prettify_enabled: true, keyboard: true,
                        onChange: function (data) {
                            $('#txtACRatio').val('');
                            showTangriGraphOnSliderChange();
                        }
                    });
                    $("#ureaAlbuminSlider").attr('step', stp);
                    $('#txtACRatio').attr('min', mn).attr('max', mx); //Set the validation text      

                    //Show correct range for this unit
                    $('#ACRationRange').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');


                    var ureaAlbuminSlider = $("#ureaAlbuminSlider").data("ionRangeSlider");
                    ureaAlbuminSlider.update({ to: t, from: fm });

                    break;
                case 'calcium':
                    curUnit = $('#selSCalcium option:selected').text();
                    $slider = $("#calciumSlider").data("ionRangeSlider");
                    $slider.destroy();

                    //Clear the textbox
                    $('#txtSCalcium').val('');

                    if (curUnit === 'mg/dL') {
                        fm = 8.4;
                        t = 10.2;
                        mn = 7.5;
                        mx = 10.5;
                        stp = .5;
                    } else if (curUnit === 'mmol/L') {
                        fm = 2.1;
                        t = 2.5;
                        mn = 1.87;
                        mx = 2.6;
                        stp = .2;
                    }

                    $("#calciumSlider").ionRangeSlider({
                        type: "double", grid: true, grid_snap: true, from: fm, to: t, min: mn, max: mx, step: stp, prettify_enabled: true, keyboard: true,
                        onChange: function (data) {
                            $('#txtSCalcium').val('');
                            showTangriGraphOnSliderChange();
                        }
                    });
                    $("#calciumSlider").attr('step', stp);
                    $('#txtSCalcium').attr('min', mn).attr('max', mx); //Set the validation text


                    var calciumSlider = $("#calciumSlider").data("ionRangeSlider");
                    calciumSlider.update({ to: t, from: fm });

                    //Show correct range for this unit
                    $('#spnSCal').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');

                    break;
                case 'phosphate':
                    curUnit = $('#selSPhosphate option:selected').text();
                    $slider = $("#phosSlider").data("ionRangeSlider");
                    $slider.destroy();

                    //Clear the textbox
                    $('#txtSPhosphate').val('');

                    //console.log('just changed phosphate ddl');


                    if (curUnit === 'mg/dL') {
                        console.log('curUnit is: mg/dL');
                        fm = 3;
                        t = 4.5;
                        mn = 3;
                        mx = 6.5;
                        stp = .5;
                    } else if (curUnit === 'mmol/L') {
                        console.log('curUnit is: mmol/L');
                        fm = .96;
                        t = 1.45;
                        mn = .96;
                        mx = 2.09;
                        stp = .1;
                    }
                    $("#phosSlider").ionRangeSlider({
                        type: "double", grid: true, grid_snap: true, from: fm, to: t, min: mn, max: mx, step: stp, prettify_enabled: true, keyboard: true,
                        onChange: function (data) {
                            $('#txtSPhosphate').val('');
                            showTangriGraphOnSliderChange();
                        }
                    });
                    $("#phosSlider").attr('step', stp);
                    $('#txtSPhosphate').attr('min', mn).attr('max', mx); //Set the validation text

                    var phosSlider = $("#phosSlider").data("ionRangeSlider");
                    phosSlider.update({ to: t, from: fm });

                    //Show correct range for this unit
                    $('#spnPhosphate').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');

                    break;
                case 'bicarbonate':

                    //Just update the range label
                    curUnit = $('#selSBicarbinate option:selected').text();
                    $('#spnBiCarb').text('(Range: 15 - 28 ' + curUnit + ')');

                    break;
                case 'albumin':

                    curUnit = $('#selSAlbumin option:selected').text();
                    $slider = $("#albSlider").data("ionRangeSlider");
                    $slider.destroy();

                    //Clear the textbox
                    $('#txtSAlbumin').val('');

                    if (curUnit === 'g/dL') {
                        fm = 2;
                        t = 4;
                        mn = 1;
                        mx = 4;
                        stp = .5;
                    } else if (curUnit === 'g/L') {
                        fm = 20;
                        t = 40;
                        mn = 10;
                        mx = 40;
                        stp = 5;
                    }
                    $("#albSlider").ionRangeSlider({
                        type: "double", grid: true, grid_snap: true, from: fm, to: t, min: mn, max: mx, step: stp, prettify_enabled: true, keyboard: true,
                        onChange: function (data) {
                            $('#txtSAlbumin').val('');
                            showTangriGraphOnSliderChange();
                        }
                    });
                    $("#albSlider").attr('step', stp);
                    $('#txtSAlbumin').attr('min', mn).attr('max', mx); //Set the validation text

                    var albSlider = $("#albSlider").data("ionRangeSlider");
                    albSlider.update({ to: t, from: fm });


                    //Show correct range for this unit
                    $('#spnSAlbumin').text('(Range: ' + mn.toString() + ' - ' + mx.toString() + ' ' + curUnit + ')');

                    break;
            }

            //console.log('to:' + t + ', from:' + fm + ',min:' + mn + ',max:' + mx);    

            //Make all slider handles 'focussable'
            $('.irs-slider').attr('tabindex', '0');

            //Adjustments for CSS
            fixSliderExceptions();

            //Show changes
            showTangriGraphOnSliderChange();


            //Add a toolip instructions for the sliders
            addToolTipInstructions();

            return false;
        }

        function addToolTipInstructions() {
            $('.irs-with-grid').attr('title', 'Click and drag the left and right sliders to the desired interval.  Entering a value in the box above the sliders will automatically move both sliders to that value.');
        }

        function updateSlider(slidername, val) {
            //console.log("inside Update Slider");
            //If a value is added to a textbox, the sliders should honor the new value

            //http://ionden.com/a/plugins/ion.rangeSlider/demo_interactions.html -- see (Range slider public methods)
            var $slider;

            switch (slidername) {
                case 'egfr':
                    $("#eGFRSlider").ionRangeSlider({ type: "double", grid: true, grid_snap: true, from: val, to: val, min: 10, max: 60, step: 3, prettify_enabled: true, keyboard: true });
                    $slider = $("#eGFRSlider").data("ionRangeSlider");
                    break;
                case 'acratio':
                    $("#ureaAlbuminSlider").ionRangeSlider({ type: "double", grid: true, grid_snap: true, from: val, to: val, min: 10, max: 3000, step: 100, prettify_enabled: true, keyboard: true });
                    $slider = $("#ureaAlbuminSlider").data("ionRangeSlider");
                    break;
                case 'calcium':
                    $("#calciumSlider").ionRangeSlider({ type: "double", grid: true, grid_snap: true, from: val, to: val, min: 7.5, max: 10.5, step: .5, prettify_enabled: true, keyboard: true });
                    $slider = $("#calciumSlider").data("ionRangeSlider");
                    break;
                case 'phosphate':
                    $("#phosSlider").ionRangeSlider({ type: "double", grid: true, grid_snap: true, from: val, to: val, min: 3, max: 6.5, step: .5, prettify_enabled: true, keyboard: true });
                    $slider = $("#phosSlider").data("ionRangeSlider");
                    break;
                case 'bicarb':
                    $("#biCarbSlider").ionRangeSlider({ type: "double", grid: true, grid_snap: true, from: val, to: val, min: 15, max: 28, step: 2, prettify_enabled: true, keyboard: true });
                    var $slider = $("#biCarbSlider").data("ionRangeSlider");
                    break;
                case 'albumin':
                    $("#albSlider").ionRangeSlider({ type: "double", grid: true, grid_snap: true, from: val, to: val, min: 1, max: 4, step: .5, prettify_enabled: true, keyboard: true });
                    $slider = $("#albSlider").data("ionRangeSlider");
                    break;
            }

            $slider.update({ to: val, from: val, keyboard: true });

            //Make all slider handles 'focussable'
            $('.irs-slider').attr('tabindex', '0');

            fixSliderExceptions();

            //Run the short  or long version if there is enough info
            showTangriGraphOnSliderChange();

            //Add a toolip instructions for the sliders
            addToolTipInstructions();
        }



    </script>
</asp:Content>
