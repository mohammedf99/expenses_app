import 'package:flutter/material.dart';

import 'expenses.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense App',
      home: Expenses(),
    );
  }
}