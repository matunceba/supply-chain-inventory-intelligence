###### **Data Preparation and Validation**



**1. Project Context**



This document describes the data preparation and validation workflow for the Supply Chain \& Inventory Intelligence portfolio project.



The dataset was prepared for analysis using Excel/Power Query and SQL Server, with Power BI used for reporting.



**2. Source Data Profile**



* **Records:** 91,250
* **Columns:** 15
* **Date coverage**:1 January 2024 to 30 December 2024
* **SKUs**:50
* **Warehouses**:5
* **Suppliers**: 10
* **Regions**:4



The original CSV file was preserved separately from the working data.



**3. Preparation Workflow**



1\. Inspected the dataset structure, column names and data types.

2\. Reviewed categorical values and created a data dictionary.

3\. Checked for nulls, blanks and errors during the Power Query preparation stage.

4\. Resolved decimal-comma conversion issues affecting numeric fields.

5\. Prepared the data for SQL Server import.

6\. Loaded the data into the `SupplyChainBI` database, in the `dbo.SupplyChain\_Staging` table.

7\. Converted columns to appropriate SQL data types, including dates, numeric measures, identifiers and indicator fields.

8\. Confirmed that the SQL staging table contained 91,250 records.

9\. Connected Power BI Desktop to SQL Server and created measures and visual reports.



**4. Validation Checks**



The workflow included checks of:



* Record counts and column structure.
* Data types and numeric conversion.
* Nulls, blanks and data errors in Power Query.
* Categorical values and indicator fields.
* The consistency of the imported record count.
* Duplicate combinations of Date, SKU\_ID and Warehouse\_ID.



The combination of Date, SKU\_ID and Warehouse\_ID had zero duplicate combinations in the completed SQL check.



**5. Analytical Definitions and Cautions**



**Records below reorder point**



A record is counted when `Inventory\_Level` is less than `Reorder\_Point`.



This identifies potential replenishment exceptions. It does not, by itself, establish that an item was out of stock or that an order should immediately have been placed.



**Demand forecast accuracy**



Weighted Absolute Percentage Error (WAPE) is calculated as:



Sum of absolute differences between actual recorded units sold and forecast units, divided by total actual recorded units sold.



The result is expressed as a percentage. It should be interpreted in the context of the dataset's undocumented forecast horizon and business definitions.



**Promotion analysis**



Differences in average recorded units sold between promotion and non-promotion records are descriptive associations. They do not establish that promotions caused changes in sales.



**6. Limitations**



* The dataset's original source and redistribution permissions have not been confirmed.
* The currency and detailed business definitions are undocumented.
* The forecast horizon and forecasting methodology are unknown.
* Repeated inventory observations should not be summed and treated as current stock.
* Recorded data may not capture all operational factors affecting replenishment decisions.



**7. Tools Used**



* Excel and Power Query
* SQL Server Management Studio (SSMS)
* Microsoft SQL Server
* Power BI Desktop and DAX



**This is a self-directed portfolio project using a supply-chain dataset.**

