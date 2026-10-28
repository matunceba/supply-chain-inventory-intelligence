/*
Project: Supply Chain & Inventory Intelligence
Script: 37_monthly_sales_moving_average
Purpose: Calculate a three-month moving average of recorded sales.
Technique: AVG OVER with a window frame.
*/

USE SupplyChainBI;
GO

WITH MonthlySales AS
(
    SELECT
        YEAR([Date]) AS SalesYear,
        MONTH([Date]) AS SalesMonth,
        SUM(Units_Sold) AS MonthlyUnitsSold
    FROM dbo.SupplyChain_Staging
    GROUP BY
        YEAR([Date]),
        MONTH([Date])
)
SELECT
    SalesYear,
    SalesMonth,
    MonthlyUnitsSold,

    CAST(
        AVG(CAST(MonthlyUnitsSold AS decimal(18,4))) OVER
        (
            ORDER BY SalesYear, SalesMonth
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        )
        AS decimal(12,2)
    ) AS ThreeMonthMovingAverage,

    COUNT(*) OVER
    (
        ORDER BY SalesYear, SalesMonth
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MonthsIncluded

FROM MonthlySales

ORDER BY SalesYear, SalesMonth;
GO