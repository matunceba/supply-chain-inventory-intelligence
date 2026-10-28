/*
Project: Supply Chain & Inventory Intelligence
Script: 33_promotion_performance_by_region
Purpose: Compare recorded sales with and without promotions by region.
Caution: Differences are associations, not proof of promotional impact.
*/

USE SupplyChainBI;
GO

WITH PromotionSummary AS
(
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

        AVG(CASE
            WHEN Promotion_Flag = 0
                THEN CAST(Units_Sold AS decimal(18,4))
        END) AS AvgSalesWithoutPromotion,

        AVG(CASE
            WHEN Promotion_Flag = 1
                THEN CAST(Units_Sold AS decimal(18,4))
        END) AS AvgSalesWithPromotion

    FROM dbo.SupplyChain_Staging
    GROUP BY Region
)
SELECT
    Region,
    TotalRecords,
    NonPromotionRecords,
    PromotionRecords,

    CAST(AvgSalesWithoutPromotion AS decimal(12,2))
        AS AvgSalesWithoutPromotion,

    CAST(AvgSalesWithPromotion AS decimal(12,2))
        AS AvgSalesWithPromotion,

    CAST(
        AvgSalesWithPromotion - AvgSalesWithoutPromotion
        AS decimal(12,2)
    ) AS AverageSalesDifference,

    CAST(
        100.0 * (
            AvgSalesWithPromotion - AvgSalesWithoutPromotion
        ) / NULLIF(AvgSalesWithoutPromotion, 0)
        AS decimal(10,2)
    ) AS PercentageDifference

FROM PromotionSummary
ORDER BY Region;
GO