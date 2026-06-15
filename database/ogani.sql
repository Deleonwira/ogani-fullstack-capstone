-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 15, 2026 at 05:25 AM
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
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`cart_id`, `user_id`, `product_id`, `quantity`) VALUES
(6, 2, 1, 2),
(16, 3, 2, 1);

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
(1, 'Fruits', 'https://i.pinimg.com/736x/23/a3/ff/23a3ffac0623ea6d2bd0c8b16619964a.jpg'),
(2, 'Vegetables', 'https://i.pinimg.com/1200x/c8/6d/d7/c86dd70e9f9deb4d725c627a03e74891.jpg'),
(3, 'Beverages', 'https://i.pinimg.com/736x/d4/15/b8/d415b8cf493969d41ab218621c1fbaeb.jpg'),
(4, 'Dried Fruit', 'https://i.pinimg.com/736x/ab/da/b3/abdab3b2128705642e954665e3755748.jpg'),
(5, 'Fast Food', 'https://i.pinimg.com/1200x/23/6b/a5/236ba56962a3ba362a47fcbc634f206e.jpg'),
(6, 'Meat', 'https://i.pinimg.com/1200x/1d/2e/4e/1d2e4e5a92c50a80da8a6c180c742084.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `invoice_code` varchar(50) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `payment_method_id` int(11) DEFAULT NULL,
  `total_price` decimal(12,2) DEFAULT NULL,
  `subtotal_amount` decimal(12,2) DEFAULT NULL,
  `shipping_cost` decimal(12,2) DEFAULT NULL,
  `discount_amount` decimal(12,2) DEFAULT NULL,
  `order_status` enum('pending','processing','shipped','completed','cancelled') DEFAULT 'pending',
  `order_time` datetime DEFAULT current_timestamp(),
  `estimated_arrival` datetime DEFAULT NULL,
  `receiver_name` varchar(100) DEFAULT NULL,
  `receiver_phone` varchar(20) DEFAULT NULL,
  `shipping_address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `invoice_code`, `user_id`, `address_id`, `payment_method_id`, `total_price`, `subtotal_amount`, `shipping_cost`, `discount_amount`, `order_status`, `order_time`, `estimated_arrival`, `receiver_name`, `receiver_phone`, `shipping_address`) VALUES
(1, 'INV-68F3FFA231C57', 1, NULL, NULL, 30000.00, NULL, NULL, NULL, 'shipped', '2025-10-19 03:59:14', NULL, 'Jamaludin', '083123123', 'axkdnasd'),
(2, 'INV-68F479720E250', 1, NULL, NULL, 30000.00, NULL, NULL, NULL, 'pending', '2025-10-19 12:38:58', NULL, 'jamaldu', '12093123', 'iosajdasd'),
(3, 'INV-68F4CFC15F1F2', 1, NULL, NULL, 30000.00, NULL, NULL, NULL, 'processing', '2025-10-19 18:47:13', NULL, 'Jamaludin', '083103293225', 'Tangerang'),
(4, 'INV-68F506821A13B', 1, NULL, NULL, 62000.00, NULL, NULL, NULL, 'pending', '2025-10-19 22:40:50', NULL, 'asdkasd', 'asoidjasd', 'asdji0aisd'),
(5, 'INV-68F50D03A5978', 1, NULL, NULL, 40000.00, NULL, NULL, NULL, 'pending', '2025-10-19 23:08:35', NULL, 'lkasd', '123123', 'dsaasd'),
(6, 'INV-68F50D1B1A869', 1, NULL, NULL, 40000.00, NULL, NULL, NULL, 'pending', '2025-10-19 23:08:59', NULL, 'lkasd', '123123', 'dsaasd'),
(7, 'INV-68F50D432ED58', 1, NULL, NULL, 24000.00, NULL, NULL, NULL, 'pending', '2025-10-19 23:09:39', NULL, 'efgg', '971923', 'as;odojasd'),
(8, 'INV-68F5134B31DAC', 1, NULL, NULL, 30000.00, NULL, NULL, NULL, 'pending', '2025-10-19 23:35:23', NULL, 'Hamza Deleon', '083103293225', 'Tangerang');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `detail_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price_at_order` decimal(12,2) DEFAULT NULL,
  `subtotal` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`detail_id`, `order_id`, `product_id`, `quantity`, `price_at_order`, `subtotal`) VALUES
(1, 1, 4, 1, 10000.00, 10000.00),
(2, 1, 2, 1, 20000.00, 20000.00),
(3, 2, 1, 1, 30000.00, 30000.00),
(4, 3, 1, 1, 30000.00, 30000.00),
(5, 4, 7, 1, 12000.00, 12000.00),
(6, 4, 2, 1, 20000.00, 20000.00),
(7, 4, 1, 1, 30000.00, 30000.00),
(8, 5, 2, 2, 20000.00, 40000.00),
(9, 7, 3, 2, 12000.00, 24000.00),
(10, 8, 1, 1, 30000.00, 30000.00);

-- --------------------------------------------------------

--
-- Table structure for table `order_tracking`
--

CREATE TABLE `order_tracking` (
  `tracking_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `status_update` varchar(100) NOT NULL,
  `timestamp` datetime DEFAULT current_timestamp(),
  `courier_location` varchar(100) DEFAULT NULL,
  `courier_info` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

CREATE TABLE `payment_methods` (
  `payment_method_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `provider` varchar(100) NOT NULL,
  `masked_number` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(12,2) NOT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `weight_per_unit` decimal(10,2) DEFAULT NULL,
  `product_status` varchar(100) DEFAULT NULL,
  `stock` int(11) DEFAULT 0,
  `product_image` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `description`, `price`, `unit`, `weight_per_unit`, `product_status`, `stock`, `product_image`, `category_id`) VALUES
(1, 'Apple Fuji', 'Fresh Fuji apples imported from Japan', 30000.00, NULL, NULL, NULL, 93, 'https://i.pinimg.com/1200x/9f/48/90/9f48905995a8a3320f4cac90368fc4a1.jpg', 1),
(2, 'Banana Cavendish', 'Sweet Cavendish bananas per kg', 20000.00, NULL, NULL, NULL, 116, 'https://i.pinimg.com/736x/42/14/73/421473ceb7d77d9f36be61c8b77bc23f.jpg', 1),
(3, 'Broccoli', 'Organic green broccoli per 500g', 12000.00, NULL, NULL, NULL, 78, 'https://i.pinimg.com/1200x/91/c2/d5/91c2d5cb35f8db6bd9ab3cadcb2e65a3.jpg', 2),
(4, 'Carrot', 'Local fresh carrots per kg', 10000.00, NULL, NULL, NULL, 89, 'https://i.pinimg.com/1200x/62/2d/3d/622d3d6a9254162fe71459bdd26b016f.jpg', 2),
(5, 'Apple Juice', '600ML of Apple Juice', 22000.00, NULL, NULL, NULL, 60, 'https://i.pinimg.com/736x/ab/22/98/ab22987c0024f19f2c79b3fbf8fd27f9.jpg', 3),
(6, 'Soft Dried Dragon Fruit', 'Hand Selected Dragon Fruit', 20000.00, NULL, NULL, NULL, 150, 'https://i.pinimg.com/736x/33/19/18/331918d332a80266587e3267fb36bfd3.jpg', 4),
(7, 'Fried Chicken', 'Very Crunchy and Juicy', 12000.00, NULL, NULL, NULL, 90, 'https://i.pinimg.com/1200x/1b/c3/c1/1bc3c1feb503ba69895c5eaedcebbcfd.jpg', 5);

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
  `promo_id` int(11) NOT NULL,
  `promo_code` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `discount_value` decimal(12,2) NOT NULL,
  `minimum_spend` decimal(12,2) DEFAULT 0.00,
  `expiration_date` datetime NOT NULL,
  `banner_image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `title` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `review_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `role` enum('ADMIN','CUSTOMER') DEFAULT 'CUSTOMER',
  `avatar_url` varchar(255) DEFAULT NULL,
  `total_orders` int(11) DEFAULT 0,
  `total_points` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `full_name`, `password`, `phone_number`, `birth_date`, `age`, `address`, `role`, `avatar_url`, `total_orders`, `total_points`) VALUES
(1, 'deleonwira', 'deleonwira@gmail.com', NULL, '123', '081234567890', NULL, NULL, NULL, 'CUSTOMER', NULL, 0, 0),
(2, 'fathur', 'fathur@gmail.com', NULL, '123', '082198765432', NULL, NULL, NULL, 'CUSTOMER', NULL, 0, 0),
(3, 'Admin', 'admin@gmail.com', NULL, '123', '080000000000', NULL, NULL, NULL, 'CUSTOMER', NULL, 0, 0),
(4, 'jamaludin', 'jamaludin@gmail.com', NULL, '$2y$10$q3NRUUPs/4mKX7Op/6wUPe1/1V3fjZ/bkTt1qtbLg8t/4zr1S2fF6', '0182973123', NULL, NULL, NULL, 'CUSTOMER', NULL, 0, 0),
(5, 'eren', 'eren@gmail.com', NULL, '$2y$10$462ssbPOW83ustV/m/n2e.hpE71HamBoq8eBeIFZzI2PlvPK3YO7S', '10293123', NULL, NULL, NULL, 'CUSTOMER', NULL, 0, 0),
(7, 'johndoe2025', 'john.doe@example.com', 'John Doe', '$2a$10$vDvz7bfItBOUqULorVFNguz0crZa6xqUZEDLMje1Q3n0GF52/S.by', '082299887766', '1990-01-15', 35, 'Jl. Sudirman No. 456, Jakarta Selatan', 'CUSTOMER', NULL, 0, 0),
(8, 'admintest', 'admin@test.com', 'Admin Test User', '$2a$10$H5DnSy6ZHHfbKVyyGtcWoORjA3Hi2iGWQVVHOVxOHtWKgp4P9cGHq', '085512345678', '1985-03-20', 40, 'Jl. Admin Street No. 1, Jakarta', 'CUSTOMER', NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_addresses`
--

CREATE TABLE `user_addresses` (
  `address_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `full_address` text NOT NULL,
  `coordinates` varchar(100) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

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
  ADD KEY `fk_notifications_user` (`user_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD UNIQUE KEY `invoice_code` (`invoice_code`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `fk_orders_address` (`address_id`),
  ADD KEY `fk_orders_payment` (`payment_method_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`detail_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `order_tracking`
--
ALTER TABLE `order_tracking`
  ADD PRIMARY KEY (`tracking_id`),
  ADD KEY `fk_order_tracking` (`order_id`);

--
-- Indexes for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`payment_method_id`),
  ADD KEY `fk_user_payments` (`user_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `fk_product_images` (`product_id`);

--
-- Indexes for table `promos`
--
ALTER TABLE `promos`
  ADD PRIMARY KEY (`promo_id`),
  ADD UNIQUE KEY `promo_code` (`promo_code`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `fk_reviews_product` (`product_id`),
  ADD KEY `fk_reviews_user` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `unique_email` (`email`),
  ADD UNIQUE KEY `unique_phone` (`phone_number`),
  ADD KEY `idx_users_full_name` (`full_name`),
  ADD KEY `idx_users_phone` (`phone_number`),
  ADD KEY `idx_users_email` (`email`),
  ADD KEY `idx_users_username` (`username`);

--
-- Indexes for table `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD PRIMARY KEY (`address_id`),
  ADD KEY `fk_user_addresses` (`user_id`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`user_id`,`product_id`),
  ADD KEY `fk_wishlist_product` (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `order_tracking`
--
ALTER TABLE `order_tracking`
  MODIFY `tracking_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `payment_method_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promos`
--
ALTER TABLE `promos`
  MODIFY `promo_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user_addresses`
--
ALTER TABLE `user_addresses`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notifications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_address` FOREIGN KEY (`address_id`) REFERENCES `user_addresses` (`address_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_orders_payment` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`payment_method_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `order_tracking`
--
ALTER TABLE `order_tracking`
  ADD CONSTRAINT `fk_order_tracking` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE;

--
-- Constraints for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD CONSTRAINT `fk_user_payments` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `fk_product_images` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_reviews_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_reviews_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD CONSTRAINT `fk_user_addresses` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `fk_wishlist_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_wishlist_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
