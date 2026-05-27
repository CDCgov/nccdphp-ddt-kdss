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
    N'Chronic Kidney Disease in the United States: The New CDC Report on the State of CKD',  -- Title - nvarchar(2000)
    N'../AreYouAware.aspx?emailDate=June_2026',  -- AYALink - nvarchar(200)
    '',   -- QNUM - varchar(6)
    N'',  -- CKDSurveillanceChartLink - nvarchar(200)
    N'',  -- ChartSpecifics - nvarchar(200)
    'CDC recently published its 2026 report on chronic kidney disease (CKD). The report shares updated national estimates of CKD in the United States. It also highlights how CKD affects different groups and shares steps people can take to help manage CKD and protect their kidney and heart health.', -- ShortDescription - nvarchar(max)
    1, -- TopicID - int
    1, -- IsActive - bit
    '../TopicHome/PrevalenceIncidence.aspx?topic=1', -- TopicHomePageURL - nvarchar(max)
    5  -- MonthNum - int
    )