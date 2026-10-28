/*
Project: Supply Chain & Inventory Intelligence
Script: 21_supplier_lead_time_analysis
Purpose: Compare recorded supplier lead-time values.
Caution: Rows are not confirmed to represent individual
purchase orders or deliveries. Do not infer reliability.
*/

USE SupplyChainBI;
GO

SELECT
    Supplier_ID,

    COUNT_BIG(*) AS RecordCount,

    COUNT(DISTINCT SKU_ID) AS DistinctSKUs,

    MIN(Supplier_Lead_Time_Days) AS MinimumLeadTimeDays,

    CAST(
        AVG(CAST(Supplier_Lead_Time_Days AS decimal(18,4)))
        AS decimal(10,2)
    ) AS AverageLeadTimeDays,

    MAX(Supplier_Lead_Time_Days) AS MaximumLeadTimeDays,

    COUNT(
        DISTINCT Supplier_Lead_Time_Days
    ) AS DistinctLeadTimeValues

FROM dbo.SupplyChain_Staging

GROUP BY Supplier_ID

ORDER BY AverageLeadTimeDays DESC;
GO