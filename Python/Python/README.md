
# Supply Chain & Inventory Intelligence — Python Data Science

## 1. Project Overview

This project applies data science, statistical analysis and machine learning techniques to a supply chain and inventory dataset.

The objective is to investigate operational patterns, examine relationships between supply chain variables, evaluate existing demand forecasts, and develop predictive models for next-day sales.

The Python component extends the wider Supply Chain & Inventory Intelligence project, which also includes SQL analysis and Power BI reporting.

The analysis follows a structured workflow:

1. Data understanding and quality assessment.
2. Exploratory data analysis (EDA).
3. Statistical analysis and hypothesis testing.
4. Feature engineering and predictive modelling.
5. Model evaluation and interpretation.

## 2. Business Problem

Effective inventory and supply chain management requires an understanding of demand patterns and the relationship between sales, inventory and replenishment activity.

This project investigates questions such as:

- What patterns and distributions are present in daily sales and inventory data?
- How accurately does the supplied demand forecast reflect actual sales?
- Are there observable differences in sales associated with promotion status?
- Is beginning inventory associated with daily sales?
- What relationships can be identified between supplier lead times and operational outcomes?
- Can historical sales and other available information help predict next-day sales?
- How do statistical and machine learning approaches compare with simple forecasting benchmarks?

The findings are intended to support evidence-based operational analysis. They should not be interpreted as proof of causation or as a production-ready inventory management system.

## 3. Dataset Description

The analysis uses `supply_chain_dataset1.csv`.

| Attribute | Description |
|---|---|
| Observations | 91,250 |
| Variables | 15 |
| Date range | 1 January 2024 – 30 December 2024 |
| Unique SKUs | 50 |
| Warehouses | 5 |
| Suppliers | 10 |
| Regions | 4 |
| SKU–Warehouse groups | 250 |

The dataset contains daily supply chain observations, including:

- Date
- SKU_ID
- Warehouse_ID
- Supplier_ID
- Region
- Units_Sold
- Inventory_Level
- Supplier_Lead_Time_Days
- Reorder_Point
- Order_Quantity
- Unit_Cost
- Unit_Price
- Promotion_Flag
- Stockout_Flag
- Demand_Forecast

The original CSV is retained as the source dataset. Analytical transformations and engineered features are created within the Python workflow.

## 4. Python Notebook Workflow

### Notebook 01 — Data Understanding

**File:** `notebooks/01_Data_Understanding_Supply_Chain.ipynb`

This notebook establishes an understanding of the dataset before conducting deeper analysis.

Key activities include:

- Loading and inspecting the dataset.
- Examining dimensions, column names and data types.
- Reviewing descriptive statistics.
- Checking missing values and duplicate records.
- Examining categorical variables and numerical ranges.
- Assessing date coverage and SKU–Warehouse group structure.
- Investigating data-quality concerns and documenting assumptions.

### Notebook 02 — Exploratory Data Analysis

**File:** `notebooks/02_Exploratory_Data_Analysis_Supply_Chain.ipynb`

This notebook explores the operational characteristics and relationships within the dataset.

Key areas include:

- Daily sales and demand distributions.
- Inventory levels and replenishment patterns.
- Supplier and warehouse comparisons.
- Demand forecast error analysis.
- Forecast performance across SKUs, suppliers, warehouses, regions and months.
- Sales patterns by promotion status.
- Correlation analysis and visual exploration.

The supplied demand forecast was evaluated using measures including:

- Mean Absolute Error (MAE).
- Root Mean Squared Error (RMSE).
- Mean Forecast Error (MFE).
- Relative Mean Absolute Error.

### Notebook 03 — Statistical Analysis

**File:** `notebooks/03_Statistical_Analysis_Supply_Chain.ipynb`

This notebook investigates selected operational relationships using statistical methods.

The research questions include:

1. **Promotion status and daily sales:** Examining the association between promotion status and daily sales using descriptive comparisons and regression models with fixed effects and clustered standard errors.

2. **Beginning inventory and daily sales:** Investigating whether the previous day's inventory level is associated with subsequent daily sales.

3. **Supplier lead time and operational outcomes:** Examining differences and relationships involving supplier lead times, inventory, order quantities and average daily sales.

Methods include:

- Descriptive statistics.
- Pearson and Spearman correlation.
- ANOVA and Welch's ANOVA.
- Kruskal–Wallis testing.
- Regression analysis.
- Heteroskedasticity-robust and clustered standard errors.
- Model and residual diagnostics.

The analysis distinguishes statistical association from causation and documents relevant limitations.

