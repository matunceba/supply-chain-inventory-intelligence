/*
Project: Supply Chain & Inventory Intelligence
Script: 10_flag_value_validation
Purpose: Inspect distinct flag values and their record counts.
*/

USE SupplyChainBI;
GO

SELECT
    'Promotion_Flag' AS FlagName,
    CAST(Promotion_Flag AS varchar(20)) AS FlagValue,
    COUNT_BIG(*) AS RecordCount
FROM dbo.SupplyChain_Staging
GROUP BY Promotion_Flag

UNION ALL

SELECT
    'Stockout_Flag' AS FlagName,
    CAST(Stockout_Flag AS varchar(20)) AS FlagValue,
    COUNT_BIG(*) AS RecordCount
FROM dbo.SupplyChain_Staging
GROUP BY Stockout_Flag

ORDER BY FlagName, FlagValue;
GO