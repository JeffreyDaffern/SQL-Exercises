USE sql_store;
-- Return all the products (name, unit price, new price (unit price * 1.1)
SELECT name, unit_price as "unit price", (unit_price * 1.1) AS "new price" FROM products;

-- Get the orders placed in 2019
SELECT * FROM orders WHERE order_date BETWEEN '2019-01-01' AND '2019-12-31';

-- From the order_items table get the items for order #6 where the total price is greater than 30
SELECT  * FROM order_items WHERE order_id = 6 AND unit_price * quantity > 30;

-- Return products with quantity in stock equal to 49, 38, 72
SELECT * FROM products WHERE quantity_in_stock IN (49, 38, 72);

-- Return customers born between 1/1/1990 and 1/1/2000
SELECT * FROM customers WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

-- Get the customers whose addresses contain TRAIL or AVENUE, phone numbers that end with 9
SELECT * FROM customers WHERE (address LIKE '%trail%' OR address LIKE '%avenue%') OR phone LIKE '%9';

-- Get the customers whose first names are ELKA or AMBUR, last names end with EY or ON, last names start with MY or contains SE, last names contain B followed by R or U
SELECT * FROM customers WHERE first_name REGEXP 'Elka|Ambur' OR last_name REGEXP 'ey$|on$' OR last_name REGEXP '^my|se' OR last_name REGEXP 'b[ru]';

-- Get the orders that are not shipped
SELECT * FROM orders WHERE shipped_date IS NULL;

-- Select all items with order_id #2 and sort by total price
SELECT * FROM order_items WHERE order_id = 2 ORDER BY quantity * unit_price DESC;

-- Get the top three loyal customers
SELECT * FROM customers ORDER BY points DESC LIMIT 3;

-- Join order_items with products
SELECT oi.order_id, oi.product_id, quantity, oi.unit_price FROM order_items oi JOIN products p ON oi.product_id = p.product_id;

-- Self join employee with itsself
USE sql_hr;
SELECT e.employee_id, e.first_name, m.first_name FROM employees e JOIN employees m ON e.reports_to = m.employee_id;

-- Join payments with payment_methods and clients to create a report
USE sql_invoicing;
SELECT p.date, p.invoice_id, c.name AS client,  p.amount, pm.name AS payment_method FROM payments p JOIN payment_methods pm ON p.payment_method = pm.payment_method_id JOIN clients c USING (client_id);

-- Outer join products and order_items to show product_id and name, and quantity of all products whether they exist in the second table or not
USE sql_store;
SELECT p.product_id, p.name, oi.quantity FROM products p LEFT JOIN order_items oi USING(product_id);

-- Create a report using orders, customers, order_statuses, and shippers
SELECT o.order_date, o.order_id, c.first_name AS customer, s.name AS shipper, os.name AS status FROM orders o JOIN customers c USING(customer_id) LEFT JOIN shippers s USING(shipper_id) JOIN order_statuses os ON o.status = os.order_status_id;

-- Create a report using payments, clients, and payment_methods
USE sql_invoicing;
SELECT p.date, c.name AS client, p.amount, pm.name AS payment_method FROM payments p JOIN clients c USING(client_id) JOIN payment_methods pm ON p.payment_method = pm.payment_method_id;

-- Do a cross join between shippers and products using the implicit syntax and then using the explicit syntax
USE sql_store;
SELECT * FROM products, shippers; SELECT * FROM products CROSS JOIN shippers;

-- Using Unions, write a query that will categorize customers into bronze, silver, and gold based on their current points.ALTER
SELECT customer_id, first_name, points, 'Bronze' AS type FROM customers WHERE points < 2000 UNION SELECT customer_id, first_name, points, 'Silver' AS type FROM customers WHERE points BETWEEN 2000 AND 2999 UNION SELECT customer_id, first_name, points, 'Gold' AS type FROM customers WHERE points >= 3000 ORDER BY first_name;




