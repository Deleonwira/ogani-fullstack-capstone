package com.ogani.api.repository;

import com.ogani.api.model.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Integer> {
    List<Review> findByProductProductIdOrderByReviewDateDesc(Integer productId);
    List<Review> findByUserUserIdOrderByReviewDateDesc(Integer userId);
}
