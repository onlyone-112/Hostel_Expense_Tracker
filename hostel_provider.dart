import 'package:flutter/foundation.dart';
import '../models/hostel_expense.dart';
import '../services/hostel_storage_service.dart';

class HostelProvider extends ChangeNotifier {
  final HostelStorageService _storage = HostelStorageService();
  List<HostelExpense> _expenses = [];
  bool isLoading = true;
  String? error;

  List<HostelExpense> get expenses => List.unmodifiable(_expenses);

  double get totalSpent =>
      _expenses.fold(0, (sum, item) => sum + item.amount);

  double get currentMonthTotal {
    final now = DateTime.now();
    return _expenses.where((e) =>
      e.date.year == now.year && e.date.month == now.month
    ).fold(0, (sum, item) => sum + item.amount);
  }

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      _expenses = await _storage.readExpenses();
      _expenses.sort((a, b) => b.date.compareTo(a.date));
    } catch (_) {
      error = 'Could not load saved expenses. Please retry.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> add(HostelExpense expense) async {
    _expenses.insert(0, expense);
    try {
      await _storage.saveExpenses(_expenses);
      error = null;
    } catch (_) {
      _expenses.removeWhere((e) => e.id == expense.id);
      error = 'Could not save this expense. Please try again.';
      rethrow;
    }
    notifyListeners();
  }

  Future<void> remove(String id) async {
    final old = List<HostelExpense>.from(_expenses);
    _expenses.removeWhere((e) => e.id == id);
    try {
      await _storage.saveExpenses(_expenses);
    } catch (_) {
      _expenses = old;
      error = 'Could not delete expense. Please try again.';
      rethrow;
    }
    notifyListeners();
  }

  Map<String, double> categoryTotals() {
    final totals = <String, double>{};
    for (final item in _expenses) {
      totals[item.category] = (totals[item.category] ?? 0) + item.amount;
    }
    return totals;
  }
}
