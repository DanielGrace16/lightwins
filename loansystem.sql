-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 21, 2018 at 12:46 PM
-- Server version: 5.7.9
-- PHP Version: 7.1.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `loansystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `activations`
--

DROP TABLE IF EXISTS `activations`;
CREATE TABLE IF NOT EXISTS `activations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activations`
--

INSERT INTO `activations` (`id`, `user_id`, `code`, `completed`, `completed_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'n5gSW5azTEHBjCw3e7ZnWgQVifhqPWnM', 1, '2018-04-24 04:44:57', '2018-04-24 04:44:57', '2018-04-24 04:44:57'),
(2, 2, 'rnm96zuLvEl1Xd68RtnM8jLeoH7tQ3ZY', 1, '2018-04-24 08:37:52', '2018-04-24 08:37:52', '2018-04-24 08:37:52');

-- --------------------------------------------------------

--
-- Table structure for table `audit_trail`
--

DROP TABLE IF EXISTS `audit_trail`;
CREATE TABLE IF NOT EXISTS `audit_trail` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `module` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `charges`
--

DROP TABLE IF EXISTS `charges`;
CREATE TABLE IF NOT EXISTS `charges` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `product` enum('loan','savings','shares','client') COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge_type` enum('disbursement','disbursement_repayment','specified_due_date','installment_fee','overdue_installment_fee','loan_rescheduling_fee','overdue_maturity','savings_activation','withdrawal_fee','annual_fee','monthly_fee','activation','shares_purchase','shares_redeem') COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge_option` enum('flat','percentage','installment_principal_due','installment_principal_interest_due','installment_interest_due','installment_total_due','total_due','principal_due','interest_due','total_outstanding','original_principal') COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge_frequency` tinyint(4) NOT NULL DEFAULT '0',
  `charge_frequency_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'days',
  `charge_frequency_amount` int(11) NOT NULL DEFAULT '0',
  `amount` decimal(65,2) DEFAULT NULL,
  `minimum_amount` decimal(65,2) DEFAULT NULL,
  `maximum_amount` decimal(65,2) DEFAULT NULL,
  `charge_payment_mode` enum('regular','account_transfer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'regular',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `penalty` tinyint(4) NOT NULL DEFAULT '0',
  `override` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `gl_account_income_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `charges`
--

INSERT INTO `charges` (`id`, `created_by_id`, `name`, `currency_id`, `product`, `charge_type`, `charge_option`, `charge_frequency`, `charge_frequency_type`, `charge_frequency_amount`, `amount`, `minimum_amount`, `maximum_amount`, `charge_payment_mode`, `active`, `penalty`, `override`, `created_at`, `updated_at`, `gl_account_income_id`) VALUES
(1, 1, 'Registration Fee', 2, 'loan', 'disbursement', 'flat', 0, 'days', 0, '50.00', NULL, NULL, 'regular', 1, 0, 1, '2018-04-26 07:48:15', '2018-04-26 07:48:15', NULL),
(2, 1, 'Processing fee', 2, 'client', 'specified_due_date', 'flat', 0, 'days', 0, '20.00', NULL, NULL, 'regular', 1, 0, 1, '2018-04-26 07:52:19', '2018-04-26 07:52:19', 3),
(3, 1, 'Overdue Fee', 2, 'loan', 'overdue_installment_fee', 'installment_principal_due', 1, 'days', 3, '10.00', NULL, NULL, 'regular', 1, 0, 0, '2018-04-26 07:55:05', '2018-04-26 07:55:05', NULL),
(4, 1, 'Default', 1, 'savings', 'monthly_fee', 'flat', 0, 'days', 0, '5.00', NULL, NULL, 'regular', 1, 0, 0, '2018-05-10 09:00:19', '2018-05-10 09:00:19', NULL),
(5, 1, 'Activation Fee', 1, 'savings', 'savings_activation', 'flat', 0, 'days', 0, '10.00', NULL, NULL, 'regular', 1, 0, 0, '2018-05-10 09:00:51', '2018-05-10 09:00:51', NULL),
(6, 1, 'Specified', 1, 'savings', 'specified_due_date', 'flat', 0, 'days', 0, '123.00', NULL, NULL, 'regular', 1, 0, 0, '2018-05-10 18:15:22', '2018-05-10 18:15:22', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `country_id` int(11) DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `referred_by_id` int(11) DEFAULT NULL,
  `account_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `external_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `incorporation_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `picture` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('male','female','other','unspecified') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_type` enum('individual','business','ngo','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','active','inactive','declined','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `marital_status` enum('married','single','divorced','widowed','unspecified') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `street` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ward` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `joined_date` date DEFAULT NULL,
  `activated_date` date DEFAULT NULL,
  `reactivated_date` date DEFAULT NULL,
  `declined_date` date DEFAULT NULL,
  `declined_reason` text COLLATE utf8mb4_unicode_ci,
  `closed_reason` text COLLATE utf8mb4_unicode_ci,
  `closed_date` date DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `activated_by_id` int(11) DEFAULT NULL,
  `reactivated_by_id` int(11) DEFAULT NULL,
  `declined_by_id` int(11) DEFAULT NULL,
  `closed_by_id` int(11) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `country_id`, `office_id`, `user_id`, `staff_id`, `referred_by_id`, `account_no`, `external_id`, `title`, `first_name`, `middle_name`, `last_name`, `full_name`, `incorporation_number`, `display_name`, `picture`, `mobile`, `phone`, `email`, `gender`, `client_type`, `status`, `marital_status`, `dob`, `street`, `ward`, `district`, `region`, `address`, `joined_date`, `activated_date`, `reactivated_date`, `declined_date`, `declined_reason`, `closed_reason`, `closed_date`, `created_by_id`, `activated_by_id`, `reactivated_by_id`, `declined_by_id`, `closed_by_id`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 1, NULL, 2, NULL, '00234-1', 'jj', NULL, 'Tererai', 'James', 'Mugova', NULL, NULL, NULL, '00234_15adfb2113e6e8.jpeg', '774175438', NULL, 'tjmugova@webstudio.co.zw', 'male', 'individual', 'active', 'single', '2000-01-01', '933 Glenview 1', NULL, NULL, NULL, '933 Glenview 1', '2018-04-24', '2018-04-25', NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, 'kk', '2018-04-24 12:37:52', '2018-04-25 00:02:12', NULL),
(2, NULL, 1, NULL, 2, NULL, '00234-2', 'b24', NULL, NULL, NULL, NULL, 'Webstudio', 'wrr/2012', NULL, NULL, '774175438', NULL, 'tjmugova@webstudio.co.zw', NULL, 'business', 'active', NULL, NULL, '933 Glenview 1', NULL, NULL, NULL, '933 Glenview 1', '2018-04-24', '2018-05-07', NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-04-24 12:39:31', '2018-05-06 23:39:04', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `client_identifications`
--

DROP TABLE IF EXISTS `client_identifications`;
CREATE TABLE IF NOT EXISTS `client_identifications` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `client_identification_type_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `attachment` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `client_identifications`
--

INSERT INTO `client_identifications` (`id`, `client_id`, `client_identification_type_id`, `name`, `active`, `notes`, `attachment`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '14-199697C18', 0, 'National id', '14_199697c185adf82eb53a2b.png', '2018-04-24 19:18:03', '2018-04-24 19:18:03');

-- --------------------------------------------------------

--
-- Table structure for table `client_identification_types`
--

DROP TABLE IF EXISTS `client_identification_types`;
CREATE TABLE IF NOT EXISTS `client_identification_types` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `client_identification_types`
--

INSERT INTO `client_identification_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'National ID', NULL, NULL),
(2, 'Drivers License', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `client_next_of_kin`
--

DROP TABLE IF EXISTS `client_next_of_kin`;
CREATE TABLE IF NOT EXISTS `client_next_of_kin` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `client_relationship_id` int(11) DEFAULT NULL,
  `qualification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ward` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `street` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `picture` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('male','female','other','unspecified') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `client_next_of_kin`
--

INSERT INTO `client_next_of_kin` (`id`, `client_id`, `client_relationship_id`, `qualification`, `first_name`, `middle_name`, `last_name`, `ward`, `street`, `district`, `region`, `address`, `picture`, `mobile`, `phone`, `email`, `gender`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, 'Tererai', 'James', 'Mugova', NULL, NULL, NULL, NULL, '933 Glenview 1', '5adf9ad87befc.png', '774175438', NULL, NULL, 'male', 'kkf', '2018-04-24 21:00:08', '2018-04-24 21:48:48');

-- --------------------------------------------------------

--
-- Table structure for table `client_profession`
--

DROP TABLE IF EXISTS `client_profession`;
CREATE TABLE IF NOT EXISTS `client_profession` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `client_relationships`
--

DROP TABLE IF EXISTS `client_relationships`;
CREATE TABLE IF NOT EXISTS `client_relationships` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `client_relationships`
--

INSERT INTO `client_relationships` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Sibling', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `collateral`
--

DROP TABLE IF EXISTS `collateral`;
CREATE TABLE IF NOT EXISTS `collateral` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `loan_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `collateral_type_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` decimal(65,4) DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `serial` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `collateral`
--

INSERT INTO `collateral` (`id`, `loan_id`, `client_id`, `collateral_type_id`, `name`, `value`, `description`, `serial`, `created_at`, `updated_at`) VALUES
(1, 3, NULL, 1, NULL, '1200.0000', '4 set', 'dk', '2018-04-28 08:39:55', '2018-04-28 08:49:02');

-- --------------------------------------------------------

--
-- Table structure for table `collateral_types`
--

DROP TABLE IF EXISTS `collateral_types`;
CREATE TABLE IF NOT EXISTS `collateral_types` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `collateral_types`
--

INSERT INTO `collateral_types` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Sofa', '2018-04-27 21:13:42', '2018-04-27 21:13:42'),
(2, 'Tv', '2018-04-27 21:13:57', '2018-04-27 21:13:57');

-- --------------------------------------------------------

--
-- Table structure for table `communication_campaigns`
--

DROP TABLE IF EXISTS `communication_campaigns`;
CREATE TABLE IF NOT EXISTS `communication_campaigns` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` int(11) DEFAULT NULL,
  `type` enum('sms','email') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `report_start_date` date DEFAULT NULL,
  `report_start_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurrence_type` enum('none','schedule') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recur_frequency` enum('daily','monthly','weekly','yearly') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recur_interval` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_recipients` text COLLATE utf8mb4_unicode_ci,
  `email_subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci,
  `email_attachment_file_format` enum('pdf','csv','xls') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recipients_category` enum('all_clients','active_clients','prospective_clients','active_loans','loans_in_arrears','overdue_loans','happy_birthday') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `report_attachment` enum('loan_schedule','loan_statement','savings_statement','audit_report','group_indicator_report') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_day` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_day` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `office_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_officer_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gl_account_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manual_entries` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_product_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_run_date` date DEFAULT NULL,
  `next_run_date` date DEFAULT NULL,
  `last_run_time` date DEFAULT NULL,
  `next_run_time` date DEFAULT NULL,
  `number_of_runs` int(11) NOT NULL DEFAULT '0',
  `number_of_recipients` int(11) NOT NULL DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `sent` tinyint(4) NOT NULL DEFAULT '0',
  `status` enum('pending','approved','declined') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `approved_by_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
CREATE TABLE IF NOT EXISTS `countries` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sortname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `sortname`, `name`) VALUES
(1, 'AF', 'Afghanistan'),
(2, 'AL', 'Albania'),
(3, 'DZ', 'Algeria'),
(4, 'AS', 'American Samoa'),
(5, 'AD', 'Andorra'),
(6, 'AO', 'Angola'),
(7, 'AI', 'Anguilla'),
(8, 'AQ', 'Antarctica'),
(9, 'AG', 'Antigua And Barbuda'),
(10, 'AR', 'Argentina'),
(11, 'AM', 'Armenia'),
(12, 'AW', 'Aruba'),
(13, 'AU', 'Australia'),
(14, 'AT', 'Austria'),
(15, 'AZ', 'Azerbaijan'),
(16, 'BS', 'Bahamas The'),
(17, 'BH', 'Bahrain'),
(18, 'BD', 'Bangladesh'),
(19, 'BB', 'Barbados'),
(20, 'BY', 'Belarus'),
(21, 'BE', 'Belgium'),
(22, 'BZ', 'Belize'),
(23, 'BJ', 'Benin'),
(24, 'BM', 'Bermuda'),
(25, 'BT', 'Bhutan'),
(26, 'BO', 'Bolivia'),
(27, 'BA', 'Bosnia and Herzegovina'),
(28, 'BW', 'Botswana'),
(29, 'BV', 'Bouvet Island'),
(30, 'BR', 'Brazil'),
(31, 'IO', 'British Indian Ocean Territory'),
(32, 'BN', 'Brunei'),
(33, 'BG', 'Bulgaria'),
(34, 'BF', 'Burkina Faso'),
(35, 'BI', 'Burundi'),
(36, 'KH', 'Cambodia'),
(37, 'CM', 'Cameroon'),
(38, 'CA', 'Canada'),
(39, 'CV', 'Cape Verde'),
(40, 'KY', 'Cayman Islands'),
(41, 'CF', 'Central African Republic'),
(42, 'TD', 'Chad'),
(43, 'CL', 'Chile'),
(44, 'CN', 'China'),
(45, 'CX', 'Christmas Island'),
(46, 'CC', 'Cocos (Keeling) Islands'),
(47, 'CO', 'Colombia'),
(48, 'KM', 'Comoros'),
(49, 'CG', 'Congo'),
(50, 'CD', 'Congo The Democratic Republic Of The'),
(51, 'CK', 'Cook Islands'),
(52, 'CR', 'Costa Rica'),
(53, 'CI', 'Cote D''Ivoire (Ivory Coast)'),
(54, 'HR', 'Croatia (Hrvatska)'),
(55, 'CU', 'Cuba'),
(56, 'CY', 'Cyprus'),
(57, 'CZ', 'Czech Republic'),
(58, 'DK', 'Denmark'),
(59, 'DJ', 'Djibouti'),
(60, 'DM', 'Dominica'),
(61, 'DO', 'Dominican Republic'),
(62, 'TP', 'East Timor'),
(63, 'EC', 'Ecuador'),
(64, 'EG', 'Egypt'),
(65, 'SV', 'El Salvador'),
(66, 'GQ', 'Equatorial Guinea'),
(67, 'ER', 'Eritrea'),
(68, 'EE', 'Estonia'),
(69, 'ET', 'Ethiopia'),
(70, 'XA', 'External Territories of Australia'),
(71, 'FK', 'Falkland Islands'),
(72, 'FO', 'Faroe Islands'),
(73, 'FJ', 'Fiji Islands'),
(74, 'FI', 'Finland'),
(75, 'FR', 'France'),
(76, 'GF', 'French Guiana'),
(77, 'PF', 'French Polynesia'),
(78, 'TF', 'French Southern Territories'),
(79, 'GA', 'Gabon'),
(80, 'GM', 'Gambia The'),
(81, 'GE', 'Georgia'),
(82, 'DE', 'Germany'),
(83, 'GH', 'Ghana'),
(84, 'GI', 'Gibraltar'),
(85, 'GR', 'Greece'),
(86, 'GL', 'Greenland'),
(87, 'GD', 'Grenada'),
(88, 'GP', 'Guadeloupe'),
(89, 'GU', 'Guam'),
(90, 'GT', 'Guatemala'),
(91, 'XU', 'Guernsey and Alderney'),
(92, 'GN', 'Guinea'),
(93, 'GW', 'Guinea-Bissau'),
(94, 'GY', 'Guyana'),
(95, 'HT', 'Haiti'),
(96, 'HM', 'Heard and McDonald Islands'),
(97, 'HN', 'Honduras'),
(98, 'HK', 'Hong Kong S.A.R.'),
(99, 'HU', 'Hungary'),
(100, 'IS', 'Iceland'),
(101, 'IN', 'India'),
(102, 'ID', 'Indonesia'),
(103, 'IR', 'Iran'),
(104, 'IQ', 'Iraq'),
(105, 'IE', 'Ireland'),
(106, 'IL', 'Israel'),
(107, 'IT', 'Italy'),
(108, 'JM', 'Jamaica'),
(109, 'JP', 'Japan'),
(110, 'XJ', 'Jersey'),
(111, 'JO', 'Jordan'),
(112, 'KZ', 'Kazakhstan'),
(113, 'KE', 'Kenya'),
(114, 'KI', 'Kiribati'),
(115, 'KP', 'Korea North'),
(116, 'KR', 'Korea South'),
(117, 'KW', 'Kuwait'),
(118, 'KG', 'Kyrgyzstan'),
(119, 'LA', 'Laos'),
(120, 'LV', 'Latvia'),
(121, 'LB', 'Lebanon'),
(122, 'LS', 'Lesotho'),
(123, 'LR', 'Liberia'),
(124, 'LY', 'Libya'),
(125, 'LI', 'Liechtenstein'),
(126, 'LT', 'Lithuania'),
(127, 'LU', 'Luxembourg'),
(128, 'MO', 'Macau S.A.R.'),
(129, 'MK', 'Macedonia'),
(130, 'MG', 'Madagascar'),
(131, 'MW', 'Malawi'),
(132, 'MY', 'Malaysia'),
(133, 'MV', 'Maldives'),
(134, 'ML', 'Mali'),
(135, 'MT', 'Malta'),
(136, 'XM', 'Man (Isle of)'),
(137, 'MH', 'Marshall Islands'),
(138, 'MQ', 'Martinique'),
(139, 'MR', 'Mauritania'),
(140, 'MU', 'Mauritius'),
(141, 'YT', 'Mayotte'),
(142, 'MX', 'Mexico'),
(143, 'FM', 'Micronesia'),
(144, 'MD', 'Moldova'),
(145, 'MC', 'Monaco'),
(146, 'MN', 'Mongolia'),
(147, 'MS', 'Montserrat'),
(148, 'MA', 'Morocco'),
(149, 'MZ', 'Mozambique'),
(150, 'MM', 'Myanmar'),
(151, 'NA', 'Namibia'),
(152, 'NR', 'Nauru'),
(153, 'NP', 'Nepal'),
(154, 'AN', 'Netherlands Antilles'),
(155, 'NL', 'Netherlands The'),
(156, 'NC', 'New Caledonia'),
(157, 'NZ', 'New Zealand'),
(158, 'NI', 'Nicaragua'),
(159, 'NE', 'Niger'),
(160, 'NG', 'Nigeria'),
(161, 'NU', 'Niue'),
(162, 'NF', 'Norfolk Island'),
(163, 'MP', 'Northern Mariana Islands'),
(164, 'NO', 'Norway'),
(165, 'OM', 'Oman'),
(166, 'PK', 'Pakistan'),
(167, 'PW', 'Palau'),
(168, 'PS', 'Palestinian Territory Occupied'),
(169, 'PA', 'Panama'),
(170, 'PG', 'Papua new Guinea'),
(171, 'PY', 'Paraguay'),
(172, 'PE', 'Peru'),
(173, 'PH', 'Philippines'),
(174, 'PN', 'Pitcairn Island'),
(175, 'PL', 'Poland'),
(176, 'PT', 'Portugal'),
(177, 'PR', 'Puerto Rico'),
(178, 'QA', 'Qatar'),
(179, 'RE', 'Reunion'),
(180, 'RO', 'Romania'),
(181, 'RU', 'Russia'),
(182, 'RW', 'Rwanda'),
(183, 'SH', 'Saint Helena'),
(184, 'KN', 'Saint Kitts And Nevis'),
(185, 'LC', 'Saint Lucia'),
(186, 'PM', 'Saint Pierre and Miquelon'),
(187, 'VC', 'Saint Vincent And The Grenadines'),
(188, 'WS', 'Samoa'),
(189, 'SM', 'San Marino'),
(190, 'ST', 'Sao Tome and Principe'),
(191, 'SA', 'Saudi Arabia'),
(192, 'SN', 'Senegal'),
(193, 'RS', 'Serbia'),
(194, 'SC', 'Seychelles'),
(195, 'SL', 'Sierra Leone'),
(196, 'SG', 'Singapore'),
(197, 'SK', 'Slovakia'),
(198, 'SI', 'Slovenia'),
(199, 'XG', 'Smaller Territories of the UK'),
(200, 'SB', 'Solomon Islands'),
(201, 'SO', 'Somalia'),
(202, 'ZA', 'South Africa'),
(203, 'GS', 'South Georgia'),
(204, 'SS', 'South Sudan'),
(205, 'ES', 'Spain'),
(206, 'LK', 'Sri Lanka'),
(207, 'SD', 'Sudan'),
(208, 'SR', 'Suriname'),
(209, 'SJ', 'Svalbard And Jan Mayen Islands'),
(210, 'SZ', 'Swaziland'),
(211, 'SE', 'Sweden'),
(212, 'CH', 'Switzerland'),
(213, 'SY', 'Syria'),
(214, 'TW', 'Taiwan'),
(215, 'TJ', 'Tajikistan'),
(216, 'TZ', 'Tanzania'),
(217, 'TH', 'Thailand'),
(218, 'TG', 'Togo'),
(219, 'TK', 'Tokelau'),
(220, 'TO', 'Tonga'),
(221, 'TT', 'Trinidad And Tobago'),
(222, 'TN', 'Tunisia'),
(223, 'TR', 'Turkey'),
(224, 'TM', 'Turkmenistan'),
(225, 'TC', 'Turks And Caicos Islands'),
(226, 'TV', 'Tuvalu'),
(227, 'UG', 'Uganda'),
(228, 'UA', 'Ukraine'),
(229, 'AE', 'United Arab Emirates'),
(230, 'GB', 'United Kingdom'),
(231, 'US', 'United States'),
(232, 'UM', 'United States Minor Outlying Islands'),
(233, 'UY', 'Uruguay'),
(234, 'UZ', 'Uzbekistan'),
(235, 'VU', 'Vanuatu'),
(236, 'VA', 'Vatican City State (Holy See)'),
(237, 'VE', 'Venezuela'),
(238, 'VN', 'Vietnam'),
(239, 'VG', 'Virgin Islands (British)'),
(240, 'VI', 'Virgin Islands (US)'),
(241, 'WF', 'Wallis And Futuna Islands'),
(242, 'EH', 'Western Sahara'),
(243, 'YE', 'Yemen'),
(244, 'YU', 'Yugoslavia'),
(245, 'ZM', 'Zambia'),
(246, 'ZW', 'Zimbabwe');

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
CREATE TABLE IF NOT EXISTS `currencies` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `symbol` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `decimals` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '2',
  `xrate` decimal(65,8) DEFAULT NULL,
  `international_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `code`, `symbol`, `decimals`, `xrate`, `international_code`, `active`, `created_at`, `updated_at`) VALUES
