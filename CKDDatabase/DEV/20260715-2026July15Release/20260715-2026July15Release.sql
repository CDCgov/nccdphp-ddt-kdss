USE [NCCD_DDT_CKD]

INSERT INTO dbo.AYA
(
    Month,
    Year,
    Title,
    AYALink,
    QNUM,
    CKDSurveillanceChartLink,
    ChartSpecifics,
    ShortDescription,
    TopicID,
    IsActive,
    TopicHomePageURL,
    MonthNum
)
VALUES
(   N'August',  -- Month - nchar(10)
    '2026',   -- Year - varchar(4)
    N'Increasing Use of GLP-1 RA Medications Among Adults With Type 2 Diabetes and Chronic Kidney Disease',  -- Title - nvarchar(2000)
    N'../AreYouAware.aspx?emailDate=August_2026',  -- AYALink - nvarchar(200)
    'Q813',   -- QNUM - varchar(6)
    N'https://nccd.cdc.gov/CKD/detail.aspx?Qnum=Q813&topic=1&Strat=CKD+Stage#refreshPosition',  -- CKDSurveillanceChartLink - nvarchar(200)
    N'',  -- ChartSpecifics - nvarchar(200)
    'Glucagon-like peptide-1 receptor agonists (GLP-1 RAs) have beneficial effects in the management of chronic kidney disease (CKD), type 2 diabetes, obesity, and cardiovascular disease. From 2016 to 2023, GLP-1 RA medication use increased among Military Health System beneficiaries with type 2 diabetes and CKD, rising from 5.5% to 36.6% overall. The rapidly increasing use of GLP-1 RAs shows a change in how type 2 diabetes and CKD are managed.', -- ShortDescription - nvarchar(max)
    6, -- TopicID - int
    1, -- IsActive - bit
    '../TopicHome/QualityofCare.aspx?topic=6', -- TopicHomePageURL - nvarchar(max)
    8  -- MonthNum - int
    )