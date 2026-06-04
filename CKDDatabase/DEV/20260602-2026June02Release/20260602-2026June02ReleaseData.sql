/*
Run this script on:

AWSSQLPRODM.mathematica.net.51349_CDCCKD    -  This database will be modified

to synchronize it with:

AWSSQLSTGM.mathematica.net.51349_CDCCKD_TED

You are recommended to back up your database before running this script

Script created by SQL Data Compare version 15.3.6.25729 from Red Gate Software Ltd at 6/2/2026 1:56:19 PM

*/
		
USE [51349_CDCCKD]
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION

PRINT(N'Drop constraints from [dbo].[t_SpecSheet]')
ALTER TABLE [dbo].[t_SpecSheet] NOCHECK CONSTRAINT [FK_t_SpecSheet_t_Page]

PRINT(N'Drop constraints from [dbo].[t_KeyPoint]')
ALTER TABLE [dbo].[t_KeyPoint] NOCHECK CONSTRAINT [FK_t_KeyPoint_t_Page]

PRINT(N'Drop constraints from [dbo].[t_DataPoint]')
ALTER TABLE [dbo].[t_DataPoint] NOCHECK CONSTRAINT [FK_t_DataPoint_t_Chart]
ALTER TABLE [dbo].[t_DataPoint] NOCHECK CONSTRAINT [FK_t_DataPoint_t_Stratification_1]
ALTER TABLE [dbo].[t_DataPoint] NOCHECK CONSTRAINT [FK_t_DataPoint_t_Stratification_2]
ALTER TABLE [dbo].[t_DataPoint] NOCHECK CONSTRAINT [FK_t_DataPoint_t_Stratification_3]

PRINT(N'Drop constraint FK_t_IndicatorFactorOfInterestLink_t_Indicator from [dbo].[t_IndicatorFactorOfInterestLink]')
ALTER TABLE [dbo].[t_IndicatorFactorOfInterestLink] NOCHECK CONSTRAINT [FK_t_IndicatorFactorOfInterestLink_t_Indicator]

PRINT(N'Drop constraint FK_t_IndicatorLink_t_Indicator_1 from [dbo].[t_IndicatorLink]')
ALTER TABLE [dbo].[t_IndicatorLink] NOCHECK CONSTRAINT [FK_t_IndicatorLink_t_Indicator_1]

PRINT(N'Drop constraint FK_t_IndicatorLink_t_Indicator_2 from [dbo].[t_IndicatorLink]')
ALTER TABLE [dbo].[t_IndicatorLink] NOCHECK CONSTRAINT [FK_t_IndicatorLink_t_Indicator_2]

PRINT(N'Drop constraint FK_t_MeasureIndicatorLink_t_Indicator from [dbo].[t_MeasureIndicatorLink]')
ALTER TABLE [dbo].[t_MeasureIndicatorLink] NOCHECK CONSTRAINT [FK_t_MeasureIndicatorLink_t_Indicator]

PRINT(N'Drop constraint FK_t_Page_t_Indicator from [dbo].[t_Page]')
ALTER TABLE [dbo].[t_Page] NOCHECK CONSTRAINT [FK_t_Page_t_Indicator]

