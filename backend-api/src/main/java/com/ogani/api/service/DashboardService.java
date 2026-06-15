package com.ogani.api.service;

import com.ogani.api.repository.OrderRepository;
import com.ogani.api.repository.ProductRepository;
import com.ogani.api.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.math.BigDecimal;

@Service
@RequiredArgsConstructor
public class DashboardService {
    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    private final UserRepository userRepository;

    public Map<String, Object> getStats(Integer days) {
        Map<String, Object> stats = new HashMap<>();
        
        List<com.ogani.api.model.Order> allOrders = orderRepository.findAll();
        List<com.ogani.api.model.Order> filteredOrders = new ArrayList<>();
        
        LocalDateTime startDate = null;
        if (days != null && days > 0) {
            startDate = LocalDateTime.now().minusDays(days);
        }

        for (com.ogani.api.model.Order o : allOrders) {
            if (startDate == null || (o.getOrderTime() != null && o.getOrderTime().isAfter(startDate))) {
                filteredOrders.add(o);
            }
        }

        stats.put("totalOrders", filteredOrders.size());
        stats.put("totalProducts", productRepository.count());
        stats.put("totalUsers", userRepository.count());
        
        BigDecimal revenue = BigDecimal.ZERO;
        long pending = 0;
        
        Map<String, BigDecimal> monthlyRevenue = new LinkedHashMap<>();
        for (int i = 5; i >= 0; i--) {
            String monthLabel = DateTimeFormatter.ofPattern("MMM yyyy").format(LocalDateTime.now().minusMonths(i));
            monthlyRevenue.put(monthLabel, BigDecimal.ZERO);
        }

        for(com.ogani.api.model.Order o : filteredOrders) {
            if (o.getOrderStatus() == com.ogani.api.model.Order.OrderStatus.completed || o.getOrderStatus() == com.ogani.api.model.Order.OrderStatus.shipped) {
                if (o.getTotalPrice() != null) {
                    revenue = revenue.add(o.getTotalPrice());
                }
            }
            if (o.getOrderStatus() == com.ogani.api.model.Order.OrderStatus.pending) {
                pending++;
            }
        }

        // Chart data should ideally remain monthly to show trends even if filtered by a few days, 
        // but if the filter is tight, we just show whatever is in the period.
        // For chart we always use allOrders up to 6 months to avoid an empty chart when days=7
        for(com.ogani.api.model.Order o : allOrders) {
             if (o.getOrderTime() != null && o.getOrderTime().isAfter(LocalDateTime.now().minusMonths(6))) {
                String monthLabel = DateTimeFormatter.ofPattern("MMM yyyy").format(o.getOrderTime());
                if (monthlyRevenue.containsKey(monthLabel) && o.getTotalPrice() != null) {
                    monthlyRevenue.put(monthLabel, monthlyRevenue.get(monthLabel).add(o.getTotalPrice()));
                }
            }
        }
        
        stats.put("revenueToday", revenue); 
        stats.put("pendingOrders", pending); 
        
        List<String> labels = new ArrayList<>(monthlyRevenue.keySet());
        List<BigDecimal> data = new ArrayList<>(monthlyRevenue.values());
        Map<String, Object> chartData = new HashMap<>();
        chartData.put("labels", labels);
        chartData.put("data", data);
        stats.put("chartData", chartData);
        
        // Sort filtered orders by time descending and get top 5
        filteredOrders.sort((o1, o2) -> {
            if (o1.getOrderTime() == null && o2.getOrderTime() == null) return 0;
            if (o1.getOrderTime() == null) return 1;
            if (o2.getOrderTime() == null) return -1;
            return o2.getOrderTime().compareTo(o1.getOrderTime());
        });
        
        List<com.ogani.api.model.Order> recent = new ArrayList<>();
        for (int i = 0; i < Math.min(5, filteredOrders.size()); i++) {
            recent.add(filteredOrders.get(i));
        }
        stats.put("recentOrders", recent);
        
        return stats;
    }

    public String generateCsvReport(Integer days) {
        List<com.ogani.api.model.Order> allOrders = orderRepository.findAll();
        LocalDateTime startDate = null;
        if (days != null && days > 0) {
            startDate = LocalDateTime.now().minusDays(days);
        }

        StringBuilder csv = new StringBuilder();
        csv.append("Order ID,Invoice Code,Customer Name,Order Date,Total Price,Status\n");

        for (com.ogani.api.model.Order o : allOrders) {
            if (startDate == null || (o.getOrderTime() != null && o.getOrderTime().isAfter(startDate))) {
                String invoice = o.getInvoiceCode() != null ? o.getInvoiceCode() : "#ORD-" + o.getOrderId();
                String customer = o.getUser() != null ? o.getUser().getFullName() : "Unknown";
                String date = o.getOrderTime() != null ? o.getOrderTime().toString() : "";
                BigDecimal price = o.getTotalPrice() != null ? o.getTotalPrice() : BigDecimal.ZERO;
                String status = o.getOrderStatus() != null ? o.getOrderStatus().name() : "pending";
                
                // Escape commas
                customer = "\"" + customer + "\"";
                
                csv.append(String.format("%d,%s,%s,%s,%.2f,%s\n", 
                    o.getOrderId(), invoice, customer, date, price, status));
            }
        }
        return csv.toString();
    }

    public Map<String, Object> getReportData(Integer days) {
        Map<String, Object> stats = getStats(days);
        
        List<com.ogani.api.model.Order> allOrders = orderRepository.findAll();
        List<com.ogani.api.model.Order> filteredOrders = new ArrayList<>();
        LocalDateTime startDate = null;
        if (days != null && days > 0) {
            startDate = LocalDateTime.now().minusDays(days);
        }

        for (com.ogani.api.model.Order o : allOrders) {
            if (startDate == null || (o.getOrderTime() != null && o.getOrderTime().isAfter(startDate))) {
                filteredOrders.add(o);
            }
        }
        
        // Sort descending by order time
        filteredOrders.sort((o1, o2) -> {
            if (o1.getOrderTime() == null && o2.getOrderTime() == null) return 0;
            if (o1.getOrderTime() == null) return 1;
            if (o2.getOrderTime() == null) return -1;
            return o2.getOrderTime().compareTo(o1.getOrderTime());
        });

        // Replace recent orders with FULL list of orders
        stats.put("recentOrders", filteredOrders);

        // Add Average Order Value (AOV)
        BigDecimal revenue = (BigDecimal) stats.get("revenueToday");
        int totalOrders = filteredOrders.size();
        BigDecimal aov = BigDecimal.ZERO;
        if (totalOrders > 0) {
            aov = revenue.divide(new BigDecimal(totalOrders), 2, java.math.RoundingMode.HALF_UP);
        }
        stats.put("averageOrderValue", aov);

        return stats;
    }
}
