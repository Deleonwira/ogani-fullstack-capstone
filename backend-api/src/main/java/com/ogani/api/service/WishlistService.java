package com.ogani.api.service;

import com.ogani.api.model.Wishlist;
import com.ogani.api.model.WishlistId;
import com.ogani.api.model.User;
import com.ogani.api.model.Product;
import com.ogani.api.repository.WishlistRepository;
import com.ogani.api.repository.UserRepository;
import com.ogani.api.repository.ProductRepository;
import com.ogani.api.exception.ResourceNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class WishlistService {
    private final WishlistRepository wishlistRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;

    public List<Wishlist> getWishlistsByUser(Integer userId) {
        return wishlistRepository.findByUser_UserId(userId);
    }

    public Wishlist addWishlist(Integer userId, Integer productId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));

        WishlistId id = new WishlistId(userId, productId);
        Wishlist wishlist = new Wishlist(id, user, product);

        return wishlistRepository.save(wishlist);
    }

    public void removeWishlist(Integer userId, Integer productId) {
        WishlistId id = new WishlistId(userId, productId);
        wishlistRepository.deleteById(id);
    }
}
