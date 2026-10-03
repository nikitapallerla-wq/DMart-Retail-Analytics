/*
DMart Retail Analytics — SQL Portfolio Project
Database: Dmart_Analytics
Schema: public
PostgreSQL / pgAdmin

IMPORTANT:
Each query is independent. Execute ONE query at a time.

Tables:
sales_transactions, inventories, payments, customers, stores, suppliers
*/

-- =========================
-- SECTION 1: DATA EXPLORATION & QUALITY
-- =========================

-- Q1. How many sales transactions are present?
SELECT COUNT(*) AS total_transactions
FROM sales_transactions;

-- Q2. How many unique products are sold?
SELECT COUNT(DISTINCT product_name) AS unique_products
FROM sales_transactions;

-- Q3. How many unique brands are present?
SELECT COUNT(DISTINCT brand) AS unique_brands
FROM sales_transactions;

-- Q4. How many product categories are present?
SELECT COUNT(DISTINCT category) AS unique_categories
FROM sales_transactions;

-- Q5. What are the minimum and maximum product prices?
SELECT MIN(price) AS minimum_price, MAX(price) AS maximum_price
FROM sales_transactions;

-- Q6. Are there duplicate transaction IDs?
SELECT sales_transaction_id, COUNT(*) AS duplicate_count
FROM sales_transactions
GROUP BY sales_transaction_id
HAVING COUNT(*) > 1;

-- Q7. Check for missing values in the sales table.
SELECT
    COUNT(*) AS total_rows,
    COUNT(sales_transaction_id) AS transaction_ids,
    COUNT(product_name) AS product_names,
    COUNT(brand) AS brands,
    COUNT(price) AS prices,
    COUNT(discounted_price) AS discounted_prices,
    COUNT(quantity) AS quantities,
    COUNT(category) AS categories
FROM sales_transactions;

-- Q8. Find products where discounted price is higher than original price.
SELECT product_name, brand, price, discounted_price
FROM sales_transactions
WHERE discounted_price > price;


-- =========================
-- SECTION 2: SALES, PRICING & DISCOUNTS
-- =========================

-- Q9. Calculate discount amount and discount percentage.
SELECT
    sales_transaction_id,
    product_name,
    brand,
    price,
    discounted_price,
    ROUND(price - discounted_price, 2) AS discount_amount,
    ROUND(((price - discounted_price) / NULLIF(price, 0)) * 100, 2)
        AS discount_percentage
FROM sales_transactions;

-- Q10. What is the total value at original price?
SELECT ROUND(SUM(price), 2) AS total_original_value
FROM sales_transactions;

-- Q11. What is the total value after discounts?
SELECT ROUND(SUM(discounted_price), 2) AS total_discounted_value
FROM sales_transactions;

-- Q12. What is the total discount amount?
SELECT ROUND(SUM(price - discounted_price), 2) AS total_discount_amount
FROM sales_transactions;

-- Q13. What is the average original product price?
SELECT ROUND(AVG(price), 2) AS average_original_price
FROM sales_transactions;

-- Q14. What is the average discounted product price?
SELECT ROUND(AVG(discounted_price), 2) AS average_discounted_price
FROM sales_transactions;

-- Q15. What is the average discount percentage?
SELECT ROUND(
    AVG(((price - discounted_price) / NULLIF(price, 0)) * 100), 2
) AS average_discount_percentage
FROM sales_transactions;

-- Q16. Find the 10 products with the highest discount amount.
SELECT
    product_name, brand, price, discounted_price,
    ROUND(price - discounted_price, 2) AS discount_amount
FROM sales_transactions
ORDER BY discount_amount DESC
LIMIT 10;

-- Q17. Find the 10 products with the highest discount percentage.
SELECT
    product_name, brand, price, discounted_price,
    ROUND(((price - discounted_price) / NULLIF(price, 0)) * 100, 2)
        AS discount_percentage
FROM sales_transactions
WHERE price > 0
ORDER BY discount_percentage DESC
LIMIT 10;

-- Q18. Find products receiving more than 30% discount.
SELECT
    product_name, brand, category, price, discounted_price,
    ROUND(((price - discounted_price) / NULLIF(price, 0)) * 100, 2)
        AS discount_percentage
