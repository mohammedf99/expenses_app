import 'package:flutter/material.dart';

import '../models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addExpense});

  final void Function(Expense expense) addExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // ONE WAY OF DEALING WITH FUTURES (then method)
  // void _presentDatePicker() {
  //   final now = DateTime.now();
  //   showDatePicker(
  //     context: context,
  //     initialDate: now,
  //     firstDate: DateTime(now.year - 1, now.month, now.day),
  //     lastDate: DateTime.now().add(const Duration(days: 7)),
  //   ).then((value) => _dateController.text = value.toString());
  // }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _saveExpenseData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    final amountIsInvalid = enteredAmount < 0;

    if (amountIsInvalid || enteredTitle.trim().isEmpty) {
      showDialog(context: context, builder: (ctx) {
        return AlertDialog(
          title: const Text("Invalid input"),
          content: const Text("Please enter a valid title and amount!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Close"),
            )
          ],
        );
      });
      return;
    }

    widget.addExpense(
      Expense(
        title: enteredTitle,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 48, 16, 12),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(labelText: 'Title'),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    // prefixIcon: Icon(Icons.attach_money),
                    prefixText: "\$",
                    labelText: 'Amount',
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "Select date"
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (c) => DropdownMenuItem(
                        value: c,
                        child: Text(c.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                  onPressed: _saveExpenseData,
                  child: const Text('Add expense')),
            ],
          )
        ],
      ),
    );
  }
}
