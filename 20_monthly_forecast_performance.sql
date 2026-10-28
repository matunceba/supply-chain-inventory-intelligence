/*
Project: Supply Chain & Inventory Intelligence
Script: 20_monthly_forecast_performance
Purpose: Measure monthly forecast error and WAPE.
Caution: Forecast methodology and horizon are undocumented.
*/

USE SupplyChainBI;
GO

SELECT
    YEAR([Date]) AS SalesYear,
    MONTH([Date]) AS SalesMonth,

    COUNT_BIG(*) AS RecordCount,

    SUM(Units_Sold) AS TotalRecordedUnitsSold,

    SUM(Demand_Forecast) AS TotalForecastDemand,

    SUM(
        CAST(Units_Sold AS decimal(18,4))
        - CAST(Demand_Forecast AS decimal(18,4))
    ) AS NetForecastError,

    SUM(
        ABS(
            CAST(Units_Sold AS decimal(18,4))
            - CAST(Demand_Forecast AS decimal(18,4))
        )
    ) AS TotalAbsoluteError,

    CAST(
        100.0 * SUM(
            ABS(
                CAST(Units_Sold AS decimal(18,4))
                - CAST(Demand_Forecast AS decimal(18,4))
            )
        ) / NULLIF(SUM(Units_Sold), 0)
        AS decimal(10,2)
    ) AS WAPE_Percentage

FROM dbo.SupplyChain_Staging
GROUP BY
    YEAR([Date]),
    MONTH([Date])
ORDER BY
    SalesYear,
    SalesMonth;
GO