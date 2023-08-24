import 'package:flutter/material.dart';

import '../../models/expense.dart';
import 'expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, required this.onDismissed});

  final List<Expense> expenses;
  final void Function(Expense expense) onDismissed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (direction) => onDismissed(expenses[index]),
        background: const SnackBar(content: Text("Delete")),
        child: ExpenseItem(expense: expenses[index]),
      ),
    );
  }
}
