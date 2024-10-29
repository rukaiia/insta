package com.example.instagramlab.service;

import com.example.instagramlab.dto.NewsDto;
import com.example.instagramlab.dto.PostDto;
import com.example.instagramlab.model.News;
import com.example.instagramlab.model.Post;
import com.example.instagramlab.model.User;
import com.example.instagramlab.repository.NewsRepository;
import com.example.instagramlab.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor

public class NewsService {
    private final NewsRepository newsRepository;
    private final UserRepository userRepository;
    private final ModelMapper modelMapper;

    public Page<News> getNewsPaginated(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return newsRepository.findAll(pageable);


    }

    public void deletePost(Long postId) {
        newsRepository.deleteById(postId);
    }

    public void savePost(News news) {
        User currentUser = getCurrentUser();
        if (currentUser != null) {
            news.setUser(currentUser);
            newsRepository.save(news);
        } else {
            throw new IllegalArgumentException("Ошибка: текущий пользователь не найден.");
        }
    }
    public User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated()) {
            Object principal = authentication.getPrincipal();
            if (principal instanceof UserDetails) {
                String email = ((UserDetails) principal).getUsername();
                return userRepository.findUserByEmail(email);
            }
        }
        return null;
    }

    public List<NewsDto> getPostsOfUser(Long userId) {
        User user = userRepository.findUserById(userId);
        if (user == null) {
            return new ArrayList<>();
        }

        List<News> newsList = newsRepository.findByUserOrderById(user);
        List<NewsDto> postDtoList = new ArrayList<>();

        for (News news : newsList) {
            postDtoList.add(modelMapper.map(news, NewsDto.class));
        }

        return postDtoList;
    }

}
