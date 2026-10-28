/*
Project: Supply Chain & Inventory Intelligence
Script: 23_sku_inventory_position
Purpose: Compare inventory status across SKUs.
Caution: A record below the reorder point is not proof of a stockout.
*/

USE SupplyChainBI;
GO

WITH SKUInventoryStatus AS
(
    SELECT
        SKU_ID,
        Inventory_Level,
        Reorder_Point,
        CASE
            WHEN Inventory_Level < Reorder_Point
                THEN 'Below Reorder Point'
            WHEN Inventory_Level = Reorder_Point
                THEN 'At Reorder Point'
            ELSE 'Above Reorder Point'
        END AS ReorderStatus
    FROM dbo.SupplyChain_Staging
)
SELECT
    SKU_ID,
    ReorderStatus,
    COUNT_BIG(*) AS RecordCount,

    CAST(
        100.0 * COUNT_BIG(*)
        / SUM(COUNT_BIG(*)) OVER (PARTITION BY SKU_ID)
        AS decimal(10,2)
    ) AS PercentageOfSKURecords,

    CAST(
        AVG(CAST(Inventory_Level AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageInventoryLevel,

    CAST(
        AVG(CAST(Reorder_Point AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageReorderPoint

FROM SKUInventoryStatus
GROUP BY
    SKU_ID,
    ReorderStatus
ORDER BY
    SKU_ID,
    CASE ReorderStatus
        WHEN 'Below Reorder Point' THEN 1
        WHEN 'At Reorder Point' THEN 2
        WHEN 'Above Reorder Point' THEN 3
    END;
GO