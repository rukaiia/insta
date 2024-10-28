package com.example.instagramlab.controller;

import com.example.instagramlab.dto.UserDto;
import com.example.instagramlab.model.Post;
import com.example.instagramlab.service.PostService;
import com.example.instagramlab.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("admin")
@RequiredArgsConstructor
public class AdminController {
    private final UserService userService;
    private final PostService postService;
    @GetMapping("/register")
    public String register(Model model) {
        model.addAttribute("userDto", new UserDto());
        return "auth/adminregister";
    }

    @PostMapping("/register")
    public String register(@Valid UserDto userDto, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            return "auth/adminregister";
        }

        if (userService.checkIfUserExists(userDto.getEmail())) {
            bindingResult.rejectValue("email", "error.userDto", "Пользователь с таким email уже существует.");
            return "auth/adminregister";
        }

        userService.createAdmin(userDto);

        redirectAttributes.addFlashAttribute("successMessage", "Регистрация прошла успешно! Ваш билет: " );

        return "redirect:/admin";
    }
    @GetMapping()
    public String getAdminPage(@RequestParam(defaultValue = "0") int page,
                               @RequestParam(defaultValue = "6") int size,
                               Model model) {
        Page<Post> postPage = postService.getPostsPaginated(page, size);

        model.addAttribute("posts", postPage.getContent());

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", postPage.getTotalPages());
        model.addAttribute("pageSize", size);

        return "auth/admin";
    }


}