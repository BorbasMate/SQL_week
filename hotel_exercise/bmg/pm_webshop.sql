CREATE DATABASE IF NOT EXISTS pm_webshop;

USE pm_webshop;

CREATE TABLE IF NOT EXISTS category
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL ,
    last_modified TIMESTAMP DEFAULT current_timestamp ON UPDATE current_timestamp
    );

CREATE TABLE IF NOT EXISTS sub_category
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL ,
    last_modified TIMESTAMP DEFAULT current_timestamp ON UPDATE current_timestamp
    );



CREATE TABLE IF NOT EXISTS product
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    product_number INT NOT NULL ,
    color VARCHAR(20) NOT NULL ,
    size VARCHAR(20) NOT NULL ,
    weight INT NOT NULL ,
    prod_time_days INT NOT NULL ,
    start_date DATE NOT NULL ,
    end_date DATE,
    category_id INT NOT NULL ,
    sub_category_id INT NOT NULL,
    last_modified TIMESTAMP DEFAULT current_timestamp ON UPDATE current_timestamp,
    CONSTRAINT category_fk
    FOREIGN KEY (category_id) REFERENCES category (id),
    CONSTRAINT sub_category_fk
    FOREIGN KEY (sub_category_id) REFERENCES sub_category (id)
    );

CREATE TABLE IF NOT EXISTS shop
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL ,
    last_modified TIMESTAMP DEFAULT current_timestamp ON UPDATE current_timestamp
    );

CREATE TABLE IF NOT EXISTS shop_product
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    shop_id INT NOT NULL,
    quantity INT NOT NULL,
    last_modified TIMESTAMP DEFAULT current_timestamp ON UPDATE current_timestamp,
    CONSTRAINT product_id_fk
    FOREIGN KEY (product_id) REFERENCES product (id),
    CONSTRAINT shop_id_fk
    FOREIGN KEY (shop_id) REFERENCES shop (id)
    );