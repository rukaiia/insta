package com.example.instagramlab.repository;

import com.example.instagramlab.model.News;
import com.example.instagramlab.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NewsRepository  extends JpaRepository<News, Long> {
    List<News> findByUserOrderById(User user);
}
