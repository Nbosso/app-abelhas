// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SprayArea {
  final String id;
  final String name;
  final String lat;
  final String lng;
  final String groupRisk;
  final String type;
  final String radius;
  final String? farmerId;
  final DateTime? date;
  final DateTime? createdAt;
  final bool enable;

  SprayArea({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.groupRisk,
    required this.type,
    required this.radius,
    this.farmerId,
    this.date,
    this.createdAt,
    this.enable = true,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lat': lat,
      'lng': lng,
      'group_risk': groupRisk,
      'type': type,
      'radius': radius,
      'farmer_id': farmerId,
      'date': date?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'enable': enable,
    };
  }

  factory SprayArea.fromMap(Map<String, dynamic> map) {
    return SprayArea(
      id: map['id'] != null ? map['id'].toString() : '',
      name: map['name'] ?? '',
      lat: map['lat'] ?? '',
      lng: map['lng'] ?? '',
      groupRisk: map['group_risk'] ?? map['groupRisk'] ?? '',
      type: map['pulv_type'] ?? map['type'] ?? '',
      radius: map['radius']?.toString() ?? '',
      farmerId: map['farmer_id']?.toString(),
      date: _parseDate(map['date']),
      createdAt: _parseDate(map['created_at']),
      enable: map['enable'] is bool ? map['enable'] as bool : true,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    return null;
  }

  String toJson() => json.encode(toMap());

  factory SprayArea.fromJson(String source) =>
      SprayArea.fromMap(json.decode(source) as Map<String, dynamic>);
}