FROM sales_transactions
WHERE price > 0
  AND ((price - discounted_price) / price) * 100 > 30
ORDER BY discount_percentage DESC;

-- Q19. Classify products into discount bands.
SELECT
    product_name,
    brand,
    price,
    discounted_price,
    ROUND(((price - discounted_price) / NULLIF(price, 0)) * 100, 2)
        AS discount_percentage,
    CASE
        WHEN price = discounted_price THEN 'No Discount'
        WHEN ((price - discounted_price) / NULLIF(price, 0)) * 100 < 10
            THEN 'Low Discount'
        WHEN ((price - discounted_price) / NULLIF(price, 0)) * 100 < 25
            THEN 'Medium Discount'
        WHEN ((price - discounted_price) / NULLIF(price, 0)) * 100 < 40
            THEN 'High Discount'
        ELSE 'Very High Discount'
    END AS discount_band
FROM sales_transactions;

-- Q20. Count products in each discount band.
SELECT
    CASE
        WHEN price = discounted_price THEN 'No Discount'
        WHEN ((price - discounted_price) / NULLIF(price, 0)) * 100 < 10
            THEN 'Low Discount'
        WHEN ((price - discounted_price) / NULLIF(price, 0)) * 100 < 25
            THEN 'Medium Discount'
        WHEN ((price - discounted_price) / NULLIF(price, 0)) * 100 < 40
            THEN 'High Discount'
        ELSE 'Very High Discount'
    END AS discount_band,
    COUNT(*) AS product_count
FROM sales_transactions
GROUP BY discount_band
ORDER BY product_count DESC;


-- =========================
-- SECTION 3: CATEGORY & BRAND ANALYSIS
-- =========================

-- Q21. Count transactions by category.
SELECT category, COUNT(*) AS transaction_count
FROM sales_transactions
GROUP BY category
ORDER BY transaction_count DESC;

-- Q22. Find average original price by category.
SELECT category, ROUND(AVG(price), 2) AS average_price
FROM sales_transactions
GROUP BY category
ORDER BY average_price DESC;

-- Q23. Find average discounted price by category.
SELECT category, ROUND(AVG(discounted_price), 2) AS average_discounted_price
FROM sales_transactions
GROUP BY category
ORDER BY average_discounted_price DESC;

-- Q24. Find average discount percentage by category.
SELECT
    category,
    ROUND(
        AVG(((price - discounted_price) / NULLIF(price, 0)) * 100), 2
    ) AS average_discount_percentage
FROM sales_transactions
WHERE price > 0
GROUP BY category
ORDER BY average_discount_percentage DESC;

-- Q25. Find total quantity by category.
SELECT
    category,
    SUM(
        NULLIF(REGEXP_REPLACE(quantity, '[^0-9.]', '', 'g'), '')::numeric
    ) AS total_quantity
FROM sales_transactions
GROUP BY category
ORDER BY total_quantity DESC;

-- Q26. Find the top 10 brands by number of transactions.
SELECT brand, COUNT(*) AS transaction_count
FROM sales_transactions
GROUP BY brand
ORDER BY transaction_count DESC
LIMIT 10;

-- Q27. Find average price and discount percentage by brand.
SELECT
    brand,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(
        AVG(((price - discounted_price) / NULLIF(price, 0)) * 100), 2
    ) AS average_discount_percentage
FROM sales_transactions
GROUP BY brand
ORDER BY average_discount_percentage DESC;

-- Q28. Rank categories by average discount percentage.
SELECT
    category,
    ROUND(
        AVG(((price - discounted_price) / NULLIF(price, 0)) * 100), 2
    ) AS average_discount_percentage,
    DENSE_RANK() OVER (
        ORDER BY AVG(((price - discounted_price) / NULLIF(price, 0)) * 100) DESC
    ) AS discount_rank
FROM sales_transactions
WHERE price > 0
GROUP BY category;


-- =========================
-- SECTION 4: INVENTORY ANALYSIS
-- =========================

-- Q29. How many inventory records are present?
SELECT COUNT(*) AS inventory_records
FROM inventorys;

-- Q30. How many stores have inventory records?
SELECT COUNT(DISTINCT store_id) AS stores_with_inventory
FROM inventorys;

