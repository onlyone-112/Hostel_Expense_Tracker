import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/hostel_provider.dart';
import '../widgets/expense_tile.dart';
import 'add_expense_screen.dart';
import 'expense_detail_screen.dart';
import 'hostel_summary_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HostelProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('HostelTrack', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            tooltip: 'Monthly summary',
            onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const HostelSummaryScreen())),
            icon: const Icon(Icons.pie_chart_outline),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const AddExpenseScreen())),
        icon: const Icon(Icons.add),
        label: const Text('Add expense'),
      ),
      body: RefreshIndicator(
        onRefresh: provider.load,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF176B5B), Color(0xFF27977D)]),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('THIS MONTH', style: TextStyle(color: Colors.white70, letterSpacing: 1.2)),
                const SizedBox(height: 8),
                Text('₹${provider.currentMonthTotal.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 14),
                Text('All-time hostel spending: ₹${provider.totalSpent.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white)),
              ]),
            ),
            const SizedBox(height: 22),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Recent expenses', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              Text('${provider.expenses.length} records', style: TextStyle(color: Colors.grey.shade600)),
            ]),
            const SizedBox(height: 10),
            if (provider.isLoading)
              const Padding(padding: EdgeInsets.all(30), child: Center(child: CircularProgressIndicator()))
            else if (provider.error != null && provider.expenses.isEmpty)
              _MessageState(message: provider.error!, action: provider.load)
            else if (provider.expenses.isEmpty)
              const _MessageState(message: 'No hostel expenses yet. Add your first payment.')
            else
              ...provider.expenses.map((expense) => ExpenseTile(
                expense: expense,
                onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ExpenseDetailScreen(expense: expense))),
              )),
          ],
        ),
      ),
    );
  }
}

class _MessageState extends StatelessWidget {
  final String message;
  final Future<void> Function()? action;
  const _MessageState({required this.message, this.action});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(28),
    child: Column(children: [
      const Icon(Icons.receipt_long_outlined, size: 42, color: Colors.grey),
      const SizedBox(height: 10),
      Text(message, textAlign: TextAlign.center),
      if (action != null) TextButton(onPressed: action, child: const Text('Retry')),
    ]),
  );
}
