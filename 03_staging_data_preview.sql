USE SupplyChainBI;
GO

-- Preview a small sample of the validated staging data.
SELECT TOP (10)
    [Date],
    SKU_ID,
    Warehouse_ID,
    Supplier_ID,
    Units_Sold,
    Inventory_Level,
    Reorder_Point,
    Demand_Forecast
FROM dbo.SupplyChain_Staging
ORDER BY [Date], SKU_ID, Warehouse_ID;
GO