PRINT(N'Update rows in [dbo].[t_SpecSheet]')
UPDATE [dbo].[t_SpecSheet] SET [DataText]=N'<p>Trends in Sodium-glucose cotransporter 2 inhibitor (SGLT2i) used among beneficiaries with type 2 diabetes mellitus and chronic kidney disease (CKD) in the Military Health System (MHS).</p>
' WHERE [SpecSheetID] = 12663
UPDATE [dbo].[t_SpecSheet] SET [DataText]=N'<p>Trends in Glucagon-like peptide-1 receptor agonist (GLP-1 RA) used among beneficiaries with type 2 diabetes mellitus and chronic kidney disease (CKD) in the Military Health System (MHS).</p>
' WHERE [SpecSheetID] = 12664
UPDATE [dbo].[t_SpecSheet] SET [DataText]=N'<p>Trends in use of angiotensin-converting enzyme inhibitors (ACEi) or angiotensin receptor blockers (ARB) among MHS beneficiaries with diabetes mellitus (types 1 and 2) and chronic kidney disease (CKD) in the Military Health System (MHS).</p>
' WHERE [SpecSheetID] = 12665
UPDATE [dbo].[t_SpecSheet] SET [DataText]=N'<p>Trends in use of angiotensin-converting enzyme inhibitor (ACEi) or angiotensin receptor blocker (ARB) among MHS beneficiaries with chronic kidney disease (CKD) stages 3-5 in the Military Health System (MHS).</p>
' WHERE [SpecSheetID] = 12666
UPDATE [dbo].[t_SpecSheet] SET [DataText]=N'<p>Trends in Sodium-glucose cotransporter 2 inhibitor (SGLT2i) used among beneficiaries with type 2 diabetes mellitus and chronic kidney disease (CKD) in the Military Health System (MHS).</p>
' WHERE [SpecSheetID] = 12667
UPDATE [dbo].[t_SpecSheet] SET [DataText]=N'<p>Trends in Glucagon-like peptide-1 receptor agonist (GLP-1 RA) used among beneficiaries with type 2 diabetes mellitus and chronic kidney disease (CKD) in the Military Health System (MHS).</p>
' WHERE [SpecSheetID] = 12668
UPDATE [dbo].[t_SpecSheet] SET [DataText]=N'<p>Trends in use of angiotensin-converting enzyme inhibitors (ACEi) or angiotensin receptor blockers (ARB) among MHS beneficiaries with diabetes mellitus (types 1 and 2) and chronic kidney disease (CKD) in the Military Health System (MHS).</p>
' WHERE [SpecSheetID] = 12669
UPDATE [dbo].[t_SpecSheet] SET [DataText]=N'<p>Trends in use of angiotensin-converting enzyme inhibitor (ACEi) or angiotensin receptor blocker (ARB) among MHS beneficiaries with chronic kidney disease (CKD) stages 3-5 in the Military Health System (MHS).</p>
' WHERE [SpecSheetID] = 12670
UPDATE [dbo].[t_SpecSheet] SET [DataText]=N'<p>Type 2 diabetes is determined using the Stanford algorithm (https://phekb.org/phenotype/1506), which uses one encounter with an ICD code for diabetes plus either the presence of prescribed hypoglycemic medications or the presence of abnormal chemistries (random outpatient glucose &gt; 200 mg/dL or hemoglobin A1C &ge; 6.5%).</p>
' WHERE [SpecSheetID] = 12712
UPDATE [dbo].[t_SpecSheet] SET [DataText]=N'<p>Type 2 diabetes is determined using the Stanford algorithm (https://phekb.org/phenotype/1506), which uses one encounter with an ICD code for diabetes plus either the presence of prescribed hypoglycemic medications or the presence of abnormal chemistries (random outpatient glucose &gt; 200 mg/dL or hemoglobin A1C &ge; 6.5%).</p>
' WHERE [SpecSheetID] = 12736
UPDATE [dbo].[t_SpecSheet] SET [DataText]=N'<p>Type 2 diabetes is determined using the Stanford algorithm (https://phekb.org/phenotype/1506), which uses one encounter with an ICD code for diabetes plus either the presence of prescribed hypoglycemic medications or the presence of abnormal chemistries (random outpatient glucose &gt; 200 mg/dL or hemoglobin A1C &ge; 6.5%).</p>
' WHERE [SpecSheetID] = 12760
UPDATE [dbo].[t_SpecSheet] SET [DataText]=N'<p>Type 2 diabetes is determined using the Stanford algorithm (https://phekb.org/phenotype/1506), which uses one encounter with an ICD code for diabetes plus either the presence of prescribed hypoglycemic medications or the presence of abnormal chemistries (random outpatient glucose &gt; 200 mg/dL or hemoglobin A1C &ge; 6.5%).</p>
' WHERE [SpecSheetID] = 12784
PRINT(N'Operation applied to 12 rows out of 12')

