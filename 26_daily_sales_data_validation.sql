/*
Project: Supply Chain & Inventory Intelligence
Script: 26_daily_sales_data_validation
Purpose: Identify date gaps within each SKU and warehouse.
Caution: A gap is not automatically a data-quality error.
*/

USE SupplyChainBI;
GO

WITH DailySequence AS
(
    SELECT
        SKU_ID,
        Warehouse_ID,
        [Date],

        LAG([Date]) OVER
        (
            PARTITION BY SKU_ID, Warehouse_ID
            ORDER BY [Date]
        ) AS PreviousDate

    FROM dbo.SupplyChain_Staging
)
SELECT
    SKU_ID,
    Warehouse_ID,
    PreviousDate,
    [Date] AS CurrentDate,

    DATEDIFF(DAY, PreviousDate, [Date]) AS DaysBetweenRecords

FROM DailySequence

WHERE
    PreviousDate IS NOT NULL
    AND DATEDIFF(DAY, PreviousDate, [Date]) > 1

ORDER BY
    SKU_ID,
    Warehouse_ID,
    [Date];
GO