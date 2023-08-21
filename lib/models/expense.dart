import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const Uuid uuid = Uuid();
final formatter = DateFormat.yMd();

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate => formatter.format(date);
}

enum Category {
  food,
  transportation,
  work,
  leisure,
  utilities,
}

const categoryIcons = {
  Category.food: Icons.fastfood,
  Category.transportation: Icons.directions_car,
  Category.work: Icons.work,
  Category.leisure: Icons.local_movies,
  Category.utilities: Icons.settings,
};