PRINT(N'Update rows in [dbo].[t_KeyPoint]')
UPDATE [dbo].[t_KeyPoint] SET [KeyPointText]=N'<p>The crude prevalence of Military Health System (MHS) beneficiaries with CKD stages 3&ndash;5 (estimated glomerular filtration rate [eGFR] &lt;60 ml/min/1.73<sup>2</sup>) ranged from 5.9% to 4.8% during 2009&ndash;2023. The age-standardized prevalence decreased from 7.7% to 5.6%. The crude prevalence of CKD stages 3&ndash;5 was highest in adults aged &ge;70 years and Black adults (among those with known race and ethnicity). The age-standardized prevalence was higher&nbsp;in Black adults compared with their counterparts.</p>
' WHERE [KeyPointID] = 455
UPDATE [dbo].[t_KeyPoint] SET [KeyPointText]=N'<p>The crude prevalence of Military Health System (MHS) beneficiaries with CKD stages 3&ndash;5 (estimated glomerular filtration rate [eGFR] &lt;60 ml/min/1.73<sup>2</sup>) ranged from 5.9% to 4.8% during 2009&ndash;2023. The age-standardized prevalence decreased from 7.7% to 5.6%. The crude prevalence of CKD stages 3&ndash;5 was highest in adults aged &ge;70 years and Black adults (among those with known race and ethnicity). The age-standardized prevalence was higher&nbsp;in Black adults compared with their counterparts.</p>
' WHERE [KeyPointID] = 551
UPDATE [dbo].[t_KeyPoint] SET [KeyPointText]=N'<p>Sodium-glucose cotransporter 2 inhibitor (SGLT2i) use among Military Health System (MHS) beneficiaries with type 2 diabetes mellitus and chronic kidney disease (CKD) significantly increased from 4.2% to 34.0% (age-standardized) between 2016 and 2023. The use was higher among males (both crude and age-standardized);&nbsp;those with known race and ethnicity; and individuals with CKD stage 4 (age-standardized).</p>
' WHERE [KeyPointID] = 598
UPDATE [dbo].[t_KeyPoint] SET [KeyPointText]=N'<p>Glucagon-like peptide-1 receptor agonist (GLP-1 RA) use among&nbsp;Military Health System (MHS) beneficiaries with type 2 diabetes mellitus and CKD significantly increased from 6.3% to 41.2% (age-standardized) between 2016 and 2023,&nbsp;was highest&nbsp;among individuals aged 40&ndash;59 years, and higher in females than males (age-standardized). During this period, no distinct patterns were observed within specific race and ethnicity or CKD stage strata.</p>
' WHERE [KeyPointID] = 599
UPDATE [dbo].[t_KeyPoint] SET [KeyPointText]=N'<p>Angiotensin-converting enzyme inhibitor (ACEi) or angiotensin receptor blocker (ARB) use among Military Health System (MHS) beneficiaries with types 1 and 2 diabetes mellitus and chronic kidney disease (CKD) decreased from 69.7% to 63.6% (age-standardized) between 2016 and 2023. Use was generally higher during the period among adults aged over 60 years (crude) and males (age-standardized).</p>
' WHERE [KeyPointID] = 600
UPDATE [dbo].[t_KeyPoint] SET [KeyPointText]=N'<p>Angiotensin-converting enzyme inhibitor (ACEi) or angiotensin receptor blocker (ARB) use among Department of Defense Military Health System (MHS) beneficiaries with chronic kidney disease (CKD) stages 3&ndash;5 has decreased slightly from 47.3% to 44.1% (age-standardized) between 2016 and 2023. ACEi and ARB use was higher among adults aged 60 years and older (crude); Asian American or Pacific Islander beneficiaries (age-standardized); and beneficiaries with CKD stage 4, hypertension, or diabetes (all age-standardized).</p>
' WHERE [KeyPointID] = 601
UPDATE [dbo].[t_KeyPoint] SET [KeyPointText]=N'<p>Sodium-glucose cotransporter 2 inhibitor (SGLT2i) use among&nbsp;Military Health System (MHS) beneficiaries with type 2 diabetes mellitus and chronic kidney disease (CKD) significantly increased from 4.2% to 34.0% (age-standardized) between 2016 and 2023. The use was higher among males (both crude and age-standardized);&nbsp;those with known race and ethnicity; and individuals with CKD stage 4 (age-standardized).</p>
' WHERE [KeyPointID] = 602
UPDATE [dbo].[t_KeyPoint] SET [KeyPointText]=N'<p>Glucagon-like peptide-1 receptor agonist (GLP-1 RA) use among&nbsp;Military Health System (MHS) beneficiaries with type 2 diabetes mellitus and CKD significantly increased from 6.3% to 41.2% (age-standardized) between 2016 and 2023,&nbsp;was highest&nbsp;among individuals aged 40&ndash;59 years, and higher in females than males (age-standardized). During this period, no distinct patterns were observed within specific race and ethnicity or CKD stage strata.</p>
' WHERE [KeyPointID] = 603
UPDATE [dbo].[t_KeyPoint] SET [KeyPointText]=N'<p>Angiotensin-converting enzyme inhibitor (ACEi) or angiotensin receptor blocker (ARB) use among Military Health System (MHS) beneficiaries with types 1 and 2 diabetes mellitus and chronic kidney disease (CKD) decreased from 69.7% to 63.6% (age-standardized) between 2016 and 2023. Use was generally higher during the period among adults aged over 60 years (crude) and males (age-standardized).</p>
' WHERE [KeyPointID] = 604
UPDATE [dbo].[t_KeyPoint] SET [KeyPointText]=N'<p>Angiotensin-converting enzyme inhibitor (ACEi) or angiotensin receptor blocker (ARB) use among&nbsp;Military Health System (MHS) beneficiaries with chronic kidney disease (CKD) stages 3&ndash;5 has decreased slightly from 47.3% to 44.1% (age-standardized) between 2016 and 2023. ACEi and ARB use was higher among adults aged 60 years and older (crude); Asian American or Pacific Islander beneficiaries (age-standardized); and beneficiaries with CKD stage 4, hypertension, or diabetes (all age-standardized).</p>
' WHERE [KeyPointID] = 605
PRINT(N'Operation applied to 10 rows out of 10')

