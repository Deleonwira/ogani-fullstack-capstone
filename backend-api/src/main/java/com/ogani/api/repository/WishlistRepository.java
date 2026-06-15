package com.ogani.api.repository;

import com.ogani.api.model.Wishlist;
import com.ogani.api.model.WishlistId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WishlistRepository extends JpaRepository<Wishlist, WishlistId> {
    List<Wishlist> findByIdUserId(Integer userId);
    Boolean existsByIdUserIdAndIdProductId(Integer userId, Integer productId);
}
