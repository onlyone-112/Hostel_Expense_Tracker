import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/hostel_expense.dart';

class HostelStorageService {
  static const _key = 'hostel_expenses_v1';

  Future<List<HostelExpense>> readExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return [];
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => HostelExpense.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveExpenses(List<HostelExpense> expenses) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      jsonEncode(expenses.map((expense) => expense.toJson()).toList()),
    );
  }
}
