-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 17, 2026 at 03:38 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ogani`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `image`) VALUES
(1, 'Fresh Fruits', NULL),
(2, 'Vegetables', 'https://images.pexels.com/photos/1414651/pexels-photo-1414651.jpeg?auto=compress&cs=tinysrgb&w=800'),
(3, 'Fresh Meat', 'https://images.pexels.com/photos/6187720/pexels-photo-6187720.jpeg?auto=compress&cs=tinysrgb&w=800'),
(4, 'Nuts', 'http://image');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `is_read` bit(1) DEFAULT NULL,
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp` datetime(6) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `message` text NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`is_read`, `notification_id`, `user_id`, `timestamp`, `type`, `message`, `title`) VALUES
(b'0', 1, 2, '2026-06-16 20:36:15.000000', 'INFO', 'We are glad to have you here. Check out our fresh products.', 'Welcome to Ogani!'),
(b'0', 2, 2, '2026-06-17 15:36:15.000000', 'PROMO', 'Use promo code FRESH20 for Rp 20.000 off your next purchase!', 'Promo Alert: FRESH20'),
(b'1', 3, 3, '2026-06-15 20:36:15.000000', 'ORDER', 'Your order has been delivered successfully. Enjoy your fresh produce!', 'Order Completed'),
(b'0', 4, 3, '2026-06-17 18:36:15.000000', 'PROMO', 'You have earned a special discount on meat products.', 'Special Discount'),
(b'0', 5, NULL, '2026-06-17 20:36:17.000000', 'order', 'Your order #21 has been successfully placed. We are processing it.', 'Order Placed successfully');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `address_id` int(11) DEFAULT NULL,
  `discount_amount` decimal(12,2) DEFAULT NULL,
  `order_id` int(11) NOT NULL,
  `payment_method_id` int(11) DEFAULT NULL,
  `shipping_cost` decimal(12,2) DEFAULT NULL,
  `subtotal_amount` decimal(12,2) DEFAULT NULL,
  `total_price` decimal(12,2) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `estimated_arrival` datetime(6) DEFAULT NULL,
  `order_time` datetime(6) DEFAULT NULL,
  `receiver_phone` varchar(20) DEFAULT NULL,
  `invoice_code` varchar(50) DEFAULT NULL,
  `receiver_name` varchar(100) DEFAULT NULL,
  `shipping_address` text DEFAULT NULL,
  `order_status` enum('pending','processing','shipped','completed','cancelled') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`address_id`, `discount_amount`, `order_id`, `payment_method_id`, `shipping_cost`, `subtotal_amount`, `total_price`, `user_id`, `estimated_arrival`, `order_time`, `receiver_phone`, `invoice_code`, `receiver_name`, `shipping_address`, `order_status`) VALUES
