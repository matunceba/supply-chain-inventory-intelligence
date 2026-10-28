/*
Project: Supply Chain & Inventory Intelligence
Script: 19_forecast_accuracy_analysis
Purpose: Evaluate forecast errors by promotion status.
Definitions:
  ForecastError = Units_Sold - Demand_Forecast
  MAE = Mean Absolute Error
  WAPE = Weighted Absolute Percentage Error
Caution: Forecast methodology and horizon are undocumented.
*/

USE SupplyChainBI;
GO

SELECT
    Promotion_Flag,
    COUNT_BIG(*) AS RecordCount,

    SUM(Units_Sold) AS TotalRecordedUnitsSold,

    SUM(Demand_Forecast) AS TotalForecastDemand,

    AVG(
        CAST(Units_Sold AS decimal(18,4))
        - CAST(Demand_Forecast AS decimal(18,4))
    ) AS MeanForecastError,

    AVG(
        ABS(
            CAST(Units_Sold AS decimal(18,4))
            - CAST(Demand_Forecast AS decimal(18,4))
        )
    ) AS MeanAbsoluteError,

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
GROUP BY Promotion_Flag
ORDER BY Promotion_Flag;
GO