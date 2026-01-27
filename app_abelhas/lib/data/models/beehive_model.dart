// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BeehiveModel {
  final String id;
  final String register;
  final String lat;
  final String lng;
  final String responsible;
  final String description;

  BeehiveModel({
    required this.id,
    required this.register,
    required this.lat,
    required this.lng,
    required this.responsible,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'register': register,
      'lat': lat,
      'lng': lng,
      'responsible': responsible,
      'description': description,
    };
  }

  factory BeehiveModel.fromMap(Map<String, dynamic> map) {
    return BeehiveModel(
      id: map['id'] != null ? map['id'].toString() : '',
      register: map['register'] ?? '',
      lat: map['lat'] ?? '',
      lng: map['lng'] ?? '',
      responsible: map['responsible'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BeehiveModel.fromJson(String source) =>
      BeehiveModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
