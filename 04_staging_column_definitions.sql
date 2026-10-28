USE SupplyChainBI;
GO

-- Inspect the staging table's column definitions.
SELECT
    c.column_id AS ColumnOrder,
    c.name AS ColumnName,
    ty.name AS DataType,
    c.max_length AS MaxLengthBytes,
    c.precision AS NumericPrecision,
    c.scale AS NumericScale,
    c.is_nullable AS IsNullable
FROM sys.columns AS c
INNER JOIN sys.types AS ty
    ON c.user_type_id = ty.user_type_id
WHERE c.object_id = OBJECT_ID('dbo.SupplyChain_Staging')
ORDER BY c.column_id;
GO