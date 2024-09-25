package com.example.instagramlab.controller;

import com.example.instagramlab.common.DateUtils;
import com.example.instagramlab.dto.PostDto;
import com.example.instagramlab.dto.UserDto;
import com.example.instagramlab.model.Comment;
import com.example.instagramlab.model.Post;
import com.example.instagramlab.model.User;
import com.example.instagramlab.repository.CommentRepository;
import com.example.instagramlab.repository.PostRepository;
import com.example.instagramlab.service.AuthUserDetailsService;
import com.example.instagramlab.service.PostService;
import com.example.instagramlab.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
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
    private final PostRepository postRepository;
    private final CommentRepository commentRepository;

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
    public String createPost(@RequestParam String content, @RequestParam MultipartFile image) {
        Post post = new Post();
        post.setContent(content);
        post.setCreatedDate(DateUtils.convertToDate(LocalDateTime.now()));

        if (!image.isEmpty()) {
            try {
                String uploadDir = System.getProperty("user.dir") + "/uploads/";
                File uploadsDir = new File(uploadDir);
                if (!uploadsDir.exists()) {
                    uploadsDir.mkdir();
                }

                String imagePath = System.currentTimeMillis() + "_" + image.getOriginalFilename();
                String fullPath = uploadDir + imagePath;
                File file = new File(fullPath);
                image.transferTo(file);
                post.setImagePath(imagePath);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        postService.savePost(post);
        return "redirect:/posts";
    }







    @PostMapping("/delete")
    public String deletePost(@RequestParam Long id) {
        postService.deletePost(id);
        return "redirect:/posts/mypost";
    }
    @GetMapping("/uploads/{filename:.+}")
    @ResponseBody
    public ResponseEntity<Resource> getImage(@PathVariable String filename) {
        try {
            Path file = Paths.get(System.getProperty("user.dir") + "/uploads/").resolve(filename);
            Resource resource = new UrlResource(file.toUri());

            if (resource.exists() || resource.isReadable()) {
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
                        .body(resource);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (MalformedURLException e) {
            return ResponseEntity.badRequest().build();
        }
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


    @PostMapping("/{postId}/comments")
    public String addComment(@PathVariable Long postId, @RequestParam String content, @RequestParam String email) {
        System.out.println("Adding comment to post with ID: " + postId); // Лог для проверки вызова метода
        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid post Id: " + postId));

        Comment comment = new Comment();
        comment.setText(content);
        comment.setCreated(Timestamp.valueOf(LocalDateTime.now()));

        // Получаем пользователя по email
        User user = userService.getUserByEmail(email);
        if (user == null) {
            System.out.println("User not found for email: " + email); // Лог для проверки пользователя
            return "redirect:/posts/" + postId; // Перенаправляем на страницу поста
        }
        comment.setUser(user); // Устанавливаем пользователя в комментарий

        post.addComment(comment);
        postRepository.save(post); // Сохранение поста с добавленным комментарием
        System.out.println("Comment added successfully."); // Лог успешного добавления

        return "redirect:/posts/" + postId; // Перенаправляем на страницу поста
    }


    @PostMapping("/comments/delete")
    public String deleteComment(@RequestParam Long commentId, @RequestParam Long postId) {
        Comment comment = commentRepository.findById(commentId).orElseThrow(() -> new IllegalArgumentException("Invalid comment Id:" + commentId));
        Post post = postRepository.findById(postId).orElseThrow(() -> new IllegalArgumentException("Invalid post Id:" + postId));
        post.removeComment(comment);
        postRepository.save(post);
        return "redirect:/posts/" + postId; // Перенаправляем на страницу поста
    }
}
