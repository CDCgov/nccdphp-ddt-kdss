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
(   N'June',  -- Month - nchar(10)
    '2026',   -- Year - varchar(4)
    N'Chronic Kidney Disease in the United States: The New CDC Fact Sheet is Published',  -- Title - nvarchar(2000)
    N'../AreYouAware.aspx?emailDate=June_2026',  -- AYALink - nvarchar(200)
    '',   -- QNUM - varchar(6)
    N'',  -- CKDSurveillanceChartLink - nvarchar(200)
    N'',  -- ChartSpecifics - nvarchar(200)
    'The CDC recently published its 2026 Factsheet on Chronic Kidney Disease (CKD). The Factsheet outlines key statistics and an overview of CKD Epidemiology, and overall management strategies.', -- ShortDescription - nvarchar(max)
    NULL, -- TopicID - int
    1, -- IsActive - bit
    NULL, -- TopicHomePageURL - nvarchar(max)
    5  -- MonthNum - int
    )