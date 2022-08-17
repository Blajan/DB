CREATE DATABASE project;
USE project;

-- PROCEDURE
CREATE TABLE person(
id INT PRIMARY KEY AUTO_INCREMENT,
namee VARCHAR(20),
age INT CHECK (age > 16)
);
DROP TABLE 

DELIMITER $$
CREATE PROCEDURE addPerson (IN nameInput VARCHAR(20), IN ageInput INT)
BEGIN
	INSERT INTO person(namee, age) VALUES (nameInput, ageInput);
    SELECT * FROM person GROUP BY age DESC HAVING ageInput BETWEEN 18 AND 65;
END$$
DELIMITER ;

CALL addPerson('Blajan', 22);
-- PROCEDURE


-- FUNCTION
CREATE TABLE auto(
id INT PRIMARY KEY AUTO_INCREMENT,
brand VARCHAR(20),
county VARCHAR(2),
numbers INT,
letters VARCHAR(3)
);
INSERT INTO auto(brand, county, numbers, letters) VALUES ('BMW', 'SJ', '91', 'BLJ');
INSERT INTO auto(brand, county, numbers, letters) VALUES ('Mercedes-Benz', 'BH', '21', 'FGB');
INSERT INTO auto(brand, county, numbers, letters) VALUES ('Volkswagen', 'TM', '18', 'GGD');
INSERT INTO auto(brand, county, numbers, letters) VALUES ('Audi', 'B', '44', 'LPO');
INSERT INTO auto(brand, county, numbers, letters) VALUES ('Tesla', 'B', '38', 'ITG');

CREATE FUNCTION registration_auto(county VARCHAR(2), numbers VARCHAR(2),letters VARCHAR(3))
RETURNS VARCHAR(9)  DETERMINISTIC 
RETURN CONCAT(county,'-',numbers,'-',letters);
SELECT brand AS 'Brand', registration_auto(county, numbers, letters) AS 'Registration' FROM auto;

-- CASE
CREATE TABLE people(
id INT PRIMARY KEY AUTO_INCREMENT,
namee VARCHAR(20),
age INT
);
INSERT INTO people(namee, age) VALUES ('Blajan', 24);
INSERT INTO people(namee, age) VALUES ('Mike', 14);
INSERT INTO people(namee, age) VALUES ('Jeff', 7);
INSERT INTO people(namee, age) VALUES ('Joe', 28);
INSERT INTO people(namee, age) VALUES ('Justin', 9);
INSERT INTO people(namee, age) VALUES ('Timy', 23);
INSERT INTO people(namee, age) VALUES ('Oscar', 57);

CREATE FUNCTION the_age(theAge INT)  
RETURNS VARCHAR(10) DETERMINISTIC  
RETURN CASE
WHEN theAge >= 18 THEN 'Adult'       
WHEN theAge BETWEEN 12 AND 18 THEN 'Teenager'    
ELSE 'Child'                         
END;

SELECT namee, the_age(age) FROM people; 
-- CASE
-- FUNCTION


-- JOIN
CREATE TABLE customer (
id INT PRIMARY KEY AUTO_INCREMENT,
name_customer VARCHAR(20),
phone_number INT
);
INSERT INTO customer(name_customer, phone_number) VALUES ('Jeff', 0723746281);
INSERT INTO customer(name_customer, phone_number) VALUES ('Joe', 0724575223);
INSERT INTO customer(name_customer, phone_number) VALUES ('Justin', 0745938621);
INSERT INTO customer(name_customer, phone_number) VALUES ('Mark', 0753457928);

CREATE TABLE product_ordered (
id INT PRIMARY KEY AUTO_INCREMENT,
name_product VARCHAR(20),
price_dolares INT,
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE SET NULL
);
INSERT INTO product_ordered(name_product, price_dolares, customer_id) VALUES ('stove', 200, 1);
INSERT INTO product_ordered(name_product, price_dolares, customer_id) VALUES ('TV', 500, 2);
INSERT INTO product_ordered(name_product, price_dolares, customer_id) VALUES ('sofa', 600, 3);
INSERT INTO product_ordered(name_product, price_dolares, customer_id) VALUES ('table', 250, 4);

SELECT c.name_customer, c.phone_number, p.name_product, p.price_dolares FROM product_ordered p, customer c WHERE p.customer_id = c.id AND price_dolares > 300;
-- JOIN


-- GROUP BY
CREATE TABLE income(
id INT PRIMARY KEY AUTO_INCREMENT,
company VARCHAR(30),
month_tri VARCHAR(20),
income_per_month INT
);
INSERT INTO income(company, month_tri, income_per_month) VALUES ('Michelin', 'January', 100000);
INSERT INTO income(company, month_tri, income_per_month) VALUES ('Tenaris', 'January', 90000);
INSERT INTO income(company, month_tri, income_per_month) VALUES ('Tenaris', 'February', 95000);
INSERT INTO income(company, month_tri, income_per_month) VALUES ('Molo Garden', 'March', 70000);
INSERT INTO income(company, month_tri, income_per_month) VALUES ('Michelin', 'February', 100000);
INSERT INTO income(company, month_tri, income_per_month) VALUES ('Molo Garden', 'February', 60000);
INSERT INTO income(company, month_tri, income_per_month) VALUES ('Michelin', 'March', 120000);
INSERT INTO income(company, month_tri, income_per_month) VALUES ('Molo Garden', 'January', 80000);
INSERT INTO income(company, month_tri, income_per_month) VALUES ('Tenaris', 'March', 110000);

SELECT company, month_tri, SUM(income_per_month) FROM income GROUP BY company;
-- GROUP BY