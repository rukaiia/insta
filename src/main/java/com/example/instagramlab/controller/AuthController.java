package com.example.instagramlab.controller;


import com.example.instagramlab.dto.UserDto;
import com.example.instagramlab.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
@RequestMapping("auth")
@RequiredArgsConstructor
public class AuthController {

    private final UserService userService;

    @GetMapping("login")
    public String login() {
        return "auth/login";
    }

    @GetMapping("eduFood")
    public String eduFood() {
        return "auth/eduFood";
    }

    @GetMapping("register")
    public String register(Model model) {
        model.addAttribute("userDto", new UserDto());
        return "auth/register";
    }

    @PostMapping("register")
    public String register(@Valid UserDto userDto, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "auth/register";
        }

        if (userService.checkIfUserExists(userDto.getEmail())) {
            bindingResult.rejectValue("email", "error.userDto", "Пользователь с таким email уже существует.");
            return "auth/register";
        }

        userService.createUser(userDto);
        return "redirect:/auth/login";
    }

    @GetMapping("forgot_password")
    public String forgotPassword() {
        return "auth/forgot_password";
    }

    @PostMapping("forgot_password")
    public String forgotPassword(HttpServletRequest request, Model model) {
        model.addAllAttributes(userService.forgotPassword(request));
        return "auth/forgot_password";
    }

    @GetMapping("reset_password")
    public String resetPassword(@RequestParam String token, Model model) {
        model.addAllAttributes(userService.getResetPassword(token));
        return "auth/reset_password";
    }

    @PostMapping("reset_password")
    public String resetPassword(HttpServletRequest request, Model model) {
        Map<String, Object> result = userService.postResetPassword(request);
        model.addAllAttributes(result);

        if (result.containsKey("message")) {
            return "auth/message";
        } else {
            return "auth/reset_password";
        }
    }
    @GetMapping("/lay")
    public String someMethod(Model model, Authentication authentication) {
        String profileUrl;

        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();

            boolean isAdmin = userDetails.getAuthorities().stream()
                    .anyMatch(grantedAuthority -> grantedAuthority.getAuthority().equals("ROLE_ADMIN"));

            profileUrl = isAdmin ? "/admin/adminpost" : "/posts/mypost";
        } else {
            profileUrl = "/auth/login";
        }

        model.addAttribute("profileUrl", profileUrl);
        return "layout";
    }
}