-- Q31. What is the total stock available?
SELECT SUM(stock_available) AS total_stock_available
FROM inventorys;

-- Q32. What is the average stock available?
SELECT ROUND(AVG(stock_available), 2) AS average_stock_available
FROM inventorys;

-- Q33. Find inventory records below the reorder level.
SELECT
    inventory_id, product_id, store_id,
    stock_available, reorder_level,
    last_restock_date, warehouse_location
FROM inventorys
WHERE stock_available < reorder_level
ORDER BY stock_available;

-- Q34. Count low-stock inventory records by store.
SELECT store_id, COUNT(*) AS low_stock_records
FROM inventorys
WHERE stock_available < reorder_level
GROUP BY store_id
ORDER BY low_stock_records DESC;

-- Q35. Find the top 10 inventory records by stock available.
SELECT inventory_id, product_id, store_id, stock_available, reorder_level
FROM inventorys
ORDER BY stock_available DESC
LIMIT 10;

-- Q36. Calculate the stock-to-reorder-level ratio.
SELECT
    inventory_id,
    product_id,
    store_id,
    stock_available,
    reorder_level,
    ROUND(stock_available::numeric / NULLIF(reorder_level, 0), 2)
        AS stock_to_reorder_ratio
FROM inventorys
WHERE reorder_level > 0
ORDER BY stock_to_reorder_ratio;


-- =========================
-- SECTION 5: CUSTOMER & MEMBERSHIP ANALYSIS
-- =========================

-- Q37. How many customers are present?
SELECT COUNT(*) AS total_customers
FROM customers;

-- Q38. Count customers by gender.
SELECT gender, COUNT(*) AS customer_count
FROM customers
GROUP BY gender
ORDER BY customer_count DESC;

-- Q39. Count customers by membership type.
SELECT membership_type, COUNT(*) AS customer_count
FROM customers
GROUP BY membership_type
ORDER BY customer_count DESC;

-- Q40. Find average customer age by membership type.
SELECT membership_type, ROUND(AVG(age), 2) AS average_age
FROM customers
GROUP BY membership_type
ORDER BY average_age DESC;

-- Q41. Find the number of customers by state.
SELECT state, COUNT(*) AS customer_count
FROM customers
GROUP BY state
ORDER BY customer_count DESC;

-- Q42. Rank membership types by customer count.
SELECT
    membership_type,
    COUNT(*) AS customer_count,
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS membership_rank
FROM customers
GROUP BY membership_type;


-- =========================
-- SECTION 6: PAYMENT ANALYSIS
-- =========================

-- Q43. How many payment records are present?
SELECT COUNT(*) AS total_payments
FROM payments;

-- Q44. Count payments by payment method.
SELECT payment_method, COUNT(*) AS payment_count
FROM payments
GROUP BY payment_method
ORDER BY payment_count DESC;

-- Q45. Count payments by payment status.
SELECT payment_status, COUNT(*) AS payment_count
FROM payments
GROUP BY payment_status
ORDER BY payment_count DESC;

-- Q46. Analyze payment methods by payment status.
SELECT
    payment_method,
    payment_status,
    COUNT(*) AS payment_count
FROM payments
GROUP BY payment_method, payment_status
ORDER BY payment_method, payment_count DESC;


-- =========================
-- SECTION 7: STORE & SUPPLIER ANALYSIS
-- =========================

-- Q47. Count stores by region.
SELECT region, COUNT(*) AS store_count
FROM stores
GROUP BY region
ORDER BY store_count DESC;

-- Q48. Find the 10 largest stores by floor area.
SELECT
    store_id,
    store_name,
    city,
    state,
    region,
    store_size_sqft
FROM stores
ORDER BY store_size_sqft DESC
LIMIT 10;

-- Q49. Count suppliers by state.
SELECT state, COUNT(*) AS supplier_count
FROM suppliers
GROUP BY state
ORDER BY supplier_count DESC;

-- Q50. Rank supplier states by supplier count.
SELECT
    state,
    COUNT(*) AS supplier_count,
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS supplier_state_rank
FROM suppliers
GROUP BY state
ORDER BY supplier_state_rank;
