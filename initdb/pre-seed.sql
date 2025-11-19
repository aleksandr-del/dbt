CREATE SCHEMA IF NOT EXISTS raw;

CREATE TABLE IF NOT EXISTS raw.aisles(
    aisle_id int PRIMARY KEY,
    aisle varchar(50)
);

COPY raw.aisles
FROM '/docker-entrypoint-initdb.d/aisles.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',')
;

CREATE TABLE IF NOT EXISTS raw.departments(
    department_id int PRIMARY KEY,
    department varchar(50)
);

COPY raw.departments
FROM '/docker-entrypoint-initdb.d/departments.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',')
;

CREATE TABLE IF NOT EXISTS raw.products(
    product_id int PRIMARY KEY,
    product_name text,
    aisle_id int REFERENCES raw.aisles(aisle_id),
    department_id int REFERENCES raw.departments(department_id)
);

COPY raw.products
FROM '/docker-entrypoint-initdb.d/products.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',')
;

CREATE TABLE IF NOT EXISTS raw.orders(
    order_id int PRIMARY KEY,
    user_id int,
    eval_set varchar(10),
    order_number smallint,
    order_dow smallint,
    order_hour_of_day smallint,
    days_since_prior_order numeric
);

COPY raw.orders
FROM '/docker-entrypoint-initdb.d/orders.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',')
;

CREATE TABLE IF NOT EXISTS raw.order_products(
    order_id int REFERENCES raw.orders(order_id),
    product_id int REFERENCES raw.products(product_id),
    add_to_cart_order smallint,
    reordered smallint,
    CONSTRAINT order_products_idx PRIMARY KEY (order_id, product_id)
);

COPY raw.order_products
FROM '/docker-entrypoint-initdb.d/order_products__train.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',')
;

COPY raw.order_products
FROM '/docker-entrypoint-initdb.d/order_products__prior.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',')
;

CREATE TABLE IF NOT EXISTS raw.test(
    id serial,
	name varchar(10),
	loaded_at timestamp with time zone
)
;

INSERT INTO raw.test(name, loaded_at) VALUES
	('Anna', current_timestamp),
	('Bob', current_timestamp),
	('Jessica', current_timestamp),
	('John', current_timestamp)
;
