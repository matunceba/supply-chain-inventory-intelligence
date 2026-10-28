/*
Project: Supply Chain & Inventory Intelligence
Script: 32_top_five_skus_by_region
Purpose: Return the top five SKUs by recorded sales per region.
Techniques: CTE, aggregation, ROW_NUMBER.
*/

USE SupplyChainBI;
GO

WITH SKUSales AS
(
    SELECT
        Region,
        SKU_ID,
        SUM(Units_Sold) AS TotalRecordedUnitsSold
    FROM dbo.SupplyChain_Staging
    GROUP BY
        Region,
        SKU_ID
),
RankedSKUSales AS
(
    SELECT
        Region,
        SKU_ID,
        TotalRecordedUnitsSold,

        ROW_NUMBER() OVER
        (
            PARTITION BY Region
            ORDER BY
                TotalRecordedUnitsSold DESC,
                SKU_ID ASC
        ) AS RowNum

    FROM SKUSales
)
SELECT
    Region,
    SKU_ID,
    TotalRecordedUnitsSold,
    RowNum AS SalesRank
FROM RankedSKUSales
WHERE RowNum <= 5
ORDER BY
    Region,
    SalesRank;
GO