package com.ogani.api.service;

import com.ogani.api.exception.ResourceNotFoundException;
import com.ogani.api.model.Promo;
import com.ogani.api.repository.PromoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PromoService {
    private final PromoRepository promoRepository;

    public List<Promo> getAllPromos() {
        return promoRepository.findAll();
    }

    public Promo getPromoById(Integer id) {
        return promoRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Promo not found with id: " + id));
    }

    public Promo createPromo(Promo promo) {
        return promoRepository.save(promo);
    }

    public Promo updatePromo(Integer id, Promo promoDetails) {
        Promo promo = getPromoById(id);
        promo.setPromoCode(promoDetails.getPromoCode());
        promo.setTitle(promoDetails.getTitle());
        promo.setDescription(promoDetails.getDescription());

        promo.setDiscountValue(promoDetails.getDiscountValue());
        promo.setMinimumSpend(promoDetails.getMinimumSpend());
        promo.setExpirationDate(promoDetails.getExpirationDate());
        return promoRepository.save(promo);
    }

    public void deletePromo(Integer id) {
        Promo promo = getPromoById(id);
        promoRepository.delete(promo);
    }
}
