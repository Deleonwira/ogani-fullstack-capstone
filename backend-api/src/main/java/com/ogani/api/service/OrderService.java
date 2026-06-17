package com.ogani.api.service;

import com.ogani.api.exception.ResourceNotFoundException;
import com.ogani.api.model.Order;
import com.ogani.api.repository.OrderRepository;
import com.ogani.api.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderService {
    private final OrderRepository orderRepository;
    private final NotificationService notificationService;
    private final UserRepository userRepository;

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public List<Order> getOrdersByUserId(Integer userId) {
        return orderRepository.findByUserUserIdOrderByOrderTimeDesc(userId);
    }

    public Order getOrderById(Integer id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found with id: " + id));
    }

    public Order createOrder(Order order) {
        if (order.getOrderDetails() != null) {
            order.getOrderDetails().forEach(detail -> detail.setOrder(order));
        }
        Order savedOrder = orderRepository.save(order);
        
        if (savedOrder.getUser() != null && savedOrder.getUser().getUserId() != null) {
            com.ogani.api.model.User user = userRepository.findById(savedOrder.getUser().getUserId()).orElse(null);
            if (user != null && savedOrder.getTotalPrice() != null) {
                int pointsEarned = savedOrder.getTotalPrice().intValue() / 1000;
                user.setTotalPoints((user.getTotalPoints() != null ? user.getTotalPoints() : 0) + pointsEarned);
                userRepository.save(user);
            }
        }
        
        notificationService.createNotification(
            savedOrder.getUser(),
            "Order Placed successfully",
            "Your order #" + savedOrder.getOrderId() + " has been successfully placed. We are processing it.",
            "order"
        );
        
        return savedOrder;
    }

    public Order updateOrderStatus(Integer id, String statusStr) {
        Order order = getOrderById(id);
        Order.OrderStatus status = Order.OrderStatus.valueOf(statusStr.toLowerCase());
        order.setOrderStatus(status);
        Order updatedOrder = orderRepository.save(order);
        
        notificationService.createNotification(
            updatedOrder.getUser(),
            "Order Status Updated",
            "Your order #" + updatedOrder.getOrderId() + " status is now: " + status.toString(),
            "order_update"
        );
        
        return updatedOrder;
    }

    public void deleteOrder(Integer id) {
        Order order = getOrderById(id);
        orderRepository.delete(order);
    }
}
