package com.example.instagramlab.dto;

import com.example.instagramlab.model.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
@Data

@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PostDto {
        private Long id;
        private User user;
        private String content;
        private Date createdDate;
    }

