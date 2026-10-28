/*
Project: Supply Chain & Inventory Intelligence
Script: 43_supplier_sku_performance
Purpose: Compare recorded lead times and sales by supplier.
Caution: Rows are not confirmed purchase orders or deliveries.
Sales are associated with supplier records, not proven supplier impact.
*/

USE SupplyChainBI;
GO

SELECT
    Supplier_ID,

    COUNT_BIG(*) AS RecordCount,

    COUNT(DISTINCT SKU_ID) AS DistinctSKUs,

    CAST(
        AVG(CAST(Supplier_Lead_Time_Days AS decimal(18,4)))
        AS decimal(10,2)
    ) AS AverageRecordedLeadTimeDays,

    MIN(Supplier_Lead_Time_Days) AS MinimumRecordedLeadTimeDays,

    MAX(Supplier_Lead_Time_Days) AS MaximumRecordedLeadTimeDays,

    SUM(Units_Sold) AS TotalRecordedUnitsSold,

    CAST(
        AVG(CAST(Units_Sold AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageUnitsSoldPerRecord,

    CAST(
        AVG(CAST(Inventory_Level AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageInventoryLevel

FROM dbo.SupplyChain_Staging

GROUP BY Supplier_ID

ORDER BY
    AverageRecordedLeadTimeDays DESC,
    Supplier_ID;
GO