###### **Supply Chain Dataset — Data Dictionary**



**1. Dataset Overview**



* **Dataset name:** supply\_chain\_dataset1.csv`
* **Number of records:**91,250
* **Number of columns**:15
* **Date coverage:** 1 January 2024 to 30 December 2024
* **SKUs**:50
* **Warehouses**: 5
* **Suppliers**:10
* **Regions:** 4



**2. Column Reference**



|**Column**|<br />**Description**|
|-|-|
|Date|Date associated with the recorded supply-chain observation.|
|SKU\_ID|Identifier for a stock-keeping unit (SKU).|
|Warehouse\_ID|Identifier for the warehouse associated with the record.|
|Region|Region associated with the record.|
|Inventory\_Level|Recorded inventory level.|
|Units\_Sold|Recorded units sold.|
|Unit\_Cost|Recorded unit cost.|
|Unit\_Price|Recorded unit selling price.|
|Supplier\_ID|Identifier for the supplier.|
|Supplier\_Lead\_Time\_Days|Recorded supplier lead time in days|
|Demand\_Forecast|Recorded demand forecast.|
|Reorder\_Point|Recorded inventory reorder threshold.|
|Order\_Quantity|Recorded order quantity.|
|Promotion\_Flag|Indicator for promotion status.|
|Stockout\_Flag|Indicator for stockout status.|



**3. Interpretation Notes**



* Descriptions reflect the column names and apparent meaning of the fields. They have not been independently confirmed against an official dataset specification.
* The exact business definitions, currency, forecast horizon and source of the dataset were not documented in the supplied materials.
* `Promotion\_Flag` and `Stockout\_Flag` should be interpreted according to their recorded values; the precise coding definitions should be confirmed where possible.
* A record below its reorder point is a potential replenishment exception, not proof that a stockout occurred.
* Inventory levels recorded repeatedly over time should not be summed and interpreted as current physical stock without further validation.



**4. Data Use**



This dictionary supports the SQL Server analysis and Power BI reporting developed for the Supply Chain \& Inventory Intelligence portfolio project.





