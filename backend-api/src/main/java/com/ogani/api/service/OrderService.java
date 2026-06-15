package com.ogani.api.service;

import com.ogani.api.exception.ResourceNotFoundException;
import com.ogani.api.model.Order;
import com.ogani.api.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderService {
    private final OrderRepository orderRepository;

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public Order getOrderById(Integer id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found with id: " + id));
    }

    public Order createOrder(Order order) {
        return orderRepository.save(order);
    }

    public Order updateOrderStatus(Integer id, String statusStr) {
        Order order = getOrderById(id);
        Order.OrderStatus status = Order.OrderStatus.valueOf(statusStr.toLowerCase());
        order.setOrderStatus(status);
        return orderRepository.save(order);
    }

    public void deleteOrder(Integer id) {
        Order order = getOrderById(id);
        orderRepository.delete(order);
    }
}
