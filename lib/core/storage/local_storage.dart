import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Key-value storage. Knows nothing about the game or the API.
class LocalStorage {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String? getString(String key) => _prefs.getString(key);

  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  /// Reads a saved JSON value. Corrupt data is deleted and returns null.
  dynamic getJson(String key) {
    final raw = _prefs.getString(key);
    if (raw == null) return null;
    try {
      return jsonDecode(raw);
    } catch (_) {
      _prefs.remove(key);
      return null;
    }
  }

  Future<bool> setJson(String key, Object? value) =>
      _prefs.setString(key, jsonEncode(value));

  Future<bool> remove(String key) => _prefs.remove(key);
}