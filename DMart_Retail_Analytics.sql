/*
============================================================
DMart Retail Discount & Product Analytics
============================================================

Dataset:
DMart Product Dataset

Tools:
PostgreSQL / SQL

Objective:
Analyze product pricing, discounts, brands, categories,
and subcategories to identify pricing and discount patterns.

Author: Nikita Pallerla
============================================================
*/


-- =========================================================
-- 1. DATA EXPLORATION
-- =========================================================

-- Q1. How many products are in the dataset?

SELECT COUNT(*) AS total_products
FROM dmart_products;


-- Q2. How many unique brands are there?

SELECT COUNT(DISTINCT brand) AS unique_brands
FROM dmart_products;


-- Q3. How many unique categories are there?

SELECT COUNT(DISTINCT category) AS unique_categories
FROM dmart_products;


-- Q4. How many unique subcategories are there?

SELECT COUNT(DISTINCT subcategory) AS unique_subcategories
FROM dmart_products;


-- =========================================================
-- 2. DATA QUALITY CHECKS
-- =========================================================

-- Q5. Check for duplicate product records.

SELECT
    name,
    brand,
    price,
    discountedprice,
    COUNT(*) AS duplicate_count
FROM dmart_products
GROUP BY
    name,
    brand,
    price,
    discountedprice
HAVING COUNT(*) > 1;


-- Q6. Check missing values.

SELECT
    COUNT(*) AS total_rows,
    COUNT(name) AS name_available,
    COUNT(brand) AS brand_available,
    COUNT(price) AS price_available,
    COUNT(discountedprice) AS discounted_price_available,
    COUNT(category) AS category_available,
    COUNT(subcategory) AS subcategory_available,
    COUNT(quantity) AS quantity_available
FROM dmart_products;


-- Q7. Find products where discounted price is greater
-- than original price.

SELECT *
FROM dmart_products
WHERE discountedprice > price;


-- Q8. Find products with zero or negative prices.

SELECT *
FROM dmart_products
WHERE price <= 0
   OR discountedprice <= 0;


-- Q9. Find products with no discount.

SELECT
    name,
    brand,
    price,
    discountedprice
FROM dmart_products
WHERE price = discountedprice
   OR discountedprice IS NULL;


-- =========================================================
-- 3. CREATE DISCOUNT METRICS
-- =========================================================

/*
Discount Amount =
Original Price - Discounted Price

Discount Percentage =
((Original Price - Discounted Price)
 / Original Price) * 100
*/

-- Q10. Create a product-level analysis table.

SELECT
    name,
    brand,
    category,
    subcategory,
    quantity,
    price,
    discountedprice,

    ROUND(price - discountedprice, 2)
        AS discount_amount,

    ROUND(
        ((price - discountedprice) / NULLIF(price, 0)) * 100,
        2
    ) AS discount_percentage

FROM dmart_products
WHERE price IS NOT NULL
  AND discountedprice IS NOT NULL
  AND price > 0;


-- =========================================================
-- 4. CATEGORY ANALYSIS
-- =========================================================

-- Q11. Count products in each category.

SELECT
    category,
    COUNT(*) AS product_count
FROM dmart_products
GROUP BY category
ORDER BY product_count DESC;


-- Q12. Find average original price by category.

SELECT
    category,
    ROUND(AVG(price), 2) AS average_price
FROM dmart_products
GROUP BY category
ORDER BY average_price DESC;


-- Q13. Find average discounted price by category.

SELECT
    category,
    ROUND(AVG(discountedprice), 2)
        AS average_discounted_price
FROM dmart_products
GROUP BY category
ORDER BY average_discounted_price DESC;


-- Q14. Find average discount percentage by category.

SELECT
    category,
    ROUND(
        AVG(
            ((price - discountedprice)
            / NULLIF(price, 0)) * 100
        ),
        2
    ) AS average_discount_percentage
FROM dmart_products
WHERE price > 0
  AND discountedprice IS NOT NULL
GROUP BY category
ORDER BY average_discount_percentage DESC;


-- Q15. Find maximum discount percentage in each category.

SELECT
    category,
    ROUND(
        MAX(
            ((price - discountedprice)
            / NULLIF(price, 0)) * 100
        ),
        2
    ) AS maximum_discount_percentage
FROM dmart_products
WHERE price > 0
GROUP BY category
ORDER BY maximum_discount_percentage DESC;


-- Q16. Find minimum and maximum product prices
-- by category.

SELECT
    category,
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price
FROM dmart_products
GROUP BY category
ORDER BY maximum_price DESC;


-- Q17. Find categories with the largest number
-- of discounted products.

