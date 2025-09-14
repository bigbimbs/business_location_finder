import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/business.dart';

class StorageService {
  static const String _businessesKey = 'cached_businesses';

  Future<List<Business>> getCachedBusinesses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_businessesKey);
      
      if (jsonString == null) {
        return [];
      }

      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList
          .map((json) => Business.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> cacheBusinesses(List<Business> businesses) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(
        businesses.map((business) => business.toJson()).toList(),
      );
      await prefs.setString(_businessesKey, jsonString);
    } catch (e) {
      // fail in silence
    }
  }

  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_businessesKey);
    } catch (e) {
      // fail in silence
    }
  }
}
