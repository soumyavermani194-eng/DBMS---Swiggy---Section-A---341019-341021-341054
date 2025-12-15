CREATE DATABASE SwiggyDB;
USE SwiggyDB;
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(60) UNIQUE NOT NULL,
    phone CHAR(10) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    city VARCHAR(30),
    area VARCHAR(50),
    pincode CHAR(6),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
    ON DELETE CASCADE
);
CREATE TABLE Restaurant (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(60),
    city VARCHAR(30),
    rating DECIMAL(2,1) CHECK (rating BETWEEN 0 AND 5),
    is_active BOOLEAN DEFAULT TRUE
);
CREATE TABLE Menu_Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    category_name VARCHAR(40),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id)
    ON DELETE CASCADE
);
CREATE TABLE Menu_Item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    item_name VARCHAR(60),
    price DECIMAL(6,2) CHECK (price > 0),
    is_veg BOOLEAN,
    FOREIGN KEY (category_id) REFERENCES Menu_Category(category_id)
    ON DELETE CASCADE
);
CREATE TABLE Delivery_Partner (
    partner_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    phone CHAR(10) UNIQUE,
    vehicle_type ENUM('Bike','Scooter','Cycle'),
    availability_status ENUM('Available','Busy') DEFAULT 'Available'
);
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    partner_id INT,
    order_status ENUM('Placed','Preparing','Out for Delivery','Delivered','Cancelled'),
    order_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id),
    FOREIGN KEY (partner_id) REFERENCES Delivery_Partner(partner_id)
);
CREATE TABLE Order_Item (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT CHECK (quantity > 0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
    ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES Menu_Item(item_id)
);
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT UNIQUE,
    payment_mode ENUM('UPI','Card','Cash'),
    payment_status ENUM('Success','Failed','Pending'),
    amount DECIMAL(8,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
    ON DELETE CASCADE
);
CREATE TABLE Review (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment VARCHAR(200),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id)
);
