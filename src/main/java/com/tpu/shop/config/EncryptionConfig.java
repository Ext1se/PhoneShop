package com.tpu.shop.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.MessageDigestPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class EncryptionConfig {
    @Bean
    public PasswordEncoder getPasswordEncoder(){
        return new MessageDigestPasswordEncoder("md5");
    }
}
