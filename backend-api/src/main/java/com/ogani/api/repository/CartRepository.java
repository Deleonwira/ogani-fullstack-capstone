package com.ogani.api.repository;

import com.ogani.api.model.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CartRepository extends JpaRepository<Cart, Integer> {
    List<Cart> findByUserUserId(Integer userId);
    Optional<Cart> findByUserUserIdAndProductProductId(Integer userId, Integer productId);
}
