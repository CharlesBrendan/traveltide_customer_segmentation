--- Create a table and find the profit margin using CASE WHEN.Q1 in nike data challenge
SELECT CASE WHEN product_name LIKE '%vintage%' THEN 'Nike vintage'
ELSE 'Nike official'
END AS business_unit,
				product_name, 
        (retail_price - cost)/retail_price AS profit_margin
FROM products
;

--profit margin of each distribution centers using inner join.
SELECT dc.name,
(SUM(products.retail_price) - SUM(products.cost))/ SUM(products.retail_price) AS profit_margin
FROM products 
INNER JOIN distribution_centers dc
ON products.distribution_center_id = dc.distribution_center_id
GROUP BY dc.name
;

SELECT products.product_name,
(SUM(order_items.sale_price) - SUM(products.cost)) / SUM(order_items.sale_price) AS profit_margin
FROM order_items
LEFT JOIN products
ON products.product_id = order_items.product_id
WHERE product_name IN ('Nike Pro Tights', 'Nike Dri-FIT Shorts', 'Nike Legend Tee')
GROUP BY products.product_name
;

SELECT products.product_name,
CASE WHEN created_at < '2021-05-01' THEN 'Pre-May'
ELSE 'Post-May'
END AS may21_split,
(SUM(order_items.sale_price) - SUM(products.cost)) / SUM(order_items.sale_price) AS profit_margin

FROM order_items
LEFT JOIN products
ON products.product_id = order_items.product_id
GROUP BY products.product_name, may21_split
ORDER BY products.product_name, may21_split
;

SELECT products.product_name,
(SUM(order_items.sale_price) - SUM(products.cost)) / SUM(order_items.sale_price) AS profit_margin
FROM order_items
LEFT JOIN products
ON products.product_id = order_items.product_id
GROUP BY products.product_name
 
UNION ALL

SELECT products.product_name,
(SUM(order_items_vintage.sale_price) - SUM(products.cost)) / SUM(order_items_vintage.sale_price) 
AS profit_margin

FROM order_items_vintage
LEFT JOIN products
ON products.product_id = order_items_vintage.product_id
GROUP BY products.product_name
;

---Top 10 products by profit margin  using CASE WHEN 
SELECT
CASE WHEN product_name LIKE '%vintage%' THEN 'Nike vintage'
ELSE 'Nike Official'
END AS business_unit,
				products.product_name,
        
(SUM(order_items.sale_price) - SUM(products.cost)) / SUM(order_items.sale_price) AS profit_margin
FROM order_items
LEFT JOIN products
ON products.product_id = order_items.product_id
GROUP BY products.product_name
 
UNION ALL

SELECT
		CASE WHEN product_name LIKE '%vintage%' THEN 'Nike vintage'
			ELSE 'Nike Official'
				END AS business_unit,
					products.product_name,
        
(SUM(order_items_vintage.sale_price) - SUM(products.cost)) / SUM(order_items_vintage.sale_price) 
AS profit_margin

FROM order_items_vintage
LEFT JOIN products
ON products.product_id = order_items_vintage.product_id
GROUP BY products.product_name

ORDER BY profit_margin DESC

LIMIT 10
;