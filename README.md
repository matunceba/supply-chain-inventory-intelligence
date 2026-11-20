
# Supply Chain & Inventory Intelligence

**An end-to-end data analytics and data science portfolio project using SQL Server, Power BI and Python.**

## 1. Project Overview

This project investigates supply chain and inventory operations using a structured dataset containing daily sales, inventory, replenishment, supplier and demand forecast information.

It demonstrates an end-to-end analytical workflow, combining:

- Data preparation and quality assessment.
- SQL-based data validation and analysis.
- Exploratory data analysis.
- Statistical analysis and hypothesis testing.
- Predictive modelling and model evaluation.
- Power BI reporting and visualisation.
- Technical documentation and business interpretation.

The objective is to demonstrate how data analysis and statistical modelling can help identify operational patterns, evaluate demand forecasts and support evidence-based supply chain decisions.

## 2. Business Questions

The project investigates the following questions:

- How do recorded sales change over time and across regions?
- How frequently does recorded inventory fall below the reorder point?
- Which SKUs and warehouses have more records below their reorder points?
- How accurately does the supplied demand forecast reflect actual sales?
- How do recorded sales differ between promotion and non-promotion observations?
- What relationships can be identified between inventory, sales and supplier lead times?
- Can historical sales information help predict next-day demand?
- How do statistical and machine learning models compare with simple forecasting benchmarks?

## 3. Dataset Overview

The project uses `supply_chain_dataset1.csv`.

| Attribute | Value |
|---|---:|
| Records | 91,250 |
| Columns | 15 |
| Date coverage | 1 January – 30 December 2024 |
| SKUs | 50 |
| Warehouses | 5 |
| Suppliers | 10 |
| Regions | 4 |
| SKU–Warehouse groups | 250 |

The dataset contains daily operational information, including sales, inventory levels, reorder points, order quantities, supplier lead times, prices, promotion indicators and demand forecasts.

The original dataset's provenance and redistribution permissions have not been confirmed. The raw CSV is therefore not included in this public repository.

## 4. Project Components

### A. Data Preparation and SQL Analysis

SQL Server and SQL Server Management Studio were used to:

- Validate the imported dataset.
- Inspect table structures and data types.
- Check missing values, duplicates and numerical ranges.
- Validate dates, identifiers and flag columns.
- Analyse sales trends and inventory positions.
- Examine replenishment and reorder-point patterns.
- Compare recorded sales with supplied demand forecasts.
- Investigate supplier, SKU, warehouse and regional performance.

The SQL component contains 45 analysis scripts.

### B. Exploratory Data Analysis

Python was used to investigate:

- Sales and demand distributions.
- Inventory and replenishment patterns.
- Supplier and warehouse comparisons.
- Forecast errors across operational dimensions.
- Monthly sales and forecast performance.
- Differences between promotion and non-promotion observations.
- Correlations and other descriptive relationships.

### C. Statistical Analysis

Statistical methods were used to investigate selected operational relationships.

The analysis included:

- Descriptive statistics.
- Pearson and Spearman correlation.
- ANOVA, Welch's ANOVA and Kruskal–Wallis testing.
- Regression models with fixed effects.
- Heteroskedasticity-robust and clustered standard errors.
- Residual and model diagnostics.

One finding was that promotion observations had higher average daily sales than non-promotion observations. The adjusted regression estimated an association of approximately 5.40 additional units per observation. This is an observational result and does not establish that promotions caused higher sales.

The analysis did not find statistically significant evidence of an adjusted association between beginning inventory and daily sales, or of relationships between supplier lead time and the operational outcomes examined.

### D. Predictive Modelling

The Python predictive modelling component developed one-step-ahead daily sales predictions.

The workflow included:

- Lagged sales features.
- Rolling mean features.
- Calendar features.
- Chronological training, validation and test partitions.
- Categorical encoding and numerical preprocessing.
- Seven-day rolling mean benchmark.
- Linear Regression.
- Random Forest Regression.
- Validation and independent test evaluation.
- Feature importance and permutation importance.

The independent test results were:

| Model | MAE | RMSE | R² |
|---|---:|---:|---:|
| Seven-Day Rolling Mean | 4.5063 | 5.6986 | 0.0359 |
| Linear Regression | 7.6764 | 9.1014 | -1.4592 |
| Random Forest | 5.8751 | 7.2974 | -0.5810 |

The seven-day rolling mean outperformed both machine learning models on the independent test set.

This demonstrates the importance of comparing more complex models against simple benchmarks rather than assuming that machine learning will necessarily improve predictive performance.

### E. Power BI Reporting

Microsoft Power BI Desktop was used to develop an interactive report covering two main areas.

**Executive Overview**
- Total recorded units sold.
- Number of records.
- Average inventory level.
- Overall forecast WAPE.
- Monthly sales trends.
- Regional sales comparisons.
- Records below reorder point.
- Promotion and non-promotion comparisons.
- Recorded sales versus demand forecast.

**Inventory & Replenishment**
- Inventory records below reorder point by warehouse.
- SKUs with the highest number of records below reorder point.
- Average supplier lead time by supplier.

