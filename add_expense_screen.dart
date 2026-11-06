import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/hostel_expense.dart';
import '../providers/hostel_provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});
  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _amount = TextEditingController();
  final _paidTo = TextEditingController();
  final _note = TextEditingController();
  final _categories = const ['Rent', 'Mess', 'Laundry', 'Electricity', 'Maintenance', 'Fine', 'Personal'];
  String _category = 'Mess';
  DateTime _date = DateTime.now();
  bool _saving = false;

  @override
  void dispose() {
    _title.dispose(); _amount.dispose(); _paidTo.dispose(); _note.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate() || _saving) return;
    setState(() => _saving = true);
    try {
      await context.read<HostelProvider>().add(HostelExpense(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: _title.text.trim(),
        category: _category,
        amount: double.parse(_amount.text.trim()),
        date: _date,
        paidTo: _paidTo.text.trim(),
        note: _note.text.trim(),
      ));
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to save. Please try again.')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add hostel expense')),
      body: Form(
        key: _formKey,
        child: ListView(padding: const EdgeInsets.all(18), children: [
          TextFormField(controller: _title, decoration: const InputDecoration(labelText: 'Expense title', hintText: 'e.g. September mess fee'),
            validator: (v) => v == null || v.trim().isEmpty ? 'Enter a title' : null),
          const SizedBox(height: 14),
          TextFormField(controller: _amount, keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Amount (₹)', prefixText: '₹ '),
            validator: (v) {
              final n = double.tryParse(v?.trim() ?? '');
              return n == null || n <= 0 ? 'Enter an amount greater than zero' : null;
            }),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            value: _category,
            decoration: const InputDecoration(labelText: 'Category'),
            items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => setState(() => _category = v ?? _category),
          ),
          const SizedBox(height: 14),
          TextFormField(controller: _paidTo, decoration: const InputDecoration(labelText: 'Paid to (optional)', hintText: 'Hostel office / laundry shop')),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            onPressed: () async {
              final picked = await showDatePicker(context: context, initialDate: _date,
                firstDate: DateTime(2020), lastDate: DateTime(2100));
              if (picked != null) setState(() => _date = picked);
            },
            icon: const Icon(Icons.calendar_month),
            label: Text('Date: ${_date.day}/${_date.month}/${_date.year}'),
          ),
          const SizedBox(height: 14),
          TextFormField(controller: _note, maxLines: 3, decoration: const InputDecoration(labelText: 'Note (optional)', alignLabelWithHint: true)),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _saving ? null : _save,
            icon: _saving ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.save),
            label: Text(_saving ? 'Saving...' : 'Save expense'),
          ),
        ]),
      ),
    );
  }
}