PRINT(N'Update rows in [dbo].[t_DataPoint]')
UPDATE [dbo].[t_DataPoint] SET [MainValue]=N'4.7' WHERE [DatapointID] = 402094
UPDATE [dbo].[t_DataPoint] SET [MainValue]=N'2.7' WHERE [DatapointID] = 402095
UPDATE [dbo].[t_DataPoint] SET [MainValue]=N'7.1' WHERE [DatapointID] = 402096
UPDATE [dbo].[t_DataPoint] SET [MainValue]=N'13.6' WHERE [DatapointID] = 402097
UPDATE [dbo].[t_DataPoint] SET [MainValue]=N'16.6' WHERE [DatapointID] = 402098
UPDATE [dbo].[t_DataPoint] SET [MainValue]=N'22.1' WHERE [DatapointID] = 402099
UPDATE [dbo].[t_DataPoint] SET [MainValue]=N'27.3' WHERE [DatapointID] = 402100
UPDATE [dbo].[t_DataPoint] SET [MainValue]=N'37.5' WHERE [DatapointID] = 402101
UPDATE [dbo].[t_DataPoint] SET [MainValue]=N'7.3' WHERE [DatapointID] = 402102
UPDATE [dbo].[t_DataPoint] SET [MainValue]=N'4.1' WHERE [DatapointID] = 402103
UPDATE [dbo].[t_DataPoint] SET [MainValue]=N'9.5' WHERE [DatapointID] = 402104
UPDATE [dbo].[t_DataPoint] SET [MainValue]=N'17.0' WHERE [DatapointID] = 402105
UPDATE [dbo].[t_DataPoint] SET [MainValue]=N'20.8' WHERE [DatapointID] = 402106
UPDATE [dbo].[t_DataPoint] SET [MainValue]=N'26.7' WHERE [DatapointID] = 402107
UPDATE [dbo].[t_DataPoint] SET [MainValue]=N'32.0' WHERE [DatapointID] = 402108
UPDATE [dbo].[t_DataPoint] SET [MainValue]=N'43.7' WHERE [DatapointID] = 402109
PRINT(N'Operation applied to 16 rows out of 16')

