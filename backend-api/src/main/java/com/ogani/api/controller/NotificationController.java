package com.ogani.api.controller;

import com.ogani.api.dto.response.ApiResponse;
import com.ogani.api.model.Notification;
import com.ogani.api.service.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/notifications")
@RequiredArgsConstructor
public class NotificationController {
    private final NotificationService notificationService;

    @GetMapping("/user/{userId}")
    public ResponseEntity<ApiResponse<List<Notification>>> getNotificationsByUser(@PathVariable Integer userId) {
        return ResponseEntity.ok(ApiResponse.success(notificationService.getNotificationsByUser(userId)));
    }

    @PutMapping("/{id}/read")
    public ResponseEntity<ApiResponse<Notification>> markAsRead(@PathVariable Integer id) {
        return ResponseEntity.ok(ApiResponse.success(notificationService.markAsRead(id)));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteNotification(@PathVariable Integer id) {
        notificationService.deleteNotification(id);
        return ResponseEntity.ok(ApiResponse.success(null));
    }
}
