/*
Project: Supply Chain & Inventory Intelligence
Script: 09_staging_date_validation
Purpose: Check the date coverage of the staging dataset.
*/

USE SupplyChainBI;
GO

SELECT
    MIN([Date]) AS EarliestDate,
    MAX([Date]) AS LatestDate,
    COUNT_BIG(*) AS TotalRecords,
    COUNT(DISTINCT [Date]) AS DistinctDates,
    SUM(CASE WHEN [Date] IS NULL
             THEN 1 ELSE 0 END) AS MissingDates
FROM dbo.SupplyChain_Staging;
GO