import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'api_client.dart';
import '../providers/auth_provider.dart';

class NotificationItem {
  final int id;
  final String title;
  final String message;
  final String type;
  bool isRead;
  final String timestamp;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.timestamp,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['notificationId'] ?? 0,
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? 'info',
      isRead: json['isRead'] ?? false,
      timestamp: json['timestamp'] ?? '',
    );
  }
}

class NotificationService extends ChangeNotifier {
  List<NotificationItem> _notifications = [];
  bool _isLoading = false;
  final AuthProvider authProvider;

  NotificationService({required this.authProvider});

  List<NotificationItem> get notifications => _notifications;
  bool get isLoading => _isLoading;

  Future<void> fetchNotifications() async {
    if (authProvider.user == null) return;
    
    _isLoading = true;
    notifyListeners();

    try {
      final userId = authProvider.user!['userId'];
      final response = await ApiClient.get('/notifications/user/$userId');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List list = data['data'];
          _notifications = list.map((json) => NotificationItem.fromJson(json)).toList();
        }
      }
    } catch (e) {
      debugPrint('Error fetching notifications: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> markAsRead(int notificationId) async {
    try {
      final response = await ApiClient.put('/notifications/$notificationId/read', {});
      if (response.statusCode == 200) {
        final index = _notifications.indexWhere((n) => n.id == notificationId);
        if (index != -1) {
          _notifications[index].isRead = true;
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint('Error marking notification as read: $e');
    }
  }

  Future<void> deleteNotification(int notificationId) async {
    try {
      final response = await ApiClient.delete('/notifications/$notificationId');
      if (response.statusCode == 200) {
        _notifications.removeWhere((n) => n.id == notificationId);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error deleting notification: $e');
    }
  }
}
