/*
Project: Supply Chain & Inventory Intelligence
Script: 45_executive_summary_metrics
Purpose: Produce a high-level executive summary of the dataset.
Caution:
- Inventory values are repeated observations over time.
- Below reorder point does not equal confirmed stockout.
- Forecast methodology and horizon are undocumented.
- No unit currency has been confirmed.
*/

USE SupplyChainBI;
GO

SELECT
    COUNT_BIG(*) AS TotalRecords,

    COUNT(DISTINCT SKU_ID) AS DistinctSKUs,

    COUNT(DISTINCT Warehouse_ID) AS DistinctWarehouses,

    COUNT(DISTINCT Supplier_ID) AS DistinctSuppliers,

    COUNT(DISTINCT Region) AS DistinctRegions,

    MIN([Date]) AS FirstRecordedDate,

    MAX([Date]) AS LastRecordedDate,

    SUM(Units_Sold) AS TotalRecordedUnitsSold,

    CAST(
        AVG(CAST(Units_Sold AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageUnitsSoldPerRecord,

    CAST(
        AVG(CAST(Inventory_Level AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageInventoryLevel,

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
    ) AS PercentageBelowReorderPoint,

    CAST(
        100.0 * SUM(
            ABS(
                CAST(Units_Sold AS decimal(18,4))
                - CAST(Demand_Forecast AS decimal(18,4))
            )
        ) / NULLIF(SUM(Units_Sold), 0)
        AS decimal(10,2)
    ) AS OverallWAPE_Percentage,

    SUM(
        CASE WHEN Promotion_Flag = 1 THEN 1 ELSE 0 END
    ) AS PromotionRecords,

    SUM(
        CASE WHEN Stockout_Flag = 1 THEN 1 ELSE 0 END
    ) AS StockoutFlaggedRecords

FROM dbo.SupplyChain_Staging;
GO