### Notebook 04 — Predictive Modeling

**File:** `notebooks/04_Predictive_Modeling_Supply_Chain.ipynb`

This notebook develops and evaluates models for one-step-ahead daily sales prediction.

Key activities include:

- Chronological training, validation and test splitting.
- Time-series feature engineering.
- Creation of lagged sales and rolling mean features.
- Calendar feature engineering.
- Categorical encoding and numerical preprocessing.
- Baseline forecasting.
- Linear Regression modelling.
- Random Forest Regression modelling.
- Validation and independent test evaluation.
- Feature importance and permutation importance.
- Final model diagnostics and interpretation.

The target variable is next-day units sold.

The chronological split ensures that training, validation and testing observations are separated by target date rather than randomly distributed.

## 5. Predictive Modelling Results

Three approaches were compared on the independent test set.

| Model | MAE | RMSE | R² |
|---|---:|---:|---:|
| Seven-Day Rolling Mean | 4.5063 | 5.6986 | 0.0359 |
| Linear Regression | 7.6764 | 9.1014 | -1.4592 |
| Random Forest | 5.8751 | 7.2974 | -0.5810 |

### Interpretation

The seven-day rolling mean achieved the lowest test MAE and RMSE among the three approaches evaluated.

The Linear Regression and Random Forest models did not outperform this benchmark on the independent test set.

The results demonstrate why predictive models must be assessed against appropriate baseline methods and evaluated on data that was not used for model selection.

The seven-day rolling mean was therefore the strongest approach among the methods tested in this experiment. This does not establish that it is optimal for every SKU, warehouse or future operating period.

## 6. Important Findings and Data Limitations

The analysis identified several important considerations:

- The dataset contains a complete daily observation structure for 250 SKU–Warehouse groups, with 365 observations per group.
- The supplied demand forecast has an overall MAE of approximately 2.38 units and RMSE of approximately 2.99 units.
- Promotion observations had higher average daily sales than non-promotion observations. This is an observational association, not proof that promotions caused the difference.
- Beginning inventory showed a very small pooled correlation with daily sales, while the adjusted fixed-effects analysis did not find statistically significant evidence of an association.
- The statistical analysis did not find statistically significant evidence of relationships between supplier lead time and the operational outcomes examined.
- The target sales distribution changed substantially over the chronological modelling partitions. Average daily sales declined from approximately 22.73 units in training to 10.45 in validation, before recovering to approximately 15.96 in testing.
- This change in demand levels affected predictive model performance and highlights the importance of temporal validation.

### Data and modelling limitations

- The dataset covers approximately one year, which is insufficient to establish recurring annual seasonality.
- The cause of the observed demand-level changes is unknown.
- `Stockout_Flag` contains only zero values in the supplied CSV. It therefore cannot support meaningful stockout classification or variation-based analysis.
- The meaning and timing of certain operational variables are not fully documented.
- The supplied demand forecast's original methodology and forecast horizon are unknown.
- The predictive experiment evaluates one-step-ahead daily sales using historical information available at the forecast origin.
- The findings may not generalise to unseen SKUs, warehouses, suppliers or future periods.

These limitations are considered when interpreting results and making recommendations.

## 7. Technologies and Libraries

The Python component uses:

- Python
- Google Colab
- Pandas
- NumPy
- Matplotlib
- Seaborn
- SciPy
- Statsmodels
- Scikit-learn

The broader project also uses SQL Server and Microsoft Power BI.

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
├── SQL/
│
├── PowerBI/
│
└── README.md
```

## 9. Reproducibility

The notebooks were developed using Google Colab.

To reproduce the analysis:

1. Download or clone this repository.
2. Open the required notebook in Google Colab.
3. Upload `supply_chain_dataset1.csv` when prompted by the notebook.
4. Execute the notebook cells in their documented order.
5. Review the outputs, visualisations and Markdown interpretations.

The original dataset is not assumed to be included in the public repository. Users must obtain and upload the CSV separately.

## 10. Conclusion

This project demonstrates an end-to-end analytical workflow covering data understanding, exploratory analysis, statistical investigation and predictive modelling.

It combines statistical reasoning with practical machine learning evaluation and operational interpretation.

An important outcome is that more complex models did not necessarily produce better forecasts than a simple rolling-mean benchmark on the independent test data.

The project emphasises data quality, chronological validation, transparent assumptions, appropriate model evaluation and evidence-based conclusions.

---

**Project:** Supply Chain & Inventory Intelligence  
**Python component:** Data Science and Predictive Analytics  
**Author:** Nceba Matu

