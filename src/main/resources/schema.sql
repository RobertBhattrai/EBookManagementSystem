-- Create Database
CREATE DATABASE IF NOT EXISTS ebook_database;
USE ebook_database;

CREATE TABLE IF NOT EXISTS `User` (
                                      id INT PRIMARY KEY AUTO_INCREMENT,
                                      name VARCHAR(50) NOT NULL,
                                      email VARCHAR(50) UNIQUE NOT NULL,
                                      phone VARCHAR(20),
                                      address TEXT,
                                      username VARCHAR(50) UNIQUE NOT NULL,
                                      password VARCHAR(50) NOT NULL,
                                      role ENUM('admin', 'user') DEFAULT 'user',
                                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `book` (
                                      `bookId` int NOT NULL AUTO_INCREMENT,
                                      `bookName` varchar(100) NOT NULL,
                                      `authorName` varchar(100) NOT NULL,
                                      `price` int NOT NULL,
                                      `bookCategory` varchar(10) NOT NULL,
                                      `available` int NOT NULL,
                                      `photo` varchar(50) NOT NULL,
                                      PRIMARY KEY (`bookId`)
);

CREATE TABLE IF NOT EXISTS `cart` (
                                      `id` int NOT NULL AUTO_INCREMENT,
                                      `userId` int NOT NULL,
                                      `bookId` int NOT NULL,
                                      `quantity` int NOT NULL DEFAULT '1',
                                      PRIMARY KEY (`id`),
                                      KEY `bookIdCart` (`bookId`),
                                      KEY `userIdCart` (`userId`),
                                      CONSTRAINT `bookIdCart` FOREIGN KEY (`bookId`) REFERENCES `book` (`bookId`) ON DELETE CASCADE ON UPDATE CASCADE,
                                      CONSTRAINT `userIdCart` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS `orderlist` (
                             `orderId` int NOT NULL AUTO_INCREMENT,
                             `userId` int NOT NULL,
                             `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             `price` int NOT NULL,
                             `paymentMethod` varchar(50) NOT NULL,
                             `status` varchar(10) NOT NULL DEFAULT 'No',
                             `name` varchar(30) DEFAULT NULL,
                             `phone` varchar(20) DEFAULT NULL,
                             `address1` varchar(30) DEFAULT NULL,
                             `address2` varchar(30) DEFAULT NULL,
                             `landmark` varchar(30) DEFAULT NULL,
                             `city` varchar(30) DEFAULT NULL,
                             `pincode` varchar(20) DEFAULT NULL,
                             PRIMARY KEY (`orderId`),
                             KEY `orderUserId` (`userId`),
                             CONSTRAINT `orderUserId` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS `ordercart` (
                                           `id` int NOT NULL AUTO_INCREMENT,
                                           `orderId` int NOT NULL,
                                           `bookId` int NOT NULL,
                                           `bookName` varchar(100) NOT NULL,
                                           `authorName` varchar(100) NOT NULL,
                                           `quantity` int NOT NULL,
                                           `price` int NOT NULL,
                                           PRIMARY KEY (`id`),
                                           KEY `cartOrderId` (`orderId`),
                                           CONSTRAINT `bookOrderCart` FOREIGN KEY (`bookId`) REFERENCES `book` (`bookId`) ON DELETE CASCADE ON UPDATE CASCADE,
                                           CONSTRAINT `cartOrderId` FOREIGN KEY (`orderId`) REFERENCES `orderlist` (`orderId`) ON DELETE CASCADE ON UPDATE CASCADE
);



