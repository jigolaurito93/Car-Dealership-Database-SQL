CREATE TABLE employee(
	employee_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	department VARCHAR(25) NOT NULL
);

CREATE TABLE car_for_sale(
	sale_car_id SERIAL PRIMARY KEY,
	serial_number INTEGER NOT NULL,
	make VARCHAR NOT NULL,
	model VARCHAR NOT NULL,
	"year" INTEGER NOT NULL,
	color VARCHAR NOT NULL,
	status VARCHAR NOT NULL,
	car_price NUMERIC(8,2),
	employee_id INTEGER NOT NULL,
	FOREIGN KEY(employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE invoice(
	invoice_id SERIAL PRIMARY KEY,
	purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	sale_car_id INTEGER NOT NULL,
	FOREIGN KEY(sale_car_id) REFERENCES car_for_sale(sale_car_id),
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	employee_id INTEGER NOT NULL,
	FOREIGN KEY(employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(25) NOT NULL,
	last_name VARCHAR(25) NOT NULL,
	phone_number VARCHAR(15),
	email VARCHAR(50)
);

CREATE TABLE car_for_service(
	service_car_id SERIAL PRIMARY KEY,
	serial_number VARCHAR NOT NULL,
	make VARCHAR NOT NULL,
	model VARCHAR NOT NULL,
	"year" INTEGER NOT NULL,
	color VARCHAR NOT NULL,
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE service_ticket(
	ticket_id SERIAL PRIMARY KEY,
	service_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	employee_id INTEGER NOT NULL,
	FOREIGN KEY(employee_id) REFERENCES employee(employee_id),
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	service_car_id INTEGER NOT NULL,
	FOREIGN KEY(service_car_id) REFERENCES car_for_service(service_car_id)
);

CREATE TABLE service_record(
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	ticket_id INTEGER NOT NULL,
	FOREIGN KEY(ticket_id) REFERENCES service_ticket(ticket_id),
	employee_id INTEGER NOT NULL,
	FOREIGN key(employee_id) REFERENCES employee(employee_id),
	service_car_id INTEGER NOT NULL,
	FOREIGN KEY(service_car_id) REFERENCES car_for_service(service_car_id) 
);

-- Inserts the employee information to the employee table

INSERT INTO employee(
	first_name,
	last_name,
	department 
)VALUES (
	'Richard',
	'Gutierrez',
	'Sales'
);

INSERT INTO employee(
	first_name,
	last_name,
	department 
)VALUES (
	'Luis',
	'Manzano',
	'Sales'
);

INSERT INTO employee(
	first_name,
	last_name,
	department 
)VALUES (
	'Jonathan',
	'Parker',
	'Automotive'
);

INSERT INTO employee(
	first_name,
	last_name,
	department 
)VALUES (
	'Marcus',
	'Madison',
	'Automotive'
);

INSERT INTO employee(
	first_name,
	last_name,
	department 
)VALUES (
	'Tony',
	'Rogers',
	'Sales'
);

INSERT INTO employee(
	first_name,
	last_name,
	department 
)VALUES (
	'Regina',
	'Phalange',
	'Automotive Garage'
);


SELECT *
FROM employee;

------------------------------- STORED PROCEDURES --------------------------------
-- Creates a procedure that adds the customer's information

CREATE OR REPLACE PROCEDURE add_customer(
	first_name VARCHAR, 
	last_name VARCHAR, 
	phone_number VARCHAR(15), 
	email VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO customer(first_name, last_name, phone_number, email)
	values(first_name, last_name, phone_number, email);
END;
$$;

--------------------------------- ADD A CUSTOMER --------------------------------
-- Executes the procedure that adds customer information to the customer table

CALL add_customer('Stephen', 'Brand', '(703) 457-0962', 'sbrand@greenville.com');

CALL add_customer('Cornelius', 'Jeffries', '(571) 247-3905', 'game_boss23@ledis.com' );

CALL add_customer('Tyler', 'Higgins', '(873) 724-824', 'culture_tyler@gamespot.com');

CALL add_customer('Peter', 'Masterson', '(984) 803-7218', 'pmaster@gbran.com');

CALL add_customer(:first_name, :last_name, :phone_number, :email) 

SELECT *
FROM customer 
------------------------------- STORED PROCEDURES --------------------------------
-- Creates a procedure that adds the car information to the service department

CREATE OR REPLACE PROCEDURE add_car_service(
	serial_number VARCHAR,	
	make VARCHAR,
	model VARCHAR,
	"year" INTEGER,
	color VARCHAR,
	customer_id INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO car_for_service(serial_number, make, model, "year", color, customer_id)
	VALUES(serial_number, make, model, "year", color, customer_id);
END;
$$;

--------------------------------- ADD CUSTOMER CAR INFO --------------------------------
-- Executes the procedure to add car information to the service/ maintenance department

CALL add_car_service('PQ9FJK74L9', 'Ford', 'Focus', 2016, 'Navy Blue', 3)

CALL add_car_service('VE8LG783OP', 'Nissan', 'Altima', 2008, 'Black', 4) 

SELECT *
FROM car_for_service 

INSERT INTO car_for_service(serial_number, make, model, "year", color, customer_id)
values('J7AP6N27KL', 'Honda', 'Civic', 2019, 'Red', 1);

------------------------------- STORED PROCEDURES --------------------------------
-- Creates a procedure to add the car information to the inventory table

CREATE OR REPLACE PROCEDURE add_car_sale(
	serial_number VARCHAR,	
	make VARCHAR,
	model VARCHAR,
	"year" INTEGER,
	color VARCHAR,
	status VARCHAR,
	car_price NUMERIC(8,2)
)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO car_for_sale(serial_number, make, model, "year", color, status, car_price)
	VALUES(serial_number, make, model, "year", color, status, car_price);
END;
$$;

--------------------------------- ADD CAR FOR SALE INFO --------------------------------
-- Executes the procedure to add car information to the inventory table

CALL add_car_sale('AP8BXIA7Y3', 'GMC', 'XL', 2006, 'Brown', 'SOLD', 98000);
CALL add_car_sale('S84NM591AC', 'INFINITI', 'QX4', 2002, 'Silver', 'AVAILABLE', 62000);
CALL add_car_sale('G975AN4DQ', 'GMC', 'SIERRA', 2007, 'Black', 'AVAILABLE', 32000); 
CALL add_car_sale('CY84HZ9K43', 'CHEVROLET', 'OPTRA', 2007, 'Dark Green', 'SOLD', 27000);
CALL add_car_sale('S9H29S24HA', 'FORD', 'FLEX', 2013, 'Maple Brown', 'AVAILABLE', 48000);
CALL add_car_sale ('IXB274S9MP', 'AUDI', 'S6', 2013, 'Apple Green', 'SOLD', 147000);

SELECT *
FROM car_for_sale;

------------------------------- STORED PROCEDURES --------------------------------
-- Creates a procedure to add information to the invoice table

CREATE OR REPLACE PROCEDURE add_invoice(
	sale_car_id INTEGER,	
	customer_id INTEGER,
	employee_id INTEGER,
	purchase_date TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO invoice(sale_car_id, customer_id, employee_id, purchase_date)
	VALUES(sale_car_id, customer_id, employee_id, NOW());
END;
$$;

--------------------------------- ADD INVOICE --------------------------------
-- Executes the procedure to add information to the invoice table

CALL add_invoice(5,2,2);
CALL add_invoice(2,5,1);
CALL add_invoice(3,6,3);

------------------------------- STORED PROCEDURES --------------------------------
-- Creates procedure to make tickets and add it to the service ticket table

CREATE OR REPLACE PROCEDURE add_ticket(
	customer_id INTEGER,
	service_car_id INTEGER,
	employee_id INTEGER,
	service_date TIMESTAMP
)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO service_ticket(customer_id, service_car_id, employee_id, service_date)
	VALUES(customer_id, service_car_id, employee_id, NOW());
END;
$$;

--------------------------------- ADD SERVICE TICKET --------------------------------
-- Executes the procedure to create a ticket and input it to the service ticket table

CALL add_ticket(1, 1, 3);

------------------------------- STORED PROCEDURES --------------------------------
-- Procedure that adds all the information to the service records

CREATE OR REPLACE PROCEDURE add_service_record(
	customer_id INTEGER,
	ticket_id INTEGER,
	employee_id INTEGER,
	service_car_id INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO service_record(customer_id, ticket_id, employee_id, service_car_id)
	VALUES(customer_id, ticket_id, employee_id, service_car_id);
END;
$$;

--------------------------------- ADD SERVICE RECORD --------------------------------
-- Executes the procedure to add all the information to the service records table

CALL add_service_record(1,1,3,1);

CALL add_service_record(3,2,4,2);

CALL add_service_record(4,5,3,3);

CALL add_service_record(3,4,6,2);


--------------------------------- STORED FUNCTION --------------------------------

-- Creates a function that shows the employee who sold the most expensive car

CREATE OR REPLACE FUNCTION employee_with_most_expensive_car_sold()
RETURNS VARCHAR
LANGUAGE plpgsql
AS $$
	DECLARE employee_name VARCHAR;
BEGIN
	SELECT concat(first_name,' ', last_name) INTO employee_name
	FROM employee
	WHERE employee_id = (
		SELECT employee_id
		FROM car_for_sale cs
		JOIN invoice i 
		ON i.sale_car_id = cs.sale_car_id 
		WHERE status = 'SOLD'
		GROUP BY employee_id, car_price
		ORDER BY car_price DESC
		LIMIT 1
	);
	RETURN employee_name;
END;
$$;

--------------------------------- EXECUTE THE FUNCTION ---------------------
-- Execute the funtion that returns the name of the employee 
-- that sold the most expensive car

SELECT most_expensive_car_sold();


--------------------------------- STORED FUNCTION --------------------------------
-- Creates a function that shows the car information the customer bought
-- by using the last name of the customer

SELECT make, model, "year", color, car_price, serial_number, "condition" 
FROM car_for_sale cs
JOIN invoice i
ON i.sale_car_id = cs.sale_car_id 
JOIN customer c 
ON c.customer_id = i.customer_id 
WHERE last_name = 'West';

CREATE OR REPLACE FUNCTION customer_car_info(last_namee VARCHAR)
RETURNS TABLE (
	make VARCHAR,
	model VARCHAR,
	"year" INTEGER,
	color VARCHAR,
	car_price NUMERIC(8,2),
	serial_number VARCHAR,
	"condition" VARCHAR
)
LANGUAGE plpgsql
AS $$ 
BEGIN 
	RETURN QUERY 
	SELECT cs.make, cs.model, cs."year", cs.color, cs.car_price, cs.serial_number, cs."condition" 
	FROM car_for_sale cs
	JOIN invoice i
	ON i.sale_car_id = cs.sale_car_id 
	JOIN customer c 
	ON c.customer_id = i.customer_id 
	WHERE c.last_name = last_namee;
END;
$$;

--------------------------------- EXECUTE THE FUNCTION ---------------------
-- Execute the function that returns a table when last name is given

SELECT *
FROM customer_car_info('West');

SELECT *
FROM customer_car_info('Lassiter');

SELECT *
FROM customer_car_info('Jeffries');