package cn.bugstack.test.domain.straegy;

import cn.bugstack.domain.stragegy.model.entity.RaffleAwardEntity;
import cn.bugstack.domain.stragegy.model.entity.RaffleFactorEntity;
import cn.bugstack.domain.stragegy.service.IRaffleStrategy;
import cn.bugstack.domain.stragegy.service.armory.IStrategyArmory;
import cn.bugstack.domain.stragegy.service.rule.ILogicChain;
import cn.bugstack.domain.stragegy.service.rule.chain.factory.DefaultChainFactory;
import cn.bugstack.domain.stragegy.service.rule.chain.impl.RuleWeightLogicChain;
import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.util.ReflectionTestUtils;

import javax.annotation.Resource;

/**
 * @author Fuzhengwei bugstack.cn @小傅哥
 * @description 抽奖责任链测试，验证不同的规则走不同的责任链
 * @create 2024-01-20 11:20
 */
@Slf4j
@RunWith(SpringRunner.class)
@SpringBootTest
public class LogicChainTest {

    @Resource
    private IStrategyArmory strategyArmory;
    @Resource
    private RuleWeightLogicChain ruleWeightLogicChain;
    @Resource
    private DefaultChainFactory defaultChainFactory;

    @Resource
    private IRaffleStrategy raffleStrategy;


    @Before
    public void setUp() {
        log.info("测试结果：{}", strategyArmory.assembleLotteryStrategy(10001L));
    }


    // 测试抽奖
    @Test
    public void test_performRaffle() {
        RaffleFactorEntity raffleFactorEntity = RaffleFactorEntity.builder()
                .userId("xiaofuge")
                .strategyId(10001L)
                .build();
        RaffleAwardEntity raffleAwardEntity = raffleStrategy.performRaffle(raffleFactorEntity);

        log.info("请求参数：{}", JSON.toJSONString(raffleFactorEntity));
        log.info("测试结果：{}", JSON.toJSONString(raffleAwardEntity));
    }

    @Test
    public void test_LogicChain_rule_blacklist() {
        ILogicChain logicChain = defaultChainFactory.openLogicChain(10001L);
        logicChain.logic("user001", 10001L);
    }

    @Test
    public void test_LogicChain_rule_weight() {
        // 通过反射 mock 规则中的值
        ReflectionTestUtils.setField(ruleWeightLogicChain, "userScore", 4900L);

        ILogicChain logicChain = defaultChainFactory.openLogicChain(100001L);
        logicChain.logic("xiaofuge", 100001L);
    }

    @Test
    public void test_LogicChain_rule_default() {
        ILogicChain logicChain = defaultChainFactory.openLogicChain(100001L);
       logicChain.logic("xiaofuge", 100001L);
    }

}
