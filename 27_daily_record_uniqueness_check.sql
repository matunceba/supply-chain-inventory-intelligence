/*
Project: Supply Chain & Inventory Intelligence
Script: 27_daily_record_uniqueness_check
Purpose: Validate uniqueness of the candidate daily record key.
Candidate key: Date + SKU_ID + Warehouse_ID.
*/

USE SupplyChainBI;
GO

SELECT
    [Date],
    SKU_ID,
    Warehouse_ID,

    COUNT_BIG(*) AS DuplicateRecordCount

FROM dbo.SupplyChain_Staging

GROUP BY
    [Date],
    SKU_ID,
    Warehouse_ID

HAVING COUNT_BIG(*) > 1

ORDER BY
    DuplicateRecordCount DESC,
    [Date],
    SKU_ID,
    Warehouse_ID;
GO