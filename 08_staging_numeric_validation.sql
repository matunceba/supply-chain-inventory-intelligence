/*
Project: Supply Chain & Inventory Intelligence
Script: 08_staging_numeric_validation
Purpose: Identify negative values in key numeric fields.
*/

USE SupplyChainBI;
GO

SELECT
    COUNT_BIG(*) AS TotalRecords,

    SUM(CASE WHEN Units_Sold < 0
             THEN 1 ELSE 0 END) AS NegativeUnitsSold,

    SUM(CASE WHEN Inventory_Level < 0
             THEN 1 ELSE 0 END) AS NegativeInventoryLevel,

    SUM(CASE WHEN Reorder_Point < 0
             THEN 1 ELSE 0 END) AS NegativeReorderPoint,

    SUM(CASE WHEN Demand_Forecast < 0
             THEN 1 ELSE 0 END) AS NegativeDemandForecast,

    SUM(CASE WHEN Unit_Cost < 0
             THEN 1 ELSE 0 END) AS NegativeUnitCost,

    SUM(CASE WHEN Unit_Price < 0
             THEN 1 ELSE 0 END) AS NegativeUnitPrice
FROM dbo.SupplyChain_Staging;
GO