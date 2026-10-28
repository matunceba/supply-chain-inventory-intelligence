/*
Project: Supply Chain & Inventory Intelligence
Script: 13_monthly_sales_trends
Purpose: Compare monthly recorded sales with demand forecasts.
*/

USE SupplyChainBI;
GO

SELECT
    YEAR([Date]) AS SalesYear,
    MONTH([Date]) AS SalesMonth,
    COUNT_BIG(*) AS RecordCount,

    SUM(Units_Sold) AS TotalRecordedUnitsSold,

    AVG(CAST(Units_Sold AS decimal(18,4))) AS AverageUnitsSold,

    SUM(Demand_Forecast) AS TotalForecastDemand,

    AVG(CAST(Demand_Forecast AS decimal(18,4))) AS AverageForecastDemand

FROM dbo.SupplyChain_Staging
GROUP BY
    YEAR([Date]),
    MONTH([Date])
ORDER BY
    SalesYear,
    SalesMonth;
GO
