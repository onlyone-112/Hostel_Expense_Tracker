class HostelExpense {
  final String id;
  final String title;
  final String category;
  final double amount;
  final DateTime date;
  final String paidTo;
  final String note;

  const HostelExpense({
    required this.id,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.paidTo,
    required this.note,
  });

  Map<String, dynamic> toJson() => {
    'id': id, 'title': title, 'category': category, 'amount': amount,
    'date': date.toIso8601String(), 'paidTo': paidTo, 'note': note,
  };

  factory HostelExpense.fromJson(Map<String, dynamic> json) => HostelExpense(
    id: json['id'] as String,
    title: json['title'] as String,
    category: json['category'] as String,
    amount: (json['amount'] as num).toDouble(),
    date: DateTime.parse(json['date'] as String),
    paidTo: (json['paidTo'] ?? '') as String,
    note: (json['note'] ?? '') as String,
  );
}
