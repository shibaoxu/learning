package com.shibaoxu.amqp;

import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.connection.ConnectionNameStrategy;
import org.springframework.amqp.rabbit.connection.SimplePropertyValueConnectionNameStrategy;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {
    @Bean
    public Queue SpringQueue(){
        return new Queue("spring_queue");
    }

    @Bean
    public ConnectionNameStrategy cns(){
        return new SimplePropertyValueConnectionNameStrategy("spring.application.name");
    }
}
