# 🛒 DMart Retail Analytics | Pricing, Discounts & Retail Strategy

## 📌 Project Overview

This project explores product pricing, discounts, and retail-related data using a DMart-inspired dataset. It demonstrates an end-to-end Data Analytics workflow using Microsoft Excel, PostgreSQL/SQL, Python/Pandas, and Power BI.

The central business question is:

**“Why does DMart appear to offer so many discounts compared with other retail shops?”**

The project examines available product-price and discount patterns and combines these observations with publicly available information about DMart's pricing strategy.

**Important distinction:** The available dataset allows us to explore recorded product prices and discounts. It does not contain comparable competitor pricing data, so this project cannot statistically establish that DMart offers more discounts or lower prices than other retailers.

## 🎯 Business Objectives

- Analyze original prices and discounted prices.
- Calculate and compare recorded discount percentages.
- Explore pricing patterns across product categories and brands.
- Identify data-quality issues that may affect analytical results.
- Build Excel and Power BI dashboards to communicate findings.
- Use SQL to perform structured data exploration and analysis.
- Understand DMart's publicly documented pricing strategy.
- Distinguish data-supported findings from business explanations that require further evidence.

## ❓ Business Question: Why Does DMart Appear to Offer So Many Discounts?

### 1. What the dataset helps us investigate

The available product-pricing records allow us to examine:

- The difference between original and discounted prices.
- The distribution of recorded discount percentages.
- Variations in prices and discounts across product categories.
- Differences between branded and unbranded product records.
- Missing values, duplicate records, and potentially invalid prices.

These analyses help describe the pricing patterns present in the dataset. They do not independently explain the commercial reasons behind those patterns.

### 2. What DMart's published strategy tells us

DMart's parent company, Avenue Supermarts Limited, describes its approach as **Everyday Low Cost / Everyday Low Price (EDLC/EDLP)**.

According to the company's FY2024–25 reporting, this strategy focuses on providing everyday value by managing procurement and operating costs rather than depending only on limited-period promotions. The company also identifies supplier networks, product assortment, local sourcing, and supply-chain efficiencies as elements supporting its value-retailing approach.

**Business interpretation:** DMart's pricing strategy is not simply about displaying more discounts. Its stated approach is to deliver value through cost control and competitive everyday pricing.

This is a company-reported explanation of its business strategy, not a causal finding established by the project's product-level dataset.