(1, 'United Arab Emirates Dirham', 'AED', 'ARE', '2.00000000', '3.67310000', NULL, 1, NULL, NULL),
(2, 'Australian Dollar', 'AUD', '$', '2', '1.30887000', NULL, 1, NULL, NULL),
(3, 'Brazilian Real', 'BRL', 'R$', '2.00000000', '3.28990000', NULL, 1, NULL, NULL),
(4, 'Canadian Dollar', 'CAD', '$', '2.00000000', '1.28699000', NULL, 1, NULL, NULL),
(5, 'Swiss Franc', 'CHF', 'Fr', '2.00000000', '0.99879000', NULL, 1, NULL, NULL),
(6, 'Chilean Peso', 'CLP', '$', '2.00000000', '634.92703000', NULL, 1, NULL, NULL),
(7, 'Chinese Yuan', 'CNY', '¥', '2.00000000', '6.65090000', NULL, 1, NULL, NULL),
(8, 'Czech Koruna', 'CZK', 'Kč', '2.00000000', '22.07896000', NULL, 1, NULL, NULL),
(9, 'Danish Krone', 'DKK', 'kr', '2.00000000', '6.39641000', NULL, 1, NULL, NULL),
(10, 'Euro', 'EUR', '€', '2.00000000', '0.85947000', NULL, 1, NULL, NULL),
(11, 'British Pound', 'GBP', '£', '2.00000000', '0.76160000', NULL, 1, NULL, NULL),
(12, 'Hong Kong Dollar', 'HKD', '$', '2.00000000', '7.80429000', NULL, 1, NULL, NULL),
(13, 'Hungarian Forint', 'HUF', 'Ft', '2.00000000', '266.94000000', NULL, 1, NULL, NULL),
(14, 'Indonesian Rupiah', 'IDR', 'Rp', '2.00000000', '13579.08005000', NULL, 1, NULL, NULL),
(15, 'Israeli New Shekel', 'ILS', '₪', '2.00000000', '3.52770000', NULL, 1, NULL, NULL),
(16, 'Indian Rupee', 'INR', 'INR', '2.00000000', '65.02500000', NULL, 1, NULL, NULL),
(17, 'Japanese Yen', 'JPY', '¥', '2.00000000', '114.15367000', NULL, 1, NULL, NULL),
(18, 'Kenya shillings', 'KES', 'kes', '2.00000000', '103.83500000', NULL, 1, NULL, NULL),
(19, 'Korean Won', 'KRW', '₩', '2.00000000', '1130.15833000', NULL, 1, NULL, NULL),
(20, 'Mexican Peso', 'MXN', '$', '2.00000000', '19.22180000', NULL, 1, NULL, NULL),
(21, 'Malaysian Ringgit', 'MYR', 'RM', '2.00000000', '4.23999000', NULL, 1, NULL, NULL),
(22, 'Norwegian Krone', 'NOK', 'kr', '2.00000000', '8.18854000', NULL, 1, NULL, NULL),
(23, 'New Zealand Dollar', 'NZD', '$', '2.00000000', '1.46185000', NULL, 1, NULL, NULL),
(24, 'Philippine Peso', 'PHP', '₱', '2.00000000', '51.82000000', NULL, 1, NULL, NULL),
(25, 'Pakistan Rupee', 'PKR', '₨', '2.00000000', '105.34574000', NULL, 1, NULL, NULL),
(26, 'Polish Zloty', 'PLN', 'zł', '2.00000000', '3.65669000', NULL, 1, NULL, NULL),
(27, 'Russian Ruble', 'RUB', '₽', '2.00000000', '57.79350000', NULL, 1, NULL, NULL),
(28, 'Swedish Krona', 'SEK', 'kr', '2.00000000', '8.37433000', NULL, 1, NULL, NULL),
(29, 'Singapore Dollar', 'SGD', '$', '2.00000000', '1.36899000', NULL, 1, NULL, NULL),
(30, 'Thai Baht', 'THB', '฿', '2.00000000', '33.28950000', NULL, 1, NULL, NULL),
(31, 'Turkish Lira', 'TRY', '₺', '2.00000000', '3.82340000', NULL, 1, NULL, NULL),
(32, 'Taiwan Dollar', 'TWD', '$', '2.00000000', '30.27400000', NULL, 1, NULL, NULL),
(33, 'US Dollar', 'USD', '$', '2.00000000', '1.00000000', NULL, 1, NULL, NULL),
(34, 'Bolívar Fuerte', 'VEF', 'Bs.', '2.00000000', '10.06907000', NULL, 1, NULL, NULL),
(35, 'South African Rand', 'ZAR', 'R', '2.00000000', '14.24180000', NULL, 1, NULL, NULL),
(36, 'Zim Dollar', 'ZWD', '$', '2.00000000', NULL, NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
CREATE TABLE IF NOT EXISTS `documents` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` enum('client','loan','savings','identification','shares','repayment','group') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` text COLLATE utf8mb4_unicode_ci,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id`, `type`, `record_id`, `name`, `size`, `location`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'client', 1, 'Payslip', NULL, 'payslip5adf8cb38daaf.jpeg', 'payslip', '2018-04-24 19:59:47', '2018-04-24 19:59:47'),
(3, 'group', 2, 'Cash', NULL, 'cash5ae0438f58995.jpeg', 'ffg', '2018-04-25 08:59:59', '2018-04-25 08:59:59'),
(4, 'loan', 3, 'Test', NULL, 'test5ae38d30cf8c8.jpeg', 'test m', '2018-04-27 20:50:57', '2018-04-27 20:50:57');

-- --------------------------------------------------------

--
-- Table structure for table `funds`
--

DROP TABLE IF EXISTS `funds`;
CREATE TABLE IF NOT EXISTS `funds` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `funds`
--

INSERT INTO `funds` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Agriculture', '2018-04-25 14:28:39', '2018-04-25 14:28:39');

-- --------------------------------------------------------

--
-- Table structure for table `gl_accounts`
--

DROP TABLE IF EXISTS `gl_accounts`;
CREATE TABLE IF NOT EXISTS `gl_accounts` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `gl_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_type` enum('asset','liability','equity','income','expense') COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `manual_entries` tinyint(4) NOT NULL DEFAULT '1',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gl_accounts`
--

INSERT INTO `gl_accounts` (`id`, `name`, `parent_id`, `gl_code`, `account_type`, `active`, `manual_entries`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'Loan Portfolio', NULL, '00234', 'asset', 1, 1, 'For booking our loans', '2018-04-25 10:36:07', '2018-04-25 10:36:07'),
(2, 'Cash', 1, '002341', 'asset', 1, 1, 'Cash Account', '2018-04-25 10:45:26', '2018-04-25 10:46:17'),
(3, 'Test Income', NULL, '456', 'income', 1, 1, NULL, '2018-04-26 07:51:22', '2018-04-26 07:51:22'),
(4, 'Liabiliyu', NULL, '234', 'liability', 1, 1, NULL, '2018-04-26 16:14:41', '2018-04-26 16:14:41'),
(5, 'Equity', NULL, '2345', 'equity', 1, 1, NULL, '2018-04-26 16:14:58', '2018-04-26 16:14:58'),
(6, 'Expense', NULL, '1244', 'expense', 1, 1, NULL, '2018-04-26 16:15:18', '2018-04-26 16:15:18'),
(7, 'Fund Source', NULL, '100', 'asset', 1, 1, NULL, '2018-04-29 13:06:12', '2018-04-29 13:06:12'),
(8, 'Loan Portfolio', NULL, '101', 'asset', 1, 1, NULL, '2018-04-29 13:06:32', '2018-04-29 13:06:32'),
(9, 'Penalty Income', NULL, '200', 'income', 1, 1, NULL, '2018-04-29 13:07:06', '2018-04-29 13:07:06'),
(10, 'Interest Income', NULL, '201', 'income', 1, 1, NULL, '2018-04-29 13:07:26', '2018-04-29 13:07:26'),
(11, 'Fees Income', NULL, '202', 'income', 1, 1, NULL, '2018-04-29 13:07:48', '2018-04-29 13:07:48');

-- --------------------------------------------------------

--
-- Table structure for table `gl_closures`
--

DROP TABLE IF EXISTS `gl_closures`;
CREATE TABLE IF NOT EXISTS `gl_closures` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `office_id` int(11) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `closing_date` date NOT NULL,
  `modified_by_id` int(11) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `gl_reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gl_journal_entries`
--

DROP TABLE IF EXISTS `gl_journal_entries`;
CREATE TABLE IF NOT EXISTS `gl_journal_entries` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `office_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `gl_account_id` int(11) DEFAULT NULL,
  `transaction_type` enum('disbursement','accrual','deposit','withdrawal','manual_entry','pay_charge','transfer_fund','expense','payroll','income','fee','penalty','interest','dividend','guarantee','write_off','repayment','repayment_disbursement','repayment_recovery','interest_accrual','fee_accrual','savings','shares') COLLATE utf8mb4_unicode_ci DEFAULT 'repayment',
  `transaction_sub_type` enum('overpayment','repayment_interest','repayment_principal','repayment_fees','repayment_penalty') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `debit` decimal(65,4) DEFAULT NULL,
  `credit` decimal(65,4) DEFAULT NULL,
  `reversed` tinyint(4) NOT NULL DEFAULT '0',
  `name` text COLLATE utf8mb4_unicode_ci,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `loan_transaction_id` int(11) DEFAULT NULL,
  `savings_transaction_id` int(11) DEFAULT NULL,
  `shares_transaction_id` int(11) DEFAULT NULL,
  `payroll_transaction_id` int(11) DEFAULT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `month` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by_id` int(11) DEFAULT NULL,
  `modified_by_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `payment_detail_id` int(11) DEFAULT NULL,
  `reconciled` tinyint(4) NOT NULL DEFAULT '0',
  `approved` tinyint(4) NOT NULL DEFAULT '1',
  `approved_by_id` int(11) DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `approved_notes` text COLLATE utf8mb4_unicode_ci,
  `manual_entry` tinyint(4) NOT NULL DEFAULT '0',
  `gl_closure_id` int(11) DEFAULT NULL,
  `savings_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=465 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gl_journal_entries`
--

INSERT INTO `gl_journal_entries` (`id`, `office_id`, `currency_id`, `gl_account_id`, `transaction_type`, `transaction_sub_type`, `debit`, `credit`, `reversed`, `name`, `reference`, `loan_id`, `loan_transaction_id`, `savings_transaction_id`, `shares_transaction_id`, `payroll_transaction_id`, `transaction_id`, `date`, `month`, `year`, `notes`, `created_by_id`, `modified_by_id`, `created_at`, `updated_at`, `payment_detail_id`, `reconciled`, `approved`, `approved_by_id`, `approved_date`, `approved_notes`, `manual_entry`, `gl_closure_id`, `savings_id`) VALUES
(330, 1, 2, 2, 'repayment', NULL, '5.3400', NULL, 0, 'Interest Repayment', '216', 2, 216, NULL, NULL, NULL, NULL, '2018-02-01', '0', '2', NULL, NULL, NULL, '2018-05-03 23:42:42', '2018-05-03 23:42:42', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(329, 1, 2, 10, 'repayment', 'repayment_interest', NULL, '5.3400', 0, 'Interest Repayment', '216', 2, 216, NULL, NULL, NULL, NULL, '2018-02-01', '0', '2', NULL, NULL, NULL, '2018-05-03 23:42:42', '2018-05-03 23:42:42', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(328, 1, 2, 7, 'repayment', NULL, '144.6600', NULL, 0, 'Principal Repayment', '216', 2, 216, NULL, NULL, NULL, NULL, '2018-02-01', '0', '2', NULL, NULL, NULL, '2018-05-03 23:42:42', '2018-05-03 23:42:42', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(327, 1, 2, 1, 'repayment', 'repayment_principal', NULL, '144.6600', 0, 'Principal Repayment', '216', 2, 216, NULL, NULL, NULL, NULL, '2018-02-01', '0', '2', NULL, NULL, NULL, '2018-05-03 23:42:42', '2018-05-03 23:42:42', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(326, 1, 2, 10, 'accrual', NULL, NULL, '177.2200', 0, 'Accrued Interest', '2', 2, NULL, NULL, NULL, NULL, NULL, '2018-01-01', '04', '2018', NULL, 1, NULL, '2018-05-03 23:21:07', '2018-05-03 23:21:07', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(325, 1, 2, 2, 'accrual', NULL, '177.2200', NULL, 0, 'Accrued Interest', '2', 2, NULL, NULL, NULL, NULL, NULL, '2018-01-01', '04', '2018', NULL, 1, NULL, '2018-05-03 23:21:07', '2018-05-03 23:21:07', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(324, 1, 2, 1, 'disbursement', NULL, '5400.0000', NULL, 0, 'Loan Disbursement', '2', 2, NULL, NULL, NULL, NULL, NULL, '2018-01-01', '04', '2018', NULL, 1, NULL, '2018-05-03 23:21:07', '2018-05-03 23:21:07', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(323, 1, 2, 7, 'disbursement', NULL, NULL, '5400.0000', 0, 'Loan Disbursement', '2', 2, NULL, NULL, NULL, NULL, NULL, '2018-01-01', '04', '2018', NULL, 1, NULL, '2018-05-03 23:21:07', '2018-05-03 23:21:07', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(321, 1, 2, 11, 'fee', NULL, NULL, '52.0000', 0, 'Fee Income', '214', 2, 214, NULL, NULL, NULL, NULL, '2018-01-01', '01', '2018', NULL, 1, NULL, '2018-05-03 23:21:07', '2018-05-03 23:21:07', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(322, 1, 2, 7, 'fee', NULL, '52.0000', NULL, 0, 'Fee Income', '214', 2, 214, NULL, NULL, NULL, NULL, '2018-01-01', '01', '2018', NULL, 1, NULL, '2018-05-03 23:21:07', '2018-05-03 23:21:07', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(318, 1, 2, 1, 'repayment', NULL, '40.0000', NULL, 0, 'Fees Repayment', '206', 3, 206, NULL, NULL, NULL, NULL, '2018-05-03', '0', '2', NULL, NULL, NULL, '2018-05-03 11:01:11', '2018-05-11 17:22:17', NULL, 1, 1, NULL, NULL, NULL, 0, NULL, NULL),
(317, 1, 2, 11, 'repayment', 'repayment_fees', NULL, '40.0000', 0, 'Fees Repayment', '206', 3, 206, NULL, NULL, NULL, NULL, '2018-05-03', '0', '2', NULL, NULL, NULL, '2018-05-03 11:01:11', '2018-05-03 11:01:11', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(316, 1, 2, 2, 'repayment', NULL, '108.0700', NULL, 0, 'Interest Repayment', '206', 3, 206, NULL, NULL, NULL, NULL, '2018-05-03', '0', '2', NULL, NULL, NULL, '2018-05-03 11:01:11', '2018-05-03 11:01:11', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(315, 1, 2, 10, 'repayment', 'repayment_interest', NULL, '108.0700', 0, 'Interest Repayment', '206', 3, 206, NULL, NULL, NULL, NULL, '2018-05-03', '0', '2', NULL, NULL, NULL, '2018-05-03 11:01:11', '2018-05-11 17:32:20', NULL, 1, 1, NULL, NULL, NULL, 0, NULL, NULL),
(314, 1, 2, 7, 'repayment', NULL, '251.9300', NULL, 0, 'Principal Repayment', '206', 3, 206, NULL, NULL, NULL, NULL, '2018-05-03', '0', '2', NULL, NULL, NULL, '2018-05-03 11:01:11', '2018-05-03 11:01:11', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(313, 1, 2, 1, 'repayment', 'repayment_principal', NULL, '251.9300', 0, 'Principal Repayment', '206', 3, 206, NULL, NULL, NULL, NULL, '2018-05-03', '0', '2', NULL, NULL, NULL, '2018-05-03 11:01:11', '2018-05-06 01:58:17', NULL, 1, 1, NULL, NULL, NULL, 0, NULL, NULL),
(312, 1, 2, 10, 'accrual', NULL, NULL, '246.8500', 0, 'Accrued Interest', '3', 3, NULL, NULL, NULL, NULL, NULL, '2018-04-29', '07', '2018', NULL, 1, NULL, '2018-05-03 10:58:06', '2018-05-03 10:58:06', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(311, 1, 2, 2, 'accrual', NULL, '246.8500', NULL, 0, 'Accrued Interest', '3', 3, NULL, NULL, NULL, NULL, NULL, '2018-04-29', '07', '2018', NULL, 1, NULL, '2018-05-03 10:58:06', '2018-05-03 10:58:06', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(310, 1, 2, 1, 'disbursement', NULL, '1200.0000', NULL, 0, 'Loan Disbursement', '3', 3, NULL, NULL, NULL, NULL, NULL, '2018-04-29', '07', '2018', NULL, 1, NULL, '2018-05-03 10:58:06', '2018-05-03 10:58:06', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(309, 1, 2, 7, 'disbursement', NULL, NULL, '1200.0000', 0, 'Loan Disbursement', '3', 3, NULL, NULL, NULL, NULL, NULL, '2018-04-29', '07', '2018', NULL, 1, NULL, '2018-05-03 10:58:06', '2018-05-03 10:58:06', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(308, 1, 2, 7, 'fee', NULL, '52.0000', NULL, 0, 'Fee Income', '203', 3, 203, NULL, NULL, NULL, NULL, '2018-04-29', '04', '2018', NULL, 1, NULL, '2018-05-03 10:58:06', '2018-05-03 10:58:06', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(307, 1, 2, 11, 'fee', NULL, NULL, '52.0000', 0, 'Fee Income', '203', 3, 203, NULL, NULL, NULL, NULL, '2018-04-29', '04', '2018', NULL, 1, NULL, '2018-05-03 10:58:06', '2018-05-03 10:58:06', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(331, NULL, NULL, 1, 'manual_entry', NULL, NULL, '120.0000', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-06', '05', '2018', NULL, 1, NULL, '2018-05-06 00:17:34', '2018-05-11 17:22:17', 96, 1, 1, NULL, NULL, NULL, 1, NULL, NULL),
(332, NULL, NULL, 2, 'manual_entry', NULL, '120.0000', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-06', '05', '2018', NULL, 1, NULL, '2018-05-06 00:17:35', '2018-05-06 00:17:35', 96, 0, 1, NULL, NULL, NULL, 1, NULL, NULL),
(333, 1, 2, 11, 'fee', NULL, NULL, '50.0000', 0, 'Fee Income', '220', 6, 220, NULL, NULL, NULL, NULL, '2018-05-07', '05', '2018', NULL, 1, NULL, '2018-05-07 14:32:44', '2018-05-07 14:32:44', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(334, 1, 2, 7, 'fee', NULL, '50.0000', NULL, 0, 'Fee Income', '220', 6, 220, NULL, NULL, NULL, NULL, '2018-05-07', '05', '2018', NULL, 1, NULL, '2018-05-07 14:32:45', '2018-05-07 14:32:45', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(335, 1, 2, 7, 'disbursement', NULL, NULL, '4000.0000', 0, 'Loan Disbursement', '6', 6, NULL, NULL, NULL, NULL, NULL, '2018-05-07', '05', '2018', NULL, 1, NULL, '2018-05-07 14:32:45', '2018-05-07 14:32:45', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(336, 1, 2, 1, 'disbursement', NULL, '4000.0000', NULL, 0, 'Loan Disbursement', '6', 6, NULL, NULL, NULL, NULL, NULL, '2018-05-07', '05', '2018', NULL, 1, NULL, '2018-05-07 14:32:45', '2018-05-11 17:22:17', NULL, 1, 1, NULL, NULL, NULL, 0, NULL, NULL),
(337, 1, 2, 2, 'accrual', NULL, '359.4000', NULL, 0, 'Accrued Interest', '6', 6, NULL, NULL, NULL, NULL, NULL, '2018-05-07', '05', '2018', NULL, 1, NULL, '2018-05-07 14:32:45', '2018-05-07 14:32:45', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(338, 1, 2, 10, 'accrual', NULL, NULL, '359.4000', 0, 'Accrued Interest', '6', 6, NULL, NULL, NULL, NULL, NULL, '2018-05-07', '05', '2018', NULL, 1, NULL, '2018-05-07 14:32:45', '2018-05-07 14:32:45', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(339, 1, 2, 10, 'repayment', 'repayment_interest', NULL, '200.0000', 0, 'Interest Repayment', '221', 6, 221, NULL, NULL, NULL, NULL, '2018-05-07', '0', '2', NULL, NULL, NULL, '2018-05-07 17:04:31', '2018-05-07 17:04:31', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(340, 1, 2, 2, 'repayment', NULL, '200.0000', NULL, 0, 'Interest Repayment', '221', 6, 221, NULL, NULL, NULL, NULL, '2018-05-07', '0', '2', NULL, NULL, NULL, '2018-05-07 17:04:31', '2018-05-07 17:04:31', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(341, 1, 2, 1, 'repayment', 'repayment_principal', NULL, '100.0000', 0, 'Principal Repayment', '222', 6, 222, NULL, NULL, NULL, NULL, '2018-05-07', '0', '2', NULL, NULL, NULL, '2018-05-07 17:06:56', '2018-05-11 17:22:17', NULL, 1, 1, NULL, NULL, NULL, 0, NULL, NULL),
(342, 1, 2, 7, 'repayment', NULL, '100.0000', NULL, 0, 'Principal Repayment', '222', 6, 222, NULL, NULL, NULL, NULL, '2018-05-07', '0', '2', NULL, NULL, NULL, '2018-05-07 17:06:57', '2018-05-07 17:06:57', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(343, 1, 2, 1, 'repayment', 'repayment_principal', NULL, '120.0000', 0, 'Principal Repayment', '223', 6, 223, NULL, NULL, NULL, NULL, '2018-05-07', '0', '2', NULL, NULL, NULL, '2018-05-07 17:07:40', '2018-05-11 17:22:17', NULL, 1, 1, NULL, NULL, NULL, 0, NULL, NULL),
(344, 1, 2, 7, 'repayment', NULL, '120.0000', NULL, 0, 'Principal Repayment', '223', 6, 223, NULL, NULL, NULL, NULL, '2018-05-07', '0', '2', NULL, NULL, NULL, '2018-05-07 17:07:40', '2018-05-07 17:07:40', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(345, 1, 2, 1, 'repayment', 'repayment_principal', '25.0000', '25.0000', 1, 'Principal Repayment', '224', 6, 224, NULL, NULL, NULL, NULL, '2018-05-07', '0', '2', NULL, NULL, NULL, '2018-05-07 18:07:16', '2018-05-07 18:08:23', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(346, 1, 2, 7, 'repayment', NULL, '25.0000', '25.0000', 1, 'Principal Repayment', '224', 6, 224, NULL, NULL, NULL, NULL, '2018-05-07', '0', '2', NULL, NULL, NULL, '2018-05-07 18:07:16', '2018-05-07 18:08:23', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(347, 1, NULL, 3, 'pay_charge', NULL, NULL, '10.0000', 0, 'Charge', '1', NULL, NULL, 1, NULL, NULL, NULL, '2018-05-10', '05', '2018', NULL, 1, NULL, '2018-05-10 13:21:03', '2018-05-10 13:21:03', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(348, 1, NULL, 7, 'pay_charge', NULL, '10.0000', NULL, 0, 'Charge', '1', NULL, NULL, 1, NULL, NULL, NULL, '2018-05-10', '05', '2018', NULL, 1, NULL, '2018-05-10 13:21:03', '2018-05-10 13:21:03', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(349, 1, NULL, 4, 'withdrawal', NULL, '14.0000', NULL, 0, 'Withdrawal', '7', NULL, NULL, 7, NULL, NULL, NULL, '2018-05-10', '05', '2018', NULL, 1, NULL, '2018-05-10 15:26:00', '2018-05-10 15:26:00', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, 1),
(350, 1, NULL, 1, 'withdrawal', NULL, NULL, '14.0000', 0, 'Withdrawal', '7', NULL, NULL, 7, NULL, NULL, NULL, '2018-05-10', '05', '2018', NULL, 1, NULL, '2018-05-10 15:26:00', '2018-05-11 17:22:17', NULL, 1, 1, NULL, NULL, NULL, 0, NULL, 1),
(351, 1, NULL, 4, 'withdrawal', NULL, '25.0000', NULL, 0, 'Withdrawal', '8', NULL, NULL, 8, NULL, NULL, NULL, '2018-05-10', '05', '2018', NULL, 1, NULL, '2018-05-10 15:27:52', '2018-05-10 15:27:52', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, 1),
(352, 1, NULL, 1, 'withdrawal', NULL, NULL, '25.0000', 0, 'Withdrawal', '8', NULL, NULL, 8, NULL, NULL, NULL, '2018-05-10', '05', '2018', NULL, 1, NULL, '2018-05-10 15:27:52', '2018-05-11 17:22:17', NULL, 1, 1, NULL, NULL, NULL, 0, NULL, 1),
(353, 1, NULL, 3, 'pay_charge', NULL, NULL, '123.0000', 0, 'Charge', '9', NULL, NULL, 9, NULL, NULL, NULL, '2018-05-10', '05', '2018', NULL, 1, NULL, '2018-05-10 18:28:43', '2018-05-10 18:28:43', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, 1),
(354, 1, NULL, 4, 'pay_charge', NULL, '123.0000', NULL, 0, 'Charge', '9', NULL, NULL, 9, NULL, NULL, NULL, '2018-05-10', '05', '2018', NULL, 1, NULL, '2018-05-10 18:28:43', '2018-05-10 18:28:43', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, 1),
(355, 1, NULL, 1, 'deposit', NULL, '400.0000', NULL, 0, 'Deposit', '10', NULL, NULL, 10, NULL, NULL, NULL, '2018-05-10', '05', '2018', NULL, 1, NULL, '2018-05-10 18:29:10', '2018-05-11 17:22:17', NULL, 1, 1, NULL, NULL, NULL, 0, NULL, 1),
(356, 1, NULL, 4, 'deposit', NULL, NULL, '400.0000', 0, 'Deposit', '10', NULL, NULL, 10, NULL, NULL, NULL, '2018-05-10', '05', '2018', NULL, 1, NULL, '2018-05-10 18:29:10', '2018-05-10 18:29:10', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, 1),
(357, 1, 2, 1, 'repayment', 'repayment_principal', NULL, '153.8000', 0, 'Principal Repayment', '234', 6, 234, NULL, NULL, NULL, NULL, '2018-05-11', '0', '2', NULL, NULL, NULL, '2018-05-11 20:46:45', '2018-05-11 20:46:45', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(358, 1, 2, 7, 'repayment', NULL, '153.8000', NULL, 0, 'Principal Repayment', '234', 6, 234, NULL, NULL, NULL, NULL, '2018-05-11', '0', '2', NULL, NULL, NULL, '2018-05-11 20:46:46', '2018-05-11 20:46:46', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(359, 1, NULL, 1, 'deposit', NULL, '134.0000', NULL, 0, 'Deposit', '11', NULL, NULL, 11, NULL, NULL, NULL, '2018-05-13', '05', '2018', NULL, 1, NULL, '2018-05-12 23:26:48', '2018-05-12 23:26:48', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, 1),
(360, 1, NULL, 4, 'deposit', NULL, NULL, '134.0000', 0, 'Deposit', '11', NULL, NULL, 11, NULL, NULL, NULL, '2018-05-13', '05', '2018', NULL, 1, NULL, '2018-05-12 23:26:48', '2018-05-12 23:26:48', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, 1),
(361, 1, NULL, 4, 'withdrawal', NULL, '54.0000', NULL, 0, 'Withdrawal', '12', NULL, NULL, 12, NULL, NULL, NULL, '2018-05-13', '05', '2018', NULL, 1, NULL, '2018-05-12 23:39:27', '2018-05-12 23:39:27', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, 1),
(362, 1, NULL, 1, 'withdrawal', NULL, NULL, '54.0000', 0, 'Withdrawal', '12', NULL, NULL, 12, NULL, NULL, NULL, '2018-05-13', '05', '2018', NULL, 1, NULL, '2018-05-12 23:39:27', '2018-05-12 23:39:27', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, 1),
(363, 1, NULL, 4, 'withdrawal', NULL, '35.0000', NULL, 0, 'Withdrawal', '13', NULL, NULL, 13, NULL, NULL, NULL, '2018-05-13', '05', '2018', NULL, 1, NULL, '2018-05-12 23:40:05', '2018-05-12 23:40:05', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, 1),
(364, 1, NULL, 1, 'withdrawal', NULL, NULL, '35.0000', 0, 'Withdrawal', '13', NULL, NULL, 13, NULL, NULL, NULL, '2018-05-13', '05', '2018', NULL, 1, NULL, '2018-05-12 23:40:05', '2018-05-12 23:40:05', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, 1),
(365, 1, NULL, 3, 'pay_charge', NULL, NULL, '10.0000', 0, 'Charge', '14', NULL, NULL, 2, NULL, NULL, NULL, '2018-05-15', '05', '2018', NULL, 1, NULL, '2018-05-15 12:40:35', '2018-05-15 12:40:35', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(366, 1, NULL, 7, 'pay_charge', NULL, '10.0000', NULL, 0, 'Charge', '14', NULL, NULL, 2, NULL, NULL, NULL, '2018-05-15', '05', '2018', NULL, 1, NULL, '2018-05-15 12:40:35', '2018-05-15 12:40:35', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(462, 1, 2, 10, 'accrual', NULL, NULL, '149.5600', 0, 'Accrued Interest', '7', 7, NULL, NULL, NULL, NULL, NULL, '2018-05-01', '05', '2018', NULL, 1, NULL, '2018-05-15 21:07:25', '2018-05-15 21:07:25', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(461, 1, 2, 2, 'accrual', NULL, '149.5600', NULL, 0, 'Accrued Interest', '7', 7, NULL, NULL, NULL, NULL, NULL, '2018-05-01', '05', '2018', NULL, 1, NULL, '2018-05-15 21:07:25', '2018-05-15 21:07:25', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(460, 1, 2, 1, 'disbursement', NULL, '4000.0000', NULL, 0, 'Loan Disbursement', '7', 7, NULL, NULL, NULL, NULL, NULL, '2018-05-01', '05', '2018', NULL, 1, NULL, '2018-05-15 21:07:25', '2018-05-15 21:07:25', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(459, 1, 2, 7, 'disbursement', NULL, NULL, '4000.0000', 0, 'Loan Disbursement', '7', 7, NULL, NULL, NULL, NULL, NULL, '2018-05-01', '05', '2018', NULL, 1, NULL, '2018-05-15 21:07:25', '2018-05-15 21:07:25', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(458, 1, 2, 7, 'fee', NULL, '50.0000', NULL, 0, 'Fee Income', '298', 7, 298, NULL, NULL, NULL, NULL, '2018-05-01', '05', '2018', NULL, 1, NULL, '2018-05-15 21:07:25', '2018-05-15 21:07:25', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(457, 1, 2, 11, 'fee', NULL, NULL, '50.0000', 0, 'Fee Income', '298', 7, 298, NULL, NULL, NULL, NULL, '2018-05-01', '05', '2018', NULL, 1, NULL, '2018-05-15 21:07:25', '2018-05-15 21:07:25', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(463, 1, 2, 1, 'write_off', NULL, NULL, '4000.0000', 0, 'Principal Written Off', '7', 7, 299, NULL, NULL, NULL, NULL, '2018-05-16', '05', '2018', NULL, 1, NULL, '2018-05-16 00:24:52', '2018-05-16 00:24:52', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL),
(464, 1, 2, 6, 'write_off', NULL, '4000.0000', NULL, 0, 'Loan Written Off', '7', 7, 299, NULL, NULL, NULL, NULL, '2018-05-16', '05', '2018', NULL, 1, NULL, '2018-05-16 00:24:52', '2018-05-16 00:24:52', NULL, 0, 1, NULL, NULL, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `office_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `external_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `joined_date` date DEFAULT NULL,
  `activated_date` date DEFAULT NULL,
  `reactivated_date` date DEFAULT NULL,
  `declined_date` date DEFAULT NULL,
  `declined_reason` text COLLATE utf8mb4_unicode_ci,
  `closed_reason` text COLLATE utf8mb4_unicode_ci,
  `closed_date` date DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `activated_by_id` int(11) DEFAULT NULL,
  `reactivated_by_id` int(11) DEFAULT NULL,
  `declined_by_id` int(11) DEFAULT NULL,
  `closed_by_id` int(11) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `street` text COLLATE utf8mb4_unicode_ci,
  `address` text COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','active','inactive','declined','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `office_id`, `name`, `external_id`, `account_no`, `staff_id`, `joined_date`, `activated_date`, `reactivated_date`, `declined_date`, `declined_reason`, `closed_reason`, `closed_date`, `created_by_id`, `activated_by_id`, `reactivated_by_id`, `declined_by_id`, `closed_by_id`, `notes`, `mobile`, `email`, `street`, `address`, `status`, `phone`, `created_at`, `updated_at`) VALUES
(1, 1, 'Sungano', '124c', NULL, 2, '2018-04-25', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 'A micro group', '774175438', 'tjmugova@webstudio.co.zw', '933 Glenview 1', '933 Glenview 1', 'pending', NULL, '2018-04-25 07:59:07', '2018-04-25 07:59:07'),
(2, 1, 'Herp', '124c', '00234-2', 2, '2018-04-25', '2018-04-25', NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, 'A micro group', '774175438', 'tjmugova@webstudio.co.zw', '933 Glenview 1', '933 Glenview 1', 'active', NULL, '2018-04-25 08:01:10', '2018-04-25 09:00:28');

-- --------------------------------------------------------

--
-- Table structure for table `group_clients`
--

DROP TABLE IF EXISTS `group_clients`;
CREATE TABLE IF NOT EXISTS `group_clients` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `group_clients`
--

INSERT INTO `group_clients` (`id`, `group_id`, `client_id`, `created_at`, `updated_at`) VALUES
(2, 2, 1, '2018-04-25 08:58:51', '2018-04-25 08:58:51');

-- --------------------------------------------------------

--
-- Table structure for table `group_loan_allocation`
--

DROP TABLE IF EXISTS `group_loan_allocation`;
CREATE TABLE IF NOT EXISTS `group_loan_allocation` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `loan_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `amount` decimal(65,4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `group_loan_allocation`
--

INSERT INTO `group_loan_allocation` (`id`, `loan_id`, `group_id`, `client_id`, `amount`, `created_at`, `updated_at`) VALUES
(3, 6, 2, 1, '4000.0000', '2018-05-07 13:46:07', '2018-05-07 13:46:07');

-- --------------------------------------------------------

--
-- Table structure for table `guarantors`
--

DROP TABLE IF EXISTS `guarantors`;
CREATE TABLE IF NOT EXISTS `guarantors` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `country_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `is_client` tinyint(4) NOT NULL DEFAULT '0',
  `client_relationship_id` int(11) DEFAULT NULL,
  `amount` decimal(65,4) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `middle_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `street` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `picture` text COLLATE utf8mb4_unicode_ci,
  `work` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `work_address` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `guarantors`
--

INSERT INTO `guarantors` (`id`, `country_id`, `client_id`, `loan_id`, `is_client`, `client_relationship_id`, `amount`, `title`, `first_name`, `middle_name`, `last_name`, `dob`, `street`, `address`, `mobile`, `phone`, `picture`, `work`, `work_address`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 3, 1, 1, '10000.0000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-28 20:53:20', '2018-04-28 20:53:20');

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

DROP TABLE IF EXISTS `loans`;
CREATE TABLE IF NOT EXISTS `loans` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_type` enum('client','group') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'client',
  `loan_product_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `fund_id` int(11) DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `decimals` int(11) NOT NULL DEFAULT '2',
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `external_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_officer_id` int(11) DEFAULT NULL,
  `loan_purpose_id` int(11) DEFAULT NULL,
  `principal` decimal(65,4) DEFAULT NULL,
  `principal_derived` decimal(65,4) DEFAULT NULL,
  `interest_derived` decimal(65,4) DEFAULT NULL,
  `fees_derived` decimal(65,4) DEFAULT NULL,
  `penalty_derived` decimal(65,4) DEFAULT NULL,
  `disbursement_fees` decimal(65,4) DEFAULT NULL,
  `processing_fee` decimal(65,4) DEFAULT NULL,
  `loan_term` int(11) DEFAULT NULL,
  `loan_term_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `repayment_frequency` int(11) DEFAULT NULL,
  `repayment_frequency_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approved_amount` decimal(65,4) DEFAULT NULL,
  `applied_amount` decimal(65,4) DEFAULT NULL,
  `interest_rate` decimal(65,4) DEFAULT NULL,
  `interest_rate_type` enum('day','week','month','year') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expected_disbursement_date` date DEFAULT NULL,
  `disbursement_date` date DEFAULT NULL,
  `expected_maturity_date` date DEFAULT NULL,
  `expected_first_repayment_date` date DEFAULT NULL,
  `repayments_number` int(11) DEFAULT NULL,
  `first_repayment_date` date DEFAULT NULL,
  `interest_method` enum('flat','declining_balance') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `armotization_method` enum('equal_installment','equal_principal') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grace_on_interest_charged` int(11) DEFAULT NULL,
  `grace_on_principal` int(11) DEFAULT NULL,
  `grace_on_interest_payment` int(11) DEFAULT NULL,
  `status` enum('new','pending','approved','need_changes','disbursed','declined','withdrawn','written_off','closed','pending_reschedule','rescheduled','paid') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_by_id` int(11) DEFAULT NULL,
  `modified_by_id` int(11) DEFAULT NULL,
  `approved_by_id` int(11) DEFAULT NULL,
  `disbursed_by_id` int(11) DEFAULT NULL,
  `need_changes_by_id` int(11) DEFAULT NULL,
  `withdrawn_by_id` int(11) DEFAULT NULL,
  `declined_by_id` int(11) DEFAULT NULL,
  `written_off_by_id` int(11) DEFAULT NULL,
  `rescheduled_by_id` int(11) DEFAULT NULL,
  `closed_by_id` int(11) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `modified_date` date DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `need_changes_date` date DEFAULT NULL,
  `withdrawn_date` date DEFAULT NULL,
  `declined_date` date DEFAULT NULL,
  `written_off_date` date DEFAULT NULL,
  `rescheduled_date` date DEFAULT NULL,
  `closed_date` date DEFAULT NULL,
  `month` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `approved_notes` text COLLATE utf8mb4_unicode_ci,
  `declined_notes` text COLLATE utf8mb4_unicode_ci,
  `written_off_notes` text COLLATE utf8mb4_unicode_ci,
  `disbursed_notes` text COLLATE utf8mb4_unicode_ci,
  `withdrawn_notes` text COLLATE utf8mb4_unicode_ci,
  `rescheduled_notes` text COLLATE utf8mb4_unicode_ci,
  `closed_notes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loans`
--

INSERT INTO `loans` (`id`, `client_type`, `loan_product_id`, `client_id`, `group_id`, `fund_id`, `office_id`, `currency_id`, `decimals`, `account_number`, `external_id`, `loan_officer_id`, `loan_purpose_id`, `principal`, `principal_derived`, `interest_derived`, `fees_derived`, `penalty_derived`, `disbursement_fees`, `processing_fee`, `loan_term`, `loan_term_type`, `repayment_frequency`, `repayment_frequency_type`, `approved_amount`, `applied_amount`, `interest_rate`, `interest_rate_type`, `expected_disbursement_date`, `disbursement_date`, `expected_maturity_date`, `expected_first_repayment_date`, `repayments_number`, `first_repayment_date`, `interest_method`, `armotization_method`, `grace_on_interest_charged`, `grace_on_principal`, `grace_on_interest_payment`, `status`, `created_by_id`, `modified_by_id`, `approved_by_id`, `disbursed_by_id`, `need_changes_by_id`, `withdrawn_by_id`, `declined_by_id`, `written_off_by_id`, `rescheduled_by_id`, `closed_by_id`, `created_date`, `modified_date`, `approved_date`, `need_changes_date`, `withdrawn_date`, `declined_date`, `written_off_date`, `rescheduled_date`, `closed_date`, `month`, `year`, `notes`, `created_at`, `updated_at`, `deleted_at`, `approved_notes`, `declined_notes`, `written_off_notes`, `disbursed_notes`, `withdrawn_notes`, `rescheduled_notes`, `closed_notes`) VALUES
(1, 'client', 3, 1, NULL, 1, 1, 2, 2, NULL, NULL, 2, 1, '100.0000', NULL, NULL, NULL, NULL, NULL, NULL, 100, 'days', 1, 'days', NULL, NULL, '2.0000', 'year', '2018-04-30', '2018-05-18', NULL, '2018-04-30', NULL, NULL, 'flat', 'equal_installment', 0, 0, 0, 'withdrawn', 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '2018-04-27', NULL, NULL, NULL, '2018-05-03', NULL, NULL, NULL, NULL, '04', '2018', NULL, '2018-04-27 10:46:32', '2018-05-03 08:31:14', NULL, NULL, NULL, NULL, NULL, 'withdrawn by client', NULL, NULL),
(2, 'client', 3, 1, NULL, 1, 1, 2, 2, NULL, NULL, 2, 1, '5400.0000', NULL, NULL, NULL, NULL, NULL, NULL, 100, 'days', 1, 'days', '5400.0000', '5400.0000', '12.0000', 'year', '2018-01-01', '2018-01-01', '2018-04-11', '2018-01-01', NULL, '2018-01-01', 'flat', 'equal_installment', 0, 0, 0, 'disbursed', 1, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-27', NULL, '2018-05-04', NULL, NULL, NULL, NULL, NULL, NULL, '04', '2018', NULL, '2018-04-27 10:52:24', '2018-05-03 23:21:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'client', 3, 1, NULL, 1, 1, 2, 2, NULL, NULL, 2, 1, '1200.0000', NULL, NULL, NULL, NULL, NULL, NULL, 30, 'months', 1, 'months', '1200.0000', '1200.0000', '15.0000', 'year', '2018-04-29', '2018-04-29', '2020-10-29', '2018-04-29', NULL, '2018-04-29', 'declining_balance', 'equal_installment', 0, 0, 0, 'disbursed', 1, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-27', NULL, '2018-05-02', NULL, NULL, NULL, NULL, NULL, NULL, '04', '2018', NULL, '2018-04-27 10:54:30', '2018-05-03 10:58:04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'group', 3, NULL, 2, 1, 1, 2, 2, NULL, NULL, 2, 1, '4000.0000', NULL, NULL, NULL, NULL, NULL, NULL, 20, 'months', 1, 'months', '4000.0000', '4000.0000', '10.0000', 'year', '2018-05-07', '2018-05-07', '2020-01-10', '2018-05-10', NULL, '2018-05-10', 'declining_balance', 'equal_installment', 0, 0, 0, 'disbursed', 1, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-07', NULL, '2018-05-07', NULL, NULL, NULL, NULL, NULL, NULL, '05', '2018', NULL, '2018-05-07 12:35:54', '2018-05-07 14:32:42', NULL, 'llf', NULL, NULL, NULL, NULL, NULL, NULL),
(7, 'client', 3, 1, NULL, 1, 1, 2, 2, NULL, NULL, 2, 1, '4000.0000', NULL, NULL, NULL, NULL, NULL, NULL, 10, 'months', 1, 'months', '4000.0000', '4000.0000', '10.0000', 'year', '2018-05-01', '2018-05-01', '2019-03-01', '2018-05-01', NULL, '2018-05-01', 'declining_balance', 'equal_installment', 0, 0, 2, 'written_off', 1, NULL, 1, 1, NULL, NULL, NULL, 1, NULL, NULL, '2018-05-15', NULL, '2018-05-15', NULL, NULL, NULL, '2018-05-16', NULL, NULL, '05', '2018', NULL, '2018-05-15 18:55:08', '2018-05-16 00:24:51', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `loan_charges`
--

DROP TABLE IF EXISTS `loan_charges`;
CREATE TABLE IF NOT EXISTS `loan_charges` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `loan_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `penalty` tinyint(4) NOT NULL DEFAULT '0',
  `waived` tinyint(4) NOT NULL DEFAULT '0',
  `charge_type` enum('disbursement','disbursement_repayment','specified_due_date','installment_fee','overdue_installment_fee','loan_rescheduling_fee','overdue_maturity') COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge_option` enum('flat','percentage','installment_principal_due','installment_principal_interest_due','installment_interest_due','installment_total_due','total_due','original_principal') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(65,2) DEFAULT NULL,
  `amount_paid` decimal(65,2) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `grace_period` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_charges`
--

INSERT INTO `loan_charges` (`id`, `loan_id`, `charge_id`, `penalty`, `waived`, `charge_type`, `charge_option`, `amount`, `amount_paid`, `due_date`, `grace_period`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 0, 0, 'disbursement', 'flat', '50.00', NULL, NULL, 0, '2018-04-27 10:46:32', '2018-04-27 10:46:32'),
(25, 2, 2, 0, 0, 'specified_due_date', 'flat', '22.00', NULL, '2018-05-31', 0, '2018-05-03 23:20:37', '2018-05-03 23:20:37'),
(24, 2, 1, 0, 0, 'disbursement', 'flat', '52.00', NULL, NULL, 0, '2018-05-03 23:20:37', '2018-05-03 23:20:37'),
(21, 3, 2, 0, 0, 'specified_due_date', 'flat', '20.00', NULL, '2018-07-06', 0, '2018-05-02 12:18:48', '2018-05-02 12:18:48'),
(20, 3, 2, 0, 0, 'specified_due_date', 'flat', '20.00', NULL, '2018-07-06', 0, '2018-05-02 12:18:48', '2018-05-02 12:18:48'),
(6, 5, 2, 0, 0, 'specified_due_date', 'flat', '20.00', NULL, '2018-04-18', 0, '2018-04-29 11:10:10', '2018-04-29 11:10:10'),
(7, 5, 1, 0, 0, 'disbursement', 'flat', '52.00', NULL, NULL, 0, '2018-04-29 11:10:10', '2018-04-29 11:10:10'),
(19, 3, 1, 0, 0, 'disbursement', 'flat', '52.00', NULL, NULL, 0, '2018-05-02 12:18:48', '2018-05-02 12:18:48'),
(28, 6, 1, 0, 0, 'disbursement', 'flat', '50.00', NULL, NULL, 0, '2018-05-07 13:46:07', '2018-05-07 13:46:07'),
(30, 7, 1, 0, 0, 'disbursement', 'flat', '50.00', NULL, NULL, 0, '2018-05-15 19:28:49', '2018-05-15 19:28:49');

-- --------------------------------------------------------

--
-- Table structure for table `loan_products`
--

DROP TABLE IF EXISTS `loan_products`;
CREATE TABLE IF NOT EXISTS `loan_products` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `fund_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `decimals` int(11) NOT NULL DEFAULT '2',
  `minimum_principal` decimal(65,4) DEFAULT NULL,
  `default_principal` decimal(65,4) DEFAULT NULL,
  `maximum_principal` decimal(65,4) DEFAULT NULL,
  `minimum_loan_term` int(11) DEFAULT NULL,
  `default_loan_term` int(11) DEFAULT NULL,
  `maximum_loan_term` int(11) DEFAULT NULL,
  `repayment_frequency` int(11) DEFAULT NULL,
  `repayment_frequency_type` enum('days','weeks','months','years') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `minimum_interest_rate` decimal(65,4) DEFAULT NULL,
  `default_interest_rate` decimal(65,4) DEFAULT NULL,
  `maximum_interest_rate` decimal(65,4) DEFAULT NULL,
  `interest_rate_type` enum('day','week','month','year') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grace_on_interest_charged` int(11) DEFAULT NULL,
  `grace_on_principal` int(11) DEFAULT NULL,
  `grace_on_interest_payment` int(11) DEFAULT NULL,
  `allow_custom_grace` tinyint(4) NOT NULL DEFAULT '0',
  `allow_standing_instuctions` tinyint(4) NOT NULL DEFAULT '0',
  `interest_method` enum('flat','declining_balance') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `armotization_method` enum('equal_installment','equal_principal') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_calculation_period_type` enum('daily','same') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'same',
  `year_days` enum('actual','360','364','365') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '365',
  `month_days` enum('actual','30','31') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '30',
  `loan_transaction_strategy` enum('penalty_fees_interest_principal','principal_interest_penalty_fees','interest_principal_penalty_fees') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'interest_principal_penalty_fees',
  `include_in_cycle` tinyint(4) NOT NULL DEFAULT '0',
  `lock_guarantee` tinyint(4) NOT NULL DEFAULT '0',
  `allocate_overpayments` tinyint(4) NOT NULL DEFAULT '0',
  `allow_additional_charges` tinyint(4) NOT NULL DEFAULT '0',
  `accounting_rule` enum('none','cash','accrual_periodic','accrual_upfront') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `npa_days` int(11) DEFAULT NULL,
  `npa_suspend_income` tinyint(4) NOT NULL DEFAULT '0',
  `gl_account_fund_source_id` int(11) DEFAULT NULL,
  `gl_account_loan_portfolio_id` int(11) DEFAULT NULL,
  `gl_account_receivable_interest_id` int(11) DEFAULT NULL,
  `gl_account_receivable_fee_id` int(11) DEFAULT NULL,
  `gl_account_receivable_penalty_id` int(11) DEFAULT NULL,
  `gl_account_loan_over_payments_id` int(11) DEFAULT NULL,
  `gl_account_suspended_income_id` int(11) DEFAULT NULL,
  `gl_account_income_interest_id` int(11) DEFAULT NULL,
  `gl_account_income_fee_id` int(11) DEFAULT NULL,
  `gl_account_income_penalty_id` int(11) DEFAULT NULL,
  `gl_account_income_recovery_id` int(11) DEFAULT NULL,
  `gl_account_loans_written_off_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `arrears_grace_days` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_products`
--

INSERT INTO `loan_products` (`id`, `created_by_id`, `name`, `short_name`, `description`, `fund_id`, `currency_id`, `decimals`, `minimum_principal`, `default_principal`, `maximum_principal`, `minimum_loan_term`, `default_loan_term`, `maximum_loan_term`, `repayment_frequency`, `repayment_frequency_type`, `minimum_interest_rate`, `default_interest_rate`, `maximum_interest_rate`, `interest_rate_type`, `grace_on_interest_charged`, `grace_on_principal`, `grace_on_interest_payment`, `allow_custom_grace`, `allow_standing_instuctions`, `interest_method`, `armotization_method`, `interest_calculation_period_type`, `year_days`, `month_days`, `loan_transaction_strategy`, `include_in_cycle`, `lock_guarantee`, `allocate_overpayments`, `allow_additional_charges`, `accounting_rule`, `npa_days`, `npa_suspend_income`, `gl_account_fund_source_id`, `gl_account_loan_portfolio_id`, `gl_account_receivable_interest_id`, `gl_account_receivable_fee_id`, `gl_account_receivable_penalty_id`, `gl_account_loan_over_payments_id`, `gl_account_suspended_income_id`, `gl_account_income_interest_id`, `gl_account_income_fee_id`, `gl_account_income_penalty_id`, `gl_account_income_recovery_id`, `gl_account_loans_written_off_id`, `created_at`, `updated_at`, `arrears_grace_days`) VALUES
(3, 1, 'Webstudio', 'bv543', 'testing', 1, 2, 2, '1000.0000', '4000.0000', '20000.0000', 1, 20, 300, 1, 'months', '10.0000', '10.0000', '30.0000', 'year', 1, 0, 0, 0, 0, 'declining_balance', 'equal_installment', 'same', '365', 'actual', 'penalty_fees_interest_principal', 0, 1, 0, 0, 'accrual_periodic', NULL, 0, 7, 1, 2, 1, 1, 4, 4, 10, 11, 9, 3, 6, NULL, NULL, 3);

-- --------------------------------------------------------

--
-- Table structure for table `loan_product_charges`
--

DROP TABLE IF EXISTS `loan_product_charges`;
CREATE TABLE IF NOT EXISTS `loan_product_charges` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `loan_product_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_product_charges`
--

INSERT INTO `loan_product_charges` (`id`, `loan_product_id`, `charge_id`, `created_at`, `updated_at`) VALUES
(37, 3, 3, '2018-05-15 20:44:13', '2018-05-15 20:44:13'),
(36, 3, 2, '2018-05-15 20:44:13', '2018-05-15 20:44:13'),
(35, 3, 1, '2018-05-15 20:44:13', '2018-05-15 20:44:13');

-- --------------------------------------------------------

--
-- Table structure for table `loan_provisioning_criteria`
--

DROP TABLE IF EXISTS `loan_provisioning_criteria`;
CREATE TABLE IF NOT EXISTS `loan_provisioning_criteria` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` int(11) DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `min` int(11) DEFAULT NULL,
  `max` int(11) DEFAULT NULL,
  `percentage` int(11) DEFAULT NULL,
  `gl_account_liability_id` int(11) DEFAULT NULL,
  `gl_account_expense_id` int(11) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_provisioning_criteria`
--

INSERT INTO `loan_provisioning_criteria` (`id`, `created_by_id`, `name`, `min`, `max`, `percentage`, `gl_account_liability_id`, `gl_account_expense_id`, `notes`, `active`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Current', 0, 30, 1, 4, 6, NULL, 1, NULL, '2018-05-06 13:50:46'),
(2, NULL, 'Especially Mentioned', 31, 60, 5, 4, 6, NULL, 1, NULL, '2018-05-06 14:52:01'),
(3, NULL, 'Substandard', 61, 90, 10, 4, 6, NULL, 1, NULL, '2018-05-06 14:52:58'),
(4, NULL, 'Doubtful', 91, 180, 50, NULL, NULL, NULL, 1, NULL, NULL),
(5, NULL, 'Loss', 181, 1200, 100, NULL, NULL, NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `loan_purposes`
--

DROP TABLE IF EXISTS `loan_purposes`;
CREATE TABLE IF NOT EXISTS `loan_purposes` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_purposes`
--

INSERT INTO `loan_purposes` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Agriculture', '2018-04-26 21:32:49', '2018-04-26 21:32:49');

-- --------------------------------------------------------

--
-- Table structure for table `loan_repayment_schedules`
--

DROP TABLE IF EXISTS `loan_repayment_schedules`;
CREATE TABLE IF NOT EXISTS `loan_repayment_schedules` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `loan_id` int(11) DEFAULT NULL,
  `installment` int(11) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `month` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `principal` decimal(65,4) DEFAULT NULL,
  `principal_waived` decimal(65,4) DEFAULT NULL,
  `principal_written_off` decimal(65,4) DEFAULT NULL,
  `principal_paid` decimal(65,4) DEFAULT NULL,
  `interest` decimal(65,4) DEFAULT NULL,
  `interest_waived` decimal(65,4) DEFAULT NULL,
  `interest_written_off` decimal(65,4) DEFAULT NULL,
  `interest_paid` decimal(65,4) DEFAULT NULL,
  `fees` decimal(65,4) DEFAULT NULL,
  `fees_waived` decimal(65,4) DEFAULT NULL,
  `fees_written_off` decimal(65,4) DEFAULT NULL,
  `fees_paid` decimal(65,4) DEFAULT NULL,
  `penalty` decimal(65,4) DEFAULT NULL,
  `penalty_waived` decimal(65,4) DEFAULT NULL,
  `penalty_written_off` decimal(65,4) DEFAULT NULL,
  `penalty_paid` decimal(65,4) DEFAULT NULL,
  `total_due` decimal(65,4) DEFAULT NULL,
  `total_paid_advance` decimal(65,4) DEFAULT NULL,
  `total_paid_late` decimal(65,4) DEFAULT NULL,
  `paid` tinyint(4) NOT NULL DEFAULT '0',
  `modified_by_id` int(11) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1481 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_repayment_schedules`
--

INSERT INTO `loan_repayment_schedules` (`id`, `loan_id`, `installment`, `due_date`, `from_date`, `month`, `year`, `principal`, `principal_waived`, `principal_written_off`, `principal_paid`, `interest`, `interest_waived`, `interest_written_off`, `interest_paid`, `fees`, `fees_waived`, `fees_written_off`, `fees_paid`, `penalty`, `penalty_waived`, `penalty_written_off`, `penalty_paid`, `total_due`, `total_paid_advance`, `total_paid_late`, `paid`, `modified_by_id`, `created_by_id`, `created_at`, `updated_at`) VALUES
(1080, 3, NULL, '2020-10-01', NULL, '10', '2020', '47.7600', NULL, NULL, '0.0000', '1.0000', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1079, 3, NULL, '2020-09-01', NULL, '09', '2020', '47.0300', NULL, NULL, '0.0000', '1.1800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1078, 3, NULL, '2020-08-01', NULL, '08', '2020', '46.4400', NULL, NULL, '0.0000', '1.7700', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1077, 3, NULL, '2020-07-01', NULL, '07', '2020', '45.8700', NULL, NULL, '0.0000', '2.3400', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1076, 3, NULL, '2020-06-01', NULL, '06', '2020', '45.3000', NULL, NULL, '0.0000', '2.9100', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1075, 3, NULL, '2020-05-01', NULL, '05', '2020', '44.7500', NULL, NULL, '0.0000', '3.4600', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1074, 3, NULL, '2020-04-01', NULL, '04', '2020', '44.1900', NULL, NULL, '0.0000', '4.0200', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1073, 3, NULL, '2020-03-01', NULL, '03', '2020', '43.6500', NULL, NULL, '0.0000', '4.5600', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1072, 3, NULL, '2020-02-01', NULL, '02', '2020', '43.1100', NULL, NULL, '0.0000', '5.1000', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1071, 3, NULL, '2020-01-01', NULL, '01', '2020', '42.5800', NULL, NULL, '0.0000', '5.6300', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1070, 3, NULL, '2019-12-01', NULL, '12', '2019', '42.0500', NULL, NULL, '0.0000', '6.1600', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1069, 3, NULL, '2019-11-01', NULL, '11', '2019', '41.5300', NULL, NULL, '0.0000', '6.6800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1068, 3, NULL, '2019-10-01', NULL, '10', '2019', '41.0200', NULL, NULL, '0.0000', '7.1900', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1051, 3, NULL, '2018-05-12', '2018-05-12', '04', '2018', '33.2100', NULL, NULL, NULL, '15.0000', NULL, NULL, '15.0000', NULL, NULL, NULL, '0.0000', '9.9630', NULL, NULL, '0.0000', NULL, NULL, '48.2100', 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-08 18:47:15'),
(1052, 3, NULL, '2018-05-29', '2018-05-03', '05', '2018', '33.6300', NULL, NULL, '33.6300', '14.5800', NULL, NULL, '14.5800', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, '48.2100', NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1053, 3, NULL, '2018-06-29', '2018-05-03', '06', '2018', '34.0500', NULL, NULL, '34.0500', '14.1600', NULL, NULL, '14.1600', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, '48.2100', NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1054, 3, NULL, '2018-07-29', '2018-05-03', '07', '2018', '34.4700', NULL, NULL, '34.4700', '13.7400', NULL, NULL, '13.7400', '40.0000', NULL, NULL, '40.0000', NULL, NULL, NULL, '0.0000', NULL, '88.2100', NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:11'),
(1055, 3, NULL, '2018-08-29', '2018-05-03', '08', '2018', '34.9000', NULL, NULL, '34.9000', '13.3100', NULL, NULL, '13.3100', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, '48.2100', NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:11'),
(1056, 3, NULL, '2018-09-29', '2018-05-03', '09', '2018', '35.3400', NULL, NULL, '35.3400', '12.8700', NULL, NULL, '12.8700', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, '48.2100', NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:11'),
(1057, 3, NULL, '2018-10-29', '2018-05-03', '10', '2018', '35.7800', NULL, NULL, '35.7800', '12.4300', NULL, NULL, '12.4300', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, '48.2100', NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:11'),
(1058, 3, NULL, '2018-11-29', NULL, '11', '2018', '36.2300', NULL, NULL, '10.5500', '11.9800', NULL, NULL, '11.9800', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:11'),
(1059, 3, NULL, '2018-12-29', NULL, '12', '2018', '36.6800', NULL, NULL, '0.0000', '11.5300', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1060, 3, NULL, '2019-01-29', NULL, '01', '2019', '37.1400', NULL, NULL, '0.0000', '11.0700', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1061, 3, NULL, '2019-03-01', NULL, '03', '2019', '37.6000', NULL, NULL, '0.0000', '10.6100', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1062, 3, NULL, '2019-04-01', NULL, '04', '2019', '38.0700', NULL, NULL, '0.0000', '10.1400', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1063, 3, NULL, '2019-05-01', NULL, '05', '2019', '38.5500', NULL, NULL, '0.0000', '9.6600', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1064, 3, NULL, '2019-06-01', NULL, '06', '2019', '39.0300', NULL, NULL, '0.0000', '9.1800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1065, 3, NULL, '2019-07-01', NULL, '07', '2019', '39.5200', NULL, NULL, '0.0000', '8.6900', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1066, 3, NULL, '2019-08-01', NULL, '08', '2019', '40.0100', NULL, NULL, '0.0000', '8.2000', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1067, 3, NULL, '2019-09-01', NULL, '09', '2019', '40.5100', NULL, NULL, '0.0000', '7.7000', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 10:58:05', '2018-05-03 11:01:10'),
(1280, 2, NULL, '2018-04-10', NULL, '04', '2018', '54.0000', NULL, NULL, '0.0000', '1.0000', NULL, NULL, '0.0000', '22.0000', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:07', '2018-05-03 23:42:32'),
(1279, 2, NULL, '2018-04-09', NULL, '04', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:07', '2018-05-03 23:42:32'),
(1278, 2, NULL, '2018-04-08', NULL, '04', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:07', '2018-05-03 23:42:32'),
(1277, 2, NULL, '2018-04-07', NULL, '04', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:07', '2018-05-03 23:42:32'),
(1276, 2, NULL, '2018-04-06', NULL, '04', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:07', '2018-05-03 23:42:32'),
(1275, 2, NULL, '2018-04-05', NULL, '04', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:07', '2018-05-03 23:42:32'),
(1274, 2, NULL, '2018-04-04', NULL, '04', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:07', '2018-05-03 23:42:32'),
(1273, 2, NULL, '2018-04-03', NULL, '04', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:07', '2018-05-03 23:42:32'),
(1272, 2, NULL, '2018-04-02', NULL, '04', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:07', '2018-05-03 23:42:32'),
(1271, 2, NULL, '2018-04-01', NULL, '04', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:07', '2018-05-03 23:42:32'),
(1270, 2, NULL, '2018-03-31', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:32'),
(1269, 2, NULL, '2018-03-30', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:32'),
(1268, 2, NULL, '2018-03-29', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:32'),
(1267, 2, NULL, '2018-03-28', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:32'),
(1266, 2, NULL, '2018-03-27', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:32'),
(1265, 2, NULL, '2018-03-26', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:32'),
(1264, 2, NULL, '2018-03-25', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:32'),
(1263, 2, NULL, '2018-03-24', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:32'),
(1262, 2, NULL, '2018-03-23', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:32'),
(1261, 2, NULL, '2018-03-22', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1260, 2, NULL, '2018-03-21', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1259, 2, NULL, '2018-03-20', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1258, 2, NULL, '2018-03-19', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1257, 2, NULL, '2018-03-18', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1256, 2, NULL, '2018-03-17', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1255, 2, NULL, '2018-03-16', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1254, 2, NULL, '2018-03-15', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1253, 2, NULL, '2018-03-14', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1252, 2, NULL, '2018-03-13', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1251, 2, NULL, '2018-03-12', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1250, 2, NULL, '2018-03-11', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1249, 2, NULL, '2018-03-10', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1248, 2, NULL, '2018-03-09', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1247, 2, NULL, '2018-03-08', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1246, 2, NULL, '2018-03-07', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1245, 2, NULL, '2018-03-06', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1244, 2, NULL, '2018-03-05', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1243, 2, NULL, '2018-03-04', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1242, 2, NULL, '2018-03-03', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1241, 2, NULL, '2018-03-02', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1240, 2, NULL, '2018-03-01', NULL, '03', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1239, 2, NULL, '2018-02-28', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1238, 2, NULL, '2018-02-27', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1237, 2, NULL, '2018-02-26', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1236, 2, NULL, '2018-02-25', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1235, 2, NULL, '2018-02-24', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1234, 2, NULL, '2018-02-23', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1233, 2, NULL, '2018-02-22', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1232, 2, NULL, '2018-02-21', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1231, 2, NULL, '2018-02-20', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1230, 2, NULL, '2018-02-19', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1229, 2, NULL, '2018-02-18', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1228, 2, NULL, '2018-02-17', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1227, 2, NULL, '2018-02-16', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1226, 2, NULL, '2018-02-15', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1225, 2, NULL, '2018-02-14', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1224, 2, NULL, '2018-02-13', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1223, 2, NULL, '2018-02-12', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1222, 2, NULL, '2018-02-11', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1221, 2, NULL, '2018-02-10', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1220, 2, NULL, '2018-02-09', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:33'),
(1219, 2, NULL, '2018-02-08', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1218, 2, NULL, '2018-02-07', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1217, 2, NULL, '2018-02-06', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1216, 2, NULL, '2018-02-05', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1215, 2, NULL, '2018-02-04', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1214, 2, NULL, '2018-02-03', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1213, 2, NULL, '2018-02-02', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1212, 2, NULL, '2018-02-01', NULL, '02', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1211, 2, NULL, '2018-01-31', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1210, 2, NULL, '2018-01-30', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1209, 2, NULL, '2018-01-29', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1208, 2, NULL, '2018-01-28', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1207, 2, NULL, '2018-01-27', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1206, 2, NULL, '2018-01-26', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1205, 2, NULL, '2018-01-25', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1204, 2, NULL, '2018-01-24', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1203, 2, NULL, '2018-01-23', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1202, 2, NULL, '2018-01-22', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1201, 2, NULL, '2018-01-21', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1200, 2, NULL, '2018-01-20', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1199, 2, NULL, '2018-01-19', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1198, 2, NULL, '2018-01-18', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1197, 2, NULL, '2018-01-17', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1196, 2, NULL, '2018-01-16', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1195, 2, NULL, '2018-01-15', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1194, 2, NULL, '2018-01-14', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1193, 2, NULL, '2018-01-13', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1192, 2, NULL, '2018-01-12', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1191, 2, NULL, '2018-01-11', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1190, 2, NULL, '2018-01-10', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1189, 2, NULL, '2018-01-09', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1188, 2, NULL, '2018-01-08', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1187, 2, NULL, '2018-01-07', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1186, 2, NULL, '2018-01-06', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:06', '2018-05-03 23:42:34'),
(1185, 2, NULL, '2018-01-05', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:05', '2018-05-03 23:42:34'),
(1184, 2, NULL, '2018-01-04', NULL, '01', '2018', '54.0000', NULL, NULL, '0.0000', '1.7800', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:05', '2018-05-03 23:42:34'),
(1183, 2, NULL, '2018-01-03', NULL, '01', '2018', '54.0000', NULL, NULL, '36.6600', '1.7800', NULL, NULL, '1.7800', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-03 23:21:05', '2018-05-03 23:42:39'),
(1182, 2, NULL, '2018-01-02', '2018-02-01', '01', '2018', '54.0000', NULL, NULL, '54.0000', '1.7800', NULL, NULL, '1.7800', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, '55.7800', 0, NULL, NULL, '2018-05-03 23:21:05', '2018-05-03 23:42:39'),
(1181, 2, NULL, '2018-01-01', '2018-02-01', '01', '2018', '54.0000', NULL, NULL, '54.0000', '1.7800', NULL, NULL, '1.7800', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, '55.7800', 0, NULL, NULL, '2018-05-03 23:21:05', '2018-05-03 23:42:39'),
(1281, 6, NULL, '2018-05-10', '2018-05-07', '05', '2018', '184.6300', NULL, NULL, '184.6300', '33.3300', NULL, NULL, '33.3300', '3.0000', NULL, NULL, '3.0000', NULL, NULL, NULL, '0.0000', NULL, '87.6300', NULL, 0, NULL, NULL, '2018-05-07 14:32:42', '2018-05-11 20:46:45'),
(1282, 6, NULL, '2018-06-10', '2018-05-11', '06', '2018', '186.1700', NULL, NULL, '186.1700', '31.7900', NULL, NULL, '31.7900', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, '153.8000', NULL, 0, NULL, NULL, '2018-05-07 14:32:42', '2018-05-11 20:46:45'),
(1283, 6, NULL, '2018-07-10', NULL, '07', '2018', '187.7200', NULL, NULL, '0.0000', '30.2400', NULL, NULL, '30.2400', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:42', '2018-05-11 20:46:45'),
(1284, 6, NULL, '2018-08-10', NULL, '08', '2018', '189.2800', NULL, NULL, '0.0000', '28.6800', NULL, NULL, '28.6800', '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:42', '2018-05-11 20:46:43'),
(1285, 6, NULL, '2018-09-10', NULL, '09', '2018', '190.8600', NULL, NULL, '0.0000', '27.1000', NULL, NULL, '27.1000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:42', '2018-05-11 20:46:43'),
(1286, 6, NULL, '2018-10-10', NULL, '10', '2018', '192.4500', NULL, NULL, '0.0000', '25.5100', NULL, NULL, '25.5100', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:42', '2018-05-11 20:46:43'),
(1287, 6, NULL, '2018-11-10', NULL, '11', '2018', '194.0500', NULL, NULL, '0.0000', '23.9100', '0.5600', NULL, '23.3500', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:42', '2018-05-11 20:46:43'),
(1288, 6, NULL, '2018-12-10', NULL, '12', '2018', '195.6700', NULL, NULL, '0.0000', '22.2900', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:42', '2018-05-11 20:46:43'),
(1289, 6, NULL, '2019-01-10', NULL, '01', '2019', '197.3000', NULL, NULL, '0.0000', '20.6600', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:42', '2018-05-11 20:46:42'),
(1290, 6, NULL, '2019-02-10', NULL, '02', '2019', '198.9400', NULL, NULL, '0.0000', '19.0200', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:42', '2018-05-11 20:46:42'),
(1291, 6, NULL, '2019-03-10', NULL, '03', '2019', '200.6000', NULL, NULL, '0.0000', '17.3600', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:43', '2018-05-11 20:46:42'),
(1292, 6, NULL, '2019-04-10', NULL, '04', '2019', '202.2700', NULL, NULL, '0.0000', '15.6900', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:43', '2018-05-11 20:46:42'),
(1293, 6, NULL, '2019-05-10', NULL, '05', '2019', '203.9600', NULL, NULL, '0.0000', '14.0000', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:43', '2018-05-11 20:46:42'),
(1294, 6, NULL, '2019-06-10', NULL, '06', '2019', '205.6600', NULL, NULL, '0.0000', '12.3000', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:43', '2018-05-11 20:46:42'),
(1295, 6, NULL, '2019-07-10', NULL, '07', '2019', '207.3700', NULL, NULL, '0.0000', '10.5900', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:43', '2018-05-11 20:46:42'),
(1296, 6, NULL, '2019-08-10', NULL, '08', '2019', '209.1000', NULL, NULL, '0.0000', '8.8600', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:43', '2018-05-11 20:46:42'),
(1297, 6, NULL, '2019-09-10', NULL, '09', '2019', '210.8400', NULL, NULL, '0.0000', '7.1200', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:43', '2018-05-11 20:46:42'),
(1298, 6, NULL, '2019-10-10', NULL, '10', '2019', '212.6000', NULL, NULL, '0.0000', '5.3600', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:43', '2018-05-11 20:46:42'),
(1299, 6, NULL, '2019-11-10', NULL, '11', '2019', '214.3700', NULL, NULL, '0.0000', '3.5900', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:43', '2018-05-11 20:46:43'),
(1300, 6, NULL, '2019-12-10', NULL, '12', '2019', '216.1600', NULL, NULL, '0.0000', '2.0000', NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, 0, NULL, NULL, '2018-05-07 14:32:43', '2018-05-11 20:46:43'),
(1480, 7, NULL, '2019-02-01', NULL, '02', '2019', '379.5200', NULL, NULL, NULL, '3.0000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2018-05-15 21:07:24', '2018-05-15 21:07:24'),
(1479, 7, NULL, '2019-01-01', NULL, '01', '2019', '411.9600', NULL, NULL, NULL, '6.6000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2018-05-15 21:07:24', '2018-05-15 21:07:24'),
(1478, 7, NULL, '2018-12-01', NULL, '12', '2018', '408.5600', NULL, NULL, NULL, '10.0000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2018-05-15 21:07:24', '2018-05-15 21:07:24'),
(1477, 7, NULL, '2018-11-01', NULL, '11', '2018', '405.1800', NULL, NULL, NULL, '13.3800', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2018-05-15 21:07:24', '2018-05-15 21:07:24'),
(1476, 7, NULL, '2018-10-01', NULL, '10', '2018', '401.8300', NULL, NULL, NULL, '16.7300', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2018-05-15 21:07:24', '2018-05-15 21:07:24'),
(1475, 7, NULL, '2018-09-01', NULL, '09', '2018', '398.5100', NULL, NULL, NULL, '20.0500', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2018-05-15 21:07:24', '2018-05-15 21:07:24'),
(1474, 7, NULL, '2018-08-01', NULL, '08', '2018', '395.2200', NULL, NULL, NULL, '23.3400', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2018-05-15 21:07:24', '2018-05-15 21:07:24'),
(1473, 7, NULL, '2018-07-01', NULL, '07', '2018', '391.9500', NULL, NULL, NULL, '26.6100', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2018-05-15 21:07:24', '2018-05-15 21:07:24'),
(1472, 7, NULL, '2018-06-01', NULL, '06', '2018', '388.7100', NULL, NULL, NULL, '29.8500', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2018-05-15 21:07:24', '2018-05-15 21:07:24'),
(1471, 7, NULL, '2018-05-01', NULL, '05', '2018', '418.5600', NULL, NULL, NULL, '0.0000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2018-05-15 21:07:24', '2018-05-15 21:07:24');

-- --------------------------------------------------------

--
-- Table structure for table `loan_reschedule_requests`
--

DROP TABLE IF EXISTS `loan_reschedule_requests`;
CREATE TABLE IF NOT EXISTS `loan_reschedule_requests` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `loan_id` int(11) DEFAULT NULL,
  `principal` decimal(65,4) DEFAULT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_by_id` int(11) DEFAULT NULL,
  `modified_by_id` int(11) DEFAULT NULL,
  `approved_by_id` int(11) DEFAULT NULL,
  `rejected_by_id` int(11) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `modified_date` date DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `rejected_date` date DEFAULT NULL,
  `reschedule_from_date` date DEFAULT NULL,
  `recalculate_interest` int(11) NOT NULL DEFAULT '0',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loan_transactions`
--

DROP TABLE IF EXISTS `loan_transactions`;
CREATE TABLE IF NOT EXISTS `loan_transactions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `loan_id` int(11) DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `payment_type_id` int(11) DEFAULT NULL,
  `transaction_type` enum('repayment','repayment_disbursement','write_off','write_off_recovery','disbursement','interest_accrual','fee_accrual','penalty_accrual','deposit','withdrawal','manual_entry','pay_charge','transfer_fund','interest','income','fee','disbursement_fee','installment_fee','specified_due_date_fee','overdue_maturity','overdue_installment_fee','loan_rescheduling_fee','penalty','interest_waiver','charge_waiver') COLLATE utf8mb4_unicode_ci DEFAULT 'repayment',
  `created_by_id` int(11) DEFAULT NULL,
  `modified_by_id` int(11) DEFAULT NULL,
  `payment_detail_id` int(11) DEFAULT NULL,
  `loan_repayment_schedule_id` int(11) DEFAULT NULL,
  `debit` decimal(65,4) DEFAULT NULL,
  `credit` decimal(65,4) DEFAULT NULL,
  `balance` decimal(65,4) DEFAULT NULL,
  `amount` decimal(65,4) DEFAULT NULL,
  `reversible` tinyint(4) NOT NULL DEFAULT '0',
  `reversed` tinyint(4) NOT NULL DEFAULT '0',
  `reversal_type` enum('system','user','none') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `payment_apply_to` enum('interest','principal','fees','penalty','regular') COLLATE utf8mb4_unicode_ci DEFAULT 'regular',
  `interest` decimal(65,4) DEFAULT NULL,
  `principal` decimal(65,4) DEFAULT NULL,
  `fee` decimal(65,4) DEFAULT NULL,
  `penalty` decimal(65,4) DEFAULT NULL,
  `overpayment` decimal(65,4) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `month` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt` text COLLATE utf8mb4_unicode_ci,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `principal_derived` decimal(65,4) DEFAULT NULL,
  `interest_derived` decimal(65,4) DEFAULT NULL,
  `fees_derived` decimal(65,4) DEFAULT NULL,
  `penalty_derived` decimal(65,4) DEFAULT NULL,
  `overpayment_derived` decimal(65,4) DEFAULT NULL,
  `unrecognized_income_derived` decimal(65,4) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=300 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_transactions`
--

INSERT INTO `loan_transactions` (`id`, `loan_id`, `office_id`, `client_id`, `payment_type_id`, `transaction_type`, `created_by_id`, `modified_by_id`, `payment_detail_id`, `loan_repayment_schedule_id`, `debit`, `credit`, `balance`, `amount`, `reversible`, `reversed`, `reversal_type`, `payment_apply_to`, `interest`, `principal`, `fee`, `penalty`, `overpayment`, `date`, `month`, `year`, `receipt`, `notes`, `created_at`, `updated_at`, `deleted_at`, `principal_derived`, `interest_derived`, `fees_derived`, `penalty_derived`, `overpayment_derived`, `unrecognized_income_derived`, `charge_id`) VALUES
(220, 6, 1, NULL, NULL, 'repayment_disbursement', 1, NULL, NULL, NULL, NULL, '50.0000', NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-07', '05', '2018', NULL, NULL, '2018-05-07 14:32:44', '2018-05-07 14:32:44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(219, 6, 1, NULL, NULL, 'disbursement_fee', 1, NULL, NULL, NULL, '50.0000', NULL, NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-07', '05', '2018', NULL, NULL, '2018-05-07 14:32:44', '2018-05-07 14:32:44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(218, 6, 1, NULL, NULL, 'interest', 1, NULL, NULL, NULL, '359.4000', NULL, NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-07', '05', '2018', NULL, NULL, '2018-05-07 14:32:44', '2018-05-07 14:32:44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(217, 6, 1, NULL, NULL, 'disbursement', 1, NULL, 97, NULL, '4000.0000', NULL, NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-07', '05', '2018', NULL, NULL, '2018-05-07 14:32:44', '2018-05-07 14:32:44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(216, 2, 1, NULL, NULL, 'repayment', 1, NULL, 95, NULL, NULL, '150.0000', NULL, NULL, 1, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-02-01', '02', '2018', NULL, NULL, '2018-05-03 23:42:24', '2018-05-03 23:42:39', NULL, '144.6600', '5.3400', '0.0000', '0.0000', NULL, '0.0000', NULL),
(215, 2, 1, NULL, NULL, 'specified_due_date_fee', 1, NULL, NULL, 1280, '22.0000', NULL, NULL, NULL, 1, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-04-10', '04', '2018', NULL, NULL, '2018-05-03 23:21:07', '2018-05-03 23:21:07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(214, 2, 1, NULL, NULL, 'repayment_disbursement', 1, NULL, NULL, NULL, NULL, '52.0000', NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-01-01', '01', '2018', NULL, NULL, '2018-05-03 23:21:07', '2018-05-03 23:21:07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(213, 2, 1, NULL, NULL, 'disbursement_fee', 1, NULL, NULL, NULL, '52.0000', NULL, NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-01-01', '01', '2018', NULL, NULL, '2018-05-03 23:21:07', '2018-05-03 23:21:07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(212, 2, 1, NULL, NULL, 'interest', 1, NULL, NULL, NULL, '177.2200', NULL, NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-01-01', '01', '2018', NULL, NULL, '2018-05-03 23:21:07', '2018-05-03 23:21:07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(211, 2, 1, NULL, NULL, 'disbursement', 1, NULL, 94, NULL, '5400.0000', NULL, NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-01-01', '01', '2018', NULL, NULL, '2018-05-03 23:21:07', '2018-05-03 23:21:07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(206, 3, 1, NULL, NULL, 'repayment', 1, NULL, 92, NULL, NULL, '400.0000', NULL, NULL, 1, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-03', '05', '2018', NULL, NULL, '2018-05-03 11:01:04', '2018-05-03 11:01:11', NULL, '251.9300', '108.0700', '40.0000', '0.0000', NULL, '0.0000', NULL),
(205, 3, 1, NULL, NULL, 'specified_due_date_fee', 1, NULL, NULL, 1054, '20.0000', NULL, NULL, NULL, 1, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-07-29', '07', '2018', NULL, NULL, '2018-05-03 10:58:06', '2018-05-03 10:58:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(204, 3, 1, NULL, NULL, 'specified_due_date_fee', 1, NULL, NULL, 1054, '20.0000', NULL, NULL, NULL, 1, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-07-29', '07', '2018', NULL, NULL, '2018-05-03 10:58:06', '2018-05-03 10:58:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(203, 3, 1, NULL, NULL, 'repayment_disbursement', 1, NULL, NULL, NULL, NULL, '52.0000', NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-04-29', '04', '2018', NULL, NULL, '2018-05-03 10:58:06', '2018-05-03 10:58:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(202, 3, 1, NULL, NULL, 'disbursement_fee', 1, NULL, NULL, NULL, '52.0000', NULL, NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-04-29', '04', '2018', NULL, NULL, '2018-05-03 10:58:06', '2018-05-03 10:58:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(201, 3, 1, NULL, NULL, 'interest', 1, NULL, NULL, NULL, '246.8500', NULL, NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-04-29', '04', '2018', NULL, NULL, '2018-05-03 10:58:06', '2018-05-03 10:58:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(200, 3, 1, NULL, NULL, 'disbursement', 1, NULL, 91, NULL, '1200.0000', NULL, NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-04-29', '04', '2018', NULL, NULL, '2018-05-03 10:58:06', '2018-05-03 10:58:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(221, 6, 1, NULL, NULL, 'repayment', 1, NULL, 98, NULL, NULL, '200.0000', NULL, NULL, 1, 0, 'none', 'interest', NULL, NULL, NULL, NULL, NULL, '2018-05-07', '05', '2018', NULL, NULL, '2018-05-07 17:04:13', '2018-05-11 20:46:45', NULL, '0.0000', '200.0000', '0.0000', '0.0000', NULL, '0.0000', NULL),
(222, 6, 1, NULL, NULL, 'repayment', 1, NULL, 99, NULL, NULL, '100.0000', NULL, NULL, 1, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-07', '05', '2018', NULL, NULL, '2018-05-07 17:06:53', '2018-05-11 20:46:45', NULL, '97.0000', '0.0000', '3.0000', '0.0000', NULL, '0.0000', NULL),
(223, 6, 1, NULL, NULL, 'repayment', 1, NULL, 100, NULL, NULL, '120.0000', NULL, NULL, 1, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-07', '05', '2018', NULL, NULL, '2018-05-07 17:07:36', '2018-05-11 20:46:45', NULL, '120.0000', '0.0000', '0.0000', '0.0000', NULL, '0.0000', NULL),
(224, 6, 1, NULL, NULL, 'repayment', 1, NULL, 101, NULL, '25.0000', '25.0000', NULL, NULL, 0, 1, 'user', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-07', '05', '2018', NULL, NULL, '2018-05-07 18:07:07', '2018-05-07 18:08:23', NULL, '25.0000', '0.0000', '0.0000', '0.0000', NULL, '0.0000', NULL),
(228, 6, 1, NULL, NULL, 'interest_waiver', 1, NULL, NULL, NULL, NULL, '0.5600', NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-07', '05', '2018', NULL, 'kkd', '2018-05-07 19:31:17', '2018-05-07 19:31:17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(229, 6, 1, NULL, NULL, 'fee', 1, NULL, NULL, 1284, NULL, '0.0000', NULL, NULL, 1, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-08-10', '08', '2018', NULL, 'ff', '2018-05-07 19:59:09', '2018-05-07 19:59:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(230, 6, 1, NULL, NULL, 'specified_due_date_fee', 1, NULL, NULL, 1281, NULL, '3.0000', NULL, NULL, 1, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-10', '05', '2018', NULL, 'ff', '2018-05-07 20:02:42', '2018-05-07 20:02:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(231, 3, 1, NULL, NULL, 'penalty', NULL, NULL, NULL, 1051, '3.3210', NULL, NULL, NULL, 1, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-05', '05', '{"id":1051,"loan_id":3,"installment":null,"due_date":"2018', NULL, NULL, '2018-05-08 17:40:20', '2018-05-08 17:40:20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3),
(232, 3, 1, NULL, NULL, 'penalty', NULL, NULL, NULL, 1051, '3.3210', NULL, NULL, NULL, 1, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-05', '05', '{"id":1051,"loan_id":3,"installment":null,"due_date":"2018', NULL, NULL, '2018-05-08 17:44:15', '2018-05-08 17:44:15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3),
(233, 3, 1, NULL, NULL, 'overdue_installment_fee', NULL, NULL, NULL, 1051, '3.3210', NULL, NULL, NULL, 1, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-05', '05', '2018', NULL, NULL, '2018-05-08 18:47:15', '2018-05-08 18:47:15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3),
(234, 6, 1, NULL, NULL, 'repayment', 1, NULL, 110, NULL, NULL, '153.8000', NULL, NULL, 1, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-11', '05', '2018', NULL, NULL, '2018-05-11 20:46:21', '2018-05-11 20:46:45', NULL, '153.8000', '0.0000', '0.0000', '0.0000', NULL, '0.0000', NULL),
(298, 7, 1, NULL, NULL, 'repayment_disbursement', 1, NULL, NULL, NULL, NULL, '50.0000', NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-01', '05', '2018', NULL, NULL, '2018-05-15 21:07:24', '2018-05-15 21:07:24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(295, 7, 1, NULL, NULL, 'disbursement', 1, NULL, 129, NULL, '4000.0000', NULL, NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-01', '05', '2018', NULL, NULL, '2018-05-15 21:07:24', '2018-05-15 21:07:24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(296, 7, 1, NULL, NULL, 'interest', 1, NULL, NULL, NULL, '149.5600', NULL, NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-01', '05', '2018', NULL, NULL, '2018-05-15 21:07:24', '2018-05-15 21:07:24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(297, 7, 1, NULL, NULL, 'disbursement_fee', 1, NULL, NULL, NULL, '50.0000', NULL, NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-01', '05', '2018', NULL, NULL, '2018-05-15 21:07:24', '2018-05-15 21:07:24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(299, 7, 1, NULL, NULL, 'write_off', 1, NULL, NULL, NULL, NULL, '4149.5600', NULL, NULL, 0, 0, 'none', 'regular', NULL, NULL, NULL, NULL, NULL, '2018-05-16', '05', '2018', NULL, NULL, '2018-05-16 00:24:52', '2018-05-16 00:24:52', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `loan_transaction_repayment_schedule_mappings`
--

DROP TABLE IF EXISTS `loan_transaction_repayment_schedule_mappings`;
CREATE TABLE IF NOT EXISTS `loan_transaction_repayment_schedule_mappings` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `loan_repayment_schedule_id` int(11) DEFAULT NULL,
  `loan_transaction_id` int(11) DEFAULT NULL,
  `interest` decimal(65,4) DEFAULT NULL,
  `principal` decimal(65,4) DEFAULT NULL,
  `fee` decimal(65,4) DEFAULT NULL,
  `penalty` decimal(65,4) DEFAULT NULL,
  `overpayment` decimal(65,4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=378 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(327, '2014_07_02_230147_migration_cartalyst_sentinel', 1),
(328, '2018_04_17_142054_create_clients_table', 1),
(329, '2018_04_17_143536_create_offices_table', 1),
(330, '2018_04_17_143618_create_office_transactions_table', 1),
(331, '2018_04_17_145018_create_group_clients_table', 1),
(332, '2018_04_17_145018_create_groups_table', 1),
(333, '2018_04_17_145135_create_gl_accounts_table', 1),
(334, '2018_04_17_145228_create_gl_closures_table', 1),
(335, '2018_04_17_145702_create_loans_table', 1),
(336, '2018_04_17_145803_create_loan_repayment_schedules_table', 1),
(337, '2018_04_17_154317_create_gl_journal_entries_table', 1),
(338, '2018_04_17_155148_create_funds_table', 1),
(339, '2018_04_17_155538_create_documents_table', 1),
(340, '2018_04_17_155601_create_loan_products_table', 1),
(341, '2018_04_17_160526_create_payment_type_details_table', 1),
(342, '2018_04_17_160526_create_payment_types_table', 1),
(343, '2018_04_17_160706_create_currencies_table', 1),
(344, '2018_04_17_161015_create_charges_table', 1),
(345, '2018_04_17_161955_create_loan_charges_table', 1),
(346, '2018_04_17_162008_create_loan_product_charges_table', 1),
(347, '2018_04_17_162337_create_loan_reschedule_requests_table', 1),
(348, '2018_04_17_162446_create_loan_transactions_table', 1),
(349, '2018_04_17_162650_create_loan_transaction_repayment_schedule_mappings_table', 1),
(350, '2018_04_17_162728_create_notes_table', 1),
(351, '2018_04_17_173153_create_client_next_of_kin_table', 1),
(352, '2018_04_17_174617_create_client_identifications_table', 1),
(353, '2018_04_17_175118_create_client_identification_types_table', 1),
(354, '2018_04_17_175504_create_client_relationships_table', 1),
(355, '2018_04_17_175600_create_client_profession_table', 1),
(356, '2018_04_22_230823_create_settings_table', 1),
(357, '2018_04_22_230940_create_countries_table', 1),
(358, '2018_04_22_233825_create_permissions_table', 1),
(359, '2018_04_26_230414_create_loan_purposes_table', 2),
(360, '2018_04_27_230233_create_collateral_table', 3),
(361, '2018_04_27_230233_create_collateral_types_table', 3),
(363, '2018_04_28_111043_create_guarantors_table', 4),
(364, '2018_04_29_140913_create_payment_details_table', 5),
(365, '2018_04_30_172023_create_sms_gateways_table', 6),
(366, '2018_05_03_012752_create_loan_provisioning_criteria_table', 7),
(368, '2018_05_07_141744_create_group_loan_allocation_table', 8),
(369, '2018_05_08_232948_create_savings_products_table', 9),
(370, '2018_05_08_233244_create_savings_table', 9),
(371, '2018_05_08_233314_create_savings_charges_table', 9),
(372, '2018_05_08_233328_create_savings_transactions_table', 9),
(373, '2018_05_08_233440_create_savings_product_charges_table', 9),
(374, '2018_05_11_030728_create_report_scheduler_table', 10),
(375, '2018_05_11_041541_create_report_scheduler_run_history_table', 10),
(376, '2018_05_11_042659_create_communication_campaigns_table', 10),
(377, '2018_05_11_155900_create_audit_trail_table', 10);

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
CREATE TABLE IF NOT EXISTS `notes` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `reference_id` int(11) DEFAULT NULL,
  `type` enum('client','loan','savings','identification','shares','repayment','group') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `modified_by_id` int(11) DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`id`, `reference_id`, `type`, `created_by_id`, `modified_by_id`, `notes`, `created_at`, `updated_at`) VALUES
(2, 1, 'client', 1, NULL, 'too much noise', '2018-04-24 22:08:54', '2018-04-24 22:18:37'),
(3, 2, 'group', 1, NULL, 'the group is great', '2018-04-25 09:00:15', '2018-04-25 09:00:15'),
(4, 3, 'loan', 1, NULL, 'Checked by tj', '2018-04-27 20:54:28', '2018-04-27 20:56:09'),
(5, 1, 'savings', 1, NULL, 'dd', '2018-05-10 11:03:44', '2018-05-10 11:03:44');

-- --------------------------------------------------------

--
-- Table structure for table `offices`
--

DROP TABLE IF EXISTS `offices`;
CREATE TABLE IF NOT EXISTS `offices` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `external_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opening_date` date DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `phone` text COLLATE utf8mb4_unicode_ci,
  `email` text COLLATE utf8mb4_unicode_ci,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `manager_id` int(11) DEFAULT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `default_office` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `offices`
--

INSERT INTO `offices` (`id`, `name`, `parent_id`, `external_id`, `opening_date`, `address`, `phone`, `email`, `notes`, `manager_id`, `active`, `created_at`, `updated_at`, `deleted_at`, `default_office`) VALUES
(1, 'Head Office', NULL, '00234', '2010-04-24', NULL, NULL, NULL, NULL, NULL, 1, '2018-04-24 09:35:39', '2018-05-05 10:43:29', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `office_transactions`
--

DROP TABLE IF EXISTS `office_transactions`;
CREATE TABLE IF NOT EXISTS `office_transactions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `from_office_id` int(11) DEFAULT NULL,
  `to_office_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `amount` decimal(65,8) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_details`
--

DROP TABLE IF EXISTS `payment_details`;
CREATE TABLE IF NOT EXISTS `payment_details` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `payment_type_id` int(11) DEFAULT NULL,
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cheque_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `routing_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=130 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_details`
--

INSERT INTO `payment_details` (`id`, `payment_type_id`, `account_number`, `cheque_number`, `routing_code`, `receipt_number`, `bank`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 'll', 'kfk', NULL, NULL, NULL, NULL, '2018-04-29 20:34:07', '2018-04-29 20:34:07'),
(2, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-29 20:35:53', '2018-04-29 20:35:53'),
(3, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-29 20:46:42', '2018-04-29 20:46:42'),
(4, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-29 23:18:51', '2018-04-29 23:18:51'),
(5, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-29 23:25:48', '2018-04-29 23:25:48'),
(6, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-29 23:26:52', '2018-04-29 23:26:52'),
(7, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-29 23:28:40', '2018-04-29 23:28:40'),
(8, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-29 23:31:38', '2018-04-29 23:31:38'),
(9, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-29 23:36:43', '2018-04-29 23:36:43'),
(10, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-29 23:53:42', '2018-04-29 23:53:42'),
(11, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-29 23:54:45', '2018-04-29 23:54:45'),
(12, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-30 00:18:00', '2018-04-30 00:18:00'),
(13, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-30 10:08:18', '2018-04-30 10:08:18'),
(14, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-30 10:12:28', '2018-04-30 10:12:28'),
(15, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-04-30 10:14:46', '2018-04-30 10:14:46'),
(16, 1, 'vg', NULL, NULL, NULL, NULL, NULL, '2018-04-30 10:15:47', '2018-04-30 10:15:47'),
(17, 1, 'gsg', NULL, NULL, NULL, NULL, NULL, '2018-04-30 16:39:32', '2018-04-30 16:39:32'),
(18, 1, 'wwe4', 'fd', NULL, NULL, NULL, NULL, '2018-05-02 08:38:58', '2018-05-02 08:38:58'),
(19, 1, 'wwe4', 'fd', NULL, NULL, NULL, NULL, '2018-05-02 08:39:56', '2018-05-02 08:39:56'),
(20, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 08:53:55', '2018-05-02 08:53:55'),
(21, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:04:02', '2018-05-02 09:04:02'),
(22, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:06:21', '2018-05-02 09:06:21'),
(23, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:07:20', '2018-05-02 09:07:20'),
(24, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:08:46', '2018-05-02 09:08:46'),
(25, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:11:28', '2018-05-02 09:11:28'),
(26, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:13:42', '2018-05-02 09:13:42'),
(27, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:15:05', '2018-05-02 09:15:05'),
(28, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:18:10', '2018-05-02 09:18:10'),
(29, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:19:01', '2018-05-02 09:19:01'),
(30, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:28:50', '2018-05-02 09:28:50'),
(31, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:29:37', '2018-05-02 09:29:37'),
(32, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:31:50', '2018-05-02 09:31:50'),
(33, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:34:05', '2018-05-02 09:34:05'),
(34, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:36:03', '2018-05-02 09:36:03'),
(35, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:41:23', '2018-05-02 09:41:23'),
(36, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:42:13', '2018-05-02 09:42:13'),
(37, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:43:00', '2018-05-02 09:43:00'),
(38, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:52:29', '2018-05-02 09:52:29'),
(39, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:52:45', '2018-05-02 09:52:45'),
(40, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 09:55:15', '2018-05-02 09:55:15'),
(41, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 10:02:21', '2018-05-02 10:02:21'),
(42, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 10:05:28', '2018-05-02 10:05:28'),
(43, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 10:06:27', '2018-05-02 10:06:27'),
(44, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 10:13:56', '2018-05-02 10:13:56'),
(45, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 10:15:34', '2018-05-02 10:15:34'),
(46, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 10:18:05', '2018-05-02 10:18:05'),
(47, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 10:55:29', '2018-05-02 10:55:29'),
(48, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 10:59:21', '2018-05-02 10:59:21'),
(49, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 11:08:06', '2018-05-02 11:08:06'),
(50, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 11:10:19', '2018-05-02 11:10:19'),
(51, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 11:11:44', '2018-05-02 11:11:44'),
(52, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 11:14:49', '2018-05-02 11:14:49'),
(53, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 11:17:08', '2018-05-02 11:17:08'),
(54, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 11:17:21', '2018-05-02 11:17:21'),
(55, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 11:18:44', '2018-05-02 11:18:44'),
(56, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 11:22:29', '2018-05-02 11:22:29'),
(57, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 11:23:24', '2018-05-02 11:23:24'),
(58, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 11:24:11', '2018-05-02 11:24:11'),
(59, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 11:26:42', '2018-05-02 11:26:42'),
(60, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 12:01:37', '2018-05-02 12:01:37'),
(61, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 12:08:41', '2018-05-02 12:08:41'),
(62, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 12:10:24', '2018-05-02 12:10:24'),
(63, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 12:15:04', '2018-05-02 12:15:04'),
(64, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 12:19:18', '2018-05-02 12:19:18'),
(65, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 12:30:19', '2018-05-02 12:30:19'),
(66, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 14:18:36', '2018-05-02 14:18:36'),
(67, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 14:21:17', '2018-05-02 14:21:17'),
(68, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 14:25:36', '2018-05-02 14:25:36'),
(69, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 14:31:07', '2018-05-02 14:31:07'),
(70, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 14:31:49', '2018-05-02 14:31:49'),
(71, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 14:33:25', '2018-05-02 14:33:25'),
(72, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 14:34:09', '2018-05-02 14:34:09'),
(73, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 14:35:08', '2018-05-02 14:35:08'),
(74, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 14:39:32', '2018-05-02 14:39:32'),
(75, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 14:48:55', '2018-05-02 14:48:55'),
(76, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 15:14:20', '2018-05-02 15:14:20'),
(77, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 15:15:11', '2018-05-02 15:15:11'),
(78, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 15:17:25', '2018-05-02 15:17:25'),
(79, 1, 'ffd', NULL, NULL, NULL, NULL, NULL, '2018-05-02 20:08:49', '2018-05-02 20:08:49'),
(80, 1, 'ddd', 'dd', NULL, NULL, NULL, NULL, '2018-05-02 20:09:48', '2018-05-02 20:09:48'),
(81, 1, 'ff', 'fdffd', 'df', NULL, NULL, 'd', '2018-05-02 20:17:50', '2018-05-02 20:17:50'),
(82, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 21:38:50', '2018-05-02 21:38:50'),
(83, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 21:40:35', '2018-05-02 21:40:35'),
(84, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 21:42:21', '2018-05-02 21:42:21'),
(85, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 21:43:46', '2018-05-02 21:43:46'),
(86, 1, 'f', NULL, NULL, NULL, NULL, NULL, '2018-05-02 21:48:07', '2018-05-02 21:48:07'),
(87, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-02 21:51:02', '2018-05-02 21:51:02'),
(88, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-03 00:16:38', '2018-05-03 00:16:38'),
(89, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-03 07:51:46', '2018-05-03 07:51:46'),
(90, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-03 10:56:10', '2018-05-03 10:56:10'),
(91, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-03 10:58:06', '2018-05-03 10:58:06'),
(92, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-03 11:01:04', '2018-05-03 11:01:04'),
(93, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-03 23:18:26', '2018-05-03 23:18:26'),
(94, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-03 23:21:07', '2018-05-03 23:21:07'),
(95, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-03 23:42:24', '2018-05-03 23:42:24'),
(96, 1, 'd', NULL, 'ds', NULL, NULL, NULL, '2018-05-06 00:17:34', '2018-05-06 00:17:34'),
(97, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-07 14:32:43', '2018-05-07 14:32:43'),
(98, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-07 17:04:12', '2018-05-07 17:04:12'),
(99, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-07 17:06:53', '2018-05-07 17:06:53'),
(100, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-07 17:07:36', '2018-05-07 17:07:36'),
(101, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-07 18:07:07', '2018-05-07 18:07:07'),
(102, 1, 'dd', 'fd', NULL, NULL, NULL, NULL, '2018-05-10 14:32:12', '2018-05-10 14:32:12'),
(103, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-10 14:41:00', '2018-05-10 14:41:00'),
(104, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-10 14:42:53', '2018-05-10 14:42:53'),
(105, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-10 14:46:14', '2018-05-10 14:46:14'),
(106, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-10 14:47:54', '2018-05-10 14:47:54'),
(107, 1, 'vccv', NULL, NULL, NULL, NULL, NULL, '2018-05-10 15:26:00', '2018-05-10 15:26:00'),
(108, 1, NULL, NULL, NULL, NULL, NULL, 'x', '2018-05-10 15:27:51', '2018-05-10 15:27:51'),
(109, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-10 18:29:09', '2018-05-10 18:29:09'),
(110, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-11 20:46:21', '2018-05-11 20:46:21'),
(111, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-12 23:26:48', '2018-05-12 23:26:48'),
(112, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-12 23:39:27', '2018-05-12 23:39:27'),
(113, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-12 23:40:05', '2018-05-12 23:40:05'),
(114, 1, 'ff', NULL, NULL, NULL, NULL, NULL, '2018-05-15 18:56:14', '2018-05-15 18:56:14'),
(115, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-15 19:26:01', '2018-05-15 19:26:01'),
(116, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-15 19:29:16', '2018-05-15 19:29:16'),
(117, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-15 19:54:46', '2018-05-15 19:54:46'),
(118, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-15 20:00:51', '2018-05-15 20:00:51'),
(119, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-15 20:04:02', '2018-05-15 20:04:02'),
(120, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-15 20:05:45', '2018-05-15 20:05:45'),
(121, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-15 20:07:02', '2018-05-15 20:07:02'),
(122, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-15 20:08:22', '2018-05-15 20:08:22'),
(123, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-15 20:13:59', '2018-05-15 20:13:59'),
(124, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-15 20:18:00', '2018-05-15 20:18:00'),
(125, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-15 20:20:21', '2018-05-15 20:20:21'),
(126, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-15 20:23:53', '2018-05-15 20:23:53'),
(127, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-15 20:27:15', '2018-05-15 20:27:15'),
(128, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-15 20:44:29', '2018-05-15 20:44:29'),
(129, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-15 21:07:24', '2018-05-15 21:07:24');

-- --------------------------------------------------------

--
-- Table structure for table `payment_types`
--

DROP TABLE IF EXISTS `payment_types`;
CREATE TABLE IF NOT EXISTS `payment_types` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `is_cash` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_types`
--

INSERT INTO `payment_types` (`id`, `name`, `notes`, `is_cash`, `created_at`, `updated_at`) VALUES
(1, 'Ecocash', 'Ecocash', 0, '2018-04-25 14:37:14', '2018-04-25 14:37:23');

-- --------------------------------------------------------

--
-- Table structure for table `payment_type_details`
--

DROP TABLE IF EXISTS `payment_type_details`;
CREATE TABLE IF NOT EXISTS `payment_type_details` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` enum('loan','savings','share','client','journal') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_id` int(11) NOT NULL,
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cheque_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `routing_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `parent_id`, `name`, `slug`, `description`) VALUES
(1, 0, 'Users', 'users', 'Access Users Module'),
(2, 1, 'View Users', 'users.view', 'View Users'),
(3, 1, 'Create Users', 'users.create', 'Create Users'),
(4, 1, 'Update Users', 'users.update', 'Update Users'),
(5, 1, 'Delete Users', 'users.delete', 'Delete users'),
(7, 1, 'View Roles', 'users.roles.view', 'View Roles'),
(8, 1, 'Create Roles', 'users.roles.create', 'Create Roles'),
(9, 1, 'Update Roles', 'users.roles.update', 'Update Roles'),
(10, 1, 'Delete Roles', 'users.roles.delete', 'Delete Roles'),
(11, 1, 'Assign Roles', 'users.roles.assign', 'Assign User Roles'),
(12, 0, 'Settings', 'settings', 'Access Settings Module'),
(13, 12, 'Update Settings', 'settings.update', 'Update Settings'),
(14, 12, 'View General Settings', 'settings.general.view', 'View General Settings'),
(15, 12, 'View Organisation Settings', 'settings.organisation.view', 'View Organisation Settings'),
(16, 0, 'Accounting', 'accounting', 'Access Accounting Module'),
(17, 16, 'View Chart of Accounts', 'accounting.gl_accounts.view', 'View Chart of Accounts'),
(18, 16, 'Create Chart of Accounts', 'accounting.gl_accounts.create', 'Create Chart of Accounts'),
(19, 16, 'Update Chart of Accounts', 'accounting.gl_accounts.update', 'Update Chart of Accounts'),
(20, 16, 'Delete Chart of Accounts', 'accounting.gl_accounts.delete', 'Delete Chart of Accounts'),
(21, 16, 'View Journals', 'accounting.journals.view', 'View Journals'),
(22, 16, 'Create Manual Journals', 'accounting.journals.create', 'Create Manual Journals'),
(23, 16, 'Delete Manual Journals', 'accounting.journals.delete', 'Delete Manual Journals'),
(24, 16, 'Approve Manual Journals', 'accounting.journals.approve', 'Approve Manual Journals'),
(25, 16, 'View Reconciliations', 'accounting.journals.reconciliation.view', 'View Reconciliations'),
(26, 16, 'Reconcile Journal Entries', 'accounting.journals.reconciliation.create', 'Reconcile Journal Entries'),
(27, 16, 'View Accounting Close Period', 'accounting.period.view', 'View  Accounting Close Period'),
(28, 16, 'Create Accounting Close Period', 'accounting.period.create', 'Create Accounting Close Period'),
(29, 16, 'Delete Accounting Close Period', 'accounting.period.delete', 'Delete Accounting Close Period'),
(30, 0, 'Audit Trail', 'audit_trail', 'Access Audit Trail Module'),
(31, 0, 'Branches', 'offices', 'Access Branches Module'),
(32, 31, 'View Branches', 'offices.view', 'View Branches'),
(33, 31, 'Create Branches', 'offices.create', 'Create Branches'),
(34, 31, 'Update Branches', 'offices.update', 'Update Branches'),
(35, 31, 'Delete Branches', 'offices.delete', 'Delete Branches'),
(36, 0, 'Clients', 'clients', 'Access Clients Module'),
(37, 36, 'View Clients', 'clients.view', 'View Clients'),
(38, 36, 'Create Clients', 'clients.create', 'Create Clients'),
(39, 36, 'Update Clients', 'clients.update', 'Update Clients'),
(40, 36, 'Delete Clients', 'clients.delete', 'Delete Clients'),
(41, 36, 'Approve Clients', 'clients.approve', 'Approve Clients'),
(42, 36, 'Close Client', 'clients.close', 'Close Client'),
(43, 36, 'View  Client Pending approval', 'clients.pending_approval', 'View  Client Pending approval'),
(44, 36, 'View Closed Clients', 'clients.closed', 'View Closed Clients'),
(45, 36, 'Create Client Document', 'clients.documents.create', 'Create Client Document'),
(46, 36, 'Read Client Document', 'clients.documents.view', 'Read Client Document'),
(47, 36, 'Delete Client Document', 'clients.documents.delete', 'Delete Client Document'),
(48, 36, 'Update Client Document', 'clients.documents.update', 'Update Client Document'),
(49, 36, 'Read Next Of Kin', 'clients.next_of_kin.view', 'Read Next Of Kin'),
(50, 36, 'Create Next Of Kin', 'clients.next_of_kin.create', 'Create Next Of Kin'),
(51, 36, 'Update Next Of Kin', 'clients.next_of_kin.update', 'Update Next Of Kin'),
(52, 36, 'Delete Next Of Kin', 'clients.next_of_kin.delete', 'Delete Next Of Kin'),
(53, 36, 'Read Client Identifiers', 'clients.identification.view', 'Read Client Identifiers'),
(54, 36, 'Create Client Identifiers', 'clients.identification.create', 'Create Client Identifiers'),
(55, 36, 'Update Client Identifiers', 'clients.identification.update', 'Update Client Identifiers'),
(56, 36, 'Delete Client identifier', 'clients.identification.delete', 'Delete Client identifier'),
(57, 36, 'Read Client notes', 'clients.notes.view', 'Read Client notes'),
(58, 36, 'Create Client notes', 'clients.notes.create', 'Create Client notes'),
(59, 36, 'Update Client notes', 'clients.notes.update', 'Update Client notes'),
(60, 36, 'Delete Client notes', 'clients.notes.delete', 'Delete Client notes'),
(61, 36, 'Read Client Accounts', 'clients.accounts.view', 'Read Client Accounts'),
(62, 36, 'Transfer Client', 'clients.transfer.client', 'Transfer Client'),
(63, 36, 'Approve Client Transfer', 'clients.transfer.approve', 'Approve Client Transfer'),
(64, 0, 'Groups', 'groups', 'Access Groups Module'),
(65, 64, 'View Groups', 'groups.view', 'View Groups'),
(66, 64, 'Create Group', 'groups.create', 'Create Group'),
(67, 64, 'Approve Group', 'groups.approve', 'Approve Group'),
(68, 64, 'Update Groups', 'groups.update', 'Update Groups'),
(69, 64, 'Add Client to Group', 'groups.client.create', 'Add Client to Group'),
(70, 64, 'Remove Client', 'groups.client.delete', 'Remove Client'),
(71, 64, 'View Group Document', 'groups.documents.view', 'View  Group Document'),
(72, 64, 'Add Group Document', 'groups.documents.create', 'Add Group Document'),
(73, 64, 'Update Group Document', 'groups.documents.update', 'Update Group Document'),
(74, 64, 'Delete Group Document', 'groups.documents.delete', 'Delete Group Document'),
(75, 64, 'View Group Note', 'groups.notes.view', 'View Group Note'),
(76, 64, 'Create Group Note', 'groups.notes.create', 'Create Group Note'),
(77, 64, 'Update Group Note', 'groups.notes.update', 'Update Group Note'),
(78, 64, 'Delete Group Note', 'groups.notes.delete', 'Delete Group Note'),
(79, 64, 'View Assigned Groups', 'groups.view_assigned', 'View Assigned Groups'),
(80, 64, 'View Created', 'groups.view_created', 'View Created'),
(81, 36, 'View Assigned', 'clients.view_assigned', 'View Assigned'),
(82, 36, 'View Created', 'clients.view_created', 'View Created'),
(83, 0, 'Loans', 'loans', 'Access Loans Module'),
(84, 83, 'View Loans', 'loans.view', 'View Loans'),
(85, 83, 'View Pending Loans', 'loans.pending_approval', 'View Pending Loans'),
(86, 64, 'View Groups Pending Approval', 'groups.pending_approval', 'View Groups Pending Approval'),
(87, 83, 'Awaiting Disbursement', 'loans.awaiting_disbursement', 'Loans Awaiting Disbursement'),
(88, 83, 'Loans Declined', 'loans.declined', 'View Loans Declined'),
(89, 83, 'View Loans Written Off', 'loans.written_off', 'View Loans Written Off'),
(90, 83, 'View Loans Closed', 'loans.closed', 'View Loans Closed'),
(91, 83, 'View Loans Rescheduled', 'loans.rescheduled', 'View Loans Rescheduled'),
(92, 83, 'View Loans Evaluated', 'loans.evaluated', 'View Loans Evaluated'),
(93, 83, 'Create Loans', 'loans.create', 'Create Loans'),
(94, 83, 'Update Loans', 'loans.update', 'Update Loans'),
(95, 83, 'Approve Loan', 'loans.approve', 'Approve Loan'),
(96, 83, 'Disburse Loans', 'loans.disburse', 'Disburse Loans'),
(97, 83, 'Undo Approval', 'loans.undo_approval', 'Disburse Loans'),
(98, 83, 'Undo Disbursement', 'loans.undo_disbursement', 'Undo Disbursement'),
(99, 83, 'Write off loan', 'loans.write_off', 'Write off loan'),
(100, 83, 'Undo Write off', 'loans.undo_write_off', 'Undo Write off'),
(101, 83, 'Waive Loan Interest', 'loans.waive_interest', 'Waive Loan Interest'),
(102, 83, 'Apply charge to loan', 'loans.charge.create', 'Apply charge to loan'),
(103, 83, 'Waive Loan Charge', 'loans.charge.waive', 'Waive Loan Charge'),
(104, 83, 'View Assigned Loans', 'loans.view_assigned', 'View Assigned Loans'),
(105, 83, 'Create Loan Reschedule', 'loans.reschedule.create', 'Create Loan Reschedule'),
(106, 83, 'Make Repayment', 'loans.transactions.create', 'Make Repayment'),
(107, 83, 'View Transactions', 'loans.transactions.view', 'View Transactions'),
(108, 83, 'Approve Loan Repayment', 'loans.transactions.approve', 'Approve Loan Repayment'),
(109, 83, 'Adjust Loan Transaction', 'loans.transactions.update', 'Adjust Loan Transaction'),
(110, 83, 'View System Reversed Transactions', 'loans.transactions.system_reversed', 'View System Reversed Transactions'),
(111, 83, 'View Loan Repayment Schedule', 'loans.view_repayment_schedule', 'View Loan Repayment Schedule'),
(112, 83, 'View Loan Documents', 'loans.documents.view', 'View Loan Documents'),
(113, 83, 'Create Loan Documents', 'loans.documents.create', 'Create Loan Documents'),
(114, 83, 'Update Loan Documents', 'loans.documents.update', 'Update Loan Documents'),
(115, 83, 'Delete Loan Documents', 'loans.documents.delete', 'Delete Loan Documents'),
(116, 83, 'View Collateral', 'loans.collateral.view', 'View Collateral'),
(117, 83, 'Create Collateral', 'loans.collateral.create', 'Create Collateral'),
(118, 83, 'Update Collateral', 'loans.collateral.update', 'Update Collateral'),
(119, 83, 'Delete Collateral', 'loans.collateral.delete', 'Delete Collateral'),
(120, 83, 'View Guarantors', 'loans.guarantors.view', 'View Guarantors'),
(121, 83, 'Create Guarantors', 'loans.guarantors.create', 'Create Guarantors'),
(122, 83, 'Update Guarantors', 'loans.guarantors.update', 'Update Guarantors'),
(123, 83, 'Delete Guarantors', 'loans.guarantors.delete', 'Delete Guarantors'),
(124, 83, 'View Loan Notes', 'loans.notes.view', 'View Loan Notes'),
(125, 83, 'Create Loan Notes', 'loans.notes.create', 'Create Loan Notes'),
(126, 83, 'Update Loan Notes', 'loans.notes.update', 'Update Loan Notes'),
(127, 83, 'Delete Loan Notes', 'loans.notes.delete', 'Delete Loan Notes'),
(128, 83, 'View Group Allocation', 'loans.view_group_allocation', 'View Group Allocation'),
(129, 83, 'View Client Details', 'loans.view_client_details', 'View Client Details'),
(130, 83, 'Email Schedule', 'loans.email_schedule', 'Email Schedule'),
(131, 83, 'Pdf Schedule', 'loans.pdf_schedule', 'Pdf Schedule'),
(132, 0, 'Savings', 'savings', 'Access Savings Module'),
(133, 132, 'View Savings', 'savings.view', 'View Savings'),
(134, 132, 'View Savings Pending Approval', 'savings.pending_approval', 'View Savings Pending Approval'),
(135, 132, 'View Approved Savings Accounts', 'savings.approved', 'View Approved Savings Accounts'),
(136, 132, 'View Savings Closed', 'savings.closed', 'View Savings Closed'),
(137, 132, 'Create Savings', 'savings.create', 'Create Savings'),
(138, 132, 'Update Savings', 'savings.update', 'Update Savings'),
(139, 132, 'Delete Savings', 'savings.delete', 'Delete Savings'),
(140, 132, 'Approve Savings', 'savings.approve', 'Approve Savings'),
(141, 132, 'Undo Approval', 'savings.undo_approval', 'Undo Approval'),
(142, 132, 'Close Savings Account', 'savings.close', 'Close Savings Account'),
(143, 132, 'View Transactions', 'savings.transactions.view', 'View Transactions'),
(144, 132, 'Create Transactions', 'savings.transactions.create', 'Create Transactions'),
(145, 132, 'Update Transactions', 'savings.transactions.update', 'Update Transactions'),
(146, 132, 'Delete Transactions', 'savings.transactions.delete', 'Delete Transaction'),
(147, 132, 'View Documents', 'savings.documents.view', 'View Documents'),
(148, 132, 'Create Savings Documents', 'savings.documents.create', 'Create Savings Documents'),
(149, 132, 'Update Savings Documents', 'savings.documents.update', 'Update Savings Documents'),
(150, 132, 'Delete Savings Documents', 'savings.documents.delete', 'Delete Savings Documents'),
(151, 132, 'View Savings Notes', 'savings.notes.view', 'View Savings Notes'),
(152, 132, 'Create Savings Notes', 'savings.notes.create', 'Create Savings Notes'),
(153, 132, 'Update Savings Notes', 'savings.notes.update', 'Update Savings Notes'),
(154, 132, 'Delete Savings Notes', 'savings.notes.delete', 'Delete Savings Notes'),
(155, 132, 'Post Interest', 'savings.post_interest', 'Post Interest'),
(156, 132, 'Email Statement', 'savings.email_statement', 'Email Statement'),
(157, 132, 'Pdf Statement', 'savings.pdf_statement', 'Pdf Statement'),
(158, 132, 'Add Charge To Savings Account', 'savings.charge.create', 'Add Charge To Savings Account'),
(159, 132, 'Waive Saving Account Charge', 'savings.charge.waive', 'Waive Saving Account Charge'),
(160, 132, 'Approve Savings Transaction', 'savings.transactions.approve', 'Approve Savings Transaction'),
(161, 132, 'Make Deposit', 'savings.transactions.deposit', 'Make Deposit'),
(162, 132, 'Make Withdrawal', 'savings.transactions.withdrawal', 'Make Withdrawal'),
(163, 0, 'Products', 'products', 'Access Savings & Loan Products and related modules'),
(164, 163, 'View Charges', 'products.charges.view', 'View Charges'),
(165, 163, 'Create Charge', 'products.charges.create', 'Create Charge'),
(166, 163, 'Update Charge', 'products.charges.update', 'Update Charge'),
(167, 163, 'Delete Charge', 'products.charge.delete', 'Delete Charge'),
(168, 163, 'View Currencies', 'products.currencies.view', 'View Currencies'),
(169, 163, 'Create Currency', 'products.currencies.create', 'Create Currency'),
(170, 163, 'Update Currency', 'products.currencies.update', 'Update Currency'),
(171, 163, 'Delete Currencies', 'products.currencies.delete', 'Delete Currencies'),
(172, 163, 'Funds', 'products.funds.view', 'Funds'),
(173, 163, 'Create Funds', 'products.funds.create', 'Create Funds'),
(174, 163, 'Update Funds', 'products.funds.update', 'Update Funds'),
(175, 163, 'Delete Funds', 'products.funds.delete', 'Delete Funds'),
(176, 163, 'View Payment Types', 'products.payment_types.view', 'View Payment Types'),
(177, 163, 'Create Payment types', 'products.payment_types.create', 'Create Payment types'),
(178, 163, 'Update Payment Types', 'products.payment_types.update', 'Update Payment Types'),
(179, 163, 'Delete Payment Types', 'products.payment_types.delete', 'Delete Payment Types'),
(180, 163, 'View Loan Purpose', 'products.loan_purposes.view', 'View Loan Purpose'),
(181, 163, 'Create Loan Purpose', 'products.loan_purposes.create', 'Create Loan Purpose'),
(182, 163, 'Delete Loan Purpose', 'products.loan_purposes.delete', 'Delete Loan Purpose'),
(183, 163, 'Update Loan Purpose', 'products.loan_purposes.update', 'Update Loan Purpose'),
(184, 163, 'View Collateral Types', 'products.collateral_types.view', 'View Collateral Types'),
(185, 163, 'Create Collateral Types', 'products.collateral_types.create', 'Create Collateral Types'),
(186, 163, 'Update Collateral Types', 'products.collateral_types.update', 'Update Collateral Types'),
(187, 163, 'Delete Collateral Types', 'products.collateral_types.delete', 'Delete Collateral Types'),
(188, 163, 'View Client Relationship', 'products.client_relationships.view', 'View Client Relationship'),
(189, 163, 'Create Client Relationship', 'products.client_relationships.create', 'Create Client Relationship'),
(190, 163, 'Update Client Relationship', 'products.client_relationships.update', 'Update Client Relationship'),
(191, 163, 'Delete Client Relationship', 'products.client_relationships.delete', 'Delete Client Relationship'),
(192, 163, 'View Client Identification Type', 'products.client_identification_types.view', 'View Client Identification Type'),
(193, 163, 'Create Client Identification Type', 'products.client_identification_types.create', 'Create Client Identification Type'),
(194, 163, 'Update Client Identification Type', 'products.client_identification_types.update', 'Update Client Identification Type'),
(195, 163, 'Delete Client Identification Type', 'products.client_identification_types.delete', 'Delete Client Identification Type'),
(196, 163, 'Manage Loan Provisioning Criteria', 'products.loan_provisioning_criteria.update', 'Manage Loan Provisioning Criteria'),
(197, 163, 'View Loan Products', 'products.loan_products.view', 'View Loan Products'),
(198, 163, 'Create Loan Products', 'products.loan_products.create', 'Create Loan Products'),
(199, 163, 'Update Loan Products', 'products.loan_products.update', 'Update Loan Products'),
(200, 163, 'Delete Loan Products', 'products.loan_products.delete', 'Delete Loan Products'),
(201, 163, 'View Savings Products', 'products.savings_products.view', 'View Savings Products'),
(202, 163, 'Create Savings Products', 'products.savings_products.create', 'Create View Savings Products'),
(203, 163, 'Update Savings Products', 'products.savings_products.update', 'Update Savings Products'),
(204, 163, 'Delete Savings Products', 'products.savings_products.delete', 'Delete Savings Products'),
(205, 0, 'Reports', 'reports', 'Access Reports Module'),
(206, 205, 'Downloading/Exporting of Reports', 'reports.downloading_exporting_of_reports', 'Downloading/Exporting of Reports'),
(207, 205, 'Client Reports', 'reports.client_reports', 'Access Client Reports Menu'),
(208, 205, 'Loan Reports', 'reports.loan_reports', 'Access Loan Reports Menu'),
(209, 205, 'Financial Reports', 'reports.financial_reports', 'Financial Reports'),
(210, 205, 'Savings Reports', 'reports.savings_reports', 'Access Savings Reports Menu'),
(211, 205, 'Reports Scheduler', 'reports.reports_scheduler', 'Access Reports Scheduler Menu'),
(212, 205, 'Client Numbers Report', 'reports.client_numbers_report', 'Client Numbers Report'),
(213, 205, 'Collection Sheet', 'reports.collection_sheet', 'Collection Sheet'),
(214, 205, 'Repayments Report', 'reports.repayments_report', 'Repayments Report'),
(215, 205, 'Expected Repayment', 'reports.expected_repayment', 'Expected Repayment'),
(216, 205, 'Arrears Report', 'reports.arrears_report', 'Arrears Report'),
(217, 205, 'Disbursed Loans', 'reports.disbursed_loans', 'Disbursed Loans'),
(218, 205, 'Loan Portfolio', 'reports.loan_portfolio', 'Loan Portfolio'),
(219, 205, 'Balance Sheet', 'reports.balance_sheet', 'Balance Sheet'),
(220, 205, 'Trial Balance', 'reports.trial_balance', 'Trial Balance'),
(221, 205, 'Income Statement', 'reports.income_statement', 'Income Statement'),
(222, 205, 'Provisioning', 'reports.provisioning', 'Provisioning'),
(223, 205, 'Journals Report', 'reports.journals_report', 'Journals Report'),
(224, 205, 'Savings Transactions', 'reports.savings_transactions', 'Savings Transactions'),
(225, 205, 'Savings Accounts Report', 'reports.savings_accounts_report', 'Savings Accounts Report'),
(226, 205, 'View Report Scheduler', 'reports.reports_scheduler.view', 'View Report Scheduler'),
(227, 205, 'Create Report Scheduler', 'reports.reports_scheduler.create', 'Create Report Scheduler'),
(228, 205, 'Update Report Scheduler', 'reports.reports_scheduler.update', 'Update Report Scheduler'),
(229, 205, 'Delete Report Scheduler', 'reports.reports_scheduler.delete', 'Delete Report Scheduler'),
(230, 0, 'Communication', 'communication', 'Access Communication Module'),
(231, 230, 'View Campaigns', 'communication.view', 'View Campaigns'),
(232, 230, 'Create Campaign', 'communication.create', 'Create Campaign'),
(233, 230, 'Update Campaign', 'communication.update', 'Update Campaign'),
(234, 230, 'Delete Campaign', 'communication.delete', 'Delete Campaign'),
(235, 230, 'Approve Campaign', 'communication.approve', 'Approve Campaign'),
(236, 0, 'Dashboard', 'dashboard', 'Dashboard'),
(237, 236, 'Loans Disbursed', 'dashboard.loans_disbursed', 'View Loans Disbursed'),
(238, 236, 'Total Repayments', 'dashboard.total_repayments', 'Total Repayments'),
(239, 236, 'Total Outstanding', 'dashboard.total_outstanding', 'Total Outstanding'),
(240, 236, 'Amount in Arrears', 'dashboard.amount_in_arrears', 'Amount in Arrears'),
(241, 236, 'Fees Earned', 'dashboard.fees_earned', 'Fees Earned'),
(242, 236, 'Fees Paid', 'dashboard.fees_paid', 'Fees Paid'),
(243, 236, 'Penalties Paid', 'dashboard.penalties_paid', 'Penalties Paid'),
(244, 236, 'Penalties Earned', 'dashboard.penalties_earned', 'Penalties Earned'),
(245, 236, 'Loans Status Overview', 'dashboard.loans_status_overview', 'Loans Status Overview'),
(246, 236, 'Clients Overview', 'dashboard.clients_overview', 'Clients Overview'),
(247, 236, 'Savings Balances Overview', 'dashboard.savings_balances_overview', 'Savings Balances Overview'),
(248, 236, 'My Loan Repayments', 'dashboard.my_loan_repayments', 'My Loan Repayments'),
(249, 236, 'My Disbursed loans', 'dashboard.my_disbursed_loans', 'My Disbursed loans'),
(250, 236, 'My Number of outstanding loans', 'dashboard.my_number_of_outstanding_loans', 'My Number of outstanding loans'),
(251, 236, 'My Outstanding Loan balance', 'dashboard.my_outstanding_loan_balance', 'My Outstanding Loan balance'),
(252, 236, 'My Clients', 'dashboard.my_clients', 'My Clients'),
(253, 236, 'My written off Amount', 'dashboard.my_written_off_amount', 'My written off Amount'),
(254, 236, 'Collection Statistics', 'dashboard.collection_statistics', 'Collection Statistics'),
(255, 0, 'Custom Fields', 'custom_fields', 'Access Custom Fields'),
(256, 255, 'View Custom Fields', 'custom_fields.view', 'View Custom Fields'),
(257, 255, 'Create Custom Fields', 'custom_fields.create', 'Create Custom Fields'),
(258, 255, 'Update Custom Fields', 'custom_fields.update', 'Update Custom Fields'),
(259, 255, 'Delete Custom Fields', 'custom_fields.delete', 'Delete Custom Fields');

-- --------------------------------------------------------

--
-- Table structure for table `persistences`
--

DROP TABLE IF EXISTS `persistences`;
CREATE TABLE IF NOT EXISTS `persistences` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `persistences_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `persistences`
--

INSERT INTO `persistences` (`id`, `user_id`, `code`, `created_at`, `updated_at`) VALUES
(12, 1, 'VcA56ZaX4Dj4ueG8LME2HecZubBi6sfa', '2018-04-24 08:03:30', '2018-04-24 08:03:30'),
(13, 1, 'eMGm9fxTXnEuswhSzFbeWmy5wGOon8PC', '2018-04-30 13:41:08', '2018-04-30 13:41:08'),
(14, 1, 'FMPj7FLcANxh2S8vAn0Rw3FUhMkBjk5V', '2018-05-14 08:57:13', '2018-05-14 08:57:13'),
(15, 1, 'WizybdLN8cDfCbw3ZXsyX1vDI8NfCzA8', '2018-05-14 18:20:15', '2018-05-14 18:20:15'),
(16, 1, '5lhse9tuNNwITplgu2rbXZlRChlzpliY', '2018-05-15 09:09:21', '2018-05-15 09:09:21'),
(17, 1, 'Z4zmch4MzxMEFXGO7cKNFmcsj0Q0UcTv', '2018-05-17 14:32:30', '2018-05-17 14:32:30'),
(18, 1, 'joDmqXwRT8Ib7T11FlfWfqXAJ5gt6weQ', '2018-05-19 19:28:52', '2018-05-19 19:28:52');

-- --------------------------------------------------------

--
-- Table structure for table `reminders`
--

DROP TABLE IF EXISTS `reminders`;
CREATE TABLE IF NOT EXISTS `reminders` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report_scheduler`
--

DROP TABLE IF EXISTS `report_scheduler`;
CREATE TABLE IF NOT EXISTS `report_scheduler` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` int(11) DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `report_start_date` date DEFAULT NULL,
  `report_start_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recurrence_type` enum('none','schedule') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recur_frequency` enum('daily','monthly','weekly','yearly') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recur_interval` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_recipients` text COLLATE utf8mb4_unicode_ci,
  `email_subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_message` text COLLATE utf8mb4_unicode_ci,
  `email_attachment_file_format` enum('pdf','csv','xls') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `report_category` enum('client_report','loan_report','financial_report','group_report','savings_report','organisation_report') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `report_name` enum('disbursed_loans_report','loan_portfolio_report','expected_repayments_report','repayments_report','collection_report','arrears_report','balance_sheet','trial_balance','profit_and_loss','cash_flow','provisioning','historical_income_statement','journals_report','accrued_interest','client_numbers_report','clients_overview','top_clients_report','loan_sizes_report','group_report','group_breakdown','savings_account_report','savings_balance_report','savings_transaction_report','fixed_term_maturity_report','products_summary','individual_indicator_report','loan_officer_performance_report','audit_report','group_indicator_report') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date_type` enum('date_picker','today','yesterday','tomorrow') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date_type` enum('date_picker','today','yesterday','tomorrow') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `office_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_officer_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gl_account_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manual_entries` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loan_product_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_run_date` date DEFAULT NULL,
  `next_run_date` date DEFAULT NULL,
  `last_run_time` date DEFAULT NULL,
  `next_run_time` date DEFAULT NULL,
  `number_of_runs` int(11) NOT NULL DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `status` enum('pending','approved','declined') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `approved_by_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report_scheduler_run_history`
--

DROP TABLE IF EXISTS `report_scheduler_run_history`;
CREATE TABLE IF NOT EXISTS `report_scheduler_run_history` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `report_schedule_id` int(11) DEFAULT NULL,
  `report_start_date` date DEFAULT NULL,
  `report_start_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time_limit` tinyint(4) NOT NULL DEFAULT '0',
  `from_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `access_days` text COLLATE utf8mb4_unicode_ci,
  `permissions` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `slug`, `name`, `time_limit`, `from_time`, `to_time`, `access_days`, `permissions`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Admin', 0, NULL, NULL, '[]', '{"users":true,"users.view":true,"users.create":true,"users.update":true,"users.delete":true,"users.roles.view":true,"users.roles.create":true,"users.roles.update":true,"users.roles.delete":true,"users.roles.assign":true,"settings":true,"settings.update":true,"settings.general.view":true,"settings.organisation.view":true,"accounting":true,"accounting.gl_accounts.view":true,"accounting.gl_accounts.create":true,"accounting.gl_accounts.update":true,"accounting.gl_accounts.delete":true,"accounting.journals.view":true,"accounting.journals.create":true,"accounting.journals.delete":true,"accounting.journals.approve":true,"accounting.journals.reconciliation.view":true,"accounting.journals.reconciliation.create":true,"accounting.period.view":true,"accounting.period.create":true,"accounting.period.delete":true,"audit_trail":true,"offices":true,"offices.view":true,"offices.create":true,"offices.update":true,"offices.delete":true,"clients":true,"clients.view":true,"clients.create":true,"clients.update":true,"clients.delete":true,"clients.approve":true,"clients.close":true,"clients.pending_approval":true,"clients.closed":true,"clients.documents.create":true,"clients.documents.view":true,"clients.documents.delete":true,"clients.documents.update":true,"clients.next_of_kin.view":true,"clients.next_of_kin.create":true,"clients.next_of_kin.update":true,"clients.next_of_kin.delete":true,"clients.identification.view":true,"clients.identification.create":true,"clients.identification.update":true,"clients.identification.delete":true,"clients.notes.view":true,"clients.notes.create":true,"clients.notes.update":true,"clients.notes.delete":true,"clients.accounts.view":true,"clients.transfer.client":true,"clients.transfer.approve":true,"clients.view_assigned":true,"clients.view_created":true,"groups":true,"groups.view":true,"groups.create":true,"groups.approve":true,"groups.update":true,"groups.client.create":true,"groups.client.delete":true,"groups.documents.view":true,"groups.documents.create":true,"groups.documents.update":true,"groups.documents.delete":true,"groups.notes.view":true,"groups.notes.create":true,"groups.notes.update":true,"groups.notes.delete":true,"groups.view_assigned":true,"groups.view_created":true,"groups.pending_approval":true,"loans":true,"loans.view":true,"loans.pending_approval":true,"loans.awaiting_disbursement":true,"loans.declined":true,"loans.written_off":true,"loans.closed":true,"loans.rescheduled":true,"loans.evaluated":true,"loans.create":true,"loans.update":true,"loans.approve":true,"loans.disburse":true,"loans.undo_approval":true,"loans.undo_disbursement":true,"loans.write_off":true,"loans.undo_write_off":true,"loans.waive_interest":true,"loans.charge.create":true,"loans.charge.waive":true,"loans.view_assigned":true,"loans.reschedule.create":true,"loans.transactions.create":true,"loans.transactions.view":true,"loans.transactions.approve":true,"loans.transactions.update":true,"loans.transactions.system_reversed":true,"loans.view_repayment_schedule":true,"loans.documents.view":true,"loans.documents.create":true,"loans.documents.update":true,"loans.documents.delete":true,"loans.collateral.view":true,"loans.collateral.create":true,"loans.collateral.update":true,"loans.collateral.delete":true,"loans.guarantors.view":true,"loans.guarantors.create":true,"loans.guarantors.update":true,"loans.guarantors.delete":true,"loans.notes.view":true,"loans.notes.create":true,"loans.notes.update":true,"loans.notes.delete":true,"loans.view_group_allocation":true,"loans.view_client_details":true,"loans.email_schedule":true,"loans.pdf_schedule":true,"savings":true,"savings.view":true,"savings.pending_approval":true,"savings.approved":true,"savings.closed":true,"savings.create":true,"savings.update":true,"savings.delete":true,"savings.approve":true,"savings.undo_approval":true,"savings.close":true,"savings.transactions.view":true,"savings.transactions.create":true,"savings.transactions.update":true,"savings.transactions.delete":true,"savings.documents.view":true,"savings.documents.create":true,"savings.documents.update":true,"savings.documents.delete":true,"savings.notes.view":true,"savings.notes.create":true,"savings.notes.update":true,"savings.notes.delete":true,"savings.post_interest":true,"savings.email_statement":true,"savings.pdf_statement":true,"savings.charge.create":true,"savings.charge.waive":true,"savings.transactions.approve":true,"savings.transactions.deposit":true,"savings.transactions.withdrawal":true,"products":true,"products.charges.view":true,"products.charges.create":true,"products.charges.update":true,"products.charge.delete":true,"products.currencies.view":true,"products.currencies.create":true,"products.currencies.update":true,"products.currencies.delete":true,"products.funds.view":true,"products.funds.create":true,"products.funds.update":true,"products.funds.delete":true,"products.payment_types.view":true,"products.payment_types.create":true,"products.payment_types.update":true,"products.payment_types.delete":true,"products.loan_purposes.view":true,"products.loan_purposes.create":true,"products.loan_purposes.delete":true,"products.loan_purposes.update":true,"products.collateral_types.view":true,"products.collateral_types.create":true,"products.collateral_types.update":true,"products.collateral_types.delete":true,"products.client_relationships.view":true,"products.client_relationships.create":true,"products.client_relationships.update":true,"products.client_relationships.delete":true,"products.client_identification_types.view":true,"products.client_identification_types.create":true,"products.client_identification_types.update":true,"products.client_identification_types.delete":true,"products.loan_provisioning_criteria.update":true,"products.loan_products.view":true,"products.loan_products.create":true,"products.loan_products.update":true,"products.loan_products.delete":true,"products.savings_products.view":true,"products.savings_products.create":true,"products.savings_products.update":true,"products.savings_products.delete":true,"reports":true,"reports.downloading_exporting_of_reports":true,"reports.client_reports":true,"reports.loan_reports":true,"reports.financial_reports":true,"reports.savings_reports":true,"reports.reports_scheduler":true,"reports.client_numbers_report":true,"reports.collection_sheet":true,"reports.repayments_report":true,"reports.expected_repayment":true,"reports.arrears_report":true,"reports.disbursed_loans":true,"reports.loan_portfolio":true,"reports.balance_sheet":true,"reports.trial_balance":true,"reports.income_statement":true,"reports.provisioning":true,"reports.journals_report":true,"reports.savings_transactions":true,"reports.savings_accounts_report":true,"reports.reports_scheduler.view":true,"reports.reports_scheduler.create":true,"reports.reports_scheduler.update":true,"reports.reports_scheduler.delete":true,"communication":true,"communication.view":true,"communication.create":true,"communication.update":true,"communication.delete":true,"communication.approve":true,"dashboard":true,"dashboard.loans_disbursed":true,"dashboard.total_repayments":true,"dashboard.total_outstanding":true,"dashboard.amount_in_arrears":true,"dashboard.fees_earned":true,"dashboard.fees_paid":true,"dashboard.penalties_paid":true,"dashboard.penalties_earned":true,"dashboard.loans_status_overview":true,"dashboard.clients_overview":true,"dashboard.savings_balances_overview":true,"dashboard.my_loan_repayments":true,"dashboard.my_disbursed_loans":true,"dashboard.my_number_of_outstanding_loans":true,"dashboard.my_outstanding_loan_balance":true,"dashboard.my_clients":true,"dashboard.my_written_off_amount":true,"dashboard.collection_statistics":true,"custom_fields":true,"custom_fields.view":true,"custom_fields.create":true,"custom_fields.update":true,"custom_fields.delete":true}', NULL, '2018-05-20 21:19:12'),
(2, 'client', 'Client', 0, NULL, NULL, '[]', '{}', NULL, NULL),
(3, 'accountant', 'Accountant', 1, '08:00', '20:00', '["monday","tuesday","wednesday","thursday","friday"]', '{"borrowers":true,"borrowers.view":true,"borrowers.update":true,"borrowers.delete":true,"borrowers.create":true,"borrowers.approve":true,"borrowers.blacklist":true,"borrowers.groups":true,"users":true,"users.view":true,"users.create":true,"users.update":true,"users.delete":true,"users.roles":true,"settings":true}', '2018-04-24 04:48:34', '2018-04-24 05:23:55');

-- --------------------------------------------------------

--
-- Table structure for table `role_users`
--

DROP TABLE IF EXISTS `role_users`;
CREATE TABLE IF NOT EXISTS `role_users` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_users`
--

INSERT INTO `role_users` (`user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2018-04-24 04:44:57', '2018-04-24 04:44:57'),
(2, 1, '2018-04-24 08:37:52', '2018-04-24 08:37:52');

-- --------------------------------------------------------

--
-- Table structure for table `savings`
--

DROP TABLE IF EXISTS `savings`;
CREATE TABLE IF NOT EXISTS `savings` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `field_officer_id` int(11) DEFAULT NULL,
  `savings_product_id` int(11) DEFAULT NULL,
  `external_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `decimals` int(11) NOT NULL DEFAULT '2',
  `interest_rate` decimal(65,4) DEFAULT NULL,
  `allow_overdraft` tinyint(4) NOT NULL DEFAULT '0',
  `minimum_balance` decimal(65,4) DEFAULT NULL,
  `overdraft_limit` decimal(65,4) DEFAULT NULL,
  `interest_compounding_period` enum('daily','monthly','quarterly','biannual','annually') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_posting_period` enum('monthly','quarterly','biannual','annually') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allow_transfer_withdrawal_fee` tinyint(4) NOT NULL DEFAULT '0',
  `opening_balance` decimal(65,4) DEFAULT NULL,
  `allow_additional_charges` tinyint(4) NOT NULL DEFAULT '0',
  `year_days` enum('360','365') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '365',
  `status` enum('pending','approved','closed','declined','withdrawn') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_by_id` int(11) DEFAULT NULL,
  `modified_by_id` int(11) DEFAULT NULL,
  `approved_by_id` int(11) DEFAULT NULL,
  `closed_by_id` int(11) DEFAULT NULL,
  `declined_by_id` int(11) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `modified_date` date DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `declined_date` date DEFAULT NULL,
  `closed_date` date DEFAULT NULL,
  `month` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `approved_notes` text COLLATE utf8mb4_unicode_ci,
  `declined_notes` text COLLATE utf8mb4_unicode_ci,
  `closed_notes` text COLLATE utf8mb4_unicode_ci,
  `balance` decimal(65,4) DEFAULT NULL,
  `deposits` decimal(65,4) DEFAULT NULL,
  `interest_earned` decimal(65,4) DEFAULT NULL,
  `interest_posted` decimal(65,4) DEFAULT NULL,
  `interest_overdraft` decimal(65,4) DEFAULT NULL,
  `withdrawals` decimal(65,4) DEFAULT NULL,
  `fees` decimal(65,4) DEFAULT NULL,
  `penalty` decimal(65,4) DEFAULT NULL,
  `start_interest_calculation_date` date DEFAULT NULL,
  `last_interest_calculation_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `client_type` enum('client','group') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `next_interest_calculation_date` date DEFAULT NULL,
  `next_interest_posting_date` date DEFAULT NULL,
  `last_interest_posting_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `savings`
--

INSERT INTO `savings` (`id`, `client_id`, `group_id`, `field_officer_id`, `savings_product_id`, `external_id`, `account_number`, `currency_id`, `decimals`, `interest_rate`, `allow_overdraft`, `minimum_balance`, `overdraft_limit`, `interest_compounding_period`, `interest_posting_period`, `allow_transfer_withdrawal_fee`, `opening_balance`, `allow_additional_charges`, `year_days`, `status`, `created_by_id`, `modified_by_id`, `approved_by_id`, `closed_by_id`, `declined_by_id`, `created_date`, `modified_date`, `approved_date`, `declined_date`, `closed_date`, `month`, `year`, `notes`, `approved_notes`, `declined_notes`, `closed_notes`, `balance`, `deposits`, `interest_earned`, `interest_posted`, `interest_overdraft`, `withdrawals`, `fees`, `penalty`, `start_interest_calculation_date`, `last_interest_calculation_date`, `created_at`, `updated_at`, `client_type`, `office_id`, `next_interest_calculation_date`, `next_interest_posting_date`, `last_interest_posting_date`) VALUES
(1, 1, NULL, 2, 1, 'ff', NULL, 1, 2, '10.0000', 0, '100.0000', NULL, NULL, 'monthly', 0, NULL, 0, '365', 'approved', 1, NULL, 1, NULL, NULL, '2018-05-10', NULL, '2018-05-10', NULL, NULL, '05', '2018', NULL, 'ff', NULL, NULL, NULL, NULL, '0.1258', NULL, NULL, NULL, NULL, NULL, '2018-03-09', '2018-05-31', '2018-05-10 10:07:59', '2018-05-31 16:14:57', 'client', 1, '2018-06-01', NULL, NULL),
(2, NULL, 2, 2, 1, 'gg', NULL, 1, 2, '10.0000', 0, '100.0000', NULL, 'daily', 'monthly', 0, NULL, 0, '365', 'approved', 1, NULL, 1, NULL, NULL, '2018-05-15', NULL, '2018-05-15', NULL, NULL, '05', '2018', NULL, 'g', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-16', NULL, '2018-05-15 12:40:13', '2018-05-15 12:40:35', 'group', 1, '2018-05-16', '2018-05-31', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `savings_charges`
--

DROP TABLE IF EXISTS `savings_charges`;
CREATE TABLE IF NOT EXISTS `savings_charges` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `savings_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `penalty` tinyint(4) NOT NULL DEFAULT '0',
  `waived` tinyint(4) NOT NULL DEFAULT '0',
  `charge_type` enum('savings_activation','withdrawal_fee','annual_fee','monthly_fee','specified_due_date') COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge_option` enum('flat','percentage') COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(65,2) DEFAULT NULL,
  `amount_paid` decimal(65,2) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `grace_period` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `savings_charges`
--

INSERT INTO `savings_charges` (`id`, `savings_id`, `charge_id`, `penalty`, `waived`, `charge_type`, `charge_option`, `amount`, `amount_paid`, `due_date`, `grace_period`, `created_at`, `updated_at`) VALUES
(4, 1, 4, 0, 0, 'monthly_fee', 'flat', '5.00', NULL, NULL, 0, '2018-05-10 10:44:32', '2018-05-10 10:44:32'),
(3, 1, 5, 0, 0, 'savings_activation', 'flat', '10.00', NULL, NULL, 0, '2018-05-10 10:44:32', '2018-05-10 10:44:32'),
(5, 2, 4, 0, 0, 'monthly_fee', 'flat', '5.00', NULL, NULL, 0, '2018-05-15 12:40:14', '2018-05-15 12:40:14'),
(6, 2, 5, 0, 0, 'savings_activation', 'flat', '10.00', NULL, NULL, 0, '2018-05-15 12:40:14', '2018-05-15 12:40:14');

-- --------------------------------------------------------

--
-- Table structure for table `savings_products`
--

DROP TABLE IF EXISTS `savings_products`;
CREATE TABLE IF NOT EXISTS `savings_products` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `currency_id` int(11) DEFAULT NULL,
  `decimals` int(11) NOT NULL DEFAULT '2',
  `interest_rate` decimal(65,4) DEFAULT NULL,
  `allow_overdraft` tinyint(4) NOT NULL DEFAULT '0',
  `minimum_balance` decimal(65,4) DEFAULT NULL,
  `interest_compounding_period` enum('daily','monthly','quarterly','biannual','annually') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interest_posting_period` enum('monthly','quarterly','biannual','annually') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `allow_transfer_withdrawal_fee` tinyint(4) NOT NULL DEFAULT '0',
  `opening_balance` decimal(65,4) DEFAULT NULL,
  `allow_additional_charges` tinyint(4) NOT NULL DEFAULT '0',
  `year_days` enum('360','365') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '365',
  `accounting_rule` enum('none','cash') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'cash',
  `gl_account_savings_reference_id` int(11) DEFAULT NULL,
  `gl_account_overdraft_portfolio_id` int(11) DEFAULT NULL,
  `gl_account_savings_control_id` int(11) DEFAULT NULL,
  `gl_account_interest_on_savings_id` int(11) DEFAULT NULL,
  `gl_account_savings_written_off_id` int(11) DEFAULT NULL,
  `gl_account_income_interest_id` int(11) DEFAULT NULL,
  `gl_account_income_fee_id` int(11) DEFAULT NULL,
  `gl_account_income_penalty_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `interest_calculation_type` enum('daily','average') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `savings_products`
--

INSERT INTO `savings_products` (`id`, `created_by_id`, `name`, `short_name`, `description`, `currency_id`, `decimals`, `interest_rate`, `allow_overdraft`, `minimum_balance`, `interest_compounding_period`, `interest_posting_period`, `allow_transfer_withdrawal_fee`, `opening_balance`, `allow_additional_charges`, `year_days`, `accounting_rule`, `gl_account_savings_reference_id`, `gl_account_overdraft_portfolio_id`, `gl_account_savings_control_id`, `gl_account_interest_on_savings_id`, `gl_account_savings_written_off_id`, `gl_account_income_interest_id`, `gl_account_income_fee_id`, `gl_account_income_penalty_id`, `created_at`, `updated_at`, `interest_calculation_type`) VALUES
(1, 1, 'test', 'bv54', 'Service', 1, 2, '10.0000', 0, '100.0000', 'daily', 'monthly', 0, NULL, 0, '365', 'cash', 1, 7, 4, 6, 6, 10, 3, 3, '2018-05-10 08:21:26', '2018-05-10 19:19:29', 'daily'),
(2, 1, 'bb', 'ff', 'gvg', 1, 2, '12.0000', 0, '0.0000', 'daily', 'monthly', 0, NULL, 0, '365', 'none', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2018-05-10 11:16:53', '2018-05-10 13:11:09', 'daily');

-- --------------------------------------------------------

--
-- Table structure for table `savings_product_charges`
--

DROP TABLE IF EXISTS `savings_product_charges`;
CREATE TABLE IF NOT EXISTS `savings_product_charges` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` int(11) DEFAULT NULL,
  `charge_id` int(11) DEFAULT NULL,
  `savings_product_id` int(11) DEFAULT NULL,
  `amount` decimal(65,2) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `grace_period` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `savings_product_charges`
--

INSERT INTO `savings_product_charges` (`id`, `created_by_id`, `charge_id`, `savings_product_id`, `amount`, `date`, `grace_period`, `created_at`, `updated_at`) VALUES
(23, NULL, 4, 1, NULL, NULL, 0, '2018-05-10 20:46:30', '2018-05-10 20:46:30'),
(22, NULL, 5, 1, NULL, NULL, 0, '2018-05-10 20:46:30', '2018-05-10 20:46:30'),
(8, NULL, 5, 2, NULL, NULL, 0, '2018-05-10 13:11:09', '2018-05-10 13:11:09'),
(7, NULL, 4, 2, NULL, NULL, 0, '2018-05-10 13:11:09', '2018-05-10 13:11:09'),
(21, NULL, 6, 1, NULL, NULL, 0, '2018-05-10 20:46:30', '2018-05-10 20:46:30');

-- --------------------------------------------------------

--
-- Table structure for table `savings_transactions`
--

DROP TABLE IF EXISTS `savings_transactions`;
CREATE TABLE IF NOT EXISTS `savings_transactions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` int(11) DEFAULT NULL,
  `modified_by_id` int(11) DEFAULT NULL,
  `payment_detail_id` int(11) DEFAULT NULL,
  `savings_id` int(10) UNSIGNED DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT '0.00',
  `debit` decimal(65,4) DEFAULT NULL,
  `credit` decimal(65,4) DEFAULT NULL,
  `balance` decimal(65,4) DEFAULT NULL,
  `transaction_type` enum('deposit','withdrawal','bank_fees','interest','dividend','guarantee','guarantee_restored','fees_payment','transfer_loan','transfer_savings','specified_due_date_fee') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reversible` tinyint(4) NOT NULL DEFAULT '0',
  `reversed` tinyint(4) NOT NULL DEFAULT '0',
  `reversal_type` enum('system','user','none') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `system_interest` tinyint(4) NOT NULL DEFAULT '0',
  `date` date DEFAULT NULL,
  `time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `month` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `balance_days` int(11) DEFAULT NULL,
  `cumulative_balance_days` int(11) DEFAULT NULL,
  `balance_date` date DEFAULT NULL,
  `cumulative_balance` decimal(65,4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `savings_transactions`
--

INSERT INTO `savings_transactions` (`id`, `created_by_id`, `modified_by_id`, `payment_detail_id`, `savings_id`, `amount`, `debit`, `credit`, `balance`, `transaction_type`, `reversible`, `reversed`, `reversal_type`, `system_interest`, `date`, `time`, `year`, `month`, `notes`, `created_at`, `updated_at`, `office_id`, `balance_days`, `cumulative_balance_days`, `balance_date`, `cumulative_balance`) VALUES
(1, 1, NULL, NULL, 1, '0.00', '10.0000', NULL, '-10.0000', 'bank_fees', 1, 0, 'none', 0, '2018-05-10', '15:21', '2018', '05', NULL, '2018-05-10 13:21:03', '2018-05-12 23:40:05', 1, NULL, NULL, NULL, NULL),
(2, 1, NULL, 102, 1, '0.00', NULL, '120.0000', '110.0000', 'deposit', 1, 0, 'none', 0, '2018-05-10', NULL, '2018', '05', NULL, '2018-05-10 14:32:12', '2018-05-12 23:40:05', 1, NULL, NULL, NULL, NULL),
(3, 1, NULL, 103, 1, '0.00', '23.0000', '23.0000', NULL, 'deposit', 0, 1, 'user', 0, '2018-05-10', NULL, '2018', '05', NULL, '2018-05-10 14:41:00', '2018-05-10 14:42:53', 1, NULL, NULL, NULL, NULL),
(4, 1, NULL, 104, 1, '0.00', '26.0000', '26.0000', NULL, 'deposit', 0, 1, 'user', 0, '2018-05-10', NULL, '2018', '05', NULL, '2018-05-10 14:42:53', '2018-05-10 14:50:23', 1, NULL, NULL, NULL, NULL),
(5, 1, NULL, 105, 1, '0.00', NULL, '26.0000', '136.0000', 'deposit', 1, 0, 'none', 0, '2018-05-10', NULL, '2018', '05', NULL, '2018-05-10 14:46:14', '2018-05-12 23:40:05', 1, NULL, NULL, NULL, NULL),
(6, 1, NULL, 106, 1, '0.00', NULL, '26.0000', '162.0000', 'deposit', 1, 0, 'none', 0, '2018-05-10', NULL, '2018', '05', NULL, '2018-05-10 14:47:54', '2018-05-12 23:40:05', 1, NULL, NULL, NULL, NULL),
(8, 1, NULL, 108, 1, '0.00', '25.0000', NULL, '137.0000', 'withdrawal', 1, 0, 'none', 0, '2018-05-10', NULL, '2018', '05', 'x', '2018-05-10 15:27:51', '2018-05-12 23:40:05', 1, NULL, NULL, NULL, NULL),
(9, 1, NULL, NULL, 1, '0.00', '123.0000', NULL, '14.0000', 'bank_fees', 1, 0, 'none', 0, '2018-05-10', '20:28', '2018', '05', NULL, '2018-05-10 18:28:42', '2018-05-12 23:40:05', 1, NULL, NULL, NULL, NULL),
(10, 1, NULL, 109, 1, '0.00', NULL, '400.0000', '414.0000', 'deposit', 1, 0, 'none', 0, '2018-05-10', NULL, '2018', '05', NULL, '2018-05-10 18:29:10', '2018-05-12 23:40:05', 1, NULL, NULL, NULL, NULL),
(11, 1, NULL, 111, 1, '0.00', NULL, '134.0000', '513.0000', 'deposit', 1, 0, 'none', 0, '2018-05-13', NULL, '2018', '05', NULL, '2018-05-12 23:26:48', '2018-05-12 23:40:05', 1, NULL, NULL, NULL, NULL),
(12, 1, NULL, 112, 1, '0.00', '54.0000', NULL, '459.0000', 'withdrawal', 1, 0, 'none', 0, '2018-05-13', NULL, '2018', '05', NULL, '2018-05-12 23:39:27', '2018-05-12 23:40:05', 1, NULL, NULL, NULL, NULL),
(13, 1, NULL, 113, 1, '0.00', '35.0000', NULL, '379.0000', 'withdrawal', 1, 0, 'none', 0, '2018-05-12', NULL, '2018', '05', NULL, '2018-05-12 23:40:05', '2018-05-12 23:40:05', 1, NULL, NULL, NULL, NULL),
(14, 1, NULL, NULL, 2, '0.00', '10.0000', NULL, NULL, 'bank_fees', 1, 0, 'none', 0, '2018-05-15', '14:40', '2018', '05', NULL, '2018-05-15 12:40:35', '2018-05-15 12:40:35', 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `setting_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setting_value` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `setting_key`, `setting_value`) VALUES
(1, 'company_name', 'Loan'),
(2, 'company_address', 'Suite 608'),
(3, 'company_currency', '1'),
(4, 'company_website', 'http://www.webstudio.co.zw'),
(5, 'company_country', '1'),
(6, 'system_version', '1.0'),
(7, 'sms_enabled', '1'),
(8, 'active_sms', NULL),
(9, 'portal_address', 'http://www.'),
(10, 'company_email', 'info@webstudio.co.zw'),
(11, 'currency_symbol', '$'),
(12, 'currency_position', 'left'),
(13, 'company_logo', 'logo.jpg'),
(14, 'paypal_email', ''),
(15, 'currency', 'USD'),
(16, 'password_reset_subject', 'Password reset instructions'),
(17, 'password_reset_template', '<div class="WordSection1">\r\n<p class="MsoNormal">&nbsp;</p>\r\n<p>{companyLogo}</p>\r\n<p>Hello {firstName} {lastName},</p>\r\n<p>Your password has been reset. Please click the link below to reset it. If you did not request a password reset just ignore this ms</p>\r\n<p>Click <a href="{resetLink}">{resetLink}</a></p>\r\n<p>Best Wishes, <br /> Webstudio Support Team<br /> The Web Specialists</p>\r\n<table id="templateFooter" class="MsoNormalTable" style="width: 100.0%; mso-cellspacing: 0in; mso-yfti-tbllook: 1184; mso-padding-alt: 0in 0in 0in 0in;" border="0" width="100%" cellspacing="0" cellpadding="0">\r\n<tbody>\r\n<tr style="mso-yfti-irow: 0; mso-yfti-firstrow: yes; mso-yfti-lastrow: yes;">\r\n<td style="padding: 15.0pt 15.0pt 15.0pt 15.0pt;" valign="top">\r\n<p class="MsoNormal" style="text-align: center; line-height: 150%;" align="center"><span style="font-size: 9.0pt; line-height: 150%; font-family: ''Helvetica'',''sans-serif'';"><a href="http://webstudio.co.zw"><span style="color: #606060;">visit our website</span></a> <span class="hide-mobile"><span style="font-family: ''Helvetica'',''sans-serif'';">| </span></span><a href="http://clients.webstudio.co.zw/"><span style="color: #606060;">log in to your account</span></a> <span class="hide-mobile"><span style="font-family: ''Helvetica'',''sans-serif'';">| </span></span><a href="http://clients.webstudio.co.zw/ticket/create"><span style="color: #606060;">get support</span></a> <br /> Copyright &copy; webstudio.co.zw, All rights reserved. </span></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p class="MsoNormal">&nbsp;</p>\r\n</div>'),
(18, 'payment_received_sms_template', 'Dear {clientName}, we have received your payment of ${paymentAmount} for loan {loanNumber}. New loan balance:${loanBalance}. Thank you'),
(19, 'payment_received_email_template', '<p>Dear {clientName}, we have received your payment of ${paymentAmount} for loan {loanNumber}. New loan balance:${loanBalance}. Thank you</p>'),
(20, 'payment_received_email_subject', 'Payment Received'),
(21, 'payment_email_subject', 'Payment Receipt'),
(22, 'payment_email_template', '<p>Dear {clientName}, find attached receipt of your payment of ${paymentAmount} for loan {loanNumber} on {paymentDate}. New loan balance:${loanBalance}. Thank you</p>'),
(23, 'client_statement_email_subject', 'Client Statement'),
(24, 'client_statement_email_template', '<p>Dear {clientName}, find attached statement of your loans with us. Thank you</p>'),
(25, 'loan_statement_email_subject', 'Loan Statement'),
(26, 'loan_statement_email_template', '<p>Dear {clientName}, find attached loan statement for loan {loanNumber}. Thank you</p>'),
(27, 'loan_schedule_email_subject', 'Loan Schedule'),
(28, 'loan_schedule_email_template', '<p>Dear {clientName}, find attached loan schedule for loan {loanNumber}. Thank you</p>'),
(29, 'cron_last_run', '2018-05-31 18:17:29'),
(30, 'auto_apply_penalty', NULL),
(31, 'auto_payment_receipt_sms', '0'),
(32, 'auto_payment_receipt_email', '1'),
(33, 'auto_repayment_sms_reminder', '0'),
(34, 'auto_repayment_email_reminder', '1'),
(35, 'auto_repayment_days', '4'),
(36, 'auto_overdue_repayment_sms_reminder', '0'),
(37, 'auto_overdue_repayment_email_reminder', '1'),
(38, 'auto_overdue_repayment_days', '2'),
(39, 'auto_overdue_loan_sms_reminder', '0'),
(40, 'auto_overdue_loan_email_reminder', '1'),
(41, 'auto_overdue_loan_days', '4'),
(42, 'loan_overdue_email_subject', 'Loan Overdue'),
(43, 'loan_overdue_email_template', '<p>Dear {clientName}, Your loan {loanNumber} is overdue. Please make your payment. Thank you</p>'),
(44, 'loan_overdue_sms_template', 'Dear {clientName}, Your loan {loanNumber} is overdue. Please make your payment. Thank you'),
(45, 'loan_payment_reminder_subject', 'Upcoming Payment Reminder'),
(46, 'loan_payment_reminder_email_template', '<p>Dear {clientName},You have an upcoming payment of {paymentAmount} due on {paymentDate} for loan {loanNumber}. Please make your payment. Thank you</p>'),
(47, 'loan_payment_reminder_sms_template', 'Dear {clientName},You have an upcoming payment of {paymentAmount} due on {paymentDate} for loan {loanNumber}. Please make your payment. Thank you'),
(48, 'missed_payment_email_subject', 'Missed Payment'),
(49, 'missed_payment_email_template', '<p>Dear {clientName},You missed payment of {paymentAmount} which was due on {paymentDate} for loan {loanNumber}. Please make your payment. Thank you</p>'),
(50, 'missed_payment_sms_template', 'Dear {clientName},You missed  payment of {paymentAmount} which was due on {paymentDate} for loan {loanNumber}. Please make your payment. Thank you'),
(51, 'enable_cron', '1'),
(52, 'loan_approved_auto_email', '1'),
(53, 'loan_approved_auto_sms', '0'),
(54, 'loan_disbursed_auto_email', '1'),
(55, 'loan_disbursed_auto_sms', '0'),
(56, 'loan_approved_email_subject', 'Loan Approved'),
(57, 'loan_approved_email_template', '<p>Dear {clientName},Your loan {loanNumber} has been approved, amount {approvedAmount}. Thank you</p>'),
(58, 'loan_approved_sms_template', 'Dear {clientName},Your loan {loanNumber} has been approved, amount {approvedAmount}. Thank you'),
(59, 'loan_disbursed_email_subject', 'Loan Disbursed'),
(60, 'loan_disbursed_email_template', '<p>Dear {clientName},Your loan {loanNumber} has been disbursed.First payment:{firstPaymentDate},amount {firstPaymentAmount}. Thank you</p>'),
(61, 'loan_disbursed_sms_template', 'Dear {clientName},Your loan {loanNumber} has been disbursed.First payment:{firstPaymentDate},amount {firstPaymentAmount}. Thank you'),
(62, 'savings_statement_email_subject', 'Savings Statement'),
(63, 'savings_statement_email_template', 'Dear {clientName},Find your statement for {savingsNumber} attached. Thank you'),
(64, 'allow_self_registration', '0'),
(65, 'allow_client_apply', '0'),
(66, 'enable_google_recaptcha', '0'),
(67, 'google_recaptcha_site_key', NULL),
(68, 'google_recaptcha_secret_key', NULL),
(69, 'update_url', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sms_gateways`
--

DROP TABLE IF EXISTS `sms_gateways`;
CREATE TABLE IF NOT EXISTS `sms_gateways` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_id` int(11) DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `from_name` text COLLATE utf8mb4_unicode_ci,
  `to_name` text COLLATE utf8mb4_unicode_ci,
  `url` text COLLATE utf8mb4_unicode_ci,
  `msg_name` text COLLATE utf8mb4_unicode_ci,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `throttle`
--

DROP TABLE IF EXISTS `throttle`;
CREATE TABLE IF NOT EXISTS `throttle` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `throttle_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `office_id` int(11) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8mb4_unicode_ci,
  `last_login` timestamp NULL DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable_google2fa` tinyint(4) NOT NULL DEFAULT '0',
  `blocked` tinyint(4) NOT NULL DEFAULT '0',
  `google2fa_secret` text COLLATE utf8mb4_unicode_ci,
  `time_limit` tinyint(4) NOT NULL DEFAULT '0',
  `from_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `access_days` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `office_id`, `email`, `password`, `permissions`, `last_login`, `first_name`, `last_name`, `enable_google2fa`, `blocked`, `google2fa_secret`, `time_limit`, `from_time`, `to_time`, `access_days`, `created_at`, `updated_at`) VALUES
(1, NULL, 'admin@webstudio.co.zw', '$2y$10$6ZiAWShc82tn1GpDGU/AMOGM0VlJIXcAz20ImrYd34soBjbmgld7m', NULL, '2018-05-19 19:28:53', 'Admin', 'Admin', 0, 0, NULL, 0, NULL, NULL, NULL, '2018-04-24 04:44:57', '2018-05-19 19:28:53'),
(2, NULL, 'tjmugova@webstudio.co.zw', '$2y$10$NibS4CN4ZHd3giRehd7ndevHaPGUiBBjEXqlh0wR/pjISE5ib/AOy', NULL, NULL, 'Tererai', 'Mugova', 0, 0, NULL, 0, NULL, NULL, NULL, '2018-04-24 08:37:52', '2018-04-24 08:37:52');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
