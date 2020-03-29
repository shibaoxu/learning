package com.shibaoxu.amqp.controller;

import com.shibaoxu.amqp.service.Person;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AmqpSender {

    private final AmqpTemplate amqpTemplate;

    @PostMapping("/sender")
    public void SendMessage(@RequestParam("message") String message,
                            @RequestParam(value = "exchange", defaultValue = "") String exchange,
                            @RequestParam("routeKey") String routeKey) {
        amqpTemplate.convertAndSend(exchange, routeKey, message);
    }

    @PostMapping("/sendPerson")
    public void SendPerson(){
        Person person = new Person("shibaoxu", 30);
        amqpTemplate.convertAndSend("spring_queue", person);
    }

    public AmqpSender(AmqpTemplate amqpTemplate) {
        this.amqpTemplate = amqpTemplate;
    }
}
