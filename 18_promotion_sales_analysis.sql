/*
Project: Supply Chain & Inventory Intelligence
Script: 18_promotion_sales_analysis
Purpose: Compare recorded sales and forecast demand by promotion status.
Caution: Results show associations, not causation.
*/

USE SupplyChainBI;
GO

SELECT
    Promotion_Flag,
    COUNT_BIG(*) AS RecordCount,

    SUM(Units_Sold) AS TotalRecordedUnitsSold,

    AVG(CAST(Units_Sold AS decimal(18,4)))
        AS AverageUnitsSold,

    AVG(CAST(Demand_Forecast AS decimal(18,4)))
        AS AverageDemandForecast,

    AVG(CAST(Inventory_Level AS decimal(18,4)))
        AS AverageInventoryLevel

FROM dbo.SupplyChain_Staging
GROUP BY Promotion_Flag
ORDER BY Promotion_Flag;
GO