# Supply Chain & Inventory Intelligence

**A self-directed data analytics portfolio project using SQL Server and Power BI**

## Project Overview

This project analyses supply-chain data to explore recorded sales, inventory levels, replenishment exceptions, supplier lead times and demand forecast accuracy.

The objective is to demonstrate how SQL-based analysis and interactive Power BI reporting can help stakeholders investigate inventory risks and support data-informed replenishment decisions.

## Business Questions

- How do recorded sales change over time and across regions?
- How often is recorded inventory below the reorder point?
- Which warehouses and SKUs have the most records below their reorder points?
- How do recorded sales compare with demand forecasts?
- How do recorded sales differ between promotion and non-promotion records?
- How do recorded supplier lead times compare across suppliers?

## Dataset Overview

| Attribute | Value |
|---|---|
| Records | 91,250 |
| Columns | 15 |
| Date coverage | 1 January–30 December 2024 |
| SKUs | 50 |
| Warehouses | 5 |
| Suppliers | 10 |
| Regions | 4 |

The source dataset's original provenance and redistribution permissions have not been confirmed. The raw dataset is therefore not included in this repository.

## Tools and Technologies

- **SQL Server and SQL Server Management Studio (SSMS):** Data validation, aggregation, trend analysis, inventory exception analysis and reporting metrics.
- **Power BI Desktop:** Interactive report development and visual analysis.
- **DAX:** Measures for sales, inventory and forecast accuracy.
- **Excel and Power Query:** Data inspection, preparation, type conversion and validation.

## Project Workflow

1. Inspected the source structure, columns and data types.
2. Prepared and validated data using Excel/Power Query.
3. Imported 91,250 records into SQL Server.
4. Developed 45 SQL analysis scripts.
5. Created DAX measures and a date table in Power BI.
6. Built report pages for executive overview, inventory exceptions, warehouse/SKU analysis, supplier lead times and sales-versus-forecast comparisons.
7. Documented the data definitions, workflow and analytical limitations.

## Selected Findings

- **4,787 records (5.25%)** had inventory levels below their recorded reorder points.
- **Overall WAPE:** approximately 12%, based on the recorded units sold and demand forecast in the dataset.
- Average recorded units sold were approximately **24.91** for promotion records and **19.50** for non-promotion records.

These are descriptive findings from the dataset. A record below reorder point is a potential replenishment exception, not proof of a stockout. The difference between promotion and non-promotion records does not establish that promotions caused higher sales.

## Power BI Report

The report contains two pages:

### Executive Overview
- Total recorded units sold
- Total records
- Average inventory level
- Overall forecast WAPE
- Monthly recorded sales trends
- Regional sales comparisons
- Records below reorder point by region
- Promotion and non-promotion comparisons
- Recorded sales versus demand forecast

### Inventory & Replenishment
- Records below reorder point by warehouse
- Top 10 SKUs by records below reorder point
- Average supplier lead time by supplier

## Repository Structure

- `README.md` — Project overview, analytical findings, methodology and limitations.
- `SQL` analysis scripts — 45 scripts covering data validation, aggregation, trend analysis, inventory exceptions and reporting metrics.
- `Supply_Chain_Inventory_Intelligence.pbix` — Interactive Power BI report.
- `Documentation/` — Data dictionary and data preparation and validation documentation.

## Documentation

- [Data Dictionary](Documentation/Data_Dictionary.md)
- [Data Preparation and Validation](Documentation/Data_Preparation_and_Validation.md)

## Limitations

- The original dataset source, currency and detailed business definitions are undocumented.
- The forecast horizon and forecasting method are unknown.
- Inventory levels repeated across dates should not be summed and interpreted as current stock.
- Supplier lead time alone does not establish supplier performance.
- Replenishment decisions would require additional context, such as demand variability, safety stock, service-level targets, order constraints and confirmed inventory policies.

## Potential Next Steps

- Add a replenishment prioritisation model using documented business rules.
- Evaluate forecast errors by SKU, warehouse and time period.
- Incorporate lead-time variability and safety-stock requirements if suitable data becomes available.
- Extend the dashboard with clearly defined service-level and inventory-risk metrics.

## Skills Demonstrated

SQL querying, data validation, data preparation, analytical reasoning, inventory exception analysis, demand forecast evaluation, DAX measures, Power BI visualisation and technical documentation.
