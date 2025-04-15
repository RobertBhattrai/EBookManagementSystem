-- Create Database
CREATE DATABASE IF NOT EXISTS ebook_db;
USE ebook_db;

-- Table: users
CREATE TABLE users (
                       user_id INT PRIMARY KEY AUTO_INCREMENT,
                       name VARCHAR(100),
                       email VARCHAR(100) UNIQUE,
                       contact VARCHAR(20),
                       password VARCHAR(100),
                       address TEXT,
                       landmark VARCHAR(100),
                       city VARCHAR(100),
                       state VARCHAR(100),
                       role ENUM('user', 'admin') DEFAULT 'user'
);

-- Table: books
CREATE TABLE books (
                       book_id INT PRIMARY KEY AUTO_INCREMENT,
                       book_name VARCHAR(200),
                       author VARCHAR(100),
                       price DECIMAL(10,2),
                       category VARCHAR(100),
                       status ENUM('available', 'sold', 'removed') DEFAULT 'available',
                       photo VARCHAR(255),
                       uploaded_by INT,
                       FOREIGN KEY (uploaded_by) REFERENCES users(user_id)
);

-- Table: cart
CREATE TABLE cart (
                      cart_id INT PRIMARY KEY AUTO_INCREMENT,
                      user_id INT,
                      book_id INT,
                      quantity INT DEFAULT 1,
                      total_price DECIMAL(10,2),
                      FOREIGN KEY (user_id) REFERENCES users(user_id),
                      FOREIGN KEY (book_id) REFERENCES books(book_id)
);
