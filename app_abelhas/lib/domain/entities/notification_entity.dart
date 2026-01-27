import 'package:flutter/material.dart';

class NotificationEntity {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final String date;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.date,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic>? map) {
    return NotificationEntity(
      id: map?['id'] ?? '',
      title: map?['title'] ?? '',
      message: map?['message'] ?? '',
      date: map?['date'] ?? '',
      type: NotificationTypeFromAPI.fromString(map?['category'] ?? ''),
    );
  }
}

enum NotificationType {
  posts(
      icon: Icons.notifications_rounded,
      color: Color.fromRGBO(224, 224, 224, 1)),
  holerite(icon: Icons.notifications_rounded, color: Colors.teal),
  ponto(
      icon: Icons.notifications_rounded,
      color: Color.fromRGBO(224, 224, 224, 1)),
  undefined(
      icon: Icons.notifications_rounded,
      color: Color.fromRGBO(224, 224, 224, 1));

  const NotificationType({required this.icon, required this.color});

  final IconData icon;
  final Color color;
}

extension NotificationTypeFromAPI on NotificationType {
  static NotificationType fromString(String value) {
    switch (value) {
      case 'posts':
        return NotificationType.posts;
      case 'holerite':
        return NotificationType.holerite;
      case 'ponto':
        return NotificationType.ponto;
      default:
        return NotificationType.undefined;
    }
  }
}
