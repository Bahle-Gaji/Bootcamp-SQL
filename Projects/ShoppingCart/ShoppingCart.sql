--To make editing easier--
DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS order_header;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;
----(simply make change where you need then execute)------



-----------Tables and Inserts------------

CREATE TABLE products (
	id bigserial PRIMARY KEY,
	name varchar(20) UNIQUE NOT NULL,
	price numeric NOT NULL
);

CREATE TABLE users (
	id bigserial PRIMARY KEY,
	name varchar(20) NOT NULL
);

CREATE TABLE cart (
	product_id bigint REFERENCES Products(id) ON DELETE CASCADE,
	qty bigint CHECK (qty > 0)
);

CREATE TABLE order_header (
	order_id bigserial PRIMARY KEY,
	user_id bigint REFERENCES users(id) ON DELETE CASCADE,
	order_date timestamp DEFAULT current_timestamp
);

CREATE TABLE order_details (
	order_header bigint REFERENCES order_header(order_id) ON DELETE CASCADE,
	prod_id bigint REFERENCES products(id),
	qty bigint NOT NULL
);

INSERT INTO products (name, price)
VALUES
('coke', 10),
('chips', 5),
('cake', 20);

INSERT INTO users (name)
VALUES
('Arnold'),
('Sheryl');



---------Add to cart------------
CREATE OR REPLACE FUNCTION add_update_product(prod_id BIGINT)
RETURNS void AS $$
BEGIN
    IF EXISTS (SELECT * FROM CART WHERE product_id = prod_id)
    THEN
        UPDATE Cart SET qty = qty + 1  WHERE product_id = prod_id;
    ELSE
        INSERT INTO Cart (product_id,qty) VALUES (prod_id,1);
    END IF; 
END;
$$ LANGUAGE plpgsql;

--adding to cart demonstration (with hard code)
SELECT add_update_product(1); -- 1 coke
SELECT * FROM cart; -- display

SELECT add_update_product(3); -- 1 cake
SELECT * FROM cart; -- display

SELECT add_update_product(2); -- 1 chips
SELECT * FROM cart; -- display

SELECT add_update_product(3); -- 2 cake
SELECT * FROM cart; -- display

---------Delete from cart------------
CREATE OR REPLACE FUNCTION delete_product(prod_id BIGINT)
RETURNS void AS $$
BEGIN
    IF EXISTS (SELECT * FROM CART WHERE product_id = prod_id
                                  AND qty > 1)
    THEN
        UPDATE  CART
        SET qty = qty - 1
        WHERE product_id = prod_id;
    ELSE
        DELETE FROM Cart 
        WHERE product_id = prod_id;
    END IF; 
END;
$$ LANGUAGE plpgsql;

--removing from cart demonstration (with hard code)
SELECT delete_product(1); -- -1 coke
SELECT * FROM cart; -- display

SELECT delete_product(2); -- -1 chips
SELECT * FROM cart; -- display

SELECT delete_product(3); -- -1 cake
SELECT * FROM cart; -- display

SELECT delete_product(3); -- -2 cake
SELECT * FROM cart; -- display


--Clear cart
DELETE FROM cart;





--************CHECKOUT EXPERIENCE************--


--------User 1 - Arnold: 3 cokes and 1 chips-----------

--3 Cokes
SELECT add_update_product(1);
SELECT add_update_product(1);
SELECT add_update_product(1);
SELECT * FROM cart; -- display

--1 Chips
SELECT add_update_product(2); -- 1 chips
SELECT * FROM cart; -- display


--Checkout
INSERT INTO order_header(user_id)
VALUES('1');
SELECT * FROM order_header;

INSERT INTO order_details
	(order_header, prod_id, qty)
VALUES 
	(1, 1, 3),
	(1, 2, 1);

SELECT * FROM order_details;

--Clear cart
DELETE FROM cart;



--------User 2 - Sheryl: 1 coke, 2 chips, 1 cake -----------

--1 Cokes
SELECT add_update_product(1);
SELECT * FROM cart; -- display

--2 Chips
SELECT add_update_product(2); -- 1 chips
SELECT add_update_product(2); -- 2 chips
SELECT * FROM cart; -- display

--1 Cake
SELECT add_update_product(3);
SELECT * FROM cart;


--Checkout
INSERT INTO order_header(user_id)
VALUES('2');
SELECT * FROM order_header;

INSERT INTO order_details
	(order_header, prod_id, qty)
VALUES 
	(2, 1, 1),
	(2, 2, 2),
	(2, 3, 1);


--all order details
SELECT * FROM order_details;



--User 1 - Arnold's order
SELECT u.name, prod.name, prod.price, odet.qty, ohead.order_date
FROM order_header AS ohead
INNER JOIN users AS u
ON ohead.user_id = u.id
INNER JOIN order_details AS odet
ON ohead.order_id = odet.order_header
INNER JOIN products AS prod
ON odet.prod_id = prod.id
WHERE u.id = 1;


--User 2 - Sheryl's order
SELECT u.name, prod.name, prod.price, odet.qty, ohead.order_date
FROM order_header AS ohead
INNER JOIN users AS u
ON ohead.user_id = u.id
INNER JOIN order_details AS odet
ON ohead.order_id = odet.order_header
INNER JOIN products AS prod
ON odet.prod_id = prod.id
WHERE u.id = 2;


--All orders for a day--
SELECT u.name, prod.name, prod.price, odet.qty, prod.price * odet.qty AS sub_total, ohead.order_date
FROM order_header AS ohead
INNER JOIN users AS u
ON ohead.user_id = u.id
INNER JOIN order_details AS odet
ON ohead.order_id = odet.order_header
INNER JOIN products AS prod
ON odet.prod_id = prod.id
WHERE date_part('day', ohead.order_date) = date_part('day', current_timestamp);


--Total order for user1
SELECT SUM(prod.price * odet.qty)
FROM order_header AS ohead
INNER JOIN users AS u
ON ohead.user_id = u.id
INNER JOIN order_details AS odet
ON ohead.order_id = odet.order_header
INNER JOIN products AS prod
ON odet.prod_id = prod.id
WHERE u.id = 1;