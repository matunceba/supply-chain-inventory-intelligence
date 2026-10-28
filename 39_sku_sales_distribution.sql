/*
Project: Supply Chain & Inventory Intelligence
Script: 39_sku_sales_distribution
Purpose: Classify SKUs by total recorded sales using quartiles.
Techniques: CTE, NTILE, window functions.
Caution: Quartiles are relative to this dataset and period.
*/

USE SupplyChainBI;
GO

WITH SKUSales AS
(
    SELECT
        SKU_ID,
        SUM(Units_Sold) AS TotalRecordedUnitsSold
    FROM dbo.SupplyChain_Staging
    GROUP BY SKU_ID
),
SKUQuartiles AS
(
    SELECT
        SKU_ID,
        TotalRecordedUnitsSold,

        NTILE(4) OVER
        (
            ORDER BY TotalRecordedUnitsSold
        ) AS SalesQuartile

    FROM SKUSales
)
SELECT
    SKU_ID,
    TotalRecordedUnitsSold,
    SalesQuartile,

    CASE SalesQuartile
        WHEN 1 THEN 'Q1 - Lowest Sales'
        WHEN 2 THEN 'Q2 - Lower-Middle Sales'
        WHEN 3 THEN 'Q3 - Upper-Middle Sales'
        WHEN 4 THEN 'Q4 - Highest Sales'
    END AS SalesSegment

FROM SKUQuartiles

ORDER BY
    SalesQuartile DESC,
    TotalRecordedUnitsSold DESC,
    SKU_ID;
GO