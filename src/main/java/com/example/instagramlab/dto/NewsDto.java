package com.example.instagramlab.dto;

import com.example.instagramlab.model.Comment;
import com.example.instagramlab.model.User;
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
public class NewsDto {
    private Long id;
    private String imagePath;
    private User user;
    private String content;
    private Date createdDate;
}
