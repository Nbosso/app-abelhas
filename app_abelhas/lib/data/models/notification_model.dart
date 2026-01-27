class NotificationModel {
  final int id;
  final String userId;
  final String title;
  final String message;
  final bool read;
  final DateTime createdAt;

  const NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.read,
    required this.createdAt,
  });

  /// 🔹 Converte do Supabase (Map<String, dynamic>) → Model
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as int,
      userId: map['user_id'] as String,
      title: map['title'] as String,
      message: map['message'] as String,
      read: map['read'] as bool? ?? false,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  /// 🔹 Converte Model → Map (útil para inserts locais ou testes)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'message': message,
      'read': read,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// 🔹 Cópia imutável (ex: marcar como lida)
  NotificationModel copyWith({
    bool? read,
  }) {
    return NotificationModel(
      id: id,
      userId: userId,
      title: title,
      message: message,
      read: read ?? this.read,
      createdAt: createdAt,
    );
  }

  @override
  String toString() {
    return 'NotificationModel('
        'id: $id, '
        'userId: $userId, '
        'title: $title, '
        'message: $message, '
        'read: $read, '
        'createdAt: $createdAt'
        ')';
  }
}
