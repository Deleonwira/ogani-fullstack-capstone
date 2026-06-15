package com.ogani.api.controller;

import com.ogani.api.dto.response.ApiResponse;
import com.ogani.api.model.Promo;
import com.ogani.api.service.PromoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
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
}
