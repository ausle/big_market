
-- 抽奖策略表
CREATE TABLE `strategy` (
    `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
    `strategy_id` int NOT NULL COMMENT '抽奖策略ID',
    `strategy_desc` varchar(128) NOT NULL COMMENT '抽奖策略描述',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖策略表';

-- 抽奖策略奖品表
CREATE TABLE `strategy_award` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `strategy_id` int NOT NULL COMMENT '抽奖策略ID',
  `award_id` int NOT NULL COMMENT '抽奖奖品ID',
  `award_title` varchar(128) NOT NULL COMMENT '抽奖奖品标题',
  `award_subtitle` varchar(128) DEFAULT NULL COMMENT '抽奖奖品副标题',
  `award_count` int NOT NULL COMMENT '奖品库存总量',
  `award_count_surplus` int NOT NULL COMMENT '奖品库存剩余',
  `award_rate` decimal(6,4) NOT NULL COMMENT '奖品中奖概率',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖策略奖品表';

CREATE TABLE `strategy_rule` (
     `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
     `strategy_id` int NOT NULL COMMENT '抽奖策略ID',
     `award_id` int NOT NULL COMMENT '抽奖奖品ID',
     `rule_type` int NOT NULL DEFAULT '0' COMMENT '抽奖规则类型【1-策略规则、2-奖品规则】',
     `rule_model` varchar(16) NOT NULL COMMENT '抽奖规则类型【rule_lock】',
     `rule_value` varchar(128) NOT NULL COMMENT '抽奖规则比值',
     `rule_desc` varchar(128) NOT NULL COMMENT '抽奖规则描述',
     `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
     `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
     PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='抽奖策略规则表';


INSERT INTO `strategy_award`
(
    `strategy_id`,
    `award_id`,
    `award_title`,
    `award_subtitle`,
    `award_count`,
    `award_count_surplus`,
    `award_rate`,
    `sort`,
    `create_time`,
    `update_time`
)
VALUES
(10001, 101, '随机积分', NULL, 80000, 80000, 80.0000, 1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
(10001, 102, '5次使用', NULL, 10000, 10000, 10.0000, 2, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
(10001, 103, '10次使用', NULL, 5000, 5000, 5.0000, 3, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
(10001, 104, '20次使用', NULL, 4000, 4000, 4.0000, 4, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
(10001, 105, '增加 gpt-4对话模型', NULL, 600, 600, 0.6000, 5, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
(10001, 106, '增加 dall-e-2 画图模型', NULL, 200, 200, 0.2000, 6, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
(10001, 107, '增加 dall-e-3 画图模型', NULL, 199, 199, 0.1999, 6, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()),
(10001, 108, '解锁全部模型', NULL, 1, 1, 0.0001, 6, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());