package com.example.instagramlab.controller;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import com.example.instagramlab.dto.PostDto;
import com.example.instagramlab.model.Comment;
import com.example.instagramlab.model.Post;
import com.example.instagramlab.model.User;
import com.example.instagramlab.service.CommentService;
import com.example.instagramlab.service.PostService;
import com.example.instagramlab.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
public class CommentController {

    private final CommentService commentService;

    private final PostService postService;
    private final UserService userService;


    @PostMapping("/comment")
    public String addComment(
            @ModelAttribute @Valid Comment comment,
            BindingResult result,
            @RequestParam long postId,
            Model model) {

        if (!result.hasErrors()) {
            comment.setCreated(new Timestamp(new Date().getTime()));

            PostDto postDto = postService.getPostById(postId);
            Post post = new Post();
            post.setId(postDto.getId());
            post.setContent(postDto.getContent());

            comment.setPost(post);
            commentService.save(comment);
            System.out.println("Комментарий сохранен: " + comment.getText());

            return "redirect:/post?id=" + postId;
        } else {
            PostDto post = postService.getPostById(postId);
            List<Comment> allComments = commentService.findAllByPostId(postId);
            model.addAttribute("allComments", allComments);
            model.addAttribute("post", post);
            return "post/posts";
        }
    }



    @GetMapping("/comments/{postId}")
    public String viewComments(@PathVariable long postId, Model model) {
        List<Comment> allComments = commentService.findAllByPostId(postId);
        PostDto postDto = postService.getPostById(postId);

        model.addAttribute("allComments", allComments);
        model.addAttribute("post", postDto);

        return "post/comments";
    }


}
