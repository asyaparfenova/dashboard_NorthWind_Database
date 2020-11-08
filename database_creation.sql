--queries for creating tables and copying data from CSV files

--regions
CREATE TABLE regions(
	region_id SERIAL PRIMARY KEY,
	region_name VARCHAR(255)
);

\copy regions from '...\data\regions.csv' with (FORMAT CSV, HEADER True)

--territories
CREATE TABLE territories(
	territory_id SERIAL PRIMARY KEY,
	territory_name VARCHAR(50),
	region_id INT REFERENCES regions(region_id)
);
\copy territories from '...\data\territories.csv' with (FORMAT CSV, HEADER True)

--suppliers
CREATE TABLE suppliers(
	supplier_id SERIAL PRIMARY KEY,
	company_name VARCHAR(255),
	contact_name VARCHAR(255),
	contact_title VARCHAR(255),
	address VARCHAR(255),
	city VARCHAR(50),
	region VARCHAR(50),
	postal_code VARCHAR(50),
	country VARCHAR(50),
	phone VARCHAR(50),
	fax VARCHAR(50),
	homepage VARCHAR(255)
);
\copy suppliers from '...\data\suppliers.csv' with (FORMAT CSV, HEADER True)

--customers
CREATE TABLE customers(
	customer_id CHAR(5) PRIMARY KEY,
	company_name VARCHAR(255),
	contact_name VARCHAR(255),
	contact_title VARCHAR(255),
	address VARCHAR(255),
	city VARCHAR(50),
	region VARCHAR(50),
	postal_code VARCHAR(50),
	country VARCHAR(50),
	phone VARCHAR(50),
	fax VARCHAR(50)
);
\copy customers from '...\data\customers.csv' with (FORMAT CSV, HEADER True)

--shippers
CREATE TABLE shippers(
	shipper_id SERIAL PRIMARY KEY,
	company_name VARCHAR(255),
	phone VARCHAR(50)
);
\copy shippers from '...\data\shippers.csv' with (FORMAT CSV, HEADER True)

--categories
CREATE TABLE categories(
	category_id SERIAL PRIMARY KEY,
	category_name VARCHAR(50),
	category_description TEXT,
	picture BYTEA
);
\copy categories from '...\data\categories.csv' with (FORMAT CSV, HEADER True)

--employees
CREATE TABLE employees(
	employee_id SERIAL PRIMARY KEY,
	last_name VARCHAR(50),
	first_name VARCHAR(50),
	title VARCHAR(50),
	title_of_courtesy CHAR(5),
	birth_date TIMESTAMP,
	birth VARCHAR(50),
	hire_date TIMESTAMP,
	hire VARCHAR(50),
	address VARCHAR(255),
	city VARCHAR(50),
	region CHAR(5),
	postal_code VARCHAR(20),
	country VARCHAR(50),
	home_phone VARCHAR(50),
	extention SMALLINT,
	photo BYTEA,
	notes TEXT,
	reports_to INT REFERENCES employees(employee_id),
	photo_path VARCHAR(255)
);
--I altered a bit csv columns by double-clicking on birthDate and hireDate, and simply deleting NULL from reportsTo)
\copy employees(employee_id, last_name,	first_name, title, title_of_courtesy, birth, hire, address, city, region, postal_code, country,	home_phone, extention, photo, notes, reports_to, photo_path) from 'C:\Users\asyap\SPICED\spiced_exercises_and_challenges\week_06\data\employees2.csv' with (FORMAT CSV, HEADER True)
--reformatting dates (birth_date & hire_date)
UPDATE employees SET birth_date = to_timestamp(birth,'MM/DD/YYYY');
UPDATE employees SET hire_date = to_timestamp(hire,'MM/DD/YYYY');
ALTER TABLE employees DROP COLUMN birth;
ALTER TABLE employees DROP COLUMN hire;


--employee_territories
CREATE TABLE employee_territories(
	employee_id INT REFERENCES employees(employee_id),
	territory_id INT REFERENCES territories(territory_id)
);
\copy employee_territories from 'C:\Users\asyap\SPICED\spiced_exercises_and_challenges\week_06\data\employee_territories.csv' with (FORMAT CSV, HEADER True)

--orders
CREATE TABLE orders(
	order_id SERIAL PRIMARY KEY,
	customer_id CHAR(5) REFERENCES customers(customer_id),
	employee_id INT REFERENCES employees(employee_id),
	order_date TIMESTAMP,
	order_char VARCHAR(50),
	required_date TIMESTAMP,
	required_char VARCHAR(50),
	shipped_date TIMESTAMP,
	shipped_char VARCHAR(50),
	ship_via INT REFERENCES shippers(shipper_id),
	freight FLOAT4,
	ship_name VARCHAR(50),
	ship_address VARCHAR(255),
	ship_city VARCHAR(50),
	ship_region VARCHAR(50),
	ship_postal_code VARCHAR(50),
	ship_country VARCHAR(50)
);
--I altered date columns and deletes NULLs)
\copy orders(order_id, customer_id, employee_id, order_char, required_char, shipped_char, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country) from 'C:\Users\asyap\SPICED\spiced_exercises_and_challenges\week_06\data\orders.csv' with (FORMAT CSV, HEADER True)
--reformatting dates
UPDATE orders SET order_date = to_timestamp(ALTER TABLE employees DROP COLUMN birth;,'YYYY-MM-DD');
UPDATE orders SET required_date = to_timestamp(required_char,'YYYY-MM-DD');
UPDATE orders SET shipped_date = to_timestamp(shipped_char,'YYYY-MM-DD') WHERE order_id in (SELECT order_id FROM orders WHERE shipped_char <> 'NULL');
ALTER TABLE orders DROP COLUMN order_char;
ALTER TABLE orders DROP COLUMN required_char;
ALTER TABLE orders DROP COLUMN shipped_char;

--products
CREATE TABLE products(
	product_id SERIAL PRIMARY KEY,
	product_name VARCHAR(50),
	supplier_id INT REFERENCES suppliers(supplier_id),	
	category_id INT REFERENCES categories(category_id),
	quantity_per_unit VARCHAR(50),
	unit_price FLOAT4,
	units_in_stock SMALLINT,
	units_on_order SMALLINT,
	reorder_level SMALLINT,
	discontinued BOOL
);
\copy products from 'C:\Users\asyap\SPICED\spiced_exercises_and_challenges\week_06\data\products.csv' with (FORMAT CSV, HEADER True)

--order_details
CREATE TABLE order_details(
	order_id INT REFERENCES orders(order_id),	
	product_id INT REFERENCES products(product_id),
	unit_price FLOAT4,
	quantity SMALLINT,
	dicount FLOAT4
);
\copy order_details from 'C:\Users\asyap\SPICED\spiced_exercises_and_challenges\week_06\data\order_details.csv' with (FORMAT CSV, HEADER True)

--iso_country_codes
CREATE TABLE iso_countries(
	country_name VARCHAR(50),
	alpha_2 CHAR(2),
	alpha_3 CHAR(5),
        num_code SMALLINT,
	latitude FLOAT,
	longitude FLOAT
);
\copy iso_countries from '...\data\countries_codes_and_coordinates.csv' with (FORMAT CSV, HEADER True)
