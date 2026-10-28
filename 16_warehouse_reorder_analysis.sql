/*
Project: Supply Chain & Inventory Intelligence
Script: 16_warehouse_reorder_analysis
Purpose: Compare inventory status against reorder points by warehouse.
*/

USE SupplyChainBI;
GO

WITH WarehouseInventory AS
(
    SELECT
        Warehouse_ID,
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
    COUNT_BIG(*) AS TotalRecords,

    SUM(CASE WHEN ReorderStatus = 'Below Reorder Point'
             THEN 1 ELSE 0 END) AS BelowReorderRecords,

    CAST(
        100.0 * SUM(
            CASE WHEN ReorderStatus = 'Below Reorder Point'
                 THEN 1 ELSE 0 END
        ) / COUNT_BIG(*)
        AS decimal(6,2)
    ) AS BelowReorderPercentage,

    SUM(CASE WHEN ReorderStatus = 'At Reorder Point'
             THEN 1 ELSE 0 END) AS AtReorderRecords,

    SUM(CASE WHEN ReorderStatus = 'Above Reorder Point'
             THEN 1 ELSE 0 END) AS AboveReorderRecords

FROM WarehouseInventory
GROUP BY Warehouse_ID
ORDER BY BelowReorderPercentage DESC, Warehouse_ID;
GO