SELECT
    category,
    COUNT(*) AS discounted_products
FROM dmart_products
WHERE discountedprice < price
GROUP BY category
ORDER BY discounted_products DESC;


-- Q18. Find categories where average discount
-- exceeds 20%.

SELECT
    category,
    ROUND(
        AVG(
            ((price - discountedprice)
            / NULLIF(price, 0)) * 100
        ),
        2
    ) AS average_discount_percentage
FROM dmart_products
WHERE price > 0
GROUP BY category
HAVING AVG(
    ((price - discountedprice)
    / NULLIF(price, 0)) * 100
) > 20
ORDER BY average_discount_percentage DESC;


-- Q19. Rank categories by average discount percentage.

SELECT
    category,
    ROUND(
        AVG(
            ((price - discountedprice)
            / NULLIF(price, 0)) * 100
        ),
        2
    ) AS average_discount_percentage,

    DENSE_RANK() OVER (
        ORDER BY
        AVG(
            ((price - discountedprice)
            / NULLIF(price, 0)) * 100
        ) DESC
    ) AS discount_rank

FROM dmart_products
WHERE price > 0
GROUP BY category;


-- Q20. Rank categories by product count.

SELECT
    category,
    COUNT(*) AS product_count,

    DENSE_RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS product_count_rank

FROM dmart_products
GROUP BY category;


-- =========================================================
-- 5. SUBCATEGORY ANALYSIS
-- =========================================================

-- Q21. Count products by subcategory.

SELECT
    subcategory,
    COUNT(*) AS product_count
FROM dmart_products
GROUP BY subcategory
ORDER BY product_count DESC;


-- Q22. Find average price by subcategory.

SELECT
    subcategory,
    ROUND(AVG(price), 2) AS average_price
FROM dmart_products
GROUP BY subcategory
ORDER BY average_price DESC;


-- Q23. Find average discounted price by subcategory.

SELECT
    subcategory,
    ROUND(AVG(discountedprice), 2)
        AS average_discounted_price
FROM dmart_products
GROUP BY subcategory
ORDER BY average_discounted_price DESC;


-- Q24. Find average discount percentage
-- by subcategory.

SELECT
    subcategory,
    ROUND(
        AVG(
            ((price - discountedprice)
            / NULLIF(price, 0)) * 100
        ),
        2
    ) AS average_discount_percentage
FROM dmart_products
WHERE price > 0
GROUP BY subcategory
ORDER BY average_discount_percentage DESC;


-- Q25. Top 10 subcategories by average discount.

SELECT
    subcategory,
    ROUND(
        AVG(
            ((price - discountedprice)
            / NULLIF(price, 0)) * 100
        ),
        2
    ) AS average_discount_percentage
FROM dmart_products
WHERE price > 0
GROUP BY subcategory
ORDER BY average_discount_percentage DESC
LIMIT 10;


-- Q26. Find subcategories containing products
-- with discounts above 40%.

SELECT DISTINCT
    subcategory
FROM dmart_products
WHERE price > 0
  AND ((price - discountedprice)
       / price) * 100 > 40;


-- Q27. Find the most expensive product
-- in each subcategory.

WITH ranked_products AS (
    SELECT
        name,
        subcategory,
        price,
        ROW_NUMBER() OVER (
            PARTITION BY subcategory
            ORDER BY price DESC
        ) AS rn
    FROM dmart_products
    WHERE price IS NOT NULL
)

SELECT
    name,
    subcategory,
    price
FROM ranked_products
WHERE rn = 1;


-- Q28. Find the cheapest product
-- in each subcategory.

WITH ranked_products AS (
    SELECT
        name,
        subcategory,
        price,
        ROW_NUMBER() OVER (
            PARTITION BY subcategory
            ORDER BY price
        ) AS rn
    FROM dmart_products
    WHERE price IS NOT NULL
)

SELECT
    name,
    subcategory,
    price
FROM ranked_products
WHERE rn = 1;


-- Q29. Rank products within each subcategory
-- by discount percentage.

SELECT
    name,
    subcategory,
    price,
    discountedprice,

    ROUND(
        ((price - discountedprice)
        / NULLIF(price, 0)) * 100,
        2
    ) AS discount_percentage,

    DENSE_RANK() OVER (
        PARTITION BY subcategory
        ORDER BY
            ((price - discountedprice)
            / NULLIF(price, 0)) * 100 DESC
    ) AS discount_rank

FROM dmart_products
WHERE price > 0;


-- Q30. Find the top 3 discounted products
-- from each subcategory.

