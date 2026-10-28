/*
Project: Supply Chain & Inventory Intelligence
Script: 11_identifier_coverage
Purpose: Count distinct business identifiers.
*/

USE SupplyChainBI;
GO

SELECT
    COUNT_BIG(*) AS TotalRecords,
    COUNT(DISTINCT SKU_ID) AS DistinctSKUs,
    COUNT(DISTINCT Warehouse_ID) AS DistinctWarehouses,
    COUNT(DISTINCT Supplier_ID) AS DistinctSuppliers,
    COUNT(DISTINCT Region) AS DistinctRegions
FROM dbo.SupplyChain_Staging;
GO