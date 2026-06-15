package com.ogani.api.service;

import com.ogani.api.repository.OrderRepository;
import com.ogani.api.repository.ProductRepository;
import com.ogani.api.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


import java.util.Map;

@Service
@RequiredArgsConstructor
public class DashboardService {
    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    private final UserRepository userRepository;

    public Map<String, Object> getStats() {
        Map<String, Object> stats = new java.util.HashMap<>();
        stats.put("totalOrders", orderRepository.count());
        stats.put("totalProducts", productRepository.count());
        stats.put("totalUsers", userRepository.count());
        
        java.util.List<com.ogani.api.model.Order> allOrders = orderRepository.findAll();
        java.math.BigDecimal revenue = java.math.BigDecimal.ZERO;
        long pending = 0;
        
        java.util.Map<String, java.math.BigDecimal> monthlyRevenue = new java.util.LinkedHashMap<>();
        for (int i = 5; i >= 0; i--) {
            String monthLabel = java.time.format.DateTimeFormatter.ofPattern("MMM yyyy").format(java.time.LocalDateTime.now().minusMonths(i));
            monthlyRevenue.put(monthLabel, java.math.BigDecimal.ZERO);
        }

        for(com.ogani.api.model.Order o : allOrders) {
            if (o.getOrderStatus() == com.ogani.api.model.Order.OrderStatus.completed || o.getOrderStatus() == com.ogani.api.model.Order.OrderStatus.shipped) {
                if (o.getTotalPrice() != null) {
                    revenue = revenue.add(o.getTotalPrice());
                }
            }
            if (o.getOrderStatus() == com.ogani.api.model.Order.OrderStatus.pending) {
                pending++;
            }
            
            if (o.getOrderTime() != null && o.getOrderTime().isAfter(java.time.LocalDateTime.now().minusMonths(6))) {
                String monthLabel = java.time.format.DateTimeFormatter.ofPattern("MMM yyyy").format(o.getOrderTime());
                if (monthlyRevenue.containsKey(monthLabel) && o.getTotalPrice() != null) {
                    monthlyRevenue.put(monthLabel, monthlyRevenue.get(monthLabel).add(o.getTotalPrice()));
                }
            }
        }
        
        stats.put("revenueToday", revenue); 
        stats.put("pendingOrders", pending); 
        
        java.util.List<String> labels = new java.util.ArrayList<>(monthlyRevenue.keySet());
        java.util.List<java.math.BigDecimal> data = new java.util.ArrayList<>(monthlyRevenue.values());
        java.util.Map<String, Object> chartData = new java.util.HashMap<>();
        chartData.put("labels", labels);
        chartData.put("data", data);
        stats.put("chartData", chartData);
        
        stats.put("recentOrders", orderRepository.findTop5ByOrderByOrderTimeDesc());
        
        return stats;
    }
}
