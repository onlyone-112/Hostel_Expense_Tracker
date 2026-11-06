import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/hostel_expense.dart';
import '../providers/hostel_provider.dart';

class ExpenseDetailScreen extends StatelessWidget {
  final HostelExpense expense;
  const ExpenseDetailScreen({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense details')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        CircleAvatar(radius: 34, backgroundColor: const Color(0xFFE4F2EE),
          child: const Icon(Icons.receipt_long, size: 34, color: Color(0xFF176B5B))),
        const SizedBox(height: 16),
        Text(expense.title, textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
        Text('₹${expense.amount.toStringAsFixed(2)}', textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 28, color: Color(0xFF176B5B), fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _DetailRow(label: 'Category', value: expense.category),
        _DetailRow(label: 'Date', value: '${expense.date.day}/${expense.date.month}/${expense.date.year}'),
        _DetailRow(label: 'Paid to', value: expense.paidTo.isEmpty ? 'Not specified' : expense.paidTo),
        _DetailRow(label: 'Note', value: expense.note.isEmpty ? 'No note added' : expense.note),
        const SizedBox(height: 28),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
          onPressed: () async {
            final confirm = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
              title: const Text('Delete expense?'),
              content: const Text('This record will be removed from your device.'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
              ],
            ));
            if (confirm == true && context.mounted) {
              try {
                await context.read<HostelProvider>().remove(expense.id);
                if (context.mounted) Navigator.pop(context);
              } catch (_) {
                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Delete failed. Try again.')));
              }
            }
          },
          icon: const Icon(Icons.delete_outline), label: const Text('Delete expense'),
        ),
      ]),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 95, child: Text(label, style: TextStyle(color: Colors.grey.shade600))),
      Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500))),
    ]),
  );
}
