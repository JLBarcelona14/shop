/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1_3306
Source Server Version : 50505
Source Host           : 127.0.0.1:3306
Source Database       : sandwich_shop

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2020-11-25 11:39:34
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `user_id` (`user_id`),
  KEY `customer_shop` (`shop_id`),
  CONSTRAINT `customer_account` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  CONSTRAINT `customer_shop` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`shop_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('1', '1', null, 'Jhan', 'Trinidad', 'Male');
INSERT INTO `customer` VALUES ('2', '3', null, 'Raven', 'Reaving', 'Male');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `employee_id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `user_id` (`user_id`),
  KEY `employee_shop` (`shop_id`),
  CONSTRAINT `employee_account` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE,
  CONSTRAINT `employee_shop` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`shop_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES ('1', '1', null, 'John', 'Barcelona', 'Male', '1996-11-14', 'Santiago', 'PH');
INSERT INTO `employee` VALUES ('2', '3', null, 'James', 'Harden', 'Male', '2000-11-14', 'Cleveland, Ohio', 'US');
INSERT INTO `employee` VALUES ('3', '1', null, 'Lebron', 'James', 'Male', '1996-11-14', 'Cleveland, Ohio', 'US');
INSERT INTO `employee` VALUES ('4', '3', null, 'Dwayne', 'Wade', 'Male', '1996-11-14', 'Cleveland, Ohio', 'US');

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager` (
  `manager_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`manager_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `manager_account` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES ('1', null, 'Juan', 'Dela Cruz', '1987-12-25', 'Male', 'San Diego', 'US');
INSERT INTO `manager` VALUES ('2', null, 'Emanuel', 'Quezon', '1987-12-25', 'Male', 'San Diego', 'US');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `cash_received` decimal(11,2) DEFAULT NULL,
  `total_payment` decimal(11,2) DEFAULT NULL,
  `cash_change` decimal(11,2) DEFAULT NULL,
  `order_status` int(1) DEFAULT 0 COMMENT '0 = pending, 1 = preparing, 2 = complete',
  `order_date` date DEFAULT NULL,
  `order_time` time DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `order_shop` (`shop_id`),
  KEY `order_customer` (`customer_id`),
  KEY `order_employee` (`employee_id`),
  CONSTRAINT `order_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_employee` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_shop` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`shop_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('1', '1', '1', '1', '100.00', '70.00', '30.00', '1', '2020-11-22', '13:14:40', '2020-11-22 13:14:40', null, null);
INSERT INTO `orders` VALUES ('2', '1', '3', '1', '20.00', '15.00', '5.00', '1', '2020-11-22', '14:00:00', '2020-11-22 16:00:00', null, null);
INSERT INTO `orders` VALUES ('3', '3', '2', '2', '20.00', '20.00', '0.00', '1', '2020-11-22', '14:00:00', '2020-11-22 14:00:00', null, null);

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `order_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `each_price` decimal(11,2) DEFAULT NULL,
  `qty` int(2) DEFAULT NULL,
  PRIMARY KEY (`order_detail_id`),
  KEY `order` (`order_id`),
  KEY `order_product` (`product_id`),
  CONSTRAINT `order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES ('1', '1', '1', '1', '5.00', '10');
INSERT INTO `order_detail` VALUES ('2', '1', '1', '2', '10.00', '2');
INSERT INTO `order_detail` VALUES ('3', '1', '2', '1', '5.00', '1');
INSERT INTO `order_detail` VALUES ('4', '1', '2', '2', '5.00', '1');
INSERT INTO `order_detail` VALUES ('5', '3', '3', '4', '10.00', '2');
INSERT INTO `order_detail` VALUES ('6', '3', '3', '3', '10.00', '10');

-- ----------------------------
-- Table structure for order_detail_addon
-- ----------------------------
DROP TABLE IF EXISTS `order_detail_addon`;
CREATE TABLE `order_detail_addon` (
  `order_detail_addon_id` int(11) NOT NULL,
  `order_detail_id` int(11) DEFAULT NULL,
  `product_addon_id` int(11) DEFAULT NULL,
  `addon_each_price` decimal(11,10) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_detail_addon_id`),
  KEY `order_detail` (`order_detail_id`),
  KEY `addon_order` (`product_addon_id`),
  CONSTRAINT `addon_order` FOREIGN KEY (`product_addon_id`) REFERENCES `product_addon_detail` (`product_addon_id`) ON UPDATE CASCADE,
  CONSTRAINT `order_detail` FOREIGN KEY (`order_detail_id`) REFERENCES `order_detail` (`order_detail_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of order_detail_addon
-- ----------------------------

-- ----------------------------
-- Table structure for owner
-- ----------------------------
DROP TABLE IF EXISTS `owner`;
CREATE TABLE `owner` (
  `owner_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`owner_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `owner_account` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of owner
-- ----------------------------
INSERT INTO `owner` VALUES ('1', null, 'Tom', 'Tuesday', 'Male', '1979-12-30', 'New York', 'US');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `category` (`category_id`),
  KEY `shop_owner` (`shop_id`),
  CONSTRAINT `category` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`category_id`) ON UPDATE CASCADE,
  CONSTRAINT `shop_owner` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`shop_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('1', '1', '1', 'Tom’s  Sandwich', '#1 sandwich in the country', '5.00');
INSERT INTO `product` VALUES ('2', '1', '3', 'Coke', '#1 drinks in the country', '10.00');
INSERT INTO `product` VALUES ('3', '3', '2', 'Tom’s Sandwich', '#1 sandwich in the country', '5.00');
INSERT INTO `product` VALUES ('4', '3', '4', 'Corona', '#1 drinks in the country', '10.00');

-- ----------------------------
-- Table structure for product_addon_detail
-- ----------------------------
DROP TABLE IF EXISTS `product_addon_detail`;
CREATE TABLE `product_addon_detail` (
  `product_addon_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `add_on_name` varchar(255) DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`product_addon_id`),
  KEY `product` (`product_id`),
  CONSTRAINT `product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of product_addon_detail
-- ----------------------------
INSERT INTO `product_addon_detail` VALUES ('1', '1', 'bread', '2');
INSERT INTO `product_addon_detail` VALUES ('2', '1', 'cheese', '2');
INSERT INTO `product_addon_detail` VALUES ('3', '1', 'meat', '3');
INSERT INTO `product_addon_detail` VALUES ('4', '1', 'vegetable', '2');
INSERT INTO `product_addon_detail` VALUES ('5', '3', 'bread', '2');
INSERT INTO `product_addon_detail` VALUES ('6', '3', 'cheese', '2');
INSERT INTO `product_addon_detail` VALUES ('7', '3', 'meat', '3');
INSERT INTO `product_addon_detail` VALUES ('8', '3', 'vegetable', '2');

-- ----------------------------
-- Table structure for product_category
-- ----------------------------
DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) DEFAULT NULL,
  `category_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  KEY `shop` (`shop_id`),
  CONSTRAINT `shop` FOREIGN KEY (`shop_id`) REFERENCES `shop` (`shop_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of product_category
-- ----------------------------
INSERT INTO `product_category` VALUES ('1', '1', 'Sandwich');
INSERT INTO `product_category` VALUES ('2', '3', 'Sandwich');
INSERT INTO `product_category` VALUES ('3', '1', 'Drinks');
INSERT INTO `product_category` VALUES ('4', '3', 'Drinks');

-- ----------------------------
-- Table structure for shop
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop` (
  `shop_id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `store_name` varchar(255) DEFAULT NULL,
  `store_description` longtext DEFAULT NULL COMMENT 'EX:"Best sandwitch of all time"',
  `store_address` longtext DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `open_time` time DEFAULT NULL,
  `close_time` time DEFAULT NULL,
  PRIMARY KEY (`shop_id`),
  KEY `show_owner` (`owner_id`),
  KEY `shop_manager` (`manager_id`),
  CONSTRAINT `shop_manager` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`manager_id`) ON UPDATE CASCADE,
  CONSTRAINT `show_owner` FOREIGN KEY (`owner_id`) REFERENCES `owner` (`owner_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of shop
-- ----------------------------
INSERT INTO `shop` VALUES ('1', '1', '1', 'Tom’s Tuesday Sandwich', 'Number Sandwich in the country', 'Cleveland, Ohio.', 'US', '08:30:00', '22:30:00');
INSERT INTO `shop` VALUES ('3', '1', '2', 'Lake Erie Submarine', 'Number Sandwich in the country', 'San Diego, California', 'US', '08:30:00', '22:30:00');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `email_address` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` longtext DEFAULT NULL,
  `user_type` int(1) DEFAULT 4 COMMENT '1 = owner, 2 = manager, 3 = employee, 4 = customer',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user
-- ----------------------------
