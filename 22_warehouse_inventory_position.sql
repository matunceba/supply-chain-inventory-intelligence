/*
Project: Supply Chain & Inventory Intelligence
Script: 22_warehouse_inventory_position
Purpose: Compare recorded warehouse inventory against reorder points.
Caution: Below reorder point does not necessarily mean a stockout.
Inventory levels may be repeated observations over time.
*/

USE SupplyChainBI;
GO

WITH InventoryStatus AS
(
    SELECT
        Warehouse_ID,
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
    Warehouse_ID,
    ReorderStatus,
    COUNT_BIG(*) AS RecordCount,

    CAST(
        100.0 * COUNT_BIG(*)
        / SUM(COUNT_BIG(*)) OVER (PARTITION BY Warehouse_ID)
        AS decimal(10,2)
    ) AS PercentageOfWarehouseRecords,

    CAST(
        AVG(CAST(Inventory_Level AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageInventoryLevel,

    CAST(
        AVG(CAST(Reorder_Point AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageReorderPoint

FROM InventoryStatus
GROUP BY
    Warehouse_ID,
    ReorderStatus
ORDER BY
    Warehouse_ID,
    CASE ReorderStatus
        WHEN 'Below Reorder Point' THEN 1
        WHEN 'At Reorder Point' THEN 2
        WHEN 'Above Reorder Point' THEN 3
    END;
GO