**Reference:** [Avenue Supermarts Limited — Annual Report FY2024–25](https://api.dmartindia.com/corporate/content/file/v1/6/vLobSX3O9BXYtJt1WfpFGuYr1752926697/Annual%20Report%202024-25.pdf)

### 3. What we cannot conclude yet

The current dataset does not provide:

- Comparable prices and discounts from competing retailers.
- Historical prices to distinguish regular pricing from temporary promotions.
- Verified units sold or transaction-level revenue.
- Supplier purchase costs or product-level margins.
- Evidence establishing the reasons behind individual discounts.

Therefore, we cannot conclude from this dataset alone that DMart offers more discounts than competitors, that its final prices are always lower, or that a specific operational practice caused the observed discounts.

### 4. What would be needed for a competitor comparison?

A stronger follow-up analysis would use comparable products from DMart and other retailers, captured over the same period and normalized for pack size, brand, and product variant.

It could then compare:

- Regular and promotional selling prices.
- Discount percentages.
- Final price per standardized unit.
- The proportion of comparable products on promotion.
- Price differences by category and retailer.

This would help test whether the perception of more offers corresponds to measurable differences in pricing.

## 🗂️ Dataset Overview

The project uses DMart-inspired retail datasets covering the following areas:

| Dataset | Analytical purpose |
|---|---|
| `Sales_Transactions` | Product names, brands, original prices, discounted prices, quantity descriptions, and categories |
| `Customers` | Available customer-related attributes |
| `Inventories` | Available inventory and store-related records |
| `Payments` | Available payment-related records |
| `Stores` | Store attributes and identifiers |
| `Suppliers` | Supplier-related information |

The source sales/pricing dataset contains **5,189 records**.

### Data Limitations and Metric Interpretation

- The sales/pricing dataset contains product-level records rather than verified sales transactions.
- The available fields do not establish verified sales dates, actual units sold, or transaction-level revenue.
- The `Quantity` field contains package or unit descriptions in the available data; it should not automatically be interpreted as units sold.
- Metrics labelled **Total Sales** represent sums of available discounted-price values, not confirmed business revenue.
- Record counts may differ across tools because of cleaning, exclusions, and filters.
- Python's previously reported analysis contained 5,187 records after cleaning, compared with the 5,189 source records. The precise exclusions should be verified against a valid notebook before treating the results as fully reconciled.
- The customer, inventory, payment, store, and sales datasets have limited matching keys. Cross-table comparisons should only be interpreted where valid relationships exist.
- The original raw dataset is not currently available for a complete independent revalidation of every result.

## 🛠️ Tools and Technologies

| Tool | Application |
|---|---|
| Microsoft Excel | Data preparation, formulas, PivotTables, analysis, and dashboard |
| PostgreSQL | Data exploration, aggregation, filtering, joins, and analytical queries |
| Python / Pandas | Data cleaning and exploratory analysis; notebook awaiting valid-file restoration and verification |
| Power BI | DAX measures, data modelling, interactive visuals, and dashboards |
| GitHub | Project documentation, file organization, and portfolio presentation |

## 📊 Project Components

### 1. Microsoft Excel Analysis

**Workbook:** [`Excel/DMart_Retail_Analytics_Excel.xlsx`](Excel/DMart_Retail_Analytics_Excel.xlsx)

The workbook includes:

- `Raw_Data` — source records.
- `Data_Cleaning` — preparation and data-quality checks.
- `Analysis` — formula-based analysis.
- `Pivot_Analysis` — category and brand comparisons.
- `Dashboard` — consolidated visual summary.

**Analysis performed:**
- Price and discount calculations.
- Category-level and brand-level comparisons.
- PivotTable-based summaries.
- Dashboard creation and presentation.

**Excel dashboard preview:**

![DMart Retail Analytics Excel Dashboard](Excel/DMart-Retail-Analytics_Dashboard.png)

### 2. SQL Analysis — PostgreSQL

**SQL file:** [`SQL/DMart_Retail_Analytics.sql`](SQL/DMart_Retail_Analytics.sql)

The project SQL file contains 50 analytical queries covering data exploration, aggregation, pricing, discounts, and data-quality analysis.

**SQL concepts demonstrated:**

- `SELECT`, `WHERE`, `ORDER BY`, and `DISTINCT`
- Aggregate functions: `SUM`, `AVG`, `MIN`, and `MAX`
- `GROUP BY` and `HAVING`
- `CASE WHEN`
- Joins and subqueries
- Common Table Expressions (CTEs)
- Window functions and ranking
- Discount calculations
- Data-quality checks

The queries explore the available records. Price-based aggregations should not be interpreted as verified revenue, and data-quality results should be treated cautiously where the underlying validation logic has not been independently confirmed.

### 3. Python Analysis — Pandas

**Intended notebook:** [`Python/DMart_Retail_Analytics_Python.ipynb`](Python/DMart_Retail_Analytics_Python.ipynb)

The Python notebook is intended to document the Pandas workflow for data inspection, cleaning, descriptive analysis, and price and discount comparisons.

**Current status:** The uploaded notebook requires restoration and validation. It should not be treated as a verified project deliverable until a valid notebook containing the original work has been recovered and uploaded.

No Python results are presented here as independently verified final results.

### 4. Power BI Dashboard

**Report:** [`PowerBI/DMart-Retail-Analytics.pbix`](PowerBI/DMart-Retail-Analytics.pbix)

The report contains four dashboard pages.

#### Page 1 — Executive Overview

![Executive Overview](PowerBI/01_Executive_Overview.png)

Summarizes the available pricing records and selected analytical indicators.

#### Page 2 — Pricing and Discount Analysis

![Pricing and Discount Analysis](PowerBI/02_Pricing_Discount_Analysis.png)

Explores original prices, discounted prices, discount percentages, and category and brand comparisons.

#### Page 3 — Inventory and Store Analysis

![Inventory and Store Analysis](PowerBI/03_Inventory_Store_Analysis.png)

Examines available inventory and store information, subject to the valid relationships and matching keys in the datasets.

#### Page 4 — Customer and Payment Analysis

![Customer and Payment Analysis](PowerBI/04_Customer_Payment_Analysis.png)

Presents available customer and payment-related information, subject to the fields and relationships supported by the datasets.

**Power BI documentation:** [`PowerBI/README.md`](PowerBI/README.md)

## 🔍 Key Analytical Observations

The project investigates the following areas:

- **Pricing:** How original and discounted prices vary across recorded products.
- **Discounts:** How recorded discount percentages vary across categories and brands.
- **Brand comparisons:** Differences between branded and unbranded product records.
- **Data quality:** Missing fields, duplicates, and zero or potentially invalid prices.
- **Inventory and stores:** Patterns in the available inventory and store information.
- **Customer and payments:** Exploratory analysis of the available customer and payment attributes.

These observations describe the supplied datasets. They should not be interpreted as verified conclusions about DMart's company-wide revenue, profitability, customer behaviour, or pricing relative to competitors.

## 💡 Business Conclusion

DMart's publicly documented EDLC/EDLP strategy emphasizes everyday value supported by cost-conscious procurement and operations, supply-chain efficiencies, and appropriate product assortment.

The product-pricing analysis provides a way to explore the prices and discounts recorded in the available dataset. However, **the dataset alone cannot establish why DMart appears to offer more discounts than other retailers**, because comparable competitor prices, historical promotions, supplier costs, and verified transaction data are not available.

The appropriate conclusion is that DMart's published strategy provides a plausible business context for its value positioning, while a direct competitor comparison would require additional comparable pricing data.

This distinction between observed data and business context is an important part of responsible data analysis.

## 🧹 Data Quality and Validation

The project considers the following data-quality dimensions:

- Total source records.
- Missing or blank values.
- Duplicate records.
- Zero or potentially invalid prices.
- Data types and consistency.
- Differences in record counts across tools.
- Metric definitions and interpretation.

The source sales/pricing dataset contains 5,189 records. Differences in counts after cleaning or filtering should be interpreted using each tool's actual transformation rules.

## 📁 Repository Structure

```text
DMart-Retail-Analytics/
│
├── Excel/
│   ├── DMart_Retail_Analytics_Excel.xlsx
│   └── DMart-Retail-Analytics_Dashboard.png
│
├── PowerBI/
│   ├── DMart-Retail-Analytics.pbix
│   ├── README.md
│   ├── 01_Executive_Overview.png
│   ├── 02_Pricing_Discount_Analysis.png
│   ├── 03_Inventory_Store_Analysis.png
│   └── 04_Customer_Payment_Analysis.png
│
├── Python/
│   └── DMart_Retail_Analytics_Python.ipynb
│
├── SQL/
│   └── DMart_Retail_Analytics.sql
│
└── README.md
```

## 🚀 Skills Demonstrated

- Data cleaning and quality checks
- Exploratory data analysis
- SQL querying and aggregation
- Joins, subqueries, CTEs, and window functions
- Excel formulas and PivotTables
- Power BI dashboards and DAX
- Data visualization
- Business-question framing
- Evidence-based interpretation
- Documentation and GitHub project organization

*Python notebook restoration and validation remain pending.*

## 👩‍💻 About the Analyst

I am a Computer Engineering graduate with professional experience in renewable energy operations, billing, receivables monitoring, and monthly MIS reporting. I am developing my Data Analytics portfolio to apply analytical thinking, SQL, spreadsheet analysis, and data visualization to business problems.

**Areas of interest:** Data Analyst, Business Analyst, Reporting Analyst, and BI Analyst roles.

**Tools:** Excel | SQL | Power BI | Python/Pandas

## 🔗 Connect

- **GitHub:** [nikitapallerla-wq](https://github.com/nikitapallerla-wq)

---

*This project uses retail-inspired data for portfolio and learning purposes. Its findings are limited to the available records and publicly documented business context; they do not constitute an official DMart analysis or a verified comparison with competing retailers.*
