package com.java.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
	    registry.addEndpoint("/ws")
	            .setAllowedOriginPatterns("*")  // "*" 대신 allowedOriginPatterns 사용
	            .withSockJS();
	}

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        // 클라이언트가 구독할 수 있는 간단한 메시지 브로커를 활성화합니다.
        registry.enableSimpleBroker("/topic");
        // 클라이언트가 메시지를 보낼 때 사용할 프리픽스를 지정합니다.
        registry.setApplicationDestinationPrefixes("/app");
    }
}