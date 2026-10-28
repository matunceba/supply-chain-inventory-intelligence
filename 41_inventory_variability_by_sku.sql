/*
Project: Supply Chain & Inventory Intelligence
Script: 41_inventory_variability_by_sku
Purpose: Measure variation in recorded inventory levels by SKU.
Techniques: AVG, STDEV, MIN, MAX.
Caution: Variability alone does not establish the cause of changes.
*/

USE SupplyChainBI;
GO

SELECT
    SKU_ID,

    COUNT_BIG(*) AS RecordCount,

    CAST(
        AVG(CAST(Inventory_Level AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageInventoryLevel,

    CAST(
        STDEV(CAST(Inventory_Level AS float))
        AS decimal(12,2)
    ) AS InventoryStandardDeviation,

    MIN(Inventory_Level) AS MinimumInventoryLevel,

    MAX(Inventory_Level) AS MaximumInventoryLevel,

    MAX(Inventory_Level) - MIN(Inventory_Level)
        AS InventoryRange

FROM dbo.SupplyChain_Staging

GROUP BY SKU_ID

ORDER BY
    InventoryStandardDeviation DESC,
    SKU_ID;
GO