package com.example.instagramlab.config;

import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }


    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED))
                .httpBasic(Customizer.withDefaults())
                .formLogin(form ->
                        form.loginPage("/auth/login")
                                .loginProcessingUrl("/auth/login")
                                .defaultSuccessUrl("/posts")
                                .failureUrl("/auth/login?error=true")
                                .permitAll())
                .logout(logout -> logout
                        .logoutRequestMatcher(new AntPathRequestMatcher("/logout")).permitAll())
                .authorizeHttpRequests(authorizeRequests -> authorizeRequests
                        .requestMatchers("/posts/mypost").permitAll()
                        .requestMatchers("/auth/register").permitAll()
                        .requestMatchers("/comment","/posts/delete").permitAll()
                        .requestMatchers("/posts/delete", "/profile","/posts/delete","/posts/create", "/comment", "/posts/like").authenticated()
                        .anyRequest().permitAll()
                );

        return http.build();
    }


    @Bean
    public ModelMapper modelMapper() {
        return new ModelMapper();
    }


}
