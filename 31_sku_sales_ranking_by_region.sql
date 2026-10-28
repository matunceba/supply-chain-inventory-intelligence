/*
Project: Supply Chain & Inventory Intelligence
Script: 30_sku_sales_performance
Purpose: Compare recorded sales and forecast performance by SKU.
Caution: Rankings describe this dataset and period only.
*/

USE SupplyChainBI;
GO

SELECT
    SKU_ID,

    COUNT_BIG(*) AS RecordCount,

    SUM(Units_Sold) AS TotalRecordedUnitsSold,

    CAST(
        AVG(CAST(Units_Sold AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageUnitsSold,

    CAST(
        AVG(CAST(Inventory_Level AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageInventoryLevel,

    CAST(
        AVG(CAST(Reorder_Point AS decimal(18,4)))
        AS decimal(12,2)
    ) AS AverageReorderPoint,

    CAST(
        AVG(
            CAST(Units_Sold AS decimal(18,4))
            - CAST(Demand_Forecast AS decimal(18,4))
        )
        AS decimal(12,4)
    ) AS AverageForecastError,

    CAST(
        100.0 * SUM(
            ABS(
                CAST(Units_Sold AS decimal(18,4))
                - CAST(Demand_Forecast AS decimal(18,4))
            )
        ) / NULLIF(SUM(Units_Sold), 0)
        AS decimal(10,2)
    ) AS WAPE_Percentage

FROM dbo.SupplyChain_Staging

GROUP BY SKU_ID

ORDER BY TotalRecordedUnitsSold DESC;
GO
