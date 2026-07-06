USE [NCCD_DDT_CKD]
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

PRINT(N'Update rows in [dbo].[t_SpecSheet]')
UPDATE [dbo].[t_SpecSheet] SET [FieldText]='Estimated Glomerular Filtration Rate (eGFR)', [DataText]=N'<p>Based on the CKD-EPI (2021) equation for calibrated creatinine: eGFR=142 x [min(serum creatinine in mg/dL) /&kappa;, 1)]^&alpha;&nbsp;x [max(serum creatinine/&kappa;, 1)]^-1.20 x 0.9938^age&nbsp;x (1.012 if female).<br />
<br />
&kappa; = 0.7 if female and 0.9 if male<br />
&alpha; = -0.241 if female and -0.302 if male</p>
' WHERE [SpecSheetID] = 1265
UPDATE [dbo].[t_SpecSheet] SET [FieldText]='Definition of Diabetes' WHERE [SpecSheetID] = 1273
UPDATE [dbo].[t_SpecSheet] SET [FieldText]='Definition of Hypertension' WHERE [SpecSheetID] = 1275
UPDATE [dbo].[t_SpecSheet] SET [DataText]=N'<p>Appropriate NHANES survey weights were used for all analyses; if relative standard error was greater than 30%, the estimates were not shown. Serum creatinine measurements were assay corrected for NHANES years 2005 and 2006 and prior to be combined with later years.</p>
' WHERE [SpecSheetID] = 1277
PRINT(N'Operation applied to 4 rows out of 4')

PRINT(N'Add constraints to [dbo].[t_SpecSheet]')
ALTER TABLE [dbo].[t_SpecSheet] WITH CHECK CHECK CONSTRAINT [FK_t_SpecSheet_t_Page]
COMMIT TRANSACTION
GO
