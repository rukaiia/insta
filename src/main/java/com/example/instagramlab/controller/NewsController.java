package com.example.instagramlab.controller;

import com.example.instagramlab.common.DateUtils;
import com.example.instagramlab.dto.NewsDto;
import com.example.instagramlab.dto.PostDto;
import com.example.instagramlab.model.News;
import com.example.instagramlab.model.Post;
import com.example.instagramlab.model.User;
import com.example.instagramlab.service.NewsService;
import com.example.instagramlab.service.PostService;
import com.example.instagramlab.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
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
import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/news")
public class NewsController {

        private final NewsService newsService;
        private final UserService userService;

    @GetMapping()
    public String getNewsPage(@RequestParam(defaultValue = "0") int page,
                               @RequestParam(defaultValue = "6") int size,
                               Model model) {
        Page<News> newsPage = newsService.getNewsPaginated(page, size);

        model.addAttribute("news", newsPage.getContent());

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", newsPage.getTotalPages());
        model.addAttribute("pageSize", size);

        return "news/news";
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
    @PostMapping("/delete")
    public String deletePost(@RequestParam Long id) {
        newsService.deletePost(id);
        return "redirect:/posts/mypost";
    }
    @PostMapping("/create")
    public String createPost(@RequestParam String content, @RequestParam MultipartFile image) {
        News news = new News();
        news.setContent(content);
        news.setCreatedDate(DateUtils.convertToDate(LocalDateTime.now()));

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
                news.setImagePath(imagePath);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        newsService.savePost(news);
        return "redirect:/news";
    }

}