WITH ranked_products AS (
    SELECT
        name,
        subcategory,
        price,
        discountedprice,

        ROUND(
            ((price - discountedprice)
            / NULLIF(price, 0)) * 100,
            2
        ) AS discount_percentage,

        ROW_NUMBER() OVER (
            PARTITION BY subcategory
            ORDER BY
                ((price - discountedprice)
                / NULLIF(price, 0)) * 100 DESC
        ) AS rn

    FROM dmart_products
    WHERE price > 0
)

SELECT
    name,
    subcategory,
    price,
    discountedprice,
    discount_percentage
FROM ranked_products
WHERE rn <= 3
ORDER BY subcategory, discount_percentage DESC;


-- =========================================================
-- 6. BRAND ANALYSIS
-- =========================================================

-- Q31. Top 10 brands by number of products.

SELECT
    brand,
    COUNT(*) AS product_count
FROM dmart_products
WHERE brand IS NOT NULL
GROUP BY brand
ORDER BY product_count DESC
LIMIT 10;


-- Q32. Find average price by brand.

SELECT
    brand,
    ROUND(AVG(price), 2) AS average_price
FROM dmart_products
WHERE brand IS NOT NULL
GROUP BY brand
ORDER BY average_price DESC;


-- Q33. Find average discount percentage by brand.

SELECT
    brand,
    ROUND(
        AVG(
            ((price - discountedprice)
            / NULLIF(price, 0)) * 100
        ),
        2
    ) AS average_discount_percentage
FROM dmart_products
WHERE brand IS NOT NULL
  AND price > 0
GROUP BY brand
ORDER BY average_discount_percentage DESC;


-- Q34. Find brands with average discount above 20%.

SELECT
    brand,
    ROUND(
        AVG(
            ((price - discountedprice)
            / NULLIF(price, 0)) * 100
        ),
        2
    ) AS average_discount_percentage
FROM dmart_products
WHERE brand IS NOT NULL
  AND price > 0
GROUP BY brand
HAVING AVG(
    ((price - discountedprice)
    / NULLIF(price, 0)) * 100
) > 20
ORDER BY average_discount_percentage DESC;


-- Q35. Find the highest discount offered by each brand.

SELECT
    brand,
    ROUND(
        MAX(
            ((price - discountedprice)
            / NULLIF(price, 0)) * 100
        ),
        2
    ) AS highest_discount_percentage
FROM dmart_products
WHERE brand IS NOT NULL
  AND price > 0
GROUP BY brand
ORDER BY highest_discount_percentage DESC;


-- Q36. Find the most expensive product
-- for each brand.

WITH ranked_products AS (
    SELECT
        brand,
        name,
        price,

        ROW_NUMBER() OVER (
            PARTITION BY brand
            ORDER BY price DESC
        ) AS rn

    FROM dmart_products
    WHERE brand IS NOT NULL
      AND price IS NOT NULL
)

SELECT
    brand,
    name,
    price
FROM ranked_products
WHERE rn = 1
ORDER BY price DESC;


-- Q37. Rank brands based on average discount.

SELECT
    brand,

    ROUND(
        AVG(
            ((price - discountedprice)
            / NULLIF(price, 0)) * 100
        ),
        2
    ) AS average_discount_percentage,

    DENSE_RANK() OVER (
        ORDER BY
            AVG(
                ((price - discountedprice)
                / NULLIF(price, 0)) * 100
            ) DESC
    ) AS discount_rank

FROM dmart_products
WHERE brand IS NOT NULL
  AND price > 0
GROUP BY brand;


-- Q38. Find brands with at least 5 products
-- and average discount above 15%.

SELECT
    brand,
    COUNT(*) AS product_count,

    ROUND(
        AVG(
            ((price - discountedprice)
            / NULLIF(price, 0)) * 100
        ),
        2
    ) AS average_discount_percentage

FROM dmart_products
WHERE brand IS NOT NULL
  AND price > 0

GROUP BY brand

HAVING COUNT(*) >= 5
   AND AVG(
       ((price - discountedprice)
       / NULLIF(price, 0)) * 100
   ) > 15

ORDER BY average_discount_percentage DESC;


-- =========================================================
-- 7. PRODUCT ANALYSIS
-- =========================================================

-- Q39. Find the 10 most expensive products.

SELECT
    name,
    brand,
    category,
    price,
    discountedprice
FROM dmart_products
WHERE price IS NOT NULL
ORDER BY price DESC
LIMIT 10;


-- Q40. Find the 10 cheapest products.

SELECT
    name,
    brand,
    category,
    price,
    discountedprice
FROM dmart_products
WHERE price IS NOT NULL
ORDER BY price
LIMIT 10;


-- Q41. Find the 10 products with the highest
-- absolute discount.

