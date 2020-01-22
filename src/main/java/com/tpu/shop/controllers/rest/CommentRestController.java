package com.tpu.shop.controllers.rest;

import com.fasterxml.jackson.annotation.JsonView;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.tpu.shop.data.*;
import com.tpu.shop.repository.*;
import com.tpu.shop.utils.Filter;
import com.tpu.shop.utils.RestException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.Type;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;


@RestController
@RequestMapping("/api")
public class CommentRestController {

    @Autowired
    private CommentRepository commentRepository;

    @JsonView(Views.Comment.class)
    @GetMapping("/comments/{id}")
    public List<Comment> getComments(@PathVariable Long id) {
        return commentRepository.findByModel_IdOrderByDateCreatedDesc(id);
    }

    @JsonView(Views.Comment.class)
    @GetMapping("/comment/{id}")
    public Comment getComment(@PathVariable Long id) {
        return commentRepository.findById(id).get();
    }

    @JsonView(Views.Comment.class)
    @PostMapping("/comment")
    public Comment saveComment(@RequestBody Comment comment, @AuthenticationPrincipal User user) {
        comment.setUser(user);
        LocalDateTime date = LocalDateTime.now();
        if (comment.getId() == null) {
            comment.setDateCreated(date);
        }
        comment.setDateUpdated(date);
        return commentRepository.save(comment);
    }

    @DeleteMapping("/comment/{id}")
    public void deleteComment(@PathVariable Long id) {
        commentRepository.deleteById(id);
    }

    @JsonView(Views.Comment.class)
    @GetMapping("/comment-user/{idModel}")
    public Comment getCommentUser(@PathVariable("idModel") Long idModel, @AuthenticationPrincipal User user) {
        return commentRepository.findFirstByModel_IdAndUser_Id(idModel, user.getId());
    }

}
