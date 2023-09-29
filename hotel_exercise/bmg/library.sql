CREATE DATABASE IF NOT EXISTS library;

USE library;

CREATE TABLE IF NOT EXISTS writer
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    sex BOOLEAN NOT NULL
    );

CREATE TABLE IF NOT EXISTS genre
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
    );

CREATE TABLE IF NOT EXISTS book
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    release_year DATE NOT NULL,
    writer_id INT NOT NULL,
    CONSTRAINT writer_id_fk
    FOREIGN KEY (writer_id) REFERENCES writer (id)
    );

CREATE TABLE IF NOT EXISTS book_genre
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    genre_id INT NOT NULL,
    CONSTRAINT genre_id_fk
    FOREIGN KEY (genre_id) REFERENCES genre (id),
    CONSTRAINT book_id_fk
    FOREIGN KEY (book_id) REFERENCES book (id)
    );