SELECT
    name,
    brand,
    category,
    price,
    discountedprice,

    ROUND(
        price - discountedprice,
        2
    ) AS discount_amount

FROM dmart_products

WHERE price IS NOT NULL
  AND discountedprice IS NOT NULL

ORDER BY discount_amount DESC
LIMIT 10;


-- Q42. Find the 10 products with the highest
-- discount percentage.

SELECT
    name,
    brand,
    category,
    price,
    discountedprice,

    ROUND(
        ((price - discountedprice)
        / NULLIF(price, 0)) * 100,
        2
    ) AS discount_percentage

FROM dmart_products

WHERE price > 0
  AND discountedprice IS NOT NULL

ORDER BY discount_percentage DESC
LIMIT 10;


-- Q43. Find products receiving more than 30% discount.

SELECT
    name,
    brand,
    category,
    price,
    discountedprice,

    ROUND(
        ((price - discountedprice)
        / NULLIF(price, 0)) * 100,
        2
    ) AS discount_percentage

FROM dmart_products

WHERE price > 0
  AND (
      ((price - discountedprice)
      / price) * 100
  ) > 30

ORDER BY discount_percentage DESC;


-- Q44. Find products receiving between 10% and 20%
-- discount.

SELECT
    name,
    brand,
    category,
    price,
    discountedprice,

    ROUND(
        ((price - discountedprice)
        / NULLIF(price, 0)) * 100,
        2
    ) AS discount_percentage

FROM dmart_products

WHERE price > 0
  AND (
      ((price - discountedprice)
      / price) * 100
  ) BETWEEN 10 AND 20

ORDER BY discount_percentage DESC;


-- Q45. Find products where discount amount
-- exceeds ₹500.

SELECT
    name,
    brand,
    category,
    price,
    discountedprice,

    ROUND(
        price - discountedprice,
        2
    ) AS discount_amount

FROM dmart_products

WHERE price - discountedprice > 500

ORDER BY discount_amount DESC;


-- Q46. Find products where discounted price
-- is less than 50% of original price.

SELECT
    name,
    brand,
    category,
    price,
    discountedprice,

    ROUND(
        ((price - discountedprice)
        / NULLIF(price, 0)) * 100,
        2
    ) AS discount_percentage

FROM dmart_products

WHERE price > 0
  AND discountedprice < price * 0.50

ORDER BY discount_percentage DESC;


-- Q47. Find the highest-priced product
-- in each category.

WITH ranked_products AS (
    SELECT
        category,
        name,
        brand,
        price,

        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY price DESC
        ) AS rn

    FROM dmart_products

    WHERE price IS NOT NULL
)

SELECT
    category,
    name,
    brand,
    price

FROM ranked_products

WHERE rn = 1;


-- Q48. Find the lowest-priced product
-- in each category.

WITH ranked_products AS (
    SELECT
        category,
        name,
        brand,
        price,

        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY price
        ) AS rn

    FROM dmart_products

    WHERE price IS NOT NULL
)

SELECT
    category,
    name,
    brand,
    price

FROM ranked_products

WHERE rn = 1;


-- Q49. Find the second-highest-priced product
-- in each category.

WITH ranked_products AS (
    SELECT
        category,
        name,
        brand,
        price,

        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY price DESC
        ) AS price_rank

    FROM dmart_products

    WHERE price IS NOT NULL
)

SELECT
    category,
    name,
    brand,
    price

FROM ranked_products

WHERE price_rank = 2;


-- =========================================================
-- 8. FINAL ANALYTICS DATASET
-- =========================================================

-- Q50. Create a final product-level analytical view.

CREATE OR REPLACE VIEW dmart_product_analysis AS

SELECT
    name,
    brand,
    category,
    subcategory,
    quantity,
    price,
    discountedprice,

    ROUND(
        price - discountedprice,
        2
    ) AS discount_amount,

    ROUND(
        ((price - discountedprice)
        / NULLIF(price, 0)) * 100,
        2
    ) AS discount_percentage,

    CASE
        WHEN price = discountedprice
            THEN 'No Discount'

        WHEN ((price - discountedprice)
              / NULLIF(price, 0)) * 100 < 10
            THEN 'Low Discount'

        WHEN ((price - discountedprice)
              / NULLIF(price, 0)) * 100 < 25
            THEN 'Medium Discount'

        WHEN ((price - discountedprice)
              / NULLIF(price, 0)) * 100 < 40
            THEN 'High Discount'

        ELSE 'Very High Discount'
    END AS discount_category

FROM dmart_products

WHERE price IS NOT NULL
  AND discountedprice IS NOT NULL
  AND price > 0;