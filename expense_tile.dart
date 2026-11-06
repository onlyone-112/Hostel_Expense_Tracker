import 'package:flutter/material.dart';
import '../models/hostel_expense.dart';

class ExpenseTile extends StatelessWidget {
  final HostelExpense expense;
  final VoidCallback onTap;
  const ExpenseTile({super.key, required this.expense, required this.onTap});

  IconData get icon {
    switch (expense.category) {
      case 'Rent': return Icons.home_work_outlined;
      case 'Mess': return Icons.restaurant_outlined;
      case 'Laundry': return Icons.local_laundry_service_outlined;
      case 'Electricity': return Icons.bolt_outlined;
      case 'Maintenance': return Icons.build_outlined;
      case 'Fine': return Icons.warning_amber_outlined;
      default: return Icons.shopping_bag_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE4F2EE),
          child: Icon(icon, color: const Color(0xFF176B5B)),
        ),
        title: Text(expense.title, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('${expense.category} • ${expense.date.day}/${expense.date.month}/${expense.date.year}'),
        trailing: Text('₹${expense.amount.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
