/*
Project: Supply Chain & Inventory Intelligence
Script: 34_sku_reorder_status_ranking
Purpose: Rank SKUs by percentage of records below reorder point.
Caution: Below reorder point is not equivalent to a confirmed stockout.
*/

USE SupplyChainBI;
GO

WITH SKUInventorySummary AS
(
    SELECT
        SKU_ID,
        COUNT_BIG(*) AS RecordCount,

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
        ) AS BelowReorderPercentage

    FROM dbo.SupplyChain_Staging
    GROUP BY SKU_ID
),
RankedSKUs AS
(
    SELECT
        SKU_ID,
        RecordCount,
        RecordsBelowReorderPoint,
        BelowReorderPercentage,

        DENSE_RANK() OVER
        (
            ORDER BY BelowReorderPercentage DESC
        ) AS BelowReorderRank

    FROM SKUInventorySummary
)
SELECT
    SKU_ID,
    RecordCount,
    RecordsBelowReorderPoint,
    BelowReorderPercentage,
    BelowReorderRank
FROM RankedSKUs
ORDER BY
    BelowReorderRank,
    SKU_ID;
GO