package com.shibaoxu.amqp.service;

import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Service;

@Service
public class MessageHandler {
    @RabbitListener(queues = "spring_queue")
    public void listen(Person person) {
        System.out.println(person);
    }
}
