/*
Project: Supply Chain & Inventory Intelligence
Script: 38_monthly_forecast_accuracy_trend
Purpose: Compare monthly WAPE with the preceding month's WAPE.
Caution: Forecast methodology and horizon are undocumented.
*/

USE SupplyChainBI;
GO

WITH MonthlyForecast AS
(
    SELECT
        YEAR([Date]) AS SalesYear,
        MONTH([Date]) AS SalesMonth,

        SUM(Units_Sold) AS TotalRecordedUnitsSold,

        SUM(
            ABS(
                CAST(Units_Sold AS decimal(18,4))
                - CAST(Demand_Forecast AS decimal(18,4))
            )
        ) AS TotalAbsoluteError

    FROM dbo.SupplyChain_Staging

    GROUP BY
        YEAR([Date]),
        MONTH([Date])
),
MonthlyWAPE AS
(
    SELECT
        SalesYear,
        SalesMonth,
        TotalRecordedUnitsSold,
        TotalAbsoluteError,

        CAST(
            100.0 * TotalAbsoluteError
            / NULLIF(TotalRecordedUnitsSold, 0)
            AS decimal(10,2)
        ) AS WAPE_Percentage

    FROM MonthlyForecast
),
WAPEComparison AS
(
    SELECT
        SalesYear,
        SalesMonth,
        TotalRecordedUnitsSold,
        TotalAbsoluteError,
        WAPE_Percentage,

        LAG(WAPE_Percentage) OVER
        (
            ORDER BY SalesYear, SalesMonth
        ) AS PreviousMonthWAPE

    FROM MonthlyWAPE
)
SELECT
    SalesYear,
    SalesMonth,
    TotalRecordedUnitsSold,
    TotalAbsoluteError,
    WAPE_Percentage,
    PreviousMonthWAPE,

    CAST(
        WAPE_Percentage - PreviousMonthWAPE
        AS decimal(10,2)
    ) AS WAPEChangePercentagePoints

FROM WAPEComparison

ORDER BY SalesYear, SalesMonth;
GO