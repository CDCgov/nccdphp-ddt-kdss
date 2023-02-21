<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/ResponsiveContentLeftNavNew.Master" AutoEventWireup="true" CodeBehind="Research.aspx.cs" Inherits="CKDSurveillance_RD.MasterPages.Research" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%-- <link href="App_Themes/local.css" rel="stylesheet" />--%>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContentPlaceHolder" runat="server">

    <style>
        .PageDesc {
            background-color: #deebf7;
            border: 1px solid #1a7aa2;
            padding: 4px 10px 4px 10px;
            border-bottom-left-radius: 5px;
            border-top-left-radius: 5px;
            border-bottom-right-radius: 5px;
            border-top-right-radius: 5px;
            */
        }
    </style>
    <div class="row">
        <div class="col-xl-12">

            <div class="Pagetitle">Published Research and Resources</div>
            <br />
        </div>
    </div>
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <div class="PageDesc">
                The following research articles on various CKD topics are published by the Surveillance Team as part of the CKD Surveillance project.
            </div>
        </div>
        <div class="col-md-1"></div>

    </div>

    <br />

    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10 content ">
<%--            <div class="mb-3 card tp-related-pages fourth-level-nav d-none">
                <div class="card-header collapse-icon">
                    <a class="collapse-link float-right nav-minus fs0875" data-toggle="collapse" href="#collapse_2495cf961f2b849a" aria-expanded="false" aria-controls="collapse_2495cf961f2b849a">
                        <svg viewBox="0 0 24 24" focusable="false" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                            <title>minus</title>
                            <path d="M19,13H5V11H19V13Z">
                            </path>
                        </svg>
                    </a>
                    <div class="h4">Related Pages</div>
                </div>
                <div class="card-body collapse show" id="collapse_2495cf961f2b849a">
                </div>
            </div>--%>

            <div id="accordion-1" class="accordion indicator-plus accordion-white mb-3" role="tablist">
                <div class="card bar">
                    <div class="card">
                        <div class="card-header collapsed" id="accordion-1-card-1" data-target="#accordion-1-collapse-1" data-toggle="collapse" role="tab" aria-expanded="false">
                            <button class="card-title btn btn-link" onclick="return false;" data-controls="accordion-1-collapse-1">
                                <span role="heading" aria-level="1">Principles and Data Sources for CKD Surveillance</span>
                            </button>
                        </div>
                        <div aria-labelledby="accordion-1-card-1" class="collapse" collapsed="" id="accordion-1-collapse-1" role="tabpanel" style="">
                            <div class="card-body">
                                <p>Radhakrishnan J, Remuzzi G, Saran R, et al. <a href="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4593485/pdf/nihms-725325.pdf" target="new" class="tp-link-policy" data-domain-ext="gov">Taming the chronic kidney disease epidemic: a global view of surveillance efforts. <span class="sr-only">pdf icon</span><span class="fi cdc-icon-pdf x16 fill-pdf" aria-hidden="true"></span><span class="file-details">[PDF – 283K]</span><span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>&nbsp;<em>Kidney Int.</em> 2014;86(2):246-250.</p>
                                <p>Grams ME, Plantinga LC, Hedgeman E, et al. <a href="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2978782/pdf/nihms219374.pdf" target="new" class="tp-link-policy" data-domain-ext="gov">Validation of CKD and related conditions in existing data sets: a systematic review. <span class="sr-only">pdf icon</span><span class="fi cdc-icon-pdf x16 fill-pdf" aria-hidden="true"></span><span class="file-details">[PDF – 363K]</span><span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>&nbsp;<em>Am J Kidney Dis.</em> 2011;57(1):44–54.</p>
                                <p>Grams ME, Plantinga LC, Hedgeman E, et al. <a href="http://cjasn.asnjournals.org/content/5/1/152.full.pdf" target="new" class="tp-link-policy" data-domain-ext="org">Establishing a national chronic kidney disease surveillance system for the United States. <span class="sr-only">pdf icon</span><span class="fi cdc-icon-pdf x16 fill-pdf" aria-hidden="true"></span><span class="file-details">[PDF – 110K]</span><span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>&nbsp;<em>Clin J Am Soc</em> <em>Nephrol.</em> 2010;5(1):152−161.</p>
                                <p>Powe NR, Plantinga L, Saran R. <a href="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2680244/pdf/nihms98040.pdf" target="new" class="tp-link-policy" data-domain-ext="gov">Public health surveillance of CKD: principles, steps, and challenges <span class="sr-only">pdf icon</span><span class="fi cdc-icon-pdf x16 fill-pdf" aria-hidden="true"></span><span class="file-details">[PDF-357K]</span><span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>&nbsp;<em>Am J Kidney Dis.</em> 2009;53(3 Suppl 3):S37−S45.</p>
                                <p>Levey AS, Schoolwerth AC, Burrows NR, Williams DE, Rabon-Stith K, McClellan W.&nbsp;<a class="noLinking" href="https://www.sciencedirect.com/science/article/pii/S0272638608017307#">Comprehensive public health strategies for preventing the development, progression, and complications of CKD: report of an expert panel convened by the Centers for Disease Control and Prevention.</a>&nbsp;<em>Am J Kidney Dis.</em> 2009;53(3):522−535.</p>
                                <p>Schoolwerth AC, Engelgau MM, Hostetter TH, et al. <a href="https://www.cdc.gov/pcd/issues/2006/apr/pdf/05_0105.pdf" target="new">Chronic kidney disease: a public health problem that needs a public health action plan. <span class="sr-only">pdf icon</span><span class="fi cdc-icon-pdf x16 fill-pdf" aria-hidden="true"></span><span class="file-details">[PDF – 190K]</span></a>&nbsp;<em>Prev Chronic Dis.</em> 2006;3(2):A57.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card bar">
                    <div class="card">
                        <div class="card-header collapsed" id="accordion-1-card-2" data-target="#accordion-1-collapse-2" data-toggle="collapse" role="tab" aria-expanded="false">
                            <button class="card-title btn btn-link" onclick="return false;" data-controls="accordion-1-collapse-2">
                                <span role="heading" aria-level="1">Natural History of CKD</span>
                            </button>
                        </div>
                        <div aria-labelledby="accordion-1-card-2" class="collapse " collapsed="" id="accordion-1-collapse-2" role="tabpanel">
                            <div class="card-body">
                                <p>Burwick N, Adams SV, Todd-Stenberg JA, Burrows NR, Pavkov ME, O’Hare AM. <a href="https://www.ncbi.nlm.nih.gov/pubmed/30442867" class="tp-link-policy" data-domain-ext="gov">Association of monoclonal gammopathy with progression to ESKD among US Veterans<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Clin J Am Soc Nephrol</em>. 2018;13(12):1810-1815.</p>
                                <p>Huang Y, Tilea A, Gillespie B, et al. <a href="https://www.ncbi.nlm.nih.gov/pubmed/28270413" class="tp-link-policy" data-domain-ext="gov">Understanding trends in kidney function 1 year after kidney transplant in the United States<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>J Am Soc Nephrol</em>. 2017;28(8):2498–2510.</p>
                                <p>Wong SP, Hebert PL, Laundry RJ, et al. <a href="https://www.ncbi.nlm.nih.gov/pubmed/27660306" class="tp-link-policy" data-domain-ext="gov">Decisions about renal replacement therapy in patients with advanced kidney disease in the US Department of Veterans Affairs, 2000–2011<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Clin J Am Soc Nephrol</em>. 2016;11(10):1825–1833.</p>
                                <p>Hsu RK, McCulloch CE, Heung M, et al. <a href="http://cjasn.asnjournals.org/content/11/1/14.long" class="tp-link-policy" data-domain-ext="org">Exploring potential reasons for the temporal trend in dialysis-requiring AKI in the United States<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Clin J Am Soc Nephrol</em>. 2016;11(1):14-20.</p>
                                <p>Wong SP, Vig EK, Taylor JS, et al. <a href="http://archinte.jamanetwork.com/article.aspx?articleid=2484296" class="tp-link-policy" data-domain-ext="com">Timing of initiation of maintenance dialysis: a qualitative analysis of the electronic medical records of a national cohort of patients from the Department of Veterans Affairs<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>JAMA Intern Med</em>. 2016 ;176(2):228-235.</p>
                                <p>O’Hare AM, Batten A, Burrows NR, et al. <a href="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3312937/" class="tp-link-policy" data-domain-ext="gov">Trajectories of kidney function decline in the 2 years before initiation of long-term dialysis<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Am J Kidney Dis</em>. 2012 Apr;59(4):513–522.</p>
                                <p>O’Hare AM, Hailpern SM, Pavkov ME, et al. <a href="http://archinte.ama-assn.org/cgi/reprint/170/11/930" class="tp-link-policy" data-domain-ext="org">Prognostic implications of the urinary albumin to creatinine ratio in veterans of different ages with diabetes<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Arch Intern Med.</em> 2010;170(11):930−936.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card bar">
                    <div class="card">
                        <div class="card-header collapsed" id="accordion-1-card-3" data-target="#accordion-1-collapse-3" data-toggle="collapse" role="tab" aria-expanded="false">
                            <button class="card-title btn btn-link" onclick="return false;" data-controls="accordion-1-collapse-3">
                                <span role="heading" aria-level="1">Screening for CKD</span>
                            </button>
                        </div>
                        <div aria-labelledby="accordion-1-card-3" class="collapse " collapsed="" id="accordion-1-collapse-3" role="tabpanel">
                            <div class="card-body">
                                <p>Burrows NR, Vassalotti JA, Saydah SH, et al. <a href="https://www.ncbi.nlm.nih.gov/pubmed/30472707" class="tp-link-policy" data-domain-ext="gov">Identifying high-risk individuals for chronic kidney disease: results of the CHERISH Community Demonstration Project<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Am J Nephrol</em>. 2018;48(6):447–455.</p>
                                <p>Saydah SH, Pavkov ME, Zhang C, et al. <a href="http://www.clinchem.org/content/59/4/675.abstract" class="tp-link-policy" data-domain-ext="org">Albuminuria prevalence in first morning void compared with previous random urine from adults in the National Health and Nutrition Examination Survey, 2009–2010<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Clin Chem</em>. 2013;59(4):1–9.</p>
                                <p>Vassalotti JA, Fox CH, Becker BN. <a href="http://www.ncbi.nlm.nih.gov/pubmed/20439092" class="tp-link-policy" data-domain-ext="gov">Risk factors and screening for chronic kidney disease.<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a> <em>Adv Chronic Kidney Dis.</em> 2010;17(3):237–245.</p>
                                <p>Collins AJ, Vassalotti JA, Wang C, et al. <a href="http://www.ncbi.nlm.nih.gov/pubmed/19231764" class="tp-link-policy" data-domain-ext="gov">Who should be targeted for CKD screening? Impact of diabetes, hypertension, and cardiovascular disease.<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a> <em>Am J Kidney Dis.</em> 2009;53(3 Suppl 3):S71–77.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card bar">
                    <div class="card">
                        <div class="card-header collapsed" id="accordion-1-card-4" data-target="#accordion-1-collapse-4" data-toggle="collapse" role="tab" aria-expanded="false">
                            <button class="card-title btn btn-link" onclick="return false;" data-controls="accordion-1-collapse-4">
                                <span role="heading" aria-level="1">Awareness of CKD</span>
                            </button>
                        </div>
                        <div aria-labelledby="accordion-1-card-4" class="collapse " collapsed="" id="accordion-1-collapse-4" role="tabpanel">
                            <div class="card-body">
                                <p>Dharmarajan SH, Bragg-Gresham JL, Morgenstern H, et al.;&nbsp;Centers for Disease Control and Prevention CKD Surveillance System. <a href="https://www.ncbi.nlm.nih.gov/pubmed/28410862" class="tp-link-policy" data-domain-ext="gov">State-level awareness of chronic kidney disease in the U.S.<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a> <em>Am J Prev Med.</em> 2017;53(3):300-307.</p>
                                <p>Tuot DS, Plantinga LC, Hsu CY, et al. <a href="http://cjasn.asnjournals.org/content/6/8/1838.full.pdf" target="new" class="tp-link-policy" data-domain-ext="org">Chronic kidney disease awareness among individuals with clinical markers of kidney dysfunction. <span class="sr-only">pdf icon</span><span class="fi cdc-icon-pdf x16 fill-pdf" aria-hidden="true"></span><span class="file-details">[PDF – 201K]</span><span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>&nbsp;<em>Clin J Am Soc Nephrol</em>. 2011;6(8):1838–1844.</p>
                                <p>Plantinga LC, Tuot DS, Powe NR. <a href="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2864779/pdf/nihms190842.pdf" target="new" class="tp-link-policy" data-domain-ext="gov">Awareness of chronic kidney disease among patients and providers. <span class="sr-only">pdf icon</span><span class="fi cdc-icon-pdf x16 fill-pdf" aria-hidden="true"></span><span class="file-details">[PDF – 226K]</span><span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>&nbsp;<em>Adv Chronic Kidney Dis.</em> 2010;17(3):225–236.</p>
                                <p>Plantinga LC, Boulware LE, Coresh J, et al. <a href="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2652122/pdf/nihms-88834.pdf" target="new" class="tp-link-policy" data-domain-ext="gov">Patient awareness of chronic kidney disease: trends and predictors. <span class="sr-only">pdf icon</span><span class="fi cdc-icon-pdf x16 fill-pdf" aria-hidden="true"></span><span class="file-details">[PDF – 986K]</span><span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>&nbsp;<em>Arch Intern Med.</em> 2008;168(20):2268–2275.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card bar">
                    <div class="card">
                        <div class="card-header collapsed" id="accordion-1-card-5" data-target="#accordion-1-collapse-5" data-toggle="collapse" role="tab" aria-expanded="false">
                            <button class="card-title btn btn-link" onclick="return false;" data-controls="accordion-1-collapse-5">
                                <span role="heading" aria-level="1">Prevalence of CKD</span>
                            </button>
                        </div>
                        <div aria-labelledby="accordion-1-card-5" class="collapse " collapsed="" id="accordion-1-collapse-5" role="tabpanel">
                            <div class="card-body">
                                <p>Murphy D , McCulloch CE , Lin F , et al. <a href="https://www.ncbi.nlm.nih.gov/pubmed/27479614" class="tp-link-policy" data-domain-ext="gov">Trends in prevalence of chronic kidney disease in the United States<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Annual of Intern Med.</em> 2016;165(7):473-481.</p>
                                <p>Hoerger TJ, Simpson SA, Yarnoff BO, et al. <a href="http://ac.els-cdn.com/S0272638614013638/1-s2.0-S0272638614013638-main.pdf?_tid=9b3bc0ba-1476-11e5-a117-00000aab0f01&amp;acdnat=1434493714_b8512b9a2af54c2824be6d35d60a3f11" target="new" class="tp-link-policy" data-domain-ext="com">The future burden of CKD in the United States: a simulation model for the CDC CKD Initiative<span class="sr-only">pdf icon</span><span class="fi cdc-icon-pdf x16 fill-pdf" aria-hidden="true"></span><span class="file-details"></span><span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a><strong>.</strong> <em>Am J Kidney Dis</em>. 2015;65(3):403–411.</p>
                                <p>Shahinian VB, Hedgeman E, Gillespie BW, et al. <a href="http://www.ncbi.nlm.nih.gov/pubmed/23489675" class="tp-link-policy" data-domain-ext="gov">Estimating prevalence of CKD stages 3–5 using health system data<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Am J Kidney Dis</em>. 2013;61(6):930–938.</p>
                                <p>Plantinga LC, Crews DC, Coresh J, et al. <a href="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2849697" class="tp-link-policy" data-domain-ext="gov">Prevalence of chronic kidney disease in U.S. adults with undiagnosed diabetes or prediabetes<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Clin J Am Soc Nephrol.</em> 2010;5(4):673−682.</p>
                                <p>Crews DC, Plantinga LC, Miller ER III, et al.&nbsp;<a href="https://www.ahajournals.org/cgi/doi/10.1161/HYPERTENSIONAHA.110.150722" class="tp-link-policy" data-domain-ext="org">Prevalence of chronic kidney disease in persons with undiagnosed or prehypertension in the United States.<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>&nbsp;<em>Hypertension.</em> 2010;55(5):1102−1109.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card bar">
                    <div class="card">
                        <div class="card-header collapsed" id="accordion-1-card-6" data-target="#accordion-1-collapse-6" data-toggle="collapse" role="tab" aria-expanded="false">
                            <button class="card-title btn btn-link" onclick="return false;" data-controls="accordion-1-collapse-6">
                                <span role="heading" aria-level="1">CKD Risk Factors</span>
                            </button>
                        </div>
                        <div aria-labelledby="accordion-1-card-6" class="collapse " collapsed="" id="accordion-1-collapse-6" role="tabpanel">
                            <div class="card-body">
                                <p>Yarnoff BO, Hoerger TJ, Shrestha SS, et al; CRIC Study Investigators. <a href="https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0205530" class="tp-link-policy" data-domain-ext="org">Modeling the impact of obesity on the lifetime risk of chronic kidney disease in the United States using updated estimates of GFR progression from the CRIC study<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>PLoS One</em>. 2018 Oct 19;13(10):e0205530.</p>
                                <p>Bragg-Gresham J, Morgenstern H, McClellan W, et al; Centers for Disease Control and Prevention CKD Surveillance System. <a href="https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6067706/" class="tp-link-policy" data-domain-ext="gov">County-level air quality and the prevalence of diagnosed chronic kidney disease in the US Medicare population<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>PLoS One</em>. 2018 Jul 31;13(7):e0200612.</p>
                                <p>Heung M, Steffick DE, Zivin K, et al. <a href="http://www.sciencedirect.com/science/article/pii/S0272638615013402" class="tp-link-policy" data-domain-ext="com">Acute kidney injury recovery pattern and subsequent risk of CKD: an analysis of Veterans Health Administration data<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Am J Kidney Dis.</em> 2016;67(5):742-752.</p>
                                <p>Banerjee T, Scherzer R, Powe NR, et al. <a href="http://www.ncbi.nlm.nih.gov/pubmed/25072613" class="tp-link-policy" data-domain-ext="gov">Race and other risk factors for incident proteinuria in a national cohort of HIV-infected veterans<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>J Acquir Immune Defic Syndr.</em> 2014;67(2):145-152.</p>
                                <h4>Food and Diet</h4>
                                <p>Banerjee T, Crews DC, Tuot DS, et al; Centers for Disease Control and Prevention Chronic Kidney Disease Surveillance Team. <a href="https://www.ncbi.nlm.nih.gov/pubmed/30975440" class="tp-link-policy" data-domain-ext="gov">Poor accordance to a DASH dietary pattern is associated with higher risk of ESRD among adults with moderate chronic kidney disease and hypertension<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. Kidney Int. 2019 Mar 4. [Epub ahead of print]</p>
                                <p>Banerjee T, Crews D, Wesson DE, et al. <a href="https://www.ncbi.nlm.nih.gov/pubmed/30908932" class="tp-link-policy" data-domain-ext="gov">Elevated serum anion gap in adults with moderate chronic kidney disease increases risk for progression to end stage renal disease.<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a> <em>Am J Physiol Renal Physiol</em>. 2019 Mar 25. [Epub ahead of print]</p>
                                <p>Crews DC, Banerjee T, Wesson DE, et al; Centers for Disease Control and Prevention Chronic Kidney Disease Surveillance Team. <a href="https://escholarship.org/uc/item/3xv177tt" class="tp-link-policy" data-domain-ext="org">Race/ethnicity, dietary acid load, and risk of end-stage renal disease among US adults with chronic kidney disease<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Am J Nephrol</em>. 2018;47(3):174-181.</p>
                                <p>Banerjee T, Crews DC, Wesson DE, et al; CDC CKD Surveillance Team. <a href="https://www.ncbi.nlm.nih.gov/pubmed/28215947" class="tp-link-policy" data-domain-ext="gov">Food insecurity, CKD, and subsequent ESRD in US adults<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Am J Kidney Dis.</em> 2017;70(1):38–47.</p>
                                <p>Banerjee T, Crews DC, Wesson DE, et al. <a href="http://www.ncbi.nlm.nih.gov/pubmed/25677388" class="tp-link-policy" data-domain-ext="gov">High dietary acid load predicts ESRD among adults with CKD<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>J Am Soc Nephrol</em>. 2015;26(7):1693-1700.</p>
                                <p>Banerjee T, Crews DC, Wesson DE, et al. <a href="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4151375/" class="tp-link-policy" data-domain-ext="gov">Dietary acid load and chronic kidney disease among adults in the United States<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>BMC Nephrol</em>. 2014;15:137.</p>
                                <p>Crews DC, Kuczmarski MF, Grubbs V, et al. <a href="http://www.ncbi.nlm.nih.gov/pubmed/24434743" class="tp-link-policy" data-domain-ext="gov">Effect of food insecurity on chronic kidney disease in lower-income Americans<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Am J Nephrol.</em> 2014;39(1):27–35.</p>
                                <h4>Medicine and Supplements</h4>
                                <p>Tuot DS, Lin F, Shlipak MG, et al. <a href="http://care.diabetesjournals.org/content/38/11/2059.long" class="tp-link-policy" data-domain-ext="org">Potential impact of prescribing metformin according to eGFR rather than serum creatinine<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Diabetes Care.</em> 2015;38(11):2059-2067.</p>
                                <p>Grubbs V, Plantinga LC, Tuot DS, et al. <a href="http://ac.els-cdn.com/S0272638613000176/1-s2.0-S0272638613000176-main.pdf?_tid=f7308f4e-82f1-11e3-81ef-00000aab0f02&amp;acdnat=1390346329_3a22d060efc7dbcdcab8458b7eb49754" target="new" class="tp-link-policy" data-domain-ext="com">Americans’ use of dietary supplements that are potentially harmful in CKD<span class="sr-only">pdf icon</span><span class="fi cdc-icon-pdf x16 fill-pdf" aria-hidden="true"></span><span class="file-details"></span><span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Am J Kidney Dis.</em> 2013;61(5):739–747.</p>
                                <p>Plantinga L, Grubbs V, Sarkar U, et al. <a href="http://www.annfammed.org/content/9/5/423.full.pdf" target="new" class="tp-link-policy" data-domain-ext="org">Nonsteroidal anti-inflammatory drug use among persons with chronic kidney disease in the United States. <span class="sr-only">pdf icon</span><span class="fi cdc-icon-pdf x16 fill-pdf" aria-hidden="true"></span><span class="file-details">[PDF – 333K]</span><span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>&nbsp;<em>Ann Fam Med</em>. 2011;9(5):423–430.</p>
                                <p>Plantinga LC, Miller ER III, Stevens LA, et al.&nbsp;<a href="https://www.ahajournals.org/cgi/doi/10.1161/HYPERTENSIONAHA.110.150722" class="tp-link-policy" data-domain-ext="org">Blood pressure control among persons without and with chronic kidney disease: US trends and risk factors 1999–2006.<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>&nbsp;<em>Hypertension.</em> 2009;54(1):47–56.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card bar">
                    <div class="card">
                        <div class="card-header collapsed" id="accordion-1-card-7" data-target="#accordion-1-collapse-7" data-toggle="collapse" role="tab" aria-expanded="false">
                            <button class="card-title btn btn-link" onclick="return false;" data-controls="accordion-1-collapse-7">
                                <span role="heading" aria-level="1">CKD Complications</span>
                            </button>
                        </div>
                        <div aria-labelledby="accordion-1-card-7" class="collapse " collapsed="" id="accordion-1-collapse-7" role="tabpanel">
                            <div class="card-body">
                                <p>Carlos CA, McCulloch CE, Hsu CY, et al; Centers for Disease Control and Prevention Chronic Kidney Disease Surveillance Team. <a href="https://www.ncbi.nlm.nih.gov/pubmed/28336719" class="tp-link-policy" data-domain-ext="gov">Colon cancer screening among patients receiving dialysis in the United States: are we choosing wisely?<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a> <em>J Am Soc Nephro</em>l. 2017;28(8):2521–2528.</p>
                                <p>Gillespie BW, Morgenstern H, Hedgeman E, et al. <a href="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4655805/" class="tp-link-policy" data-domain-ext="gov">Nephrology care prior to end-stage renal disease and outcomes among new ESRD patients in the USA<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Clin Kidney J.</em> 2015;8(6):772‒780.</p>
                                <p>Plantinga L, Lee K, Inker LA, et.al. <a href="http://www.sciencedirect.com/science/article/pii/S0272638611010225" class="tp-link-policy" data-domain-ext="com">Association of sleep-related problems with CKD in the United States, 2005–2008<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>Am J Kidney Dis.</em> 2011;58(4):554–564.</p>
                                <p>Grubbs V, Plantinga LC, Crews DC, et al. <a href="http://cjasn.asnjournals.org/content/6/4/711.full.pdf" target="new" class="tp-link-policy" data-domain-ext="org">Vulnerable populations and the association between periodontal and chronic kidney disease. <span class="sr-only">pdf icon</span><span class="fi cdc-icon-pdf x16 fill-pdf" aria-hidden="true"></span><span class="file-details">[PDF – 212K]</span><span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>&nbsp;<em>Clin J Am Soc Nephrol</em>. 2011;6(4):711–717.</p>
                                <p>Plantinga LC, Johansen K, Crews DC, et al. <a href="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3025052/pdf/nihms235032.pdf" target="new" class="tp-link-policy" data-domain-ext="gov">Association of CKD with disability in the United States. <span class="sr-only">pdf icon</span><span class="fi cdc-icon-pdf x16 fill-pdf" aria-hidden="true"></span><span class="file-details">[PDF – 597K]</span><span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>&nbsp;<em>Am J Kidney Dis.</em> 2011;57(2):212–227.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card bar">
                    <div class="card">
                        <div class="card-header collapsed" id="accordion-1-card-8" data-target="#accordion-1-collapse-8" data-toggle="collapse" role="tab" aria-expanded="false">
                            <button class="card-title btn btn-link" onclick="return false;" data-controls="accordion-1-collapse-8">
                                <span role="heading" aria-level="1">Costs and Cost-effectiveness Studies</span>
                            </button>
                        </div>
                        <div aria-labelledby="accordion-1-card-8" class="collapse " collapsed="" id="accordion-1-collapse-8" role="tabpanel">
                            <div class="card-body">
                                <p>Yarnoff BO, Hoerger TJ, Simpson SK, et al; Centers for Disease Control and Prevention CKD Initiative. <a href="https://www.ncbi.nlm.nih.gov/pubmed/28288579" class="tp-link-policy" data-domain-ext="gov">The cost-effectiveness of using chronic kidney disease risk scores to screen for early-stage chronic kidney disease.<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a> <em>BMC Nephrol</em>. 2017;18(1):85.</p>
                                <p>Yarnoff BO, Hoerger TJ, Simpson SA, et al. <a href="https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4942058/" class="tp-link-policy" data-domain-ext="gov">The cost-effectiveness of anemia treatment for persons with chronic kidney disease<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>PLoS One</em>. 2016;11(7):e0157323.</p>
                                <p>Honeycutt AA, Segel JE, Zhuo X, Hoerger TJ, Imai K, Williams D. <a href="http://jasn.asnjournals.org/content/24/9/1478.full.pdf+html" class="tp-link-policy" data-domain-ext="org">Medical costs of CKD in the Medicare population<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>.<em>J Am Soc Nephrol</em>. 2013;24(9):1478–1483.</p>
                                <p>Hoerger TJ, Wittenborn J, Zhuo X, et al. <a href="http://jasn.asnjournals.org/content/23/12/2035.abstract" class="tp-link-policy" data-domain-ext="org">Cost-effectiveness of screening for microalbuminuria among African Americans<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a>. <em>J Am Soc Nephrol</em>. 2012;23(12):2035–2041.</p>
                                <p>Hoerger TJ, Wittenborn JS, Segel JE, et al. <a href="http://www.ncbi.nlm.nih.gov/pubmed/20116911" class="tp-link-policy" data-domain-ext="gov">A health policy model of CKD: 1. model construction, assumptions, and validation of health consequences.<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a> <em>Am J Kidney Dis.</em> 2010;55(3):452–462.</p>
                                <p>Hoerger TJ, Wittenborn JS, Segel JE, et al. <a href="http://www.ncbi.nlm.nih.gov/pubmed/20116910" class="tp-link-policy" data-domain-ext="gov">A health policy model of CKD: 2. The cost-effectiveness of microalbuminuria screening.<span class="sr-only">external icon</span><span class="fi cdc-icon-external x16 fill-external" aria-hidden="true"></span></a> <em>Am J Kidney Dis.</em> 2010;55(3):463–473.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card bar">
                    <div class="card">
                        <div class="card-header collapsed" id="accordion-1-card-9" data-target="#accordion-1-collapse-9" data-toggle="collapse" role="tab" aria-expanded="false">
                            <button class="card-title btn btn-link" onclick="return false;" data-controls="accordion-1-collapse-9">
                                <span role="heading" aria-level="1">CDC Morbidity and Mortality Weekly Reports (MMWRs)</span>
                            </button>
                        </div>
                        <div aria-labelledby="accordion-1-card-9" class="collapse " collapsed="" id="accordion-1-collapse-9" role="tabpanel">
                            <div class="card-body">
                                <h4>Incidence of ESRD</h4>
                                <p>Burrows NR, Hora I, Geiss LS, Gregg EW, Albright A. <a href="https://www.cdc.gov/mmwr/volumes/66/wr/mm6643a2.htm?s_cid=mm6643a2_w">Incidence of End-Stage Renal Disease Attributed to Diabetes Among Persons with Diagnosed Diabetes — United States and Puerto Rico, 2000–2014.</a> November 3, 2017 / 66(43);1165–1170.</p>
                                <p>
                                    Bullock A, Burrows NR, Narva AS, et al.<br>
                                    <a href="https://www.cdc.gov/mmwr/volumes/66/wr/mm6601e1.htm?s_cid=mm6601e1_w">Vital Signs: Decrease in Incidence of Diabetes-Related End-Stage Renal Disease among American Indians/Alaska Natives — United States, 1996–2013</a>. January 13, 2017 / 66(01);26–32.
                                </p>
                                <p>Burrows NR, Hora I, Williams DE, Geiss LS. <a href="https://www.cdc.gov/mmwr/preview/mmwrhtml/mm6309a2.htm?s_cid=mm6309a2_e">Trends in Incidence of End-Stage Renal Disease Among Persons With Diagnosed Diabetes — Puerto Rico, 1996–2010</a>. March 7, 2014 / 63(09);186-189.</p>
                                <p>Burrows NR, Hora I, Cho P, Gerzoff RB, Geiss LS. <a href="https://www.cdc.gov/mmwr/preview/mmwrhtml/mm5942a2.htm?s_cid=mm5942a2_w">Incidence of End-Stage Renal Disease Attributed to Diabetes Among Persons With Diagnosed Diabetes—United States and Puerto Rico, 1996–2007</a>. October 29, 2010 / 59(42);1361-1366.</p>
                                <p>Burrows NR, Wang J, Geiss LS, Venkat Narayan KM, Engelgau MM. <a href="https://www.cdc.gov/mmwr/preview/mmwrhtml/mm5443a2.htm">Incidence of End-Stage Renal Disease Among Persons with Diabetes—United States, 1990–2002</a>. November 4, 2005 / 54(43);1097-1100.</p>
                                <p>Gilbertson D, Burrows NR, Wang J, Rolka D, Geiss LS, Williams DE. <a href="https://www.cdc.gov/mmwr/preview/mmwrhtml/mm5611a4.htm">Racial Differences in Trends of End-Stage Renal Disease, by Primary Diagnosis—United States, 1994–2004</a>. March 23, 2007 / 56(11);253-256.</p>
                                <h4>Prevalence of CKD and ESRD</h4>
                                <p>Saydah S, Eberhardt M, Burrows NR, Williams D, Geiss L, Dorsey R. <a href="https://www.cdc.gov/mmwr/preview/mmwrhtml/mm5608a2.htm">Prevalence of Chronic Kidney Disease and Associated Risk Factors United States, 1999–2004</a>. March 2, 2007 / 56(08);161-165.</p>
                                <p>Pirtle CJ, Schoolwerth AC, Giles WH, Brown DW, Mokdad AH, Ford ES. <a href="https://www.cdc.gov/mmwr/preview/mmwrhtml/mm5339a3.htm">State-Specific Trends in Chronic Kidney Failure—United States, 1990–2001</a>. October 8, 2004 / 53(39);918-920.</p>
                                <h4>Hospitalization and Mortality</h4>
                                <p>Pavkov ME, Harding JL, Burrows NR. <a href="/mmwr/volumes/67/wr/mm6710a2.htm?s_cid=mm6710a2_w">Trends in Hospitalizations for Acute Kidney Injury — United States, 2000–2014</a>. March 16, 2018 / 67(10);289–293.</p>
                                <p>Flowers NT, Croft JB. <a href="https://www.cdc.gov/mmwr/preview/mmwrhtml/mm5712a1.htm">Hospitalization Discharge Diagnoses for Kidney Disease—United States, 1980–2005</a>. March 28, 2008 / 57(12);309-312</p>
                                <p>Andrews A, El Reda DK, Radford G, Burrows NR, Ernst K. <a href="https://www.cdc.gov/mmwr/preview/mmwrhtml/mm5610a5.htm?s_cid=mm5610a5_e">Kidney Disease Mortality—Michigan, 1989–2005</a>. March 16, 2007 / 56(10);225-227.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-1"></div>
    </div>
    <%--</div>
			</div>--%>
    
    <br />
    <br />
    <br />
</asp:Content>