(NULL, NULL, 2, NULL, NULL, NULL, 175000.00, 3, NULL, '2026-06-08 20:36:14.000000', NULL, 'INV-1001', NULL, NULL, 'completed'),
(NULL, NULL, 3, NULL, NULL, NULL, 200000.00, 2, NULL, '2026-05-30 20:36:14.000000', NULL, 'INV-1002', NULL, NULL, 'completed'),
(NULL, NULL, 4, NULL, NULL, NULL, 225000.00, 3, NULL, '2026-05-21 20:36:14.000000', NULL, 'INV-1003', NULL, NULL, 'completed'),
(NULL, NULL, 5, NULL, NULL, NULL, 250000.00, 2, NULL, '2026-05-12 20:36:14.000000', NULL, 'INV-1004', NULL, NULL, 'pending'),
(NULL, NULL, 6, NULL, NULL, NULL, 275000.00, 3, NULL, '2026-05-03 20:36:14.000000', NULL, 'INV-1005', NULL, NULL, 'completed'),
(NULL, NULL, 7, NULL, NULL, NULL, 300000.00, 2, NULL, '2026-04-24 20:36:14.000000', NULL, 'INV-1006', NULL, NULL, 'completed'),
(NULL, NULL, 8, NULL, NULL, NULL, 325000.00, 3, NULL, '2026-04-15 20:36:14.000000', NULL, 'INV-1007', NULL, NULL, 'completed'),
(NULL, NULL, 9, NULL, NULL, NULL, 350000.00, 2, NULL, '2026-04-06 20:36:14.000000', NULL, 'INV-1008', NULL, NULL, 'pending'),
(NULL, NULL, 10, NULL, NULL, NULL, 375000.00, 3, NULL, '2026-03-28 20:36:14.000000', NULL, 'INV-1009', NULL, NULL, 'completed'),
(NULL, NULL, 11, NULL, NULL, NULL, 400000.00, 2, NULL, '2026-03-19 20:36:14.000000', NULL, 'INV-1010', NULL, NULL, 'completed'),
(NULL, NULL, 12, NULL, NULL, NULL, 425000.00, 3, NULL, '2026-03-10 20:36:14.000000', NULL, 'INV-1011', NULL, NULL, 'completed'),
(NULL, NULL, 13, NULL, NULL, NULL, 450000.00, 2, NULL, '2026-03-01 20:36:14.000000', NULL, 'INV-1012', NULL, NULL, 'pending'),
(NULL, NULL, 14, NULL, NULL, NULL, 475000.00, 3, NULL, '2026-02-20 20:36:14.000000', NULL, 'INV-1013', NULL, NULL, 'completed'),
(NULL, NULL, 15, NULL, NULL, NULL, 500000.00, 2, NULL, '2026-02-11 20:36:14.000000', NULL, 'INV-1014', NULL, NULL, 'completed'),
(NULL, NULL, 16, NULL, NULL, NULL, 525000.00, 3, NULL, '2026-02-02 20:36:14.000000', NULL, 'INV-1015', NULL, NULL, 'completed'),
(NULL, NULL, 17, NULL, NULL, NULL, 550000.00, 2, NULL, '2026-01-24 20:36:14.000000', NULL, 'INV-1016', NULL, NULL, 'pending'),
(NULL, NULL, 18, NULL, NULL, NULL, 575000.00, 3, NULL, '2026-01-15 20:36:14.000000', NULL, 'INV-1017', NULL, NULL, 'completed'),
(NULL, NULL, 19, NULL, NULL, NULL, 600000.00, 2, NULL, '2026-01-06 20:36:14.000000', NULL, 'INV-1018', NULL, NULL, 'completed'),
(NULL, NULL, 20, NULL, NULL, NULL, 625000.00, 3, NULL, '2025-12-28 20:36:15.000000', NULL, 'INV-1019', NULL, NULL, 'completed'),
(NULL, NULL, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `detail_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `price_at_order` decimal(12,2) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `subtotal` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_tracking`
--

CREATE TABLE `order_tracking` (
  `order_id` int(11) DEFAULT NULL,
  `tracking_id` int(11) NOT NULL,
  `timestamp` datetime(6) DEFAULT NULL,
  `courier_location` varchar(100) DEFAULT NULL,
  `status_update` varchar(100) NOT NULL,
  `courier_info` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

CREATE TABLE `payment_methods` (
  `payment_method_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `masked_number` varchar(50) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `provider` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment_methods`
--

INSERT INTO `payment_methods` (`payment_method_id`, `user_id`, `masked_number`, `type`, `provider`) VALUES
(1, NULL, NULL, 'Credit Card', 'Visa'),
(2, NULL, NULL, 'E-Wallet', 'GoPay');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `category_id` int(11) DEFAULT NULL,
  `price` decimal(12,2) NOT NULL,
  `product_id` int(11) NOT NULL,
  `stock` int(11) DEFAULT NULL,
  `weight_per_unit` decimal(10,2) DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `product_name` varchar(100) NOT NULL,
  `product_status` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `product_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`category_id`, `price`, `product_id`, `stock`, `weight_per_unit`, `unit`, `product_name`, `product_status`, `description`, `product_image`) VALUES
(1, 25000.00, 1, NULL, NULL, NULL, 'Apple Premium', NULL, NULL, NULL),
(1, 25000.00, 2, 100, NULL, NULL, 'Bananas', NULL, NULL, 'https://images.pexels.com/photos/2872755/pexels-photo-2872755.jpeg?auto=compress&cs=tinysrgb&w=800'),
(2, 15000.00, 3, 80, NULL, NULL, 'Carrots', NULL, NULL, 'https://images.pexels.com/photos/143133/pexels-photo-143133.jpeg?auto=compress&cs=tinysrgb&w=800'),
(3, 150000.00, 4, 20, NULL, NULL, 'Beef Steak', NULL, NULL, 'https://images.pexels.com/photos/361184/asparagus-steak-veal-steak-veal-361184.jpeg?auto=compress&cs=tinysrgb&w=800'),
(1, 10000.00, 5, 10, 1.00, 'kg', 'New Apple', 'In Stock', NULL, 'url');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `image_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `image_url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `promos`
--

CREATE TABLE `promos` (
  `discount_value` decimal(12,2) NOT NULL,
  `minimum_spend` decimal(12,2) DEFAULT NULL,
  `promo_id` int(11) NOT NULL,
  `expiration_date` datetime(6) NOT NULL,
  `promo_code` varchar(50) NOT NULL,
  `banner_image_url` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `promos`
--

INSERT INTO `promos` (`discount_value`, `minimum_spend`, `promo_id`, `expiration_date`, `promo_code`, `banner_image_url`, `description`, `title`) VALUES
(20000.00, 0.00, 2, '2026-07-02 20:36:14.000000', 'FRESH20', NULL, NULL, 'Fresh Produce Discount'),
(50000.00, 200000.00, 3, '2025-12-31 23:59:59.000000', 'HEMAT50', NULL, NULL, 'Hemat');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `product_id` int(11) DEFAULT NULL,
  `rating` int(11) NOT NULL,
  `review_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `review_date` datetime(6) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`product_id`, `rating`, `review_id`, `user_id`, `review_date`, `content`, `title`) VALUES
(1, 5, 1, 2, '2026-06-17 20:36:15.000000', 'Very fresh and delicious!', 'Great Apples'),
(2, 4, 2, 3, '2026-06-17 20:36:15.000000', 'Good quality, fast delivery.', 'Nice Bananas'),
(1, 3, 3, 2, '2026-06-17 20:36:15.000000', 'Bagus sekali produknya, kualitas sangat terjamin dan pengiriman cepat. (Review 0)', 'Sangat Puas 0'),
(2, 4, 4, 3, '2026-06-16 20:36:15.000000', 'Bagus sekali produknya, kualitas sangat terjamin dan pengiriman cepat. (Review 1)', 'Sangat Puas 1'),
(3, 5, 5, 2, '2026-06-15 20:36:15.000000', 'Bagus sekali produknya, kualitas sangat terjamin dan pengiriman cepat. (Review 2)', 'Sangat Puas 2'),
(4, 3, 6, 3, '2026-06-14 20:36:15.000000', 'Bagus sekali produknya, kualitas sangat terjamin dan pengiriman cepat. (Review 3)', 'Sangat Puas 3'),
(1, 4, 7, 2, '2026-06-13 20:36:15.000000', 'Bagus sekali produknya, kualitas sangat terjamin dan pengiriman cepat. (Review 4)', 'Sangat Puas 4'),
(2, 5, 8, 3, '2026-06-12 20:36:15.000000', 'Bagus sekali produknya, kualitas sangat terjamin dan pengiriman cepat. (Review 5)', 'Sangat Puas 5'),
(3, 3, 9, 2, '2026-06-11 20:36:15.000000', 'Bagus sekali produknya, kualitas sangat terjamin dan pengiriman cepat. (Review 6)', 'Sangat Puas 6'),
(4, 4, 10, 3, '2026-06-10 20:36:15.000000', 'Bagus sekali produknya, kualitas sangat terjamin dan pengiriman cepat. (Review 7)', 'Sangat Puas 7'),
(1, 5, 11, 2, '2026-06-09 20:36:15.000000', 'Bagus sekali produknya, kualitas sangat terjamin dan pengiriman cepat. (Review 8)', 'Sangat Puas 8'),
(2, 3, 12, 3, '2026-06-08 20:36:15.000000', 'Bagus sekali produknya, kualitas sangat terjamin dan pengiriman cepat. (Review 9)', 'Sangat Puas 9'),
(3, 4, 13, 2, '2026-06-07 20:36:15.000000', 'Bagus sekali produknya, kualitas sangat terjamin dan pengiriman cepat. (Review 10)', 'Sangat Puas 10'),
(4, 5, 14, 3, '2026-06-06 20:36:15.000000', 'Bagus sekali produknya, kualitas sangat terjamin dan pengiriman cepat. (Review 11)', 'Sangat Puas 11'),
(1, 3, 15, 2, '2026-06-05 20:36:15.000000', 'Bagus sekali produknya, kualitas sangat terjamin dan pengiriman cepat. (Review 12)', 'Sangat Puas 12'),
(2, 4, 16, 3, '2026-06-04 20:36:15.000000', 'Bagus sekali produknya, kualitas sangat terjamin dan pengiriman cepat. (Review 13)', 'Sangat Puas 13'),
(3, 5, 17, 2, '2026-06-03 20:36:15.000000', 'Bagus sekali produknya, kualitas sangat terjamin dan pengiriman cepat. (Review 14)', 'Sangat Puas 14');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `age` int(11) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `total_orders` int(11) DEFAULT NULL,
  `total_points` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `address` text DEFAULT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('ADMIN','CUSTOMER') NOT NULL DEFAULT 'CUSTOMER'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`age`, `birth_date`, `total_orders`, `total_points`, `user_id`, `phone_number`, `email`, `username`, `address`, `avatar_url`, `full_name`, `password`, `role`) VALUES
(NULL, NULL, 0, 150, 2, NULL, 'john@example.com', 'johndoe', NULL, NULL, 'John Doe', '$2a$10$Akic4rTnYEJ//Fp8XhqXY.nxb9qf.mSxAqygJXbma1DPCw4JAl1RG', 'CUSTOMER'),
(NULL, NULL, 0, 300, 3, NULL, 'alice@example.com', 'alicesmith', NULL, NULL, 'Alice Smith', '$2a$10$xnS8eU7coA7g6LUHA5NwH.4nxR9Dn0PgfgrNDOcKsXOSDfkHSqaq6', 'CUSTOMER'),
(NULL, NULL, 0, 0, 4, NULL, 'admin@ogani.com', 'admin', NULL, NULL, NULL, '$2a$10$QIt2gbXm54KyqPg1mecx/OSOkZURLK6b8WO9nPT.OuQSZj3ShKC7q', 'CUSTOMER'),
(NULL, NULL, 0, 0, 5, NULL, 'baru@test.com', 'userbaru', NULL, NULL, NULL, '$2a$10$HZ79QORmBLF8JAIhQczJ1eby91DUo6tS1pz.O.jLD2M/wLl3HDAt.', 'CUSTOMER');

-- --------------------------------------------------------

--
-- Table structure for table `user_addresses`
--

CREATE TABLE `user_addresses` (
  `address_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `coordinates` varchar(100) DEFAULT NULL,
  `full_address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_addresses`
--

INSERT INTO `user_addresses` (`address_id`, `user_id`, `phone_number`, `label`, `coordinates`, `full_address`) VALUES
(1, 2, NULL, NULL, NULL, '123 Main St, Jakarta 10000');

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `FKpu4bcbluhsxagirmbdn7dilm5` (`product_id`),
  ADD KEY `FKg5uhi8vpsuy0lgloxk2h4w5o6` (`user_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `FK9y21adhxn0ayjhfocscqox7bh` (`user_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD UNIQUE KEY `UK31s2ue419um0d1wdgsx10w2ls` (`invoice_code`),
  ADD KEY `FKebxbj09m4a87s8na3lr86xnf4` (`address_id`),
  ADD KEY `FKa03ljb6t6oa6mqtoifuwkb0kw` (`payment_method_id`),
  ADD KEY `FK32ql8ubntj5uh44ph9659tiih` (`user_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`detail_id`),
  ADD KEY `FKjyu2qbqt8gnvno9oe9j2s2ldk` (`order_id`),
  ADD KEY `FK4q98utpd73imf4yhttm3w0eax` (`product_id`);

--
-- Indexes for table `order_tracking`
--
ALTER TABLE `order_tracking`
  ADD PRIMARY KEY (`tracking_id`),
  ADD KEY `FKeu0lumcx8bcx6lk035xiklty0` (`order_id`);

--
-- Indexes for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`payment_method_id`),
  ADD KEY `FKin7rtmim3ljrrhh5kxbq27s2v` (`user_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `FKog2rp4qthbtt2lfyhfo32lsw9` (`category_id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `FKqnq71xsohugpqwf3c9gxmsuy` (`product_id`);

--
-- Indexes for table `promos`
--
ALTER TABLE `promos`
  ADD PRIMARY KEY (`promo_id`),
  ADD UNIQUE KEY `UKtbmrg7b7yy31my1j67bbmyyg2` (`promo_code`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `FKpl51cejpw4gy5swfar8br9ngi` (`product_id`),
  ADD KEY `FKcgy7qjc1r99dp117y9en6lxye` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`),
  ADD UNIQUE KEY `UK9q63snka3mdh91as4io72espi` (`phone_number`);

--
-- Indexes for table `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD PRIMARY KEY (`address_id`),
  ADD KEY `FKn2fisxyyu3l9wlch3ve2nocgp` (`user_id`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`product_id`,`user_id`),
  ADD KEY `FKtrd6335blsefl2gxpb8lr0gr7` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `detail_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_tracking`
--
ALTER TABLE `order_tracking`
  MODIFY `tracking_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `payment_method_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promos`
--
ALTER TABLE `promos`
  MODIFY `promo_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_addresses`
--
ALTER TABLE `user_addresses`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `FKg5uhi8vpsuy0lgloxk2h4w5o6` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `FKpu4bcbluhsxagirmbdn7dilm5` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `FK9y21adhxn0ayjhfocscqox7bh` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FK32ql8ubntj5uh44ph9659tiih` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `FKa03ljb6t6oa6mqtoifuwkb0kw` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`payment_method_id`),
  ADD CONSTRAINT `FKebxbj09m4a87s8na3lr86xnf4` FOREIGN KEY (`address_id`) REFERENCES `user_addresses` (`address_id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `FK4q98utpd73imf4yhttm3w0eax` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `FKjyu2qbqt8gnvno9oe9j2s2ldk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `order_tracking`
--
ALTER TABLE `order_tracking`
  ADD CONSTRAINT `FKeu0lumcx8bcx6lk035xiklty0` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD CONSTRAINT `FKin7rtmim3ljrrhh5kxbq27s2v` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `FKog2rp4qthbtt2lfyhfo32lsw9` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `FKqnq71xsohugpqwf3c9gxmsuy` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `FKcgy7qjc1r99dp117y9en6lxye` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `FKpl51cejpw4gy5swfar8br9ngi` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD CONSTRAINT `FKn2fisxyyu3l9wlch3ve2nocgp` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `FK6p7qhvy1bfkri13u29x6pu8au` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `FKtrd6335blsefl2gxpb8lr0gr7` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
