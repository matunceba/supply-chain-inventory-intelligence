/*
Project: Supply Chain & Inventory Intelligence
Script: 29_warehouse_sales_inventory_analysis
Purpose: Compare recorded sales and inventory observations by warehouse.
Caution: Inventory_Level is observed across multiple dates.
Do not interpret its sum as a snapshot of current stock.
*/

USE SupplyChainBI;
GO

SELECT
    Warehouse_ID,

    COUNT_BIG(*) AS RecordCount,

    COUNT(DISTINCT SKU_ID) AS DistinctSKUs,

    SUM(Units_Sold) AS TotalRecordedUnitsSold,

    CAST(
        AVG(CAST(Units_Sold AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageUnitsSoldPerRecord,

    CAST(
        AVG(CAST(Inventory_Level AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageInventoryLevel,

    CAST(
        AVG(CAST(Reorder_Point AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageReorderPoint,

    SUM(
        CASE
            WHEN Inventory_Level < Reorder_Point THEN 1
            ELSE 0
        END
    ) AS RecordsBelowReorderPoint,

    CAST(
        100.0 * SUM(
            CASE
                WHEN Inventory_Level < Reorder_Point THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT_BIG(*), 0)
        AS decimal(10,2)
    ) AS PercentageBelowReorderPoint

FROM dbo.SupplyChain_Staging

GROUP BY Warehouse_ID

ORDER BY TotalRecordedUnitsSold DESC;
GO