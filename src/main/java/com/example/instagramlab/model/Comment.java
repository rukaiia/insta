package com.example.instagramlab.model;
import java.sql.Timestamp;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Data
@Table(name = "comment")
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false)
    private Timestamp created;

    @NotBlank(message = "Can''t post an empty comment!")
    @NotNull(message = "Can''t post an empty comment!")
    @Column(nullable = false)
    @Size(max = 60)
    private String text;

    @NotNull(message = "User must be specified.")
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @NotNull(message = "Post must be specified.")
    @ManyToOne
    @JoinColumn(name = "post_id", nullable = false)
    private Post post;
}