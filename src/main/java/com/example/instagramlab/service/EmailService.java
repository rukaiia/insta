package com.example.instagramlab.service;


import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.mail.javamail.JavaMailSender;


import java.io.UnsupportedEncodingException;

@Service
@RequiredArgsConstructor
public class EmailService {
    private final JavaMailSender mailSender;

    @Value("${spring.mail.username")
    private String EMAIL_FROM;

    public void sendMail(String to, String content) throws MessagingException, UnsupportedEncodingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);
        helper.setFrom(EMAIL_FROM, "Instagram support");
        helper.setTo(to);

        String subject = "Edu Food";
        String body = "<p>Hello,</p>"

                      + "<p>You have requested to reset your password.</p>"

                      + "<p>Click the link below to change your password:</p>"

                      + "<p><a href=\"" + content + "\">Change my password</a></p>"

                      + "<br>"

                      + "<p>Ignore this email if you do remember your password, "

                      + "or you have not made the request.</p>";

        helper.setSubject(subject);
        helper.setText(body, true);
        mailSender.send(message);
    }
}
