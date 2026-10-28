/*
Project: Supply Chain & Inventory Intelligence
Script: 17_sku_reorder_analysis
Purpose: Rank SKUs by the proportion of observations below reorder point.
*/

USE SupplyChainBI;
GO

SELECT
    SKU_ID,
    COUNT_BIG(*) AS TotalRecords,

    SUM(
        CASE
            WHEN Inventory_Level < Reorder_Point THEN 1
            ELSE 0
        END
    ) AS BelowReorderRecords,

    CAST(
        100.0 * SUM(
            CASE
                WHEN Inventory_Level < Reorder_Point THEN 1
                ELSE 0
            END
        ) / COUNT_BIG(*)
        AS decimal(6,2)
    ) AS BelowReorderPercentage,

    AVG(CAST(Inventory_Level AS decimal(18,4)))
        AS AverageInventoryLevel,

    AVG(CAST(Reorder_Point AS decimal(18,4)))
        AS AverageReorderPoint

FROM dbo.SupplyChain_Staging
GROUP BY SKU_ID
ORDER BY
    BelowReorderPercentage DESC,
    BelowReorderRecords DESC,
    SKU_ID;
GO