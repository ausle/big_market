
-- 抽奖活动表
CREATE TABLE `raffle_activity` (
                                   `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
                                   `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
                                   `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
                                   `activity_desc` varchar(128) NOT NULL COMMENT '活动描述',
                                   `begin_date_time` datetime NOT NULL COMMENT '开始时间',
                                   `end_date_time` datetime NOT NULL COMMENT '结束时间',
                                   `strategy_id` bigint(8) NOT NULL COMMENT '抽奖策略ID',
                                   `state` varchar(8) NOT NULL DEFAULT 'create' COMMENT '活动状态',
                                   `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                   `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                   PRIMARY KEY (`id`),
                                   UNIQUE KEY `uq_activity_id` (`activity_id`),
                                   KEY `idx_begin_date_time` (`begin_date_time`),
                                   KEY `idx_end_date_time` (`end_date_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动表';

INSERT INTO `raffle_activity` (`id`, `activity_id`, `activity_name`, `activity_desc`, `begin_date_time`, `end_date_time`, `strategy_id`, `state`, `create_time`, `update_time`)
VALUES (1,100301,'测试活动','测试活动','2024-03-09 10:15:10','2034-03-09 10:15:10',100006,'create','2024-03-09 10:15:10','2024-03-16 11:17:13');

-- 抽奖活动次数配置表
CREATE TABLE `raffle_activity_count` (
                                         `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
                                         `activity_count_id` bigint(12) NOT NULL COMMENT '活动次数编号',
                                         `total_count` int(8) NOT NULL COMMENT '总次数',
                                         `day_count` int(8) NOT NULL COMMENT '日次数',
                                         `month_count` int(8) NOT NULL COMMENT '月次数',
                                         `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                         `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                         PRIMARY KEY (`id`),
                                         UNIQUE KEY `uq_activity_count_id` (`activity_count_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动次数配置表';


INSERT INTO `raffle_activity_count` (`id`, `activity_count_id`, `total_count`, `day_count`, `month_count`, `create_time`, `update_time`)
VALUES
    (1,11101,1,1,1,'2024-03-09 10:15:42','2024-03-16 12:30:54');


-- 商品SKU表
CREATE TABLE `raffle_activity_sku` (
                                       `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
                                       `sku` bigint(12) NOT NULL COMMENT '商品sku - 把每一个组合当做一个商品',
                                       `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
                                       `activity_count_id` bigint(12) NOT NULL COMMENT '活动个人参与次数ID',
                                       `stock_count` int(11) NOT NULL COMMENT '商品库存',
                                       `stock_count_surplus` int(11) NOT NULL COMMENT '剩余库存',
                                       `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                       `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                       PRIMARY KEY (`id`),
                                       UNIQUE KEY `uq_sku` (`sku`),
                                       KEY `idx_activity_id_activity_count_id` (`activity_id`,`activity_count_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `raffle_activity_sku` (`id`, `sku`, `activity_id`, `activity_count_id`, `stock_count`, `stock_count_surplus`, `create_time`, `update_time`)
VALUES
    (1,9011,100301,11101,0,0,'2024-03-16 11:41:09','2024-03-16 11:59:21');








CREATE database if NOT EXISTS `big_market_01` default character set utf8mb4;
use `big_market_01`;

# 转储表 raffle_activity_account
# ------------------------------------------------------------

DROP TABLE IF EXISTS `raffle_activity_account`;

CREATE TABLE `raffle_activity_account` (
                                           `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
                                           `user_id` varchar(32) NOT NULL COMMENT '用户ID',
                                           `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
                                           `total_count` int(8) NOT NULL COMMENT '总次数',
                                           `total_count_surplus` int(8) NOT NULL COMMENT '总次数-剩余',
                                           `day_count` int(8) NOT NULL COMMENT '日次数',
                                           `day_count_surplus` int(8) NOT NULL COMMENT '日次数-剩余',
                                           `month_count` int(8) NOT NULL COMMENT '月次数',
                                           `month_count_surplus` int(8) NOT NULL COMMENT '月次数-剩余',
                                           `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                           `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                           PRIMARY KEY (`id`),
                                           UNIQUE KEY `uq_user_id_activity_id` (`user_id`,`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动账户表';



# 转储表 raffle_activity_order_000
# ------------------------------------------------------------

DROP TABLE IF EXISTS `raffle_activity_order_000`;

CREATE TABLE `raffle_activity_order_000` (
                                             `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
                                             `user_id` varchar(32) NOT NULL COMMENT '用户ID',
                                             `sku` bigint(12) NOT NULL COMMENT '商品sku',
                                             `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
                                             `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
                                             `strategy_id` bigint(8) NOT NULL COMMENT '抽奖策略ID',
                                             `order_id` varchar(12) NOT NULL COMMENT '订单ID',
                                             `order_time` datetime NOT NULL COMMENT '下单时间',
                                             `total_count` int(8) NOT NULL COMMENT '总次数',
                                             `day_count` int(8) NOT NULL COMMENT '日次数',
                                             `month_count` int(8) NOT NULL COMMENT '月次数',
                                             `state` varchar(8) NOT NULL DEFAULT 'complete' COMMENT '订单状态（complete）',
                                             `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                             `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                             PRIMARY KEY (`id`),
                                             UNIQUE KEY `uq_order_id` (`order_id`),
                                             KEY `idx_user_id_activity_id` (`user_id`,`activity_id`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动单';

LOCK TABLES `raffle_activity_order_000` WRITE;
/*!40000 ALTER TABLE `raffle_activity_order_000` DISABLE KEYS */;

INSERT INTO `raffle_activity_order_000` (`id`, `user_id`, `sku`, `activity_id`, `activity_name`, `strategy_id`, `order_id`, `order_time`, `total_count`, `day_count`, `month_count`, `state`, `create_time`, `update_time`)
VALUES
    (1,'ODRhfGEfX',0,100301,'测试活动',100006,'826130522615','2024-03-09 06:26:20',0,0,0,'not_used','2024-03-09 14:26:19','2024-03-09 14:26:19'),
    (2,'IoTtOmcBeivNUYv',0,100301,'测试活动',100006,'469450480489','2024-03-09 06:26:20',0,0,0,'not_used','2024-03-09 14:26:20','2024-03-09 14:26:20');

/*!40000 ALTER TABLE `raffle_activity_order_000` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 raffle_activity_order_001
# ------------------------------------------------------------

DROP TABLE IF EXISTS `raffle_activity_order_001`;

CREATE TABLE `raffle_activity_order_001` (
                                             `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
                                             `user_id` varchar(32) NOT NULL COMMENT '用户ID',
                                             `sku` bigint(12) NOT NULL COMMENT '商品sku',
                                             `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
                                             `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
                                             `strategy_id` bigint(8) NOT NULL COMMENT '抽奖策略ID',
                                             `order_id` varchar(12) NOT NULL COMMENT '订单ID',
                                             `order_time` datetime NOT NULL COMMENT '下单时间',
                                             `total_count` int(8) NOT NULL COMMENT '总次数',
                                             `day_count` int(8) NOT NULL COMMENT '日次数',
                                             `month_count` int(8) NOT NULL COMMENT '月次数',
                                             `state` varchar(8) NOT NULL DEFAULT 'complete' COMMENT '订单状态（complete）',
                                             `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                             `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                             PRIMARY KEY (`id`),
                                             UNIQUE KEY `uq_order_id` (`order_id`),
                                             KEY `idx_user_id_activity_id` (`user_id`,`activity_id`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动单';



# 转储表 raffle_activity_order_002
# ------------------------------------------------------------

DROP TABLE IF EXISTS `raffle_activity_order_002`;

CREATE TABLE `raffle_activity_order_002` (
                                             `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
                                             `user_id` varchar(32) NOT NULL COMMENT '用户ID',
                                             `sku` bigint(12) NOT NULL COMMENT '商品sku',
                                             `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
                                             `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
                                             `strategy_id` bigint(8) NOT NULL COMMENT '抽奖策略ID',
                                             `order_id` varchar(12) NOT NULL COMMENT '订单ID',
                                             `order_time` datetime NOT NULL COMMENT '下单时间',
                                             `total_count` int(8) NOT NULL COMMENT '总次数',
                                             `day_count` int(8) NOT NULL COMMENT '日次数',
                                             `month_count` int(8) NOT NULL COMMENT '月次数',
                                             `state` varchar(8) NOT NULL DEFAULT 'complete' COMMENT '订单状态（complete）',
                                             `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                             `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                             PRIMARY KEY (`id`),
                                             UNIQUE KEY `uq_order_id` (`order_id`),
                                             KEY `idx_user_id_activity_id` (`user_id`,`activity_id`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动单';



# 转储表 raffle_activity_order_003
# ------------------------------------------------------------

DROP TABLE IF EXISTS `raffle_activity_order_003`;

CREATE TABLE `raffle_activity_order_003` (
                                             `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
                                             `user_id` varchar(32) NOT NULL COMMENT '用户ID',
                                             `sku` bigint(12) NOT NULL COMMENT '商品sku',
                                             `activity_id` bigint(12) NOT NULL COMMENT '活动ID',
                                             `activity_name` varchar(64) NOT NULL COMMENT '活动名称',
                                             `strategy_id` bigint(8) NOT NULL COMMENT '抽奖策略ID',
                                             `order_id` varchar(12) NOT NULL COMMENT '订单ID',
                                             `order_time` datetime NOT NULL COMMENT '下单时间',
                                             `total_count` int(8) NOT NULL COMMENT '总次数',
                                             `day_count` int(8) NOT NULL COMMENT '日次数',
                                             `month_count` int(8) NOT NULL COMMENT '月次数',
                                             `state` varchar(8) NOT NULL DEFAULT 'complete' COMMENT '订单状态（complete）',
                                             `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                             `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
                                             PRIMARY KEY (`id`),
                                             UNIQUE KEY `uq_order_id` (`order_id`),
                                             KEY `idx_user_id_activity_id` (`user_id`,`activity_id`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖活动单';

