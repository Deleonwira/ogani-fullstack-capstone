package com.ogani.api.repository;

import com.ogani.api.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {
    List<Order> findByUserUserIdOrderByOrderTimeDesc(Integer userId);
    Optional<Order> findByInvoiceCode(String invoiceCode);
}
