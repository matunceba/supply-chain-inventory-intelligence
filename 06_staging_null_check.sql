/*
Project: Supply Chain & Inventory Intelligence
Script: 06_staging_null_check
Purpose: Check missing values in key staging columns.
*/

USE SupplyChainBI;
GO

SELECT
    COUNT_BIG(*) AS TotalRecords,
    SUM(CASE WHEN [Date] IS NULL THEN 1 ELSE 0 END) AS MissingDate,
    SUM(CASE WHEN SKU_ID IS NULL THEN 1 ELSE 0 END) AS MissingSKU,
    SUM(CASE WHEN Warehouse_ID IS NULL THEN 1 ELSE 0 END) AS MissingWarehouse,
    SUM(CASE WHEN Supplier_ID IS NULL THEN 1 ELSE 0 END) AS MissingSupplier,
    SUM(CASE WHEN Units_Sold IS NULL THEN 1 ELSE 0 END) AS MissingUnitsSold,
    SUM(CASE WHEN Inventory_Level IS NULL THEN 1 ELSE 0 END) AS MissingInventoryLevel,
    SUM(CASE WHEN Reorder_Point IS NULL THEN 1 ELSE 0 END) AS MissingReorderPoint,
    SUM(CASE WHEN Demand_Forecast IS NULL THEN 1 ELSE 0 END) AS MissingDemandForecast
FROM dbo.SupplyChain_Staging;
GO