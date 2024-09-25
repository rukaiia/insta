package com.example.instagramlab.service;

import com.example.instagramlab.common.Utilities;
import com.example.instagramlab.dto.PostDto;
import com.example.instagramlab.dto.UserDto;
import com.example.instagramlab.model.Post;
import com.example.instagramlab.model.Role;
import com.example.instagramlab.model.User;
import com.example.instagramlab.repository.RoleRepository;
import com.example.instagramlab.repository.UserRepository;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jdk.jshell.spi.ExecutionControl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder encoder;
    private final RoleRepository roleRepository;
    private final EmailService emailService;


    public boolean checkIfUserExists(String email) {
        return userRepository.findByEmail(email).isPresent();
    }

    public void createUser(UserDto userDto) {
        log.info("Creating user in processing...");
        Role role = roleRepository.findById(1L)
                .orElseThrow(() -> new NoSuchElementException("Role not found"));
        User user = User.builder()
                .email(userDto.getEmail())
                .password(encoder.encode(userDto.getPassword()))
                .role(role)
                .enabled(true)
                .build();
        userRepository.save(user);
    }

    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("Пользователь с email " + email + " не найден"));
    }

    private User getUserByToken(String token) {
        return userRepository.findByResetPasswordToken(token)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
    }


    private void updatePassword(User user, String password) {
        String encodedPassword = encoder.encode(password);
        user.setPassword(encodedPassword);
        user.setResetPasswordToken(null);
        userRepository.save(user);
    }

    private void updateToken(String token, String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("Could not find any user with email: " + email));
        user.setResetPasswordToken(token);
        userRepository.save(user);
    }

    private void makeResetPasswordLink(HttpServletRequest request) throws MessagingException, UnsupportedEncodingException {
        String email = request.getParameter("email");
        String token = UUID.randomUUID().toString();
        updateToken(token, email);
        String resetPasswordLink = Utilities.getSiteUrl(request) + "/auth/reset_password?token=" + token;
        emailService.sendMail(email, resetPasswordLink);

    }

    public Map<String, Object> postResetPassword(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<>();
        String token = request.getParameter("token");
        String password = request.getParameter("password");

        if (token == null || token.isEmpty()) {
            model.put("error", "Invalid token");
            return model;
        }

        if (password == null || password.isEmpty()) {
            model.put("error", "Пароль не может быть пустым.");
            model.put("token", token);
            return model;
        }
        if (password.length() < 8 || password.length() > 20) {
            model.put("error", "Пароль должен быть длиной от 8 до 20 символов.");
            model.put("token", token);
            return model;
        }
        if (!password.matches(".*[A-Z].*")) {
            model.put("error", "Пароль должен содержать хотя бы одну заглавную букву.");
            model.put("token", token);
            return model;
        }
        if (!password.matches(".*[a-z].*")) {
            model.put("error", "Пароль должен содержать хотя бы одну строчную букву.");
            model.put("token", token);
            return model;
        }
        if (!password.matches(".*[!@#$%^&*(),.?\":{}|<>].*")) {
            model.put("error", "Пароль должен содержать хотя бы один специальный символ.");
            model.put("token", token);
            return model;
        }
        try {
            User user = getUserByToken(token);
            updatePassword(user, password);
            model.put("message", "You have successfully changed your password.");
        } catch (UsernameNotFoundException e) {
            model.put("error", "Invalid token");
        }
        return model;
    }


    public Map<String, Object> getResetPassword(String token) {
        Map<String, Object> model = new HashMap<>();
        try {
            getUserByToken(token);
            model.put("token", token);
        } catch (UsernameNotFoundException e) {
            model.put("error", "Invalid token");
        }
        return model;
    }

    public Map<String, Object> forgotPassword(HttpServletRequest request) {
        Map<String, Object> model = new HashMap<>();
        try {
            makeResetPasswordLink(request);
            model.put("message", "we have sent reset password link to your email. Please check");
        } catch (UsernameNotFoundException | UnsupportedEncodingException e) {
            model.put("error", e.getMessage());
        } catch (MessagingException e) {
            model.put("error", "Error while sending email");
        }
        return model;
    }

    public UserDto findUserById(Long userId) {
        return userRepository.findById(userId)
                .map(this::convertoDto)
                .orElseThrow(() -> new RuntimeException("такой user не найден!"));
    }

    private UserDto convertoDto(User user) {
        return UserDto.builder()
                .id(user.getId())
                .email(user.getEmail())
                .build();
    }
    public User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            String username = userDetails.getUsername();

            Optional<User> optionalUser = userRepository.findByEmail(username);

            return optionalUser.orElse(null);
        }
        return null;
    }

//    public String followUser(long reqUserId, long followUserId) throws ExecutionControl.UserException {
//        // Find the users by their IDs
//        UserDto reqUser = findUserById(reqUserId);
//        UserDto followUser = findUserById(followUserId);
//
//        // Check if users exist
//        if (reqUser == null || followUser == null) {
//            throw new ExecutionControl.UserException("User not found.");
//        }
//
//        // Create the User objects to represent the follower and the followed user
//        User follower = new User();
//        follower.setId(reqUser.getId());
//        follower.setEmail(reqUser.getEmail());
//        // follower.setUserImage(reqUser.getImage()); // Uncomment if needed
//
//        User following = new User();
//        following.setId(followUser.getId());
//        following.setEmail(followUser.getEmail());
//        // following.setUserImage(followUser.getImage()); // Uncomment if needed
//
//        // Add the following relationship
//        if (!reqUser.getFollowing().contains(following)) {
//            reqUser.getFollowing().add(following);
//        }
//
//        // Add the follower relationship
//        if (!followUser.getFollower().contains(follower)) {
//            followUser.getFollower().add(follower);
//        }
//
//        // Save the updated users to the repository
//        userRepository.save(reqUser);  // Save the requesting user
//        userRepository.save(followUser); // Save the followed user
//
//        return "You are now following " + followUser.getEmail();
//    }

}
