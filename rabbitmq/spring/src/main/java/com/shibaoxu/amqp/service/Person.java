package com.shibaoxu.amqp.service;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class Person implements Serializable {
    private static final long serialVersionUID = -6470475801016433468L;
    private String name;
    private int age;
    public Person(String name, int age){
        this.name = name;
        this.age = age;
    }

    @Override
    public String toString() {
        return String.format("name='%s', age='%d", name, age);
    }
}
