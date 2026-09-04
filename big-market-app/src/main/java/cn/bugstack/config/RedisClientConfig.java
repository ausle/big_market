package cn.bugstack.config;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.ByteBufAllocator;
import io.netty.buffer.ByteBufInputStream;
import io.netty.buffer.ByteBufOutputStream;
import org.redisson.Redisson;
import org.redisson.api.RedissonClient;
import org.redisson.client.codec.BaseCodec;
import org.redisson.client.protocol.Decoder;
import org.redisson.client.protocol.Encoder;
import org.redisson.codec.JsonJacksonCodec;
import org.redisson.config.Config;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.IOException;

/**
 * Redis 客户端，使用 Redisson <a href="https://github.com/redisson/redisson">Redisson</a>
 *
 * @author Fuzhengwei bugstack.cn @小傅哥
 */
@Configuration
@EnableConfigurationProperties(RedisClientConfigProperties.class)
public class RedisClientConfig {

    @Bean("redissonClient")
    public RedissonClient redissonClient(ConfigurableApplicationContext applicationContext, RedisClientConfigProperties properties) {
        Config config = new Config();
        // 根据需要可以设定编解码器；https://github.com/redisson/redisson/wiki/4.-%E6%95%B0%E6%8D%AE%E5%BA%8F%E5%88%97%E5%8C%96
        // 默认redis会把java对象序列化为二进制存进redis。默认是使用JDK的二进制序列化起。在redis工具中查看数据，就会是乱码。
        // 这里指定json序列化器，会把java对象序列化为json字符串存进redis中。
//        config.setCodec(new RedisCodec());  这种写法是有问题的。
        // 使用jackson做序列化和反序列化，序列化时，会把java对象序列化为json字符串存进redis中。
        // 反序列时，会把redis中的json字符串反序列化为java对象。
        config.setCodec(new JsonJacksonCodec());

        config.useSingleServer()
                .setAddress("redis://" + properties.getHost() + ":" + properties.getPort())
                .setConnectionPoolSize(properties.getPoolSize())
                .setConnectionMinimumIdleSize(properties.getMinIdleSize())
                .setIdleConnectionTimeout(properties.getIdleTimeout())
                .setConnectTimeout(properties.getConnectTimeout())
                .setRetryAttempts(properties.getRetryAttempts())
                .setRetryInterval(properties.getRetryInterval())
                .setPingConnectionInterval(properties.getPingInterval())
                .setKeepAlive(properties.isKeepAlive())
                .setPassword(properties.getPassword())
                .setDatabase(properties.getDatabase())
        ;

        return Redisson.create(config);
    }

    static class RedisCodec extends BaseCodec {

        private final Encoder encoder = in -> {
            ByteBuf out = ByteBufAllocator.DEFAULT.buffer();
            try {
                ByteBufOutputStream os = new ByteBufOutputStream(out);
                JSON.writeJSONString(os, in, SerializerFeature.WriteClassName);
                return os.buffer();
            } catch (IOException e) {
                out.release();
                throw e;
            } catch (Exception e) {
                out.release();
                throw new IOException(e);
            }
        };

        private final Decoder<Object> decoder = (buf, state) -> JSON.parseObject(new ByteBufInputStream(buf), Object.class);

        @Override
        public Decoder<Object> getValueDecoder() {
            return decoder;
        }

        @Override
        public Encoder getValueEncoder() {
            return encoder;
        }

    }

}
