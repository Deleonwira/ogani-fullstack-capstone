package com.ogani.api.controller;

import com.ogani.api.dto.response.ApiResponse;
import com.ogani.api.model.Promo;
import com.ogani.api.service.PromoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/promos")
@RequiredArgsConstructor
public class PromoController {
    private final PromoService promoService;

    @GetMapping
    public ResponseEntity<ApiResponse<List<Promo>>> getAllPromos() {
        return ResponseEntity.ok(ApiResponse.success(promoService.getAllPromos()));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<Promo>> getPromoById(@PathVariable Integer id) {
        Promo promo = promoService.getPromoById(id);
        return ResponseEntity.ok(ApiResponse.success(promo));
    }

    @GetMapping("/code/{code}")
    public ResponseEntity<ApiResponse<Promo>> getPromoByCode(@PathVariable String code) {
        Promo promo = promoService.getPromoByCode(code);
        return ResponseEntity.ok(ApiResponse.success(promo));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<Promo>> createPromo(@RequestBody Promo promo) {
        Promo createdPromo = promoService.createPromo(promo);
        return ResponseEntity.ok(ApiResponse.success(createdPromo));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<Promo>> updatePromo(@PathVariable Integer id, @RequestBody Promo promo) {
        Promo updatedPromo = promoService.updatePromo(id, promo);
        return ResponseEntity.ok(ApiResponse.success(updatedPromo));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deletePromo(@PathVariable Integer id) {
        promoService.deletePromo(id);
        return ResponseEntity.ok(ApiResponse.success(null));
    }
}
