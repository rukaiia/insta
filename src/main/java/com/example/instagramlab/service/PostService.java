package com.example.instagramlab.service;

import com.example.instagramlab.dto.PostDto;
import com.example.instagramlab.exeptions.ResourceNotFoundException;
import com.example.instagramlab.model.Post;
import com.example.instagramlab.model.User;
import com.example.instagramlab.repository.PostRepository;
import com.example.instagramlab.repository.UserRepository;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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
@Slf4j
public class PostService {

   private final PostRepository postRepository;
    private final UserService userService;

    private final UserRepository userRepository;

    private final ModelMapper modelMapper;


    public void savePost(Post post) {
        User currentUser = getCurrentUser();
        if (currentUser != null) {
            post.setUser(currentUser);
            postRepository.save(post);
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



    public List<PostDto> getPostsOfUser(Long userId) {
        User user = userRepository.findUserById(userId);
        if (user == null) {
            return new ArrayList<>();
        }

        List<Post> postList = postRepository.findByUserOrderById(user);
        List<PostDto> postDtoList = new ArrayList<>();

        for (Post post : postList) {
            postDtoList.add(modelMapper.map(post, PostDto.class));
        }

        return postDtoList;
    }


    public List<Post> getAllPost(){
        return postRepository.findAllByOrderByIdDesc();
    }



    public PostDto getPostById(Long postId) {
        log.info("post with id: {} found", postId);
        return postRepository.findById(postId)
                .map(this::convertoDto)
                .orElseThrow(() -> new RuntimeException("такой post не найден!"));
    }
    private PostDto convertoDto(Post post){
    return PostDto.builder()
            .id(post.getId())
            .content(post.getContent())
            .createdDate(post.getCreatedDate())
            .user(post.getUser())
            .build();
    }


    public void deletePost(Long postId) {
        postRepository.deleteById(postId);
    }


    public Post likePost(Long postId){
        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new RuntimeException("post not found"));
        post.setLikeCounts(post.getLikeCounts() + 1);
        return postRepository.save(post);

    }
    public Post dislikePost(Long postID){
        Post post =
        postRepository.findById(postID)
                .orElseThrow(() -> new RuntimeException("post not find "));
        post.setDislikeCounts(post.getDislikeCounts()  + 1);
        return postRepository.save(post);
    }
    public void update(PostDto postDto) {
        Post existingPost = postRepository.findById(postDto.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Post not found with id " + postDto.getId()));

        existingPost.setContent(postDto.getContent());
        existingPost.setImagePath(postDto.getImagePath());

        postRepository.save(existingPost);
    }




    @Transactional
    public void processPost(Long postId, boolean accepted) {
        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new EntityNotFoundException("Post not found"));

        if (accepted) {
            post.setAccepted(true);
            post.setRejected(false);
        } else {
            post.setRejected(true);
            post.setAccepted(false);
        }

        postRepository.save(post);
    }

    public Page<Post> getAllPosts(Pageable pageable) {
        return postRepository.findAll(pageable);
    }

    public Page<Post> getPostsPaginated(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return postRepository.findAll(pageable);
    }

}
