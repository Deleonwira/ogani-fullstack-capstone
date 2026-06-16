package com.ogani.api.controller;

import com.ogani.api.dto.response.ApiResponse;
import com.ogani.api.model.Wishlist;
import com.ogani.api.service.WishlistService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/wishlists")
@RequiredArgsConstructor
public class WishlistController {
    private final WishlistService wishlistService;

    @GetMapping("/user/{userId}")
    public ResponseEntity<ApiResponse<List<Wishlist>>> getWishlistsByUser(@PathVariable Integer userId) {
        return ResponseEntity.ok(ApiResponse.success(wishlistService.getWishlistsByUser(userId)));
    }

    @PostMapping("/user/{userId}/product/{productId}")
    public ResponseEntity<ApiResponse<Wishlist>> addWishlist(@PathVariable Integer userId, @PathVariable Integer productId) {
        return ResponseEntity.ok(ApiResponse.success(wishlistService.addWishlist(userId, productId)));
    }

    @DeleteMapping("/user/{userId}/product/{productId}")
    public ResponseEntity<ApiResponse<Void>> removeWishlist(@PathVariable Integer userId, @PathVariable Integer productId) {
        wishlistService.removeWishlist(userId, productId);
        return ResponseEntity.ok(ApiResponse.success(null));
    }
}
