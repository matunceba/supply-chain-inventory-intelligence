/*
Project: Supply Chain & Inventory Intelligence
Script: 42_inventory_sales_comparison
Purpose: Compare average inventory with average recorded sales by SKU.
Caution: The ratio is descriptive, not days of inventory coverage.
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
        AVG(CAST(Units_Sold AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageUnitsSoldPerRecord,

    CAST(
        AVG(CAST(Reorder_Point AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageReorderPoint,

    CAST(
        AVG(CAST(Inventory_Level AS decimal(18,4)))
        / NULLIF(
            AVG(CAST(Units_Sold AS decimal(18,4))),
            0
        )
        AS decimal(12,2)
    ) AS InventoryToSalesRatio,

    SUM(
        CASE
            WHEN Inventory_Level < Reorder_Point THEN 1
            ELSE 0
        END
    ) AS RecordsBelowReorderPoint

FROM dbo.SupplyChain_Staging

GROUP BY SKU_ID

ORDER BY
    InventoryToSalesRatio ASC,
    SKU_ID;
GO