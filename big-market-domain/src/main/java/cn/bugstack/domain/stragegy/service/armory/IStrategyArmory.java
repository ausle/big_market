package cn.bugstack.domain.stragegy.service.armory;

/**
 * @author Fuzhengwei bugstack.cn @小傅哥
 * @description 策略装配库(兵工厂)，负责初始化策略计算
 * @create 2023-12-23 09:44
 */
public interface IStrategyArmory {

    /**
     * 触发的时机：活动审核通过后进行调用
     * 装配抽奖策略，根据策略ID
     *
     * @param strategyId 策略ID
     * @return 装配结果
     */
    boolean assembleLotteryStrategy(Long strategyId);

    /**
     * 触发的时机：活动审核通过后进行调用
     * 装配抽奖策略，根据活动ID
     * @param activityId 活动ID
     * @return 装配结果
     */
    boolean assembleLotteryStrategyByActivityId(Long activityId);

    /**
     * 获取抽奖策略装配的随机结果
     *
     * @param strategyId 策略ID
     * @return 抽奖结果
     */
    Integer getRandomAwardId(Long strategyId);




}
