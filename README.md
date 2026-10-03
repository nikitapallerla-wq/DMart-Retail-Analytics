# 🛒 DMart Retail Analytics

## 📌 Project Overview

This project analyzes DMart retail product data to understand **product pricing, discount patterns, category and subcategory distribution, and brand-level pricing behavior**.

The project uses **SQL, Python and Power BI** to transform raw retail product data into meaningful business insights and an interactive analytical dashboard.

The objective is to demonstrate practical **Data Analyst skills**, including data cleaning, SQL analysis, exploratory data analysis, KPI development and data visualization.

---

## 🎯 Business Objective

The analysis focuses on answering key retail business questions such as:

- Which categories contain the most products?
- Which categories have the highest average prices?
- Which categories offer the highest discounts?
- Which brands have the largest product presence?
- Which products have the highest discount amounts?
- Which products receive the highest discount percentages?
- How does pricing vary across categories and subcategories?
- Which brands offer relatively higher discounts?
- Which products provide the largest price reductions?

---

## 📊 Dataset

The dataset contains **5,189 retail product records** and includes information related to:

- Product Name
- Brand
- Original Price
- Discounted Price
- Category
- Subcategory
- Quantity / Pack Size
- Product Description
- Product Breadcrumbs

### Dataset Limitations

This dataset is product-level data and does not contain transaction-level information such as:

- Sales date
- Store/branch
- Units sold
- Revenue by transaction
- Inventory quantity
- Customer information

Therefore, this project focuses on **product pricing and discount analytics** rather than actual sales or store-performance analysis.

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| **SQL / PostgreSQL** | Data exploration, transformation and business analysis |
| **Python / Pandas** | Data cleaning and exploratory data analysis |
| **Power BI** | Interactive dashboard and data visualization |
| **GitHub** | Project documentation and portfolio |

---

## 🔍 Key Analysis Areas

### 1. Data Quality Analysis

- Duplicate record identification
- Missing-value analysis
- Price validation
- Discount validation
- Data consistency checks

### 2. Category Analysis

- Product count by category
- Average original price
- Average discounted price
- Average discount percentage
- Minimum and maximum prices
- Category-level discount comparison

### 3. Subcategory Analysis

- Product distribution
- Average pricing
- Discount analysis
- Top discounted products
- Product ranking within subcategories

### 4. Brand Analysis

- Top brands by product count
- Average brand pricing
- Average discount percentage
- Highest discounts by brand
- Brand-level product ranking

### 5. Product-Level Analysis

- Most expensive products
- Cheapest products
- Highest absolute discounts
- Highest discount percentages
- Products with discounts above specific thresholds
- Highest and lowest priced products within categories

---

## 🧮 Key Metrics

The analysis creates the following calculated metrics:

### Discount Amount

```text
Discount Amount = Original Price - Discounted Price
Discount Percentage =
((Original Price - Discounted Price) / Original Price) × 100
