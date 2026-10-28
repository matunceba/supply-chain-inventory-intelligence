/*
Project: Supply Chain & Inventory Intelligence
Script: 07_staging_duplicate_check
Purpose: Identify duplicate Date-SKU-Warehouse combinations.
*/

USE SupplyChainBI;
GO

SELECT
    [Date],
    SKU_ID,
    Warehouse_ID,
    COUNT_BIG(*) AS DuplicateCount
FROM dbo.SupplyChain_Staging
GROUP BY
    [Date],
    SKU_ID,
    Warehouse_ID
HAVING COUNT_BIG(*) > 1
ORDER BY
    DuplicateCount DESC,
    [Date],
    SKU_ID,
    Warehouse_ID;
GO