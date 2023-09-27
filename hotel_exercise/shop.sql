CREATE DATABASE shop;

USE shop;

CREATE TABLE customer
(
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(50),
    address     VARCHAR(50),
    phone       VARCHAR(50)
);

CREATE INDEX customer_name_index ON customer(name);


CREATE TABLE customer_order
(
    order_id    INT PRIMARY KEY,
    order_date  DATE,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
);

ALTER TABLE customer_order CHANGE order_id order_id INT AUTO_INCREMENT;

CREATE TABLE product
(
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_id INT
);


CREATE TABLE product_order
(
    product_id INT,
    order_id INT,
    PRIMARY KEY (product_id, order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (order_id) REFERENCES customer_order(order_id)
)
