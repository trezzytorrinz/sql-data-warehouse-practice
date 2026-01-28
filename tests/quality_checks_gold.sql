/*
Quality Checks
========================================================================================
Script Purpose:
    This scripts performs quality checks to validate the integrity, consistency, and accuracy of the Gold layer.
    These checks ensure:
          - Uniqueness of surrogate keys in dimension tables.
          - Referential integrity between fact and dimension tables
          - Validation of relationships in the data model for analytical purposes.

Usage Notes:
      - Run these checks after data landing Silver Layer.
      - Investigate and resolve any discrepencies found during the checks.
========================================================================================
*/

-- ========================================================================================
-- Checking 'gold.dim_customers'
-- ========================================================================================
-- Check for uniqueness of Customer Key in gold.dim_customers
-- Expectation: No Results

SELECT
    c.customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers c
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ========================================================================================
-- Checking 'gold.dim_products'
-- ========================================================================================
-- Check for uniqueness of Product Key in gold.dim_products
-- Expectation: No Results

SELECT
    p.product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products p
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ========================================================================================
-- Foreign Key Integrity (Dimensions)
-- ========================================================================================
-- Check for correct integration of foreign keys in fact table

SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p ON p.product_key = f.product_key