PRINT(N'Update row in [dbo].[t_Indicator]')
UPDATE [dbo].[t_Indicator] SET [IndicatorText]=N'GLP-1 RA Use in Type 2 Diabetes Mellitus with CKD in the Military Health System', [IndicatorTitleRoot]=N'GLP-1 RA Use in Type 2 Diabetes Mellitus with CKD in the Military Health System' WHERE [IndicatorID] = 461

PRINT(N'Update rows in [dbo].[ApplicationConfiguration]')
UPDATE [dbo].[ApplicationConfiguration] SET [Value]='Tip: Click legend items to hide or show lines/bars. Double-click to isolate one line/bar.' WHERE [ID] = 12
PRINT(N'Operation applied to 1 rows out of 4')

PRINT(N'Add row to [dbo].[AYA]')
SET IDENTITY_INSERT [dbo].[AYA] ON
INSERT INTO [dbo].[AYA] ([AYAId], [Month], [Year], [Title], [AYALink], [QNUM], [CKDSurveillanceChartLink], [ChartSpecifics], [ShortDescription], [TopicID], [IsActive], [TopicHomePageURL], [MonthNum]) VALUES (3059, N'June      ', '2026', N'Chronic Kidney Disease in the United States: The New CDC Report on the State of CKD', N'../AreYouAware.aspx?emailDate=June_2026', '', N'', N'', N'CDC recently published its 2026 report on chronic kidney disease (CKD). The report shares updated national estimates of CKD in the United States. It also highlights how CKD affects different groups and shares steps people can take to help manage CKD and protect their kidney and heart health.', 1, 1, N'../TopicHome/PrevalenceIncidence.aspx?topic=1', 6)
SET IDENTITY_INSERT [dbo].[AYA] OFF

PRINT(N'Add rows to [dbo].[t_ShortTitles]')
SET IDENTITY_INSERT [dbo].[t_ShortTitles] ON
INSERT INTO [dbo].[t_ShortTitles] ([Topic], [Qnum], [Description], [Current Indicator Title], [Data Source], [ShortTitle], [ShortTitleKey]) VALUES (N'6', N'Q812', N'SGLT2i Use in Type 2 Diabetes Mellitus with CKD in the Military Health System', N'SGLT2i Use in Type 2 Diabetes Mellitus with CKD in the Military Health System', N'60', N'SGLT2i Use in Type 2 Diabetes Mellitus with CKD in the Military Health System', 1124)
INSERT INTO [dbo].[t_ShortTitles] ([Topic], [Qnum], [Description], [Current Indicator Title], [Data Source], [ShortTitle], [ShortTitleKey]) VALUES (N'6', N'Q813', N'GLP-1 RA Use in Type 2 Diabetes Mellitus with CKD in the Military Health System', N'GLP-1 RA Use in Type 2 Diabetes Mellitus with CKD in the Military Health System', N'60', N'GLP-1 RA Use in Type 2 Diabetes Mellitus with CKD in the Military Health System', 1127)
INSERT INTO [dbo].[t_ShortTitles] ([Topic], [Qnum], [Description], [Current Indicator Title], [Data Source], [ShortTitle], [ShortTitleKey]) VALUES (N'6', N'Q814', N'ACEi or ARB Use in Diabetes Mellitus (Types 1 and 2) with CKD in the Military Health System', N'ACEi or ARB Use in Diabetes Mellitus (Types 1 and 2) with CKD in the Military Health System', N'60', N'ACEi or ARB Use in Diabetes Mellitus (Types 1 and 2) with CKD in the Military Health System', 1128)
INSERT INTO [dbo].[t_ShortTitles] ([Topic], [Qnum], [Description], [Current Indicator Title], [Data Source], [ShortTitle], [ShortTitleKey]) VALUES (N'6', N'Q815', N'ACEi/ARB Use in CKD Stages 3–5 in the Military Health System', N'ACEi/ARB Use in CKD Stages 3–5 in the Military Health System', N'60', N'ACEi/ARB Use in CKD Stages 3–5 in the Military Health System', 1131)
INSERT INTO [dbo].[t_ShortTitles] ([Topic], [Qnum], [Description], [Current Indicator Title], [Data Source], [ShortTitle], [ShortTitleKey]) VALUES (N'6', N'S812', N'SGLT2i Use in Type 2 Diabetes Mellitus with CKD in the Military Health System', N'SGLT2i Use in Type 2 Diabetes Mellitus with CKD in the Military Health System', N'60', N'SGLT2i Use in Type 2 Diabetes Mellitus with CKD in the Military Health System', 1125)
INSERT INTO [dbo].[t_ShortTitles] ([Topic], [Qnum], [Description], [Current Indicator Title], [Data Source], [ShortTitle], [ShortTitleKey]) VALUES (N'6', N'S813', N'GLP-1 RA Use in Type 2 Diabetes Mellitus with CKD in the Military Health System', N'GLP-1 RA Use in Type 2 Diabetes Mellitus with CKD in the Military Health System', N'60', N'GLP-1 RA Use in Type 2 Diabetes Mellitus with CKD in the Military Health System', 1126)
INSERT INTO [dbo].[t_ShortTitles] ([Topic], [Qnum], [Description], [Current Indicator Title], [Data Source], [ShortTitle], [ShortTitleKey]) VALUES (N'6', N'S814', N'ACEi or ARB Use in Diabetes Mellitus (Types 1 and 2) with CKD in the Military Health System', N'ACEi or ARB Use in Diabetes Mellitus (Types 1 and 2) with CKD in the Military Health System', N'60', N'ACEi or ARB Use in Diabetes Mellitus (Types 1 and 2) with CKD in the Military Health System', 1129)
INSERT INTO [dbo].[t_ShortTitles] ([Topic], [Qnum], [Description], [Current Indicator Title], [Data Source], [ShortTitle], [ShortTitleKey]) VALUES (N'6', N'S815', N'ACEi/ARB Use in CKD Stages 3–5 in the Military Health System', N'ACEi/ARB Use in CKD Stages 3–5 in the Military Health System', N'60', N'ACEi/ARB Use in CKD Stages 3–5 in the Military Health System', 1130)
SET IDENTITY_INSERT [dbo].[t_ShortTitles] OFF
PRINT(N'Operation applied to 8 rows out of 8')

