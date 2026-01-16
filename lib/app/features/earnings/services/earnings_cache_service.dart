import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class EarningsCacheService {
  static const String _summaryKeyPrefix = 'earnings_summary_';
  static const String _historyKeyPrefix = 'earnings_history_';
  static const String _taxConfigKey = 'tax_config';
  static const Duration _defaultCacheDuration = Duration(minutes: 30);

  // --- Summary ---

  Future<void> cacheSummary(String userEmail, Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '$_summaryKeyPrefix$userEmail';
      final cacheEntry = {
        'timestamp': DateTime.now().toIso8601String(),
        'data': data,
      };
      await prefs.setString(key, jsonEncode(cacheEntry));
    } catch (e) {
      debugPrint('Error caching earnings summary: $e');
    }
  }

  Future<Map<String, dynamic>?> getCachedSummary(String userEmail) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '$_summaryKeyPrefix$userEmail';
      final jsonString = prefs.getString(key);
      
      if (jsonString == null) return null;
      
      final cacheEntry = jsonDecode(jsonString);
      final timestamp = DateTime.parse(cacheEntry['timestamp']);
      
      if (DateTime.now().difference(timestamp) > _defaultCacheDuration) {
        return null; // Expired
      }
      
      return cacheEntry['data'] as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error reading cached earnings summary: $e');
      return null;
    }
  }

  // --- History ---

  Future<void> cacheHistory(String userEmail, List<dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '$_historyKeyPrefix$userEmail';
      final cacheEntry = {
        'timestamp': DateTime.now().toIso8601String(),
        'data': data,
      };
      await prefs.setString(key, jsonEncode(cacheEntry));
    } catch (e) {
      debugPrint('Error caching earnings history: $e');
    }
  }

  Future<List<dynamic>?> getCachedHistory(String userEmail) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '$_historyKeyPrefix$userEmail';
      final jsonString = prefs.getString(key);
      
      if (jsonString == null) return null;
      
      final cacheEntry = jsonDecode(jsonString);
      final timestamp = DateTime.parse(cacheEntry['timestamp']);
      
      if (DateTime.now().difference(timestamp) > _defaultCacheDuration) {
        return null; // Expired
      }
      
      return cacheEntry['data'] as List<dynamic>;
    } catch (e) {
      debugPrint('Error reading cached earnings history: $e');
      return null;
    }
  }

  // --- Tax Config ---

  Future<void> cacheTaxConfig(Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheEntry = {
        'timestamp': DateTime.now().toIso8601String(),
        'data': data,
      };
      await prefs.setString(_taxConfigKey, jsonEncode(cacheEntry));
    } catch (e) {
      debugPrint('Error caching tax config: $e');
    }
  }

  Future<Map<String, dynamic>?> getCachedTaxConfig() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_taxConfigKey);
      
      if (jsonString == null) return null;
      
      final cacheEntry = jsonDecode(jsonString);
      // Tax config expires less frequently (e.g. 24 hours)
      final timestamp = DateTime.parse(cacheEntry['timestamp']);
       if (DateTime.now().difference(timestamp) > const Duration(hours: 24)) {
        return null; 
      }
      
      return cacheEntry['data'] as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error reading cached tax config: $e');
      return null;
    }
  }

  Future<void> clearCache() async {
     final prefs = await SharedPreferences.getInstance();
     // Clear only earnings keys
     final keys = prefs.getKeys();
     for (final key in keys) {
       if (key.startsWith('earnings_') || key == _taxConfigKey) {
         await prefs.remove(key);
       }
     }
  }
}
