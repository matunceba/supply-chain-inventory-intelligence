/*
Project: Supply Chain & Inventory Intelligence
Script: 15_inventory_reorder_analysis
Purpose: Classify inventory observations against reorder points.
*/

USE SupplyChainBI;
GO

WITH InventoryStatus AS
(
    SELECT
        CASE
            WHEN Inventory_Level < Reorder_Point
                THEN 'Below Reorder Point'
            WHEN Inventory_Level = Reorder_Point
                THEN 'At Reorder Point'
            ELSE 'Above Reorder Point'
        END AS ReorderStatus,
        Inventory_Level,
        Reorder_Point
    FROM dbo.SupplyChain_Staging
)
SELECT
    ReorderStatus,
    COUNT_BIG(*) AS RecordCount,
    CAST(
        100.0 * COUNT_BIG(*) /
        SUM(COUNT_BIG(*)) OVER ()
        AS decimal(6,2)
    ) AS PercentageOfRecords,
    AVG(CAST(Inventory_Level AS decimal(18,4)))
        AS AverageInventoryLevel,
    AVG(CAST(Reorder_Point AS decimal(18,4)))
        AS AverageReorderPoint
FROM InventoryStatus
GROUP BY ReorderStatus
ORDER BY
    CASE ReorderStatus
        WHEN 'Below Reorder Point' THEN 1
        WHEN 'At Reorder Point' THEN 2
        WHEN 'Above Reorder Point' THEN 3
    END;
GO