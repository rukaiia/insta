package com.example.instagramlab.repository;


import com.example.instagramlab.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByEmail(String userEmail);

    Optional<User> findByResetPasswordToken(String resetPasswordToken);


    User findUserById(Long aLong);
    User findUserByEmail(String email);
}
