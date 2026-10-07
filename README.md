# 🛒 DMart Retail Analytics

## 📌 Project Overview

This project analyzes DMart retail data to understand **sales performance, product pricing, discount patterns, category and brand performance, customer behavior, inventory levels, store characteristics, and payment outcomes**.

The project demonstrates an end-to-end Data Analyst workflow using:

- **PostgreSQL / SQL**
- **Python / Pandas**
- **Power BI**
- **Microsoft Excel**

The objective is to transform raw retail data into meaningful business insights through data cleaning, SQL analysis, exploratory analysis, KPI development, pivot analysis, and interactive dashboards.

---

## 🎯 Business Objectives

The project focuses on answering key business questions such as:

- Which categories generate the highest sales?
- Which brands contribute the highest sales?
- Which products generate the highest sales?
- Which products have the highest total discounts?
- What is the overall discount level across transactions?
- Which categories show stronger pricing and discount patterns?
- Which products require higher discounting?
- Which inventory items have low stock levels?
- How does stock compare with reorder levels across warehouses?
- How are customers distributed by gender, age, state, and membership type?
- Which payment methods are most commonly used?
- What proportion of payments are successful, failed, or refunded?
- Which stores and regions have larger store footprints?

---

## 📊 Dataset

The project uses multiple retail datasets covering sales, customers, inventory, payments, stores, and suppliers.

### Main Tables

| Table | Description |
|------|-------------|
| `Sales_Transactions` | Product-level sales and pricing information |
| `Customers` | Customer demographic and membership information |
| `Inventories` | Product inventory and stock information |
| `Payments` | Payment method and payment status information |
| `Stores` | Store location, size, region, and age information |
| `Suppliers` | Supplier information |

The `Sales_Transactions` dataset contains **5,189 records**.

### Sales Transaction Fields

- Sales Transaction ID
- Product Name
- Brand
- Original Price
- Discounted Price
- Quantity / Pack Size
- Category

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| **PostgreSQL / SQL** | Data exploration, cleaning checks, aggregation, joins, subqueries, CTEs, window functions and business analysis |
| **Python / Pandas** | Data cleaning, exploratory analysis, feature engineering and visualization |
| **Power BI** | Data modelling, DAX measures, KPI development and interactive dashboards |
| **Microsoft Excel** | Data quality checks, formula-based analysis, PivotTables, PivotCharts and dashboard creation |
| **GitHub** | Version control, documentation and portfolio presentation |

---

# 🔍 SQL Analysis

The SQL analysis was performed using PostgreSQL.

The project includes **50 SQL business analysis queries** covering:

- Data quality checks
- Aggregations
- GROUP BY and HAVING
- Sorting and filtering
- CASE statements
- NULL handling
- Date-related analysis
- JOINs
- Subqueries
- CTEs
- UNION / EXCEPT
- Window functions
- Ranking analysis

### Examples of Analysis

- Total sales by category
- Sales by brand
- Average product pricing
- Discount analysis
- Top-performing products
- Product ranking
- Customer analysis
- Inventory analysis
- Payment analysis
- Store analysis

SQL queries are available in:

`SQL/DMart_Retail_Analytics.sql`

---

# 🐍 Python Analysis

Python was used for practical exploratory data analysis using **Pandas, NumPy and visualization libraries**.

### Python Analysis Includes

- Dataset inspection
- Data quality checks
- Missing-value analysis
- Duplicate checks
- Price validation
- Zero-price validation
- Data cleaning
- Discount amount calculation
- Discount percentage calculation
- Overall sales analysis
- Category analysis
- Brand analysis
- Product-level analysis
- Business insights

### Key Python Metrics

After data-quality handling, the sales analysis focuses on valid pricing records.

Key metrics include:

- Total Sales
- Total Discount
- Average Selling Price
- Average Discount Percentage
- Category-level sales
- Brand-level sales
- Product-level sales

Python notebook:

`Python/DMart_Retail_Analytics_Python.ipynb`

---

# 📊 Power BI Dashboard

The Power BI project contains four analytical pages.

### Page 1 — Executive Overview

Key KPIs and overall retail performance:

- Total Transactions
- Total Sales
- Total Discount
- Average Selling Price
- Average Discount %
- Sales by Category
- Sales by Brand
- Average Discount by Category
- Total Stock by Warehouse
- Customers by Membership Type
- Payment Status Distribution

### Page 2 — Pricing & Discount Analysis

- Average Selling Price by Category
- Average Discount % by Brand
- Original Value vs Discounted Value
- Discounted Transaction %
- Product Pricing & Discount Analysis

### Page 3 — Inventory & Store Analysis

- Low Stock Items by Store
- Stock Available vs Reorder Level
- Low Stock % by Warehouse
- Total Store Size by Region
- Average Store Age by Region

### Page 4 — Customer & Payment Analysis

- Customer Distribution by Gender
- Customer Distribution by Age
- Customer Distribution by State
- Payments by Payment Method
- Top Customers by City

Power BI files and dashboard screenshots are available in:

`PowerBI/`

---

# 📗 Excel Analysis

Excel was used to create a lightweight analyst-focused reporting workflow.

### Excel Workbook Structure

- `Raw_Data`
- `Data_Cleaning`
- `Analysis`
- `Pivot_Analysis`
- `Dashboard`

### Excel Analysis Includes

- Data quality checks
- Record validation
- Missing-value checks
- Duplicate checks
- Zero-price checks
- KPI calculations
- Category sales analysis
- Brand sales analysis
- Product sales analysis
- Discount analysis
- PivotTables
- PivotCharts
- Interactive-style dashboard presentation

### Excel Dashboard KPIs

| KPI | Value |
|---|---:|
| Total Transactions | 5,189 |
| Total Sales | ₹12,27,843 |
| Total Discount | ₹5,56,990 |
| Average Selling Price | ₹236.67 |
| Average Discount % | 26.39% |

Excel files are available in:

`Excel/`

---

# 💡 Key Business Insights

The analysis provides several useful retail insights:

- **Cooking Oil** is one of the strongest categories by sales value.
- Category-level analysis highlights the products and categories contributing the most sales.
- **Unbranded products** contribute significant sales value and should be considered separately when evaluating brand performance.
- Product-level discount analysis identifies products receiving relatively high absolute discounts.
- Discount analysis helps identify areas where promotional pricing may have a significant effect on sales value.
- Inventory analysis highlights products and warehouses requiring attention due to lower stock levels.
- Customer and payment analysis provides visibility into customer demographics and payment outcomes.

These insights can support decisions related to **pricing, promotions, inventory planning, product performance and customer analysis**.

---

# 📁 Project Structure

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
