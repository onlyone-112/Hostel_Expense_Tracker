import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/hostel_provider.dart';

class HostelSummaryScreen extends StatelessWidget {
  const HostelSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HostelProvider>();
    final totals = provider.categoryTotals().entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Scaffold(
      appBar: AppBar(title: const Text('Hostel cost summary')),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Total recorded spending'),
            const SizedBox(height: 6),
            Text('₹${provider.totalSpent.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF176B5B))),
            const SizedBox(height: 12),
            Text('This month: ₹${provider.currentMonthTotal.toStringAsFixed(2)}'),
          ],
        ))),
        const SizedBox(height: 20),
        const Text('Spending by category', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        if (totals.isEmpty)
          const Padding(padding: EdgeInsets.all(24), child: Text('Add expenses to see your category breakdown.', textAlign: TextAlign.center))
        else
          ...totals.map((entry) {
            final fraction = provider.totalSpent == 0 ? 0.0 : entry.value / provider.totalSpent;
            return Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text('₹${entry.value.toStringAsFixed(2)}'),
                ]),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: fraction, minHeight: 7,
                  borderRadius: BorderRadius.circular(8)),
              ],
            )));
          }),
      ]),
    );
  }
}
