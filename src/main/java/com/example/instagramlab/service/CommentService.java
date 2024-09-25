package com.example.instagramlab.service;



import com.example.instagramlab.model.Comment;
import com.example.instagramlab.repository.CommentRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class CommentService {

    private final CommentRepository repository;

    @Autowired
    public CommentService(CommentRepository repository) {
        this.repository = repository;
    }

    public List<Comment> findAllByPostId(long id) {
        return repository.findAllByPostIdOrderByCreatedDesc(id);
    }

    public long save(Comment comment) {
        if (comment == null) {
            log.error("Comment cannot be null");
            throw new IllegalArgumentException("Comment cannot be null");
        }

        try {
            long id = repository.saveAndFlush(comment).getId();
            log.info("Comment saved successfully with id: {}", id);
            return id;
        } catch (Exception e) {
            log.error("Error saving comment: {}", e.getMessage());
            throw e;
        }
    }
}