/*
Project: Supply Chain & Inventory Intelligence
Script: 36_monthly_sales_running_total
Purpose: Calculate monthly sales, running totals, and
month-over-month changes.
Techniques: CTE, LAG, SUM OVER.
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
),
MonthlyComparison AS
(
    SELECT
        SalesYear,
        SalesMonth,
        MonthlyUnitsSold,

        LAG(MonthlyUnitsSold) OVER
        (
            ORDER BY SalesYear, SalesMonth
        ) AS PreviousMonthUnitsSold,

        SUM(MonthlyUnitsSold) OVER
        (
            ORDER BY SalesYear, SalesMonth
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS RunningUnitsSold

    FROM MonthlySales
)
SELECT
    SalesYear,
    SalesMonth,
    MonthlyUnitsSold,
    PreviousMonthUnitsSold,

    MonthlyUnitsSold - PreviousMonthUnitsSold
        AS MonthOverMonthChange,

    CAST(
        100.0 * (
            MonthlyUnitsSold - PreviousMonthUnitsSold
        ) / NULLIF(PreviousMonthUnitsSold, 0)
        AS decimal(10,2)
    ) AS MonthOverMonthPercentage,

    RunningUnitsSold

FROM MonthlyComparison

ORDER BY SalesYear, SalesMonth;
GO