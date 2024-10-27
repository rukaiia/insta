package com.example.instagramlab.dto;

import com.example.instagramlab.model.Comment;
import com.example.instagramlab.model.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data

@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PostDto {
        private Long id;
    private String imagePath;
        private User user;
        private String content;
        private Date createdDate;
    private int dislikeCounts;
    private int likeCounts;
    private String status;
    private List<Comment> comments = new ArrayList<>();
    private boolean accepted;
    private boolean rejected;
    }