PRINT(N'Add constraints to [dbo].[t_SpecSheet]')
ALTER TABLE [dbo].[t_SpecSheet] WITH CHECK CHECK CONSTRAINT [FK_t_SpecSheet_t_Page]

PRINT(N'Add constraints to [dbo].[t_KeyPoint]')
ALTER TABLE [dbo].[t_KeyPoint] WITH CHECK CHECK CONSTRAINT [FK_t_KeyPoint_t_Page]

PRINT(N'Add constraints to [dbo].[t_DataPoint]')
ALTER TABLE [dbo].[t_DataPoint] WITH CHECK CHECK CONSTRAINT [FK_t_DataPoint_t_Chart]
ALTER TABLE [dbo].[t_DataPoint] WITH CHECK CHECK CONSTRAINT [FK_t_DataPoint_t_Stratification_1]
ALTER TABLE [dbo].[t_DataPoint] WITH CHECK CHECK CONSTRAINT [FK_t_DataPoint_t_Stratification_2]
ALTER TABLE [dbo].[t_DataPoint] WITH CHECK CHECK CONSTRAINT [FK_t_DataPoint_t_Stratification_3]
ALTER TABLE [dbo].[t_IndicatorFactorOfInterestLink] WITH CHECK CHECK CONSTRAINT [FK_t_IndicatorFactorOfInterestLink_t_Indicator]
ALTER TABLE [dbo].[t_IndicatorLink] WITH CHECK CHECK CONSTRAINT [FK_t_IndicatorLink_t_Indicator_1]
ALTER TABLE [dbo].[t_IndicatorLink] WITH CHECK CHECK CONSTRAINT [FK_t_IndicatorLink_t_Indicator_2]
ALTER TABLE [dbo].[t_MeasureIndicatorLink] WITH CHECK CHECK CONSTRAINT [FK_t_MeasureIndicatorLink_t_Indicator]
ALTER TABLE [dbo].[t_Page] WITH CHECK CHECK CONSTRAINT [FK_t_Page_t_Indicator]
COMMIT TRANSACTION
GO
