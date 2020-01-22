package com.tpu.shop.repository;

import com.tpu.shop.data.Comment;
import com.tpu.shop.data.Os;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Long> {
    List<Comment> findByModel_IdOrderByDateCreatedDesc(Long id);
    Comment findFirstByModel_IdAndUser_Id(Long idModel, Long idUser);
}
