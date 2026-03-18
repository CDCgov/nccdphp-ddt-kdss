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
(   N'March',  -- Month - nchar(10)
    '2026',   -- Year - varchar(4)
    N'Higher Prevalence of Anemia among Non-Hispanic Black Adults with Chronic Kidney Disease',  -- Title - nvarchar(2000)
    N'../AreYouAware.aspx?emailDate=March_2026',  -- AYALink - nvarchar(200)
    'Q808',   -- QNUM - varchar(6)
    N'https://wwwn.cdc.gov/KDSS/detail.aspx?Qnum=Q808&topic=5&Strat=Race%2FEthnicity',  -- CKDSurveillanceChartLink - nvarchar(200)
    N'',  -- ChartSpecifics - nvarchar(200)
    'Anemia (low hemoglobin level) is a well-known complication in chronic kidney disease (CKD) that gets worse with progression of the disease. National survey data show that over the past two decades, anemia has been more common among those with CKD than without CKD. Additionally, it is consistently more common among Black adults with CKD than other racial and ethnic groups. Anemia related to CKD is important to recognize and manage early on to optimize patients’ quality of life. Awareness of factors specific to Black populations (e.g., genetics, poorer access to healthcare, faster progression of CKD) may additionally help providers in improving management of anemia in CKD in this patient population., -- ShortDescription - nvarchar(max)',
    5, -- TopicID - int
    1, -- IsActive - bit
    '../TopicHome/HealthConsequences.aspx?topic=5', -- TopicHomePageURL - nvarchar(max)
    3  -- MonthNum - int
    )