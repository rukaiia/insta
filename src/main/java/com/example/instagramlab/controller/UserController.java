//package com.example.instagramlab.controller;
//
//import com.example.instagramlab.model.User;
//import com.example.instagramlab.service.UserService;
//import jdk.jshell.spi.ExecutionControl;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.*;
//
//@Controller
//@RequestMapping("/users")
//public class UserController {
//
//    private final UserService userService;
//
//    public UserController(UserService userService) {
//        this.userService = userService;
//    }
//
//    // Подписаться на пользователя
//    @PostMapping("/follow/{followUserId}")
//    public String followUser(@PathVariable Long followUserId, @RequestParam("token") String token, Model model) throws ExecutionControl.UserException {
//        User user = userService.findUserProfile(token); // Найти текущего пользователя
//        String message = userService.followUser(user.getId(), followUserId); // Выполнить подписку
//
//        model.addAttribute("message", message);
//        return "redirect:/users/profile"; // Перенаправление на профиль пользователя
//    }
//
//    // Отписаться от пользователя
//    @PostMapping("/unfollow/{userId}")
//    public String unfollowUser(@PathVariable Long userId, @RequestParam("token") String token, Model model) throws ExecutionControl.UserException {
//        User user = userService.findUserProfile(token); // Найти текущего пользователя
//        String message = userService.unfollowUser(user.getId(), userId); // Выполнить отписку
//
//        model.addAttribute("message", message);
//        return "redirect:/users/profile"; // Перенаправление на профиль пользователя
//    }
//
//    // Профиль пользователя
//    @GetMapping("/profile")
//    public String viewUserProfile(@RequestParam("token") String token, Model model) throws ExecutionControl.UserException {
//        User user = userService.findUserProfile(token); // Найти текущего пользователя
//        model.addAttribute("user", user);
//        return "profile"; // Возвращаем страницу профиля пользователя
//    }
//}
//
