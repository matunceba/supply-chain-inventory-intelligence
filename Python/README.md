
# Python Data Science — Supply Chain & Inventory Intelligence

## Overview

This component applies Python-based data science methods to daily supply chain and inventory data.

It covers data understanding, exploratory data analysis, statistical investigation and predictive modelling.

The objective is to investigate operational patterns, evaluate supplied demand forecasts and assess whether historical information can improve next-day sales predictions.

## Dataset

The analysis uses `supply_chain_dataset1.csv`.

- 91,250 observations
- 15 variables
- 50 SKUs
- 5 warehouses
- 10 suppliers
- 4 regions
- 250 SKU–Warehouse groups
- Date coverage: 1 January to 30 December 2024

The original CSV is not included in this repository. Its provenance and redistribution permissions have not been confirmed.

## Notebook Sequence

### 01 — Data Understanding

`notebooks/01_Data_Understanding_Supply_Chain.ipynb`

Examines dataset structure, data types, descriptive statistics, missing values, duplicates, numerical ranges, date continuity and data-quality limitations.

### 02 — Exploratory Data Analysis

`notebooks/02_Exploratory_Data_Analysis_Supply_Chain.ipynb`

Investigates sales, demand, inventory, replenishment patterns, forecast errors, supplier and warehouse comparisons, and descriptive relationships.

### 03 — Statistical Analysis

`notebooks/03_Statistical_Analysis_Supply_Chain.ipynb`

Investigates selected relationships involving promotion status, beginning inventory, daily sales and supplier lead times.

Methods include correlation analysis, hypothesis testing, regression, fixed effects, clustered standard errors and diagnostics.

### 04 — Predictive Modeling

`notebooks/04_Predictive_Modeling_Supply_Chain.ipynb`

Develops one-step-ahead daily sales predictions using lagged sales, rolling means and calendar features.

Models evaluated:

- Seven-Day Rolling Mean benchmark
- Linear Regression
- Random Forest Regression

Chronological training, validation and independent test partitions were used.

## Predictive Model Results

Independent test-set results:

| Model | MAE | RMSE | R² |
|---|---:|---:|---:|
| Seven-Day Rolling Mean | 4.5063 | 5.6986 | 0.0359 |
| Linear Regression | 7.6764 | 9.1014 | -1.4592 |
| Random Forest | 5.8751 | 7.2974 | -0.5810 |

The Seven-Day Rolling Mean achieved the lowest test MAE and RMSE among the evaluated approaches.

The more complex machine learning models did not outperform this benchmark on the independent test set.

## Technologies

- Python
- Google Colab
- Pandas
- NumPy
- Matplotlib
- Seaborn
- SciPy
- Statsmodels
- Scikit-learn

## Reproducing the Analysis

1. Open a notebook in Google Colab.
2. Obtain `supply_chain_dataset1.csv` separately.
3. Upload the CSV when requested.
4. Execute the cells in order.
5. Review the documented methods, results and limitations.

## Limitations

- The dataset covers approximately one year.
- The cause of observed demand-level changes is unknown.
- `Stockout_Flag` is constant at zero in the supplied CSV.
- The original demand forecasting methodology is undocumented.
- Statistical associations do not establish causation.
- Predictive performance may change across future periods and operational groups.

## Conclusion

The four notebooks demonstrate a structured data science workflow, combining data quality assessment, exploratory analysis, statistical reasoning and predictive modelling.

The results emphasise the importance of sound validation, transparent assumptions and comparison against simple benchmarks.

**Project:** Supply Chain & Inventory Intelligence  
**Author:** Nceba Matu
