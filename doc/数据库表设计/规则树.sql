DROP TABLE IF EXISTS `rule_tree`;

CREATE TABLE `rule_tree` (
                             `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
                             `tree_id` varchar(32) NOT NULL COMMENT '规则树ID',
                             `tree_name` varchar(64) NOT NULL COMMENT '规则树名称',
                             `tree_desc` varchar(128) DEFAULT NULL COMMENT '规则树描述',
                             `tree_node_rule_key` varchar(32) NOT NULL COMMENT '规则树根入口规则',
                             `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                             `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                             PRIMARY KEY (`id`),
                             UNIQUE KEY `uq_tree_id` (`tree_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='规则表-树';

INSERT INTO `rule_tree` (`id`, `tree_id`, `tree_name`, `tree_desc`, `tree_node_rule_key`, `create_time`, `update_time`)
VALUES
    (1,'tree_lock_1','规则树','规则树','rule_lock','2024-01-27 10:01:59','2024-02-15 07:49:59'),
    (2,'tree_luck_award','规则树-兜底奖励','规则树-兜底奖励','rule_stock','2024-02-15 07:35:06','2024-02-15 07:50:20'),
    (3,'tree_lock_2','规则树','规则树','rule_lock','2024-01-27 10:01:59','2024-02-15 07:49:59');

DROP TABLE IF EXISTS `rule_tree_node`;

CREATE TABLE `rule_tree_node` (
                                  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
                                  `tree_id` varchar(32) NOT NULL COMMENT '规则树ID',
                                  `rule_key` varchar(32) NOT NULL COMMENT '规则Key',
                                  `rule_desc` varchar(64) NOT NULL COMMENT '规则描述',
                                  `rule_value` varchar(128) DEFAULT NULL COMMENT '规则比值',
                                  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='规则表-树节点';


INSERT INTO `rule_tree_node` (`id`, `tree_id`, `rule_key`, `rule_desc`, `rule_value`, `create_time`, `update_time`)
VALUES
    (1,'tree_lock_1','rule_lock','限定用户已完成N次抽奖后解锁','1','2024-01-27 10:03:09','2024-02-15 07:50:57'),
    (2,'tree_lock_1','rule_luck_award','兜底奖品随机积分','101:1,100','2024-01-27 10:03:09','2024-02-15 07:51:00'),
    (3,'tree_lock_1','rule_stock','库存扣减规则',NULL,'2024-01-27 10:04:43','2024-02-15 07:51:02'),
    (4,'tree_luck_award','rule_stock','库存扣减规则',NULL,'2024-02-15 07:35:55','2024-02-15 07:39:19'),
    (5,'tree_luck_award','rule_luck_award','兜底奖品随机积分','101:1,100','2024-02-15 07:35:55','2024-02-15 07:39:23'),
    (6,'tree_lock_2','rule_lock','限定用户已完成N次抽奖后解锁','2','2024-01-27 10:03:09','2024-02-15 07:52:20'),
    (7,'tree_lock_2','rule_luck_award','兜底奖品随机积分','101:1,100','2024-01-27 10:03:09','2024-02-08 19:59:43'),
    (8,'tree_lock_2','rule_stock','库存扣减规则',NULL,'2024-01-27 10:04:43','2024-02-03 10:40:21');



DROP TABLE IF EXISTS `rule_tree_node_line`;

CREATE TABLE `rule_tree_node_line` (
                                       `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
                                       `tree_id` varchar(32) NOT NULL COMMENT '规则树ID',
                                       `rule_node_from` varchar(32) NOT NULL COMMENT '规则Key节点 From',
                                       `rule_node_to` varchar(32) NOT NULL COMMENT '规则Key节点 To',
                                       `rule_limit_type` varchar(8) NOT NULL COMMENT '限定类型；1:=;2:>;3:<;4:>=;5<=;6:enum[枚举范围];',
                                       `rule_limit_value` varchar(32) NOT NULL COMMENT '限定值（到下个节点）',
                                       `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                       `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                       PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='规则表-树节点连线';


INSERT INTO `rule_tree_node_line` (`id`, `tree_id`, `rule_node_from`, `rule_node_to`, `rule_limit_type`, `rule_limit_value`, `create_time`, `update_time`)
VALUES
    (1,'tree_lock_1','rule_lock','rule_stock','EQUAL','ALLOW','0000-00-00 00:00:00','2024-02-15 07:55:08'),
    (2,'tree_lock_1','rule_lock','rule_luck_award','EQUAL','TAKE_OVER','0000-00-00 00:00:00','2024-02-15 07:55:11'),
    (3,'tree_lock_1','rule_stock','rule_luck_award','EQUAL','ALLOW','0000-00-00 00:00:00','2024-02-15 07:55:13'),
    (4,'tree_luck_award','rule_stock','rule_luck_award','EQUAL','ALLOW','2024-02-15 07:37:31','2024-02-15 07:39:28'),
    (5,'tree_lock_2','rule_lock','rule_stock','EQUAL','ALLOW','0000-00-00 00:00:00','2024-02-15 07:55:08'),
    (6,'tree_lock_2','rule_lock','rule_luck_award','EQUAL','TAKE_OVER','0000-00-00 00:00:00','2024-02-15 07:55:11'),
    (7,'tree_lock_2','rule_stock','rule_luck_award','EQUAL','ALLOW','0000-00-00 00:00:00','2024-02-15 07:55:13');


