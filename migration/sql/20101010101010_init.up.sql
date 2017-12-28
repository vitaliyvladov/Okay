SET NAMES utf8;
SET time_zone = '+00:00';

DROP TABLE IF EXISTS `mi_executed_migration`;
CREATE TABLE `mi_executed_migration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_banners`;
CREATE TABLE `ok_banners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` varchar(32) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `show_all_pages` tinyint(1) NOT NULL DEFAULT '0',
  `categories` varchar(200) NOT NULL DEFAULT '0',
  `pages` varchar(200) NOT NULL DEFAULT '0',
  `brands` varchar(200) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `position` (`position`),
  KEY `visible` (`visible`),
  KEY `show_all_pages` (`show_all_pages`),
  KEY `category` (`categories`),
  KEY `pages` (`pages`),
  KEY `brands` (`brands`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_banners_images`;
CREATE TABLE `ok_banners_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `banner_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `alt` varchar(255) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `image` varchar(255) NOT NULL DEFAULT '',
  `position` int(11) NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `position` (`position`),
  KEY `visible` (`visible`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_blog`;
CREATE TABLE `ok_blog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(512) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `meta_title` varchar(512) NOT NULL DEFAULT '',
  `meta_keywords` varchar(512) NOT NULL DEFAULT '',
  `meta_description` varchar(512) NOT NULL DEFAULT '',
  `annotation` text NOT NULL,
  `description` text NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `image` varchar(255) NOT NULL DEFAULT '',
  `last_modify` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type_post` enum('blog','news') NOT NULL DEFAULT 'blog',
  PRIMARY KEY (`id`),
  KEY `enabled` (`visible`),
  KEY `url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_brands`;
CREATE TABLE `ok_brands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `meta_title` varchar(512) NOT NULL DEFAULT '',
  `meta_keywords` varchar(512) NOT NULL DEFAULT '',
  `meta_description` varchar(512) NOT NULL DEFAULT '',
  `annotation` text NOT NULL,
  `description` text NOT NULL,
  `image` varchar(255) NOT NULL,
  `last_modify` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `position` int(11) NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_callbacks`;
CREATE TABLE `ok_callbacks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `name` varchar(255) NOT NULL DEFAULT '',
  `phone` varchar(255) NOT NULL DEFAULT '',
  `message` text,
  `processed` tinyint(1) NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  `admin_notes` varchar(1024) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_categories`;
CREATE TABLE `ok_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `name_h1` varchar(255) NOT NULL DEFAULT '',
  `yandex_name` varchar(255) NOT NULL DEFAULT '',
  `meta_title` varchar(512) NOT NULL DEFAULT '',
  `meta_keywords` varchar(512) NOT NULL DEFAULT '',
  `meta_description` varchar(512) NOT NULL DEFAULT '',
  `annotation` text NOT NULL,
  `description` text NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `image` varchar(255) NOT NULL DEFAULT '',
  `position` int(11) NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `external_id` varchar(36) NOT NULL DEFAULT '',
  `level_depth` tinyint(1) NOT NULL DEFAULT '1',
  `auto_meta_title` varchar(512) NOT NULL DEFAULT '',
  `auto_meta_keywords` varchar(512) NOT NULL DEFAULT '',
  `auto_meta_desc` varchar(512) NOT NULL DEFAULT '',
  `auto_description` text NOT NULL,
  `last_modify` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `url` (`url`),
  KEY `parent_id` (`parent_id`),
  KEY `position` (`position`),
  KEY `visible` (`visible`),
  KEY `external_id` (`external_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_categories_features`;
CREATE TABLE `ok_categories_features` (
  `category_id` int(11) NOT NULL,
  `feature_id` int(11) NOT NULL,
  PRIMARY KEY (`category_id`,`feature_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_comments`;
CREATE TABLE `ok_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ip` varchar(20) NOT NULL DEFAULT '',
  `object_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `text` text NOT NULL,
  `type` enum('product','blog','news') NOT NULL DEFAULT 'product',
  `approved` int(1) NOT NULL DEFAULT '0',
  `lang_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `product_id` (`object_id`),
  KEY `type` (`type`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_coupons`;
CREATE TABLE `ok_coupons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(256) NOT NULL DEFAULT '',
  `expire` timestamp NULL DEFAULT NULL,
  `type` enum('absolute','percentage') NOT NULL DEFAULT 'absolute',
  `value` decimal(10,2) NOT NULL DEFAULT '0.00',
  `min_order_price` decimal(10,2) DEFAULT NULL,
  `single` tinyint(1) NOT NULL DEFAULT '0',
  `usages` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_currencies`;
CREATE TABLE `ok_currencies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `sign` varchar(20) NOT NULL DEFAULT '',
  `code` char(3) NOT NULL DEFAULT '',
  `rate_from` decimal(10,2) NOT NULL DEFAULT '1.00',
  `rate_to` decimal(10,2) NOT NULL DEFAULT '1.00',
  `cents` int(1) NOT NULL DEFAULT '2',
  `position` int(11) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `position` (`position`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `ok_currencies` (`id`, `name`, `sign`, `code`, `rate_from`, `rate_to`, `cents`, `position`, `enabled`) VALUES
(2,	'рубли',	'руб',	'RUR',	8.13,	8.13,	0,	1,	1),
(1,	'доллары',	'$',	'USD',	1.00,	60.00,	2,	2,	1),
(3,	'вебмани wmz',	'wmz',	'WMZ',	0.15,	8.13,	2,	3,	1),
(4,	'гривны',	'грн',	'UAH',	0.45,	1.00,	2,	4,	1);

DROP TABLE IF EXISTS `ok_delivery`;
CREATE TABLE `ok_delivery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `free_from` decimal(10,2) NOT NULL DEFAULT '0.00',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `position` int(11) NOT NULL DEFAULT '0',
  `separate_payment` tinyint(1) DEFAULT '0',
  `image` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `position` (`position`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_delivery_payment`;
CREATE TABLE `ok_delivery_payment` (
  `delivery_id` int(11) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  PRIMARY KEY (`delivery_id`,`payment_method_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Связка способом оплаты и способов доставки';


DROP TABLE IF EXISTS `ok_features`;
CREATE TABLE `ok_features` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `position` int(11) NOT NULL DEFAULT '0',
  `in_filter` tinyint(1) DEFAULT '0',
  `yandex` tinyint(1) NOT NULL DEFAULT '1',
  `auto_name_id` varchar(64) NOT NULL DEFAULT '',
  `auto_value_id` varchar(64) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `external_id` varchar(36) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `position` (`position`),
  KEY `in_filter` (`in_filter`),
  KEY `yandex` (`yandex`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_feedbacks`;
CREATE TABLE `ok_feedbacks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ip` varchar(20) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `processed` tinyint(1) NOT NULL DEFAULT '0',
  `lang_id` int(11) NOT NULL DEFAULT '0',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_groups`;
CREATE TABLE `ok_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `discount` decimal(5,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_images`;
CREATE TABLE `ok_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `product_id` int(11) NOT NULL DEFAULT '0',
  `filename` varchar(255) NOT NULL DEFAULT '',
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `filename` (`filename`),
  KEY `product_id` (`product_id`),
  KEY `position` (`position`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_import_log`;
CREATE TABLE `ok_import_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `status` varchar(8) NOT NULL DEFAULT '',
  `product_name` varchar(255) NOT NULL DEFAULT '',
  `variant_name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_labels`;
CREATE TABLE `ok_labels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `color` varchar(6) NOT NULL DEFAULT '',
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_languages`;
CREATE TABLE `ok_languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(10) NOT NULL,
  `href_lang` varchar(10) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `position` int(11) NOT NULL DEFAULT '0',
  `name_ru` varchar(255) NOT NULL DEFAULT '',
  `name_ua` varchar(255) NOT NULL DEFAULT '',
  `name_en` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `ok_languages` (`id`, `name`, `label`, `href_lang`, `enabled`, `position`, `name_ru`, `name_ua`, `name_en`) VALUES
(1,	'Русский',	'ru',	'ru',	1,	1,	'Русский',	'Російська',	'Russian'),
(2,	'Английский',	'en',	'en',	1,	2,	'Английский',	'Англійська',	'English'),
(3,	'Украинский',	'ua',	'uk',	0,	3,	'Украинский',	'Українська',	'Ukrainian');

DROP TABLE IF EXISTS `ok_lang_banners_images`;
CREATE TABLE `ok_lang_banners_images` (
  `lang_id` int(11) NOT NULL,
  `banner_image_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `alt` varchar(255) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`lang_id`,`banner_image_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_lang_blog`;
CREATE TABLE `ok_lang_blog` (
  `lang_id` int(11) NOT NULL,
  `blog_id` int(11) NOT NULL,
  `name` varchar(512) NOT NULL DEFAULT '',
  `meta_title` varchar(512) NOT NULL DEFAULT '',
  `meta_keywords` varchar(512) NOT NULL DEFAULT '',
  `meta_description` varchar(512) NOT NULL DEFAULT '',
  `annotation` text NOT NULL,
  `description` text NOT NULL,
  UNIQUE KEY `lang_id` (`lang_id`,`blog_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_lang_brands`;
CREATE TABLE `ok_lang_brands` (
  `lang_id` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `meta_title` varchar(512) NOT NULL DEFAULT '',
  `meta_keywords` varchar(512) NOT NULL DEFAULT '',
  `meta_description` varchar(512) NOT NULL DEFAULT '',
  `annotation` text NOT NULL,
  `description` text NOT NULL,
  UNIQUE KEY `lang_id` (`lang_id`,`brand_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_lang_categories`;
CREATE TABLE `ok_lang_categories` (
  `lang_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `name_h1` varchar(255) NOT NULL DEFAULT '',
  `meta_title` varchar(512) NOT NULL DEFAULT '',
  `meta_keywords` varchar(512) NOT NULL DEFAULT '',
  `meta_description` varchar(512) NOT NULL DEFAULT '',
  `annotation` text NOT NULL,
  `description` text NOT NULL,
  `auto_meta_title` varchar(512) NOT NULL DEFAULT '',
  `auto_meta_keywords` varchar(512) NOT NULL DEFAULT '',
  `auto_meta_desc` varchar(512) NOT NULL DEFAULT '',
  `auto_description` text NOT NULL,
  UNIQUE KEY `lang_id` (`lang_id`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_lang_currencies`;
CREATE TABLE `ok_lang_currencies` (
  `lang_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `sign` varchar(20) NOT NULL DEFAULT '',
  UNIQUE KEY `lang_id` (`lang_id`,`currency_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `ok_lang_currencies` (`lang_id`, `currency_id`, `name`, `sign`) VALUES
(1,	2,	'рубли',	'руб'),
(1,	1,	'доллары',	'$'),
(1,	3,	'вебмани wmz',	'wmz'),
(2,	2,	'rubles',	'rub'),
(2,	1,	'dollars',	'$'),
(2,	3,	'вебмани wmz en',	'wmz'),
(3,	2,	'рубли uk',	'руб'),
(3,	1,	'доллары uk',	'$'),
(3,	3,	'вебмани wmz uk',	'wmz'),
(1,	4,	'гривны',	'грн'),
(2,	4,	'гривны en',	'грн'),
(3,	4,	'гривны uk',	'грн');

DROP TABLE IF EXISTS `ok_lang_delivery`;
CREATE TABLE `ok_lang_delivery` (
  `lang_id` int(11) NOT NULL,
  `delivery_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  UNIQUE KEY `lang_id` (`lang_id`,`delivery_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_lang_features`;
CREATE TABLE `ok_lang_features` (
  `lang_id` int(11) NOT NULL,
  `feature_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `lang_id` (`lang_id`,`feature_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_lang_orders_labels`;
CREATE TABLE `ok_lang_orders_labels` (
  `lang_id` int(11) NOT NULL,
  `order_labels_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `lang_id` (`lang_id`,`order_labels_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_lang_orders_status`;
CREATE TABLE `ok_lang_orders_status` (
  `lang_id` int(11) NOT NULL,
  `order_status_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `lang_id` (`lang_id`,`order_status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `ok_lang_orders_status` (`lang_id`, `order_status_id`, `name`) VALUES
(1,	1,	'Новые'),
(2,	1,	'Новые'),
(3,	1,	'Новые'),
(1,	2,	'Приняты'),
(2,	2,	'Приняты'),
(3,	2,	'Приняты'),
(1,	3,	'У курьера'),
(2,	3,	'У курьера'),
(3,	3,	'У курьера'),
(1,	4,	'Выполнены'),
(2,	4,	'Выполнены'),
(3,	4,	'Выполнены'),
(1,	5,	'Удалены'),
(2,	5,	'Удалены'),
(3,	5,	'Удалены');

DROP TABLE IF EXISTS `ok_lang_pages`;
CREATE TABLE `ok_lang_pages` (
  `lang_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `meta_title` varchar(512) NOT NULL DEFAULT '',
  `meta_description` varchar(512) NOT NULL DEFAULT '',
  `meta_keywords` varchar(512) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  UNIQUE KEY `lang_id` (`lang_id`,`page_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_lang_payment_methods`;
CREATE TABLE `ok_lang_payment_methods` (
  `lang_id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  UNIQUE KEY `lang_id` (`lang_id`,`payment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_lang_products`;
CREATE TABLE `ok_lang_products` (
  `lang_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `name` varchar(512) NOT NULL DEFAULT '',
  `annotation` text NOT NULL,
  `description` text NOT NULL,
  `meta_title` varchar(512) NOT NULL DEFAULT '',
  `meta_keywords` varchar(512) NOT NULL DEFAULT '',
  `meta_description` varchar(512) NOT NULL DEFAULT '',
  `special` varchar(255) DEFAULT '',
  UNIQUE KEY `lang_id` (`lang_id`,`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_lang_variants`;
CREATE TABLE `ok_lang_variants` (
  `lang_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `units` varchar(32) NOT NULL DEFAULT '',
  UNIQUE KEY `lang_id` (`lang_id`,`variant_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_managers`;
CREATE TABLE `ok_managers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(2) NOT NULL DEFAULT 'ru',
  `login` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `permissions` varchar(1024) DEFAULT NULL,
  `cnt_try` tinyint(4) NOT NULL DEFAULT '0',
  `last_try` date DEFAULT NULL,
  `comment` varchar(512) DEFAULT '',
  `menu_status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `login` (`login`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `ok_managers` (`id`, `lang`, `login`, `password`, `permissions`, `cnt_try`, `last_try`, `comment`, `menu_status`) VALUES
(1,	'ru',	'admin',	'$apr1$8m1u0cp4$MYUZf5fVcidsoTaFb0P9P1',	NULL,	0,	NULL,	'',	1);

DROP TABLE IF EXISTS `ok_menu`;
CREATE TABLE `ok_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `ok_menu` (`id`, `name`, `position`) VALUES
(1,	'Основное меню',	1),
(2,	'Другие страницы',	2);

DROP TABLE IF EXISTS `ok_options`;
CREATE TABLE `ok_options` (
  `product_id` int(11) NOT NULL,
  `feature_id` int(11) NOT NULL,
  `lang_id` int(11) NOT NULL DEFAULT '0',
  `value` varchar(1024) NOT NULL DEFAULT '',
  `translit` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`lang_id`,`product_id`,`feature_id`),
  KEY `value` (`value`(333)),
  KEY `product_id` (`product_id`),
  KEY `feature_id` (`feature_id`),
  KEY `lang_id` (`lang_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_orders`;
CREATE TABLE `ok_orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `delivery_id` int(11) DEFAULT '0',
  `delivery_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `payment_method_id` int(11) DEFAULT '0',
  `paid` tinyint(1) NOT NULL DEFAULT '0',
  `payment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `date` datetime DEFAULT '0000-00-00 00:00:00',
  `user_id` int(11) DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `address` varchar(255) NOT NULL DEFAULT '',
  `phone` varchar(32) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `comment` varchar(1024) NOT NULL DEFAULT '',
  `status_id` int(11) NOT NULL DEFAULT '0',
  `url` varchar(255) DEFAULT '',
  `payment_details` text NOT NULL,
  `ip` varchar(20) NOT NULL DEFAULT '',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `note` varchar(1024) NOT NULL DEFAULT '',
  `discount` decimal(5,2) NOT NULL DEFAULT '0.00',
  `coupon_discount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `coupon_code` varchar(255) NOT NULL DEFAULT '',
  `separate_delivery` tinyint(1) NOT NULL DEFAULT '0',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lang_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `login` (`user_id`),
  KEY `written_off` (`closed`),
  KEY `date` (`date`),
  KEY `status` (`status_id`),
  KEY `code` (`url`),
  KEY `payment_status` (`paid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_orders_labels`;
CREATE TABLE `ok_orders_labels` (
  `order_id` int(11) NOT NULL,
  `label_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`,`label_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_orders_status`;
CREATE TABLE `ok_orders_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `is_close` tinyint(1) NOT NULL DEFAULT '0',
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `ok_orders_status` (`id`, `name`, `is_close`, `position`) VALUES
(1,	'Новые',	0,	1),
(2,	'Приняты',	1,	2),
(3,	'У курьера',	1,	3),
(4,	'Выполнены',	1,	4),
(5,	'Удалены',	0,	5);

DROP TABLE IF EXISTS `ok_pages`;
CREATE TABLE `ok_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `meta_title` varchar(512) NOT NULL DEFAULT '',
  `meta_description` varchar(512) NOT NULL DEFAULT '',
  `meta_keywords` varchar(512) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `menu_id` int(11) NOT NULL DEFAULT '0',
  `position` int(11) NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '0',
  `last_modify` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_num` (`position`),
  KEY `url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_payment_methods`;
CREATE TABLE `ok_payment_methods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `currency_id` int(11) NOT NULL DEFAULT '0',
  `settings` text NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `position` int(11) NOT NULL DEFAULT '0',
  `image` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `position` (`position`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_products`;
CREATE TABLE `ok_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL DEFAULT '',
  `brand_id` int(11) DEFAULT '0',
  `name` varchar(512) NOT NULL DEFAULT '',
  `annotation` text NOT NULL,
  `description` text NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `position` int(11) NOT NULL DEFAULT '0',
  `meta_title` varchar(512) NOT NULL DEFAULT '',
  `meta_keywords` varchar(512) NOT NULL DEFAULT '',
  `meta_description` varchar(512) NOT NULL DEFAULT '',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `featured` tinyint(1) DEFAULT '0',
  `external_id` varchar(36) NOT NULL DEFAULT '',
  `rating` float(3,1) DEFAULT '0.0',
  `votes` int(11) DEFAULT '0',
  `special` varchar(255) DEFAULT '',
  `last_modify` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `url` (`url`),
  KEY `brand_id` (`brand_id`),
  KEY `visible` (`visible`),
  KEY `position` (`position`),
  KEY `external_id` (`external_id`),
  KEY `hit` (`featured`),
  KEY `name` (`name`(333))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_products_categories`;
CREATE TABLE `ok_products_categories` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`,`category_id`),
  KEY `position` (`position`),
  KEY `product_id` (`product_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_purchases`;
CREATE TABLE `ok_purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL DEFAULT '0',
  `product_id` int(11) DEFAULT '0',
  `variant_id` int(11) DEFAULT '0',
  `product_name` varchar(255) NOT NULL DEFAULT '',
  `variant_name` varchar(255) NOT NULL DEFAULT '',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `amount` int(11) NOT NULL DEFAULT '0',
  `sku` varchar(255) NOT NULL DEFAULT '',
  `units` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  KEY `variant_id` (`variant_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_related_blogs`;
CREATE TABLE `ok_related_blogs` (
  `post_id` int(11) NOT NULL,
  `related_id` int(11) NOT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`post_id`,`related_id`),
  KEY `position` (`position`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_related_products`;
CREATE TABLE `ok_related_products` (
  `product_id` int(11) NOT NULL,
  `related_id` int(11) NOT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`,`related_id`),
  KEY `position` (`position`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_settings`;
CREATE TABLE `ok_settings` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`setting_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `ok_settings` (`setting_id`, `name`, `value`) VALUES
(53,	'date_format',	'd.m.Y'),
(57,	'decimals_point',	','),
(58,	'thousands_separator',	' '),
(30,	'theme',	'okay_shop'),
(33,	'products_num',	'24'),
(113,	'max_order_amount',	'50'),
(114,	'watermark_offset_x',	'50'),
(115,	'watermark_offset_y',	'50'),
(116,	'watermark_transparency',	'50'),
(117,	'images_sharpen',	'15'),
(120,	'comparison_count',	'5'),
(121,	'is_preorder',	'1'),
(132,	'posts_num',	'10'),
(134,	'captcha_product',	'1'),
(135,	'captcha_post',	'1'),
(136,	'captcha_cart',	'1'),
(137,	'captcha_register',	'1'),
(138,	'captcha_feedback',	'1'),
(139,	'site_work',	'on'),
(152,	'image_quality',	'50'),
(153,	'email_lang',	'ru'),
(154,	'site_logo',	'logo.png'),
(155,	'gather_enabled',	'1'),
(156,	'captcha_callback',	'1');

DROP TABLE IF EXISTS `ok_settings_lang`;
CREATE TABLE `ok_settings_lang` (
  `name` varchar(128) NOT NULL,
  `lang_id` int(11) NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  PRIMARY KEY (`lang_id`,`name`),
  KEY `name` (`name`),
  KEY `lang_id` (`lang_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_spec_img`;
CREATE TABLE `ok_spec_img` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(255) NOT NULL DEFAULT '',
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_subscribe_mailing`;
CREATE TABLE `ok_subscribe_mailing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_support_info`;
CREATE TABLE `ok_support_info` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `temp_key` varchar(32) DEFAULT NULL,
  `temp_time` timestamp NULL DEFAULT NULL,
  `new_messages` int(11) NOT NULL DEFAULT '0',
  `balance` int(11) NOT NULL DEFAULT '0',
  `private_key` varchar(2048) DEFAULT NULL,
  `public_key` varchar(2048) DEFAULT NULL,
  `okay_public_key` varchar(2048) DEFAULT NULL,
  `is_auto` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_users`;
CREATE TABLE `ok_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `phone` varchar(32) NOT NULL DEFAULT '',
  `address` varchar(255) NOT NULL DEFAULT '',
  `group_id` int(11) NOT NULL DEFAULT '0',
  `last_ip` varchar(20) DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `remind_code` varchar(32) DEFAULT NULL,
  `remind_expire` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ok_variants`;
CREATE TABLE `ok_variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `sku` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `weight` decimal(10,2) DEFAULT '0.00',
  `price` decimal(14,2) NOT NULL DEFAULT '0.00',
  `compare_price` decimal(14,2) DEFAULT NULL,
  `stock` mediumint(9) DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  `attachment` varchar(255) NOT NULL DEFAULT '',
  `external_id` varchar(36) NOT NULL DEFAULT '',
  `currency_id` int(11) NOT NULL DEFAULT '0',
  `feed` tinyint(1) DEFAULT '0',
  `units` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `sku` (`sku`),
  KEY `price` (`price`),
  KEY `stock` (`stock`),
  KEY `position` (`position`),
  KEY `external_id` (`external_id`),
  KEY `yandex` (`feed`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

