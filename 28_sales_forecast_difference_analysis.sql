/*
Project: Supply Chain & Inventory Intelligence
Script: 28_sales_forecast_difference_analysis
Purpose: Compare recorded sales with forecast demand by region.
Definitions:
  ForecastError = Units_Sold - Demand_Forecast
  Positive error = sales exceeded forecast.
  Negative error = sales were below forecast.
Caution: Forecast methodology and horizon are undocumented.
*/

USE SupplyChainBI;
GO

SELECT
    Region,

    COUNT_BIG(*) AS RecordCount,

    SUM(Units_Sold) AS TotalRecordedUnitsSold,

    SUM(Demand_Forecast) AS TotalForecastDemand,

    SUM(
        CAST(Units_Sold AS decimal(18,4))
        - CAST(Demand_Forecast AS decimal(18,4))
    ) AS NetForecastError,

    CAST(
        AVG(
            CAST(Units_Sold AS decimal(18,4))
            - CAST(Demand_Forecast AS decimal(18,4))
        )
        AS decimal(12,4)
    ) AS AverageForecastError,

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

GROUP BY Region

ORDER BY WAPE_Percentage DESC;
GO