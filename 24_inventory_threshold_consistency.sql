/*
Project: Supply Chain & Inventory Intelligence
Script: 24_inventory_threshold_consistency
Purpose: Check whether inventory and reorder-point values vary
within each SKU and warehouse across recorded dates.
*/

USE SupplyChainBI;
GO

SELECT
    SKU_ID,
    Warehouse_ID,

    COUNT_BIG(*) AS RecordCount,

    COUNT(DISTINCT Inventory_Level) AS DistinctInventoryLevels,

    MIN(Inventory_Level) AS MinimumInventoryLevel,

    MAX(Inventory_Level) AS MaximumInventoryLevel,

    COUNT(DISTINCT Reorder_Point) AS DistinctReorderPoints,

    MIN(Reorder_Point) AS MinimumReorderPoint,

    MAX(Reorder_Point) AS MaximumReorderPoint

FROM dbo.SupplyChain_Staging

GROUP BY
    SKU_ID,
    Warehouse_ID