## 5. Selected Findings

The analysis produced the following descriptive and predictive findings:

- 4,787 records (5.25%) had inventory levels below their recorded reorder points.
- The supplied demand forecast had an overall MAE of approximately 2.38 units and RMSE of approximately 2.99 units.
- Average recorded sales were approximately 24.91 units for promotion observations and 19.50 units for non-promotion observations.
- The predictive modelling experiment found that the seven-day rolling mean was more accurate than the Linear Regression and Random Forest models on the independent test set.
- Average daily sales changed substantially across the chronological modelling partitions, declining from approximately 22.73 units in training to 10.45 in validation before recovering to approximately 15.96 in testing.

These findings describe the supplied dataset and should not automatically be interpreted as evidence of real-world operational causes.

## 6. Important Data and Modelling Limitations

- The original dataset source, currency and detailed business definitions are undocumented.
- The supplied forecast's original methodology and forecast horizon are unknown.
- `Stockout_Flag` contains only zero values in the supplied CSV, so it cannot support meaningful stockout classification or variation-based analysis.
- A record below reorder point represents a potential replenishment exception, not proof of a stockout.
- The dataset covers approximately one year, which is insufficient to establish recurring annual seasonality.
- Inventory levels repeated across dates should not be summed and interpreted as current stock.
- Supplier lead time alone does not establish supplier performance.
- The predictive models were evaluated using chronological partitions, and the observed demand-level changes affected model performance.
- The statistical findings are observational and do not establish causation.

Further operational conclusions would require additional information, including documented business definitions, inventory policies, safety-stock requirements, service-level targets and longer historical data.

## 7. Technologies and Tools

| Area | Technologies |
|---|---|
| Data preparation | Excel, Power Query |
| Database | SQL Server |
| SQL development | SQL Server Management Studio |
| Programming | Python |
| Data manipulation | Pandas, NumPy |
| Visualisation | Matplotlib, Seaborn, Power BI |
| Statistical analysis | SciPy, Statsmodels |
| Machine learning | Scikit-learn |
| Development environment | Google Colab |
| Version control | Git, GitHub |

## 8. Repository Structure

```text
supply-chain-inventory-intelligence/
│
├── Python/
│   ├── notebooks/
│   │   ├── 01_Data_Understanding_Supply_Chain.ipynb
│   │   ├── 02_Exploratory_Data_Analysis_Supply_Chain.ipynb
│   │   ├── 03_Statistical_Analysis_Supply_Chain.ipynb
│   │   └── 04_Predictive_Modeling_Supply_Chain.ipynb
│   │
│   └── README.md
│
├── SQL analysis scripts
├── Supply_Chain_Inventory_Intelligence.pbix
├── Data_Dictionary.md
├── Data_Preparation_and_Validation.md
└── README.md
```

## 9. Project Documentation

- [Python Data Science Documentation](Python/README.md)
- [Data Dictionary](Data_Dictionary.md)
- [Data Preparation and Validation](Data_Preparation_and_Validation.md)

### Python Notebooks

1. [01 — Data Understanding](Python/notebooks/01_Data_Understanding_Supply_Chain.ipynb)
2. [02 — Exploratory Data Analysis](Python/notebooks/02_Exploratory_Data_Analysis_Supply_Chain.ipynb)
3. [03 — Statistical Analysis](Python/notebooks/03_Statistical_Analysis_Supply_Chain.ipynb)
4. [04 — Predictive Modeling](Python/notebooks/04_Predictive_Modeling_Supply_Chain.ipynb)

## 10. Reproducibility

The Python notebooks were developed in Google Colab.

To reproduce the Python analysis:

1. Open the required notebook in Google Colab.
2. Obtain the original `supply_chain_dataset1.csv` separately.
3. Upload the CSV when prompted by the notebook.
4. Execute the notebook cells in their documented order.
5. Review the outputs, visualisations and Markdown interpretations.

The source dataset is not distributed in this repository because its original provenance and redistribution permissions have not been confirmed.

## 11. Skills Demonstrated

- Data cleaning and validation.
- SQL querying and analytical reporting.
- Exploratory data analysis.
- Statistical reasoning and hypothesis testing.
- Regression analysis and statistical diagnostics.
- Time-series feature engineering.
- Machine learning model development.
- Chronological model validation.
- Forecast evaluation and benchmarking.
- Data visualisation and Power BI reporting.
- Technical documentation.
- Business interpretation and communication of limitations.

## 12. Conclusion

This project demonstrates an integrated approach to supply chain analytics, moving from data preparation and validation through SQL analysis, statistical investigation, predictive modelling and interactive reporting.

An important lesson from the predictive modelling experiment is that a simple, well-chosen benchmark can outperform more complex machine learning models.

The project emphasises analytical discipline, data quality, appropriate statistical interpretation, transparent assumptions and independent model evaluation.

---

**Project:** Supply Chain & Inventory Intelligence  
**Author:** Nceba Matu  
**Focus:** Data Science, Statistical Analysis, Predictive Analytics and Supply Chain Intelligence

