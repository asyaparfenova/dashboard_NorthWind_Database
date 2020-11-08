--Queries used for creating Matebase-Dashboard--
/*Average Days to Ship*/
SELECT EXTRACT(DAY FROM AVG(shipped_date - order_date)) FROM orders;
/*Orders split by shippers*/
SELECT s.company_name, COUNT(o.order_id) FROM shippers AS s JOIN orders AS o ON o.ship_via = s.shipper_id GROUP BY s.company_name;
/*Statistic for order values*/
SELECT order_id, "order_sum",
	CASE WHEN order_sum >= 3000
		THEN '> 3000'
		WHEN order_sum BETWEEN 1000 and 3000
		THEN '1000>>3000'
		ELSE '<1000'
		END AS "order_type"
FROM
	(SELECT order_id, ROUND(SUM(unit_price * quantity)) AS "order_sum"
	 FROM order_details
	 GROUP BY order_id)
	 AS "order_sums";
/*Average Days to Ship per Shipping Company*/
SELECT s.company_name,
		EXTRACT(DAY FROM AVG(shipped_date - order_date))
		FROM orders AS o
		JOIN shippers AS s
		ON o.ship_via = s.shipper_id
		GROUP BY s.company_name;
/*Total Freight*/
SELECT SUM(freight) total_freight FROM orders;
/*Total orders per week by Category*/
SELECT SUM(o.order_id), c.category_name, EXTRACT(WEEK FROM o.order_date) AS week, EXTRACT(YEAR FROM o.order_date) AS year
    FROM orders AS o
	JOIN order_details AS od
	ON o.order_id = od.order_id
	JOIN products AS p
	ON od.product_ID = p.product_id
	JOIN categories as c
	ON p.category_id = c.category_id
    GROUP BY c.category_name, week, year;
/*Top 5 Profitable Products*/
SELECT p.product_name, SUM(od.unit_price * od.quantity * (1 - od.dicount)) as prod_revenue
    FROM products AS p
    JOIN  order_details AS od
    ON p.product_id = od.product_id
    GROUP BY p.product_name
    ORDER BY prod_revenue DESC
    LIMIT 5;