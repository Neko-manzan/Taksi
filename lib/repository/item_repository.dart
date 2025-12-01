import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/item.dart';

class ItemRepository {
  static const _key = 'items_list';

  Future<List<Item>> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return [];
    final decoded = json.decode(raw) as List<dynamic>;
    return decoded.map((e) => Item.fromMap(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveItems(List<Item> items) async {
    final prefs = await SharedPreferences.getInstance();
    final listMap = items.map((i) => i.toMap()).toList();
    await prefs.setString(_key, json.encode(listMap));
  }
}
