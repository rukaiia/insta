//package com.example.instagramlab.controller;
//
//
//import com.example.edufood.dto.OrderDto;
//import com.example.edufood.service.CartService;
//import lombok.RequiredArgsConstructor;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import java.util.List;
//
//@Controller
//@RequestMapping("profile")
//@RequiredArgsConstructor
//public class ProfileController {
//
//    private final CartService cartService;
//
//    @GetMapping()
//    public String profile(Model model) {
//        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//        String userEmail = auth.getName();
//        List<OrderDto> orders = cartService.getUserOrders(userEmail);
//        model.addAttribute("orders", orders);
//        return "profile/profile";
//    }
//
//    @GetMapping("/order/{orderId}")
//    public String orderDetails(@PathVariable Long orderId, Model model) {
//        OrderDto order = cartService.getOrderById(orderId);
//        model.addAttribute("order", order);
//        return "profile/orderDetails";
//    }
//
//}
