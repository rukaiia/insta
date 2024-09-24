package com.example.instagramlab.dto;


import com.example.instagramlab.validation.UniqueEmail;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserDto {
    private Long id;
    @Email
    @NotBlank(message = "Адрес эл.почты обязательное поле для заполнения!")
    @UniqueEmail(message = "Пользователь с такой эл.почтой уже существует!")
    private String email;

    @NotBlank(message = "Пароль обязательное поле для заполнения!")
    @Size(min = 8, max = 20, message = "Пароль должен быть длиною не менее 8 и не более 20 символов!")
    @Pattern(regexp = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).+$",
            message = "В пароли должны содержаться минимум 1 буква верхнева регистра, минимум 1 малого регистра, символы  латыницей!")
    private String password;
}
