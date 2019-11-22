-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2019-11-22 09:04:40
-- 服务器版本： 5.7.28-0ubuntu0.18.04.4
-- PHP 版本： 7.2.24-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `seckill`
--

-- --------------------------------------------------------

--
-- 表的结构 `pre_order`
--

CREATE TABLE `pre_order` (
  `id` int(11) NOT NULL,
  `number` varchar(32) DEFAULT NULL COMMENT '订单号',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '下单人',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品id',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '购买数量',
  `product_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品总额',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '10' COMMENT '订单状态',
  `delivery_status` tinyint(3) UNSIGNED NOT NULL DEFAULT '10' COMMENT '运输状态',
  `payment_status` tinyint(3) UNSIGNED NOT NULL DEFAULT '10' COMMENT '支付状态',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单';

-- --------------------------------------------------------

--
-- 表的结构 `pre_product`
--

CREATE TABLE `pre_product` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL COMMENT '名称',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '数量',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '单价',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '10' COMMENT '状态',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品';

--
-- 转存表中的数据 `pre_product`
--

INSERT INTO `pre_product` (`id`, `name`, `quantity`, `price`, `status`, `created_at`, `updated_at`) VALUES
(1001, '饼干', 100, '2.89', 10, '2019-05-21 19:08:25', NULL),
(1002, '巧克力', 200, '2.90', 10, '2019-05-21 19:10:01', NULL);

--
-- 转储表的索引
--

--
-- 表的索引 `pre_order`
--
ALTER TABLE `pre_order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `number` (`number`);

--
-- 表的索引 `pre_product`
--
ALTER TABLE `pre_product`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `pre_order`
--
ALTER TABLE `pre_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `pre_product`
--
ALTER TABLE `pre_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1003;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
