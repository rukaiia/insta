package com.example.instagramlab.model;


import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String email;
    private String password;
    private boolean enabled;
    private String resetPasswordToken;

    @ManyToOne
    @PrimaryKeyJoinColumn(name = "role_id")
    private Role role;


}
