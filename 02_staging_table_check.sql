USE SupplyChainBI;
GO

-- Confirm that the staging table exists.
SELECT
    s.name AS SchemaName,
    t.name AS TableName
FROM sys.tables AS t
INNER JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
WHERE s.name = 'dbo'
  AND t.name = 'SupplyChain_Staging';
GO