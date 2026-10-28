/*
Project: Supply Chain & Inventory Intelligence
Script: 12_baseline_business_metrics
Purpose: Summarise baseline sales, inventory, pricing and forecast metrics.
*/

USE SupplyChainBI;
GO

SELECT
    COUNT_BIG(*) AS TotalRecords,

    SUM(Units_Sold) AS TotalRecordedUnitsSold,
    AVG(CAST(Units_Sold AS decimal(18,4))) AS AverageUnitsSold,

    AVG(CAST(Inventory_Level AS decimal(18,4))) AS AverageInventoryLevel,

    AVG(CAST(Unit_Cost AS decimal(18,4))) AS AverageUnitCost,
    AVG(CAST(Unit_Price AS decimal(18,4))) AS AverageUnitPrice,

    AVG(CAST(Demand_Forecast AS decimal(18,4))) AS AverageDemandForecast,

    MIN([Date]) AS EarliestDate,
    MAX([Date]) AS LatestDate

FROM dbo.SupplyChain_Staging;
GO