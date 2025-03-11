package com.java;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
public class StreamingTestApplication {

	public static void main(String[] args) {
		SpringApplication.run(StreamingTestApplication.class, args);
	}

}
