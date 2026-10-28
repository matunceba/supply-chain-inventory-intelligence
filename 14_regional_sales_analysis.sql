/*
Project: Supply Chain & Inventory Intelligence
Script: 14_regional_sales_analysis
Purpose: Compare recorded sales, inventory and forecast metrics by region.
*/

USE SupplyChainBI;
GO

SELECT
    Region,
    COUNT_BIG(*) AS RecordCount,
    COUNT(DISTINCT SKU_ID) AS DistinctSKUs,
    COUNT(DISTINCT Warehouse_ID) AS DistinctWarehouses,

    SUM(Units_Sold) AS TotalRecordedUnitsSold,

    AVG(CAST(Units_Sold AS decimal(18,4))) AS AverageUnitsSold,

    AVG(CAST(Inventory_Level AS decimal(18,4))) AS AverageInventoryLevel,

    AVG(CAST(Unit_Cost AS decimal(18,4))) AS AverageUnitCost,

    AVG(CAST(Unit_Price AS decimal(18,4))) AS AverageUnitPrice,

    SUM(Demand_Forecast) AS TotalForecastDemand

FROM dbo.SupplyChain_Staging
GROUP BY Region
ORDER BY TotalRecordedUnitsSold DESC;
GO
