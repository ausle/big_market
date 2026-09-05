package cn.bugstack.domain.stragegy.service.rule.tree.factory;
import cn.bugstack.domain.stragegy.model.vo.RuleLogicCheckTypeVO;
import cn.bugstack.domain.stragegy.model.vo.RuleTreeVO;
import cn.bugstack.domain.stragegy.service.rule.tree.ILogicTreeNode;
import cn.bugstack.domain.stragegy.service.rule.tree.factory.engine.IDecisionTreeEngine;
import cn.bugstack.domain.stragegy.service.rule.tree.factory.engine.impl.DecisionTreeEngine;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author Fuzhengwei bugstack.cn @小傅哥
 * @description 规则树工厂
 * @create 2024-01-27 11:28
 */
@Service
public class DefaultTreeFactory {

    private final Map<String, ILogicTreeNode> logicTreeNodeGroup;

    // Spring 会自动走这个构造方法，把所有实现了 ILogicTreeNode 接口的 Bean 收集成一个 Map 注入进来。
    public DefaultTreeFactory(Map<String, ILogicTreeNode> logicTreeNodeGroup) {
        this.logicTreeNodeGroup = logicTreeNodeGroup;
    }

    public IDecisionTreeEngine openLogicTree(RuleTreeVO ruleTreeVO) {
        return new DecisionTreeEngine(logicTreeNodeGroup, ruleTreeVO);
    }

    /**
     * 决策树个动作实习
     */
    @Data
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class TreeActionEntity {
        private RuleLogicCheckTypeVO ruleLogicCheckType;
        private StrategyAwardVO strategyAwardVO;
    }

    @Data
    @Builder
    @AllArgsConstructor
    @NoArgsConstructor
    public static class StrategyAwardVO {
        /** 抽奖奖品ID - 内部流转使用 */
        private Integer awardId;
        /** 抽奖奖品规则 */
        private String awardRuleValue;
    }

}
