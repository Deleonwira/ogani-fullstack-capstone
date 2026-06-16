import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../services/notification_service.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationService>(
      builder: (context, notificationService, child) {
        if (notificationService.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final notifications = notificationService.notifications;

        return Scaffold(
          backgroundColor: AppTheme.surface,
          appBar: AppBar(
            title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Mark all as read not implemented in backend, could loop
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: AppTheme.primaryContainer.withValues(alpha: 0.1),
                        foregroundColor: AppTheme.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('Mark all as read'),
                    ),
                    IconButton(
                      icon: const Icon(CupertinoIcons.settings),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                if (notifications.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text('No notifications yet.'),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: notifications.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final n = notifications[index];
                      return _buildNotificationCard(
                        context,
                        icon: CupertinoIcons.bell, // Simplified icon
                        title: n.title,
                        time: n.timestamp.split('T').first,
                        description: n.message,
                        isUnread: !n.isRead,
                        iconColor: AppTheme.primary,
                        bgColor: AppTheme.primaryContainer.withValues(alpha: 0.2),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationCard(BuildContext context, {
    required IconData icon,
    required String title,
    required String time,
    required String description,
    required bool isUnread,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: isUnread ? Border(left: BorderSide(color: AppTheme.primary, width: 4)) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (isUnread)
            Positioned(
              top: 16,
              right: 16,
              child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle)),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
                  child: Icon(icon, color: iconColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                          const SizedBox(width: 16),
                          Text(time, style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(description, style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
