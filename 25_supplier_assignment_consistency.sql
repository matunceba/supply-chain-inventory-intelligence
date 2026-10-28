/*
Project: Supply Chain & Inventory Intelligence
Script: 25_supplier_assignment_consistency
Purpose: Check supplier variation within each SKU and warehouse.
Caution: Multiple suppliers may be valid; variation is not
automatically a data-quality error.
*/

USE SupplyChainBI;
GO

SELECT
    SKU_ID,
    Warehouse_ID,

    COUNT_BIG(*) AS RecordCount,

    COUNT(DISTINCT Supplier_ID) AS DistinctSupplierCount,

    MIN(Supplier_ID) AS FirstSupplierID,

    MAX(Supplier_ID) AS LastSupplierID

FROM dbo.SupplyChain_Staging

GROUP BY
    SKU_ID,
    Warehouse_ID

HAVING
    COUNT(DISTINCT Supplier_ID) > 1

ORDER BY
    DistinctSupplierCount DESC,
    SKU_ID,
    Warehouse_ID;
GO