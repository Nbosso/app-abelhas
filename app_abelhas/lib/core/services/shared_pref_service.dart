import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class AbstractSharedPref {
  Future<void> writeString(String key, String value);

  Future<void> writeInt(String key, int value);

  Future<void> writeDouble(String key, double value);

  Future<void> writeBool(String key, bool value);

  Future<void> writeJson(String key, Map<String, dynamic> value);

  String? readString(String key);

  int? readInt(String key);

  double? readDouble(String key);

  bool? readBool(String key);

  Map<String, dynamic>? readJson(String key);

  Future<void> delete(String key);

  Future<void> writeStringList(String key, List<String> value);

  List<String> readStringList(String key);

  Future<void> clearAll();
}

class SharedPref implements AbstractSharedPref {
  SharedPreferences storage;

  SharedPref({required this.storage});

  @override
  Future<void> writeString(String key, String value) async {
    await storage.setString(key, value);
  }

  @override
  Future<void> writeInt(String key, int value) async {
    await storage.setInt(key, value);
  }

  @override
  Future<void> writeDouble(String key, double value) async {
    await storage.setDouble(key, value);
  }

  @override
  Future<void> writeJson(String key, Map<String, dynamic> value) async {
    await storage.setString(key, jsonEncode(value));
  }

  @override
  String? readString(String key) {
    return storage.getString(key);
  }

  @override
  int? readInt(String key) {
    var data = storage.getInt(key);
    return data;
  }

  @override
  double? readDouble(String key) {
    var data = storage.getDouble(key);
    return data;
  }

  @override
  Map<String, dynamic>? readJson(String key) {
    var data = storage.getString(key);
    return (data != null) ? jsonDecode(data) : null;
  }

  @override
  Future<void> delete(String key) async {
    await storage.remove(key);
  }

  @override
  List<String> readStringList(String key) {
    var data = storage.getStringList(key);

    if (data != null) return data;

    return [];
  }

  @override
  Future<void> writeStringList(String key, List<String> value) async {
    await storage.setStringList(key, value);
  }

  @override
  bool? readBool(String key) {
    var data = storage.getBool(key);
    return data;
  }

  @override
  Future<void> writeBool(String key, bool value) async {
    await storage.setBool(key, value);
  }

  @override
  Future<void> clearAll() async {
    await storage.clear();
  }
}
