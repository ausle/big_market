CREATE TABLE IF NOT EXISTS `rule_tree` (
                                           `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
                                           `tree_id` varchar(32) NOT NULL COMMENT '规则树ID',
    `tree_name` varchar(64) NOT NULL COMMENT '规则树名称',
    `tree_desc` varchar(128) DEFAULT NULL COMMENT '规则树描述',
    `tree_node_rule_key` varchar(32) NOT NULL COMMENT '规则树根入口规则节点',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_tree_id` (`tree_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='规则树表';


CREATE TABLE IF NOT EXISTS `rule_tree_node` (
                                                `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
                                                `tree_id` varchar(32) NOT NULL COMMENT '规则树ID',
    `rule_key` varchar(32) NOT NULL COMMENT '规则Key',
    `rule_desc` varchar(128) DEFAULT NULL COMMENT '规则描述',
    `rule_value` varchar(128) DEFAULT NULL COMMENT '规则值',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_tree_id` (`tree_id`),
    KEY `idx_rule_key` (`rule_key`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='规则树节点表';



CREATE TABLE IF NOT EXISTS `rule_tree_node_line` (
                                                     `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
                                                     `tree_id` varchar(32) NOT NULL COMMENT '规则树ID',
    `rule_node_from` varchar(32) NOT NULL COMMENT '规则节点From',
    `rule_node_to` varchar(32) NOT NULL COMMENT '规则节点To',
    `rule_limit_type` varchar(32) NOT NULL COMMENT '限定类型',
    `rule_limit_value` varchar(32) NOT NULL COMMENT '限定值',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_tree_id` (`tree_id`),
    KEY `idx_rule_node_from` (`rule_node_from`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='规则树节点连线表';


INSERT INTO `rule_tree`
(`id`, `tree_id`, `tree_name`, `tree_desc`, `tree_node_rule_key`, `create_time`, `update_time`)
VALUES
    (1, 'tree_lock', '规则树', '规则树', 'rule_lock', NOW(), NOW());

INSERT INTO `rule_tree_node`
(`id`, `tree_id`, `rule_key`, `rule_desc`, `rule_value`, `create_time`, `update_time`)
VALUES
    (1, 'tree_lock', 'rule_lock', '限定用户已完成N次抽奖后解锁', '1', NOW(), NOW()),
    (2, 'tree_lock', 'rule_luck_award', '兜底奖品随机积分', '1,100', NOW(), NOW()),
    (3, 'tree_lock', 'rule_stock', '库存扣减规则', NULL, NOW(), NOW());

INSERT INTO `rule_tree_node_line`
(`id`, `tree_id`, `rule_node_from`, `rule_node_to`, `rule_limit_type`, `rule_limit_value`, `create_time`, `update_time`)
VALUES
    (1, 'tree_lock', 'rule_lock', 'rule_stock', 'EQUAL', 'ALLOW', NOW(), NOW()),
    (2, 'tree_lock', 'rule_lock', 'rule_luck_award', 'EQUAL', 'TAKE_OVER', NOW(), NOW()),
    (3, 'tree_lock', 'rule_stock', 'rule_luck_award', 'EQUAL', 'TAKE_OVER', NOW(), NOW());