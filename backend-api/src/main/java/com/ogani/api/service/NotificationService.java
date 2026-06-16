package com.ogani.api.service;

import com.ogani.api.model.Notification;
import com.ogani.api.repository.NotificationRepository;
import com.ogani.api.exception.ResourceNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class NotificationService {
    private final NotificationRepository notificationRepository;

    public List<Notification> getNotificationsByUser(Integer userId) {
        return notificationRepository.findByUser_UserIdOrderByTimestampDesc(userId);
    }

    public Notification markAsRead(Integer id) {
        Notification notification = notificationRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Notification not found with id: " + id));
        notification.setIsRead(true);
        return notificationRepository.save(notification);
    }

    public void deleteNotification(Integer id) {
        notificationRepository.deleteById(id);
    }
}
