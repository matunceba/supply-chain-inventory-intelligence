
/*
Project: Supply Chain & Inventory Intelligence
Script: 35_regional_sales_inventory_comparison
Purpose: Compare sales and inventory by region and promotion status.
Caution: Results describe recorded associations, not causation.
*/

USE SupplyChainBI;
GO

SELECT
    Region,

    COUNT_BIG(*) AS TotalRecords,

    SUM(CASE
        WHEN Promotion_Flag = 0 THEN 1
        ELSE 0
    END) AS NonPromotionRecords,

    SUM(CASE
        WHEN Promotion_Flag = 1 THEN 1
        ELSE 0
    END) AS PromotionRecords,

    CAST(
        AVG(CASE
            WHEN Promotion_Flag = 0
                THEN CAST(Units_Sold AS decimal(18,4))
        END)
        AS decimal(12,2)
    ) AS AvgSalesWithoutPromotion,

    CAST(
        AVG(CASE
            WHEN Promotion_Flag = 1
                THEN CAST(Units_Sold AS decimal(18,4))
        END)
        AS decimal(12,2)
    ) AS AvgSalesWithPromotion,

    CAST(
        AVG(CAST(Inventory_Level AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageInventoryLevel,

    SUM(CASE
        WHEN Inventory_Level < Reorder_Point THEN 1
        ELSE 0
    END) AS RecordsBelowReorderPoint,

    CAST(
        100.0 * SUM(CASE
            WHEN Inventory_Level < Reorder_Point THEN 1
            ELSE 0
        END) / NULLIF(COUNT_BIG(*), 0)
        AS decimal(10,2)
    ) AS PercentageBelowReorderPoint

FROM dbo.SupplyChain_Staging

GROUP BY Region

ORDER BY Region;
GO