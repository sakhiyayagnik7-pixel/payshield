

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


-- Database: `payshield`
--

-- --------------------------------------------------------

--
-- Table structure for table `bank_accounts`
--

CREATE TABLE `bank_accounts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `bank_name` varchar(50) NOT NULL,
  `account_number` varchar(20) DEFAULT NULL,
  `ifsc_code` varchar(15) DEFAULT NULL,
  `debit_card_number` varchar(20) DEFAULT NULL,
  `upi_id` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `wallet_created` tinyint(1) DEFAULT 0,
  `wallet_created_at` timestamp NULL DEFAULT NULL,
  `wallet_balance` decimal(10,2) DEFAULT 0.00,
  `mpin_hash` varchar(255) DEFAULT NULL,
  `mpin_set_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bank_accounts`
--

INSERT INTO `bank_accounts` (`id`, `user_id`, `bank_name`, `account_number`, `ifsc_code`, `debit_card_number`, `upi_id`, `created_at`, `wallet_created`, `wallet_created_at`, `wallet_balance`, `mpin_hash`, `mpin_set_at`) VALUES
(1, 9, '', 'AC3318945445', 'PYSDJBDMAUB', '8158962793553331', 'user9@payshield', '2025-10-10 09:04:01', 1, '2025-11-03 07:02:13', 10000.00, NULL, NULL),
(13, 15, '', 'AC4585533782', 'PYSD7SXD4XO', '3600018154949992', 'user15@payshield', '2025-10-30 08:57:52', 1, '2025-11-05 03:30:55', 327775.00, NULL, NULL),
(26, 21, 'IDFC First Bank', '2222222222', 'SBIN0001234', '2222222222222222', 'user21@payshield', '2025-11-08 06:11:35', 1, '2025-11-08 00:43:02', 41260.00, 'scrypt:32768:8:1$T4803RbADOS7H4N6$c160ca7835c99d550990aca8495fe866b6de8e425902c3150df49ef2ca882aee9f893cc0418198c5e2849a72e0fc32ae26c264cffdf32878b451ccc3e25b2a8e', '2025-11-08 06:09:47'),
(28, 19, 'State Bank of India', '1111111111', 'SBIN0001234', '1111111111111111', 'user19@payshield', '2025-11-08 08:01:19', 1, '2025-11-08 02:37:08', 660965.00, 'scrypt:32768:8:1$yuM2knA0HExD1dUr$65b77266ebf5c1fd226cdca998264ae9e859be8e872a9568ea42dd4e5a6beca135268911b209f2cb4b8dcd585990218f37ddcf5716b1192413e4f02253e4d53e', '2025-11-08 02:37:39');

-- --------------------------------------------------------

--
-- Table structure for table `otp_logs`
--

CREATE TABLE `otp_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `otp_code` varchar(6) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` datetime NOT NULL,
  `is_used` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `otp_logs`
--

INSERT INTO `otp_logs` (`id`, `user_id`, `otp_code`, `created_at`, `expires_at`, `is_used`) VALUES
(1, 21, '537796', '2025-11-08 11:37:30', '2025-11-08 17:12:30', 1);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `tx_id` varchar(32) NOT NULL,
  `from_user_id` int(11) DEFAULT NULL,
  `to_user_id` int(11) DEFAULT NULL,
  `to_upi` varchar(100) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `status` enum('SUCCESS','FAILED') DEFAULT 'SUCCESS',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `tx_id`, `from_user_id`, `to_user_id`, `to_upi`, `amount`, `note`, `status`, `created_at`) VALUES
(1, 'e705176b3560455bbbfa', 19, 21, 'user21@payshield', 101.00, '', 'SUCCESS', '2025-11-08 08:13:54'),
(2, '42ad133e53c54288a59f', 19, 21, 'user21@payshield', 9899.00, '', 'SUCCESS', '2025-11-08 08:17:46'),
(3, 'f71d8e5844d14979976f', 19, 21, 'user21@payshield', 12345.00, '', 'SUCCESS', '2025-11-08 08:25:51'),
(4, '314613508ee246889010', 19, 21, 'user21@payshield', 12345.00, '', 'SUCCESS', '2025-11-08 08:28:07'),
(5, '5231fb741f1f4ee4806d', 19, 21, 'user21@payshield', 12345.00, '', 'SUCCESS', '2025-11-08 08:29:15'),
(6, 'fd0047a90ca44a7398a6', 19, 15, 'user15@payshield', 151000.00, 'etc.', 'SUCCESS', '2025-11-08 09:01:22'),
(7, '6438159dede34b368a15', 19, 15, 'user15@payshield', 151000.00, 'etc.', 'SUCCESS', '2025-11-08 09:04:55'),
(8, '9d62617523ef42bca510', 21, 15, 'user15@payshield', 151.00, 'aavyaaa', 'SUCCESS', '2025-11-08 11:41:07'),
(9, '22c443fff9a14471a190', 21, 15, 'user15@payshield', 151.00, 'aavyaaa', 'SUCCESS', '2025-11-08 11:51:53'),
(10, 'd871c9a7e18d42939e73', 21, 15, 'user15@payshield', 151.00, 'aavyaaa', 'SUCCESS', '2025-11-08 11:55:13'),
(11, 'a3f873906a0e43dba963', 21, 15, 'user15@payshield', 151.00, 'aavyaaa', 'SUCCESS', '2025-11-08 11:59:31'),
(12, 'e975eebdcb6c48ec9a16', 21, 15, 'user15@payshield', 151.00, 'aavyaaa', 'SUCCESS', '2025-11-08 12:00:56'),
(13, 'fbcb7630993d40a1b2d8', 21, 15, 'user15@payshield', 151.00, 'aavyaaa', 'SUCCESS', '2025-11-08 12:04:41'),
(14, '541310f500b14fdbb376', 21, 15, 'user15@payshield', 251.00, 'hello', 'SUCCESS', '2025-11-08 12:10:56'),
(15, '020282605f9543ac98a3', 21, 15, 'user15@payshield', 501.00, 'hello', 'SUCCESS', '2025-11-08 12:17:41'),
(16, 'fbd9b146f9bd463cb3f4', 21, 15, 'user15@payshield', 1001.00, '', 'SUCCESS', '2025-11-08 12:23:23'),
(17, '397c7efc7aee4fbb9a60', 21, 15, 'user15@payshield', 1001.00, '', 'SUCCESS', '2025-11-08 12:23:39'),
(18, '789112572cf54ef0a3ab', 21, 15, 'user15@payshield', 2001.00, 'abcdefg', 'SUCCESS', '2025-11-08 12:39:37'),
(19, '36cf3ad7a1ad4c19aed4', 21, 15, 'user15@payshield', 2001.00, 'aaa', 'SUCCESS', '2025-11-08 12:46:37'),
(20, '934aa612a1d3496fbe1d', 21, 15, 'user15@payshield', 2001.00, 'aaa', 'SUCCESS', '2025-11-08 13:39:39'),
(21, '1a4c89167b8c43bab335', 21, 15, 'user15@payshield', 5001.00, 'aaa', 'SUCCESS', '2025-11-08 13:43:34'),
(22, '87628c8b5edd481d8330', 21, 15, 'user15@payshield', 101.00, 'Dinner', 'SUCCESS', '2025-11-08 14:00:01'),
(23, '3a67150521e540a79d94', 21, 15, 'user15@payshield', 101.00, 'Dinner', 'SUCCESS', '2025-11-08 14:01:42'),
(24, '70d7a4785e74496faa38', 21, 15, 'user15@payshield', 101.00, 'Dinner', 'SUCCESS', '2025-11-08 14:02:46'),
(25, 'a6423b0673b04454ae88', 21, 15, 'user15@payshield', 101.00, 'Dinner', 'SUCCESS', '2025-11-08 14:04:58'),
(26, 'd1ee26cfa4d34203811f', 21, 15, 'user15@payshield', 101.00, 'Dinner', 'SUCCESS', '2025-11-08 14:17:12'),
(27, 'f3cdb9035d6e4feaa735', 21, 15, 'user15@payshield', 101.00, 'Dinner', 'SUCCESS', '2025-11-08 14:18:02'),
(28, '016a4b70670047f79375', 21, 15, 'user15@payshield', 101.00, 'Dinner', 'SUCCESS', '2025-11-08 14:18:06'),
(29, '46812bc1920849a28779', 21, 15, 'user15@payshield', 101.00, 'Dinner', 'SUCCESS', '2025-11-08 14:18:35'),
(30, '66148724ae95471f891d', 21, 15, 'user15@payshield', 101.00, 'Dinner', 'SUCCESS', '2025-11-08 14:18:51'),
(31, '2e38b516125040b99af9', 21, 15, 'user15@payshield', 101.00, 'Dinner', 'SUCCESS', '2025-11-08 14:19:11'),
(32, '78dbcf9e46124cfc9a76', 21, 15, 'user15@payshield', 101.00, 'Dinner', 'SUCCESS', '2025-11-08 14:39:25');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `mobileno` varchar(15) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `mobileno`, `password`, `created_at`) VALUES
(9, 'yagnik sakhiya', 'yagniksakhiya777@gmail.com', '1231314256', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '2025-10-09 10:51:08'),
(15, 'DHRUMIL DHAMELIYA', 'dhrumildhameliya789@gmail.com', '8160040291', 'bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a', '2025-10-30 08:57:19'),
(19, 'Dhrumil Dhameliya', 'dhrumildhameliy@gmail.com', '8160040291', 'bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a', '2025-11-05 09:04:32'),
(21, 'sakhiya yagnik', 'sakhiyayagnik7@gmail.com', '9876543212', 'bcb15f821479b4d5772bd0ca866c00ad5f926e3580720659cc80d39c9d09802a', '2025-11-08 06:10:21');

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `upi_id` varchar(50) NOT NULL,
  `balance` decimal(10,2) DEFAULT 10000.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_number` (`account_number`),
  ADD UNIQUE KEY `debit_card_number` (`debit_card_number`),
  ADD UNIQUE KEY `upi_id` (`upi_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `otp_logs`
--
ALTER TABLE `otp_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tx_id` (`tx_id`),
  ADD KEY `from_user_id` (`from_user_id`),
  ADD KEY `to_user_id` (`to_user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `upi_id` (`upi_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `otp_logs`
--
ALTER TABLE `otp_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  ADD CONSTRAINT `bank_accounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `otp_logs`
--
ALTER TABLE `otp_logs`
  ADD CONSTRAINT `otp_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `wallets`
--
ALTER TABLE `wallets`
  ADD CONSTRAINT `wallets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
