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

  SprayArea({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.groupRisk,
    required this.type,
    required this.radius,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lat': lat,
      'lng': lng,
      'group_risk': groupRisk,
      'type': type,
      'radius': radius,
    };
  }

  factory SprayArea.fromMap(Map<String, dynamic> map) {
    return SprayArea(
      id: map['id'] != null ? map['id'].toString() : '',
      name: map['name'] ?? '',
      lat: map['lat'] ?? '',
      lng: map['lng'] ?? '',
      groupRisk: map['groupRisk'] ?? '',
      type: map['type'] ?? '',
      radius: map['radius'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SprayArea.fromJson(String source) =>
      SprayArea.fromMap(json.decode(source) as Map<String, dynamic>);
}
