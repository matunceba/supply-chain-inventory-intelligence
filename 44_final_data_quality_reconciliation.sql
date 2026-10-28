/*
Project: Supply Chain & Inventory Intelligence
Script: 44_final_data_quality_reconciliation
Purpose: Final staging-table reconciliation and data-quality checks.
Expected row count: 91,250
Candidate key: Date + SKU_ID + Warehouse_ID.
*/

USE SupplyChainBI;
GO

-- Check 1: Total row count
SELECT
    'Row Count' AS CheckName,
    COUNT_BIG(*) AS ObservedValue,
    CAST(91250 AS bigint) AS ExpectedValue,
    CASE
        WHEN COUNT_BIG(*) = 91250 THEN 'PASS'
        ELSE 'INVESTIGATE'
    END AS CheckStatus
FROM dbo.SupplyChain_Staging;


-- Check 2: Duplicate candidate keys
SELECT
    'Duplicate Candidate Keys' AS CheckName,
    COUNT_BIG(*) AS ObservedValue,
    CAST(0 AS bigint) AS ExpectedValue,
    CASE
        WHEN COUNT_BIG(*) = 0 THEN 'PASS'
        ELSE 'INVESTIGATE'
    END AS CheckStatus
FROM
(
    SELECT
        [Date],
        SKU_ID,
        Warehouse_ID
    FROM dbo.SupplyChain_Staging
    GROUP BY
        [Date],
        SKU_ID,
        Warehouse_ID
    HAVING COUNT_BIG(*) > 1
) AS DuplicateKeys;


-- Check 3: NULL values in key