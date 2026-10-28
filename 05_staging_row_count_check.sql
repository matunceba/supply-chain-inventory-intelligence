USE SupplyChainBI;
GO

-- Confirm the staging table record count.
SELECT
    COUNT_BIG(*) AS TotalRecords
FROM dbo.SupplyChain_Staging;
GO