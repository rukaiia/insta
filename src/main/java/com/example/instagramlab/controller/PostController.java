package com.example.instagramlab.controller;

import com.example.instagramlab.common.DateUtils;
import com.example.instagramlab.dto.PostDto;
import com.example.instagramlab.dto.UserDto;
import com.example.instagramlab.model.Post;
import com.example.instagramlab.model.User;
import com.example.instagramlab.service.AuthUserDetailsService;
import com.example.instagramlab.service.PostService;
import com.example.instagramlab.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.time.LocalDateTime;
import java.util.Date;

@Controller
@RequiredArgsConstructor
@RequestMapping("/posts")
public class PostController {

    private final PostService postService;
    private final UserService userService;
    private final AuthUserDetailsService authUserDetailsService;

    @GetMapping("/{postId}")
    public String getPostById(@PathVariable Long postId, Model model) {
        PostDto post = postService.getPostById(postId);

        if (post == null) {
            return "error/404";
        }
        model.addAttribute("post", post);

        return "post/postDetails";
    }

    @GetMapping("/create")
    public String createPost(Model model) {
        return "post/addpost";
    }



    @PostMapping("/create")
    public String createPost(@RequestParam String content) {
        Post post = new Post();
        post.setContent(content);
        post.setCreatedDate(DateUtils.convertToDate(LocalDateTime.now()));
        postService.savePost(content);
        return "redirect:/posts";
    }










    @GetMapping("/mypost")
    public String myPosts(Model model) {
        try {
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            if (principal instanceof UserDetails) {
                UserDetails userDetails = (UserDetails) principal;
                User user = userService.getUserByEmail(userDetails.getUsername());
                List<PostDto> postList = postService.getPostsOfUser(user.getId());
                model.addAttribute("posts", postList);
                return "post/myposts";
            } else {
                model.addAttribute("error", "Ошибка: пользователь не найден или не авторизован");
                return "error";
            }
        } catch (Exception e) {
            model.addAttribute("error", "Ошибка при получении постов: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping
    public String getAllPosts(Model model) {
        List<Post> postList = postService.getAllPost();
        model.addAttribute("posts", postList);
        return "post/posts";
    }

    @GetMapping("/{userId}/posts")
    public String getUserPosts(@PathVariable Long userId, Model model) {
        UserDto user = userService.findUserById(userId);
        List<PostDto> posts = postService.getPostsOfUser(userId);
        model.addAttribute("user", user);
        model.addAttribute("posts", posts);

        return "post/userPosts";
    }



}
