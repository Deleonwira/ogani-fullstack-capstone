package com.ogani.api.repository;

import com.ogani.api.model.Promo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PromoRepository extends JpaRepository<Promo, Integer> {
    Optional<Promo> findByPromoCode(String promoCode);
}
