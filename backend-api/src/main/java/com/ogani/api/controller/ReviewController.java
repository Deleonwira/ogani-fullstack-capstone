package com.ogani.api.controller;

import com.ogani.api.dto.response.ApiResponse;
import com.ogani.api.model.Review;
import com.ogani.api.service.ReviewService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/reviews")
@RequiredArgsConstructor
public class ReviewController {
    private final ReviewService reviewService;

    @GetMapping
    public ResponseEntity<ApiResponse<List<Review>>> getAllReviews() {
        return ResponseEntity.ok(ApiResponse.success(reviewService.getAllReviews()));
    }


}
