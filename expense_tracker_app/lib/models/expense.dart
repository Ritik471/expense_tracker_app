import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Categories {
  food,
  transportation,
  restaurant,
  groceries,
  insurance,
  travel
}

const categoryIcons = {
  Categories.food: Icons.lunch_dining,
  Categories.groceries: Icons.shopping_bag,
  Categories.insurance: Icons.health_and_safety_rounded,
  Categories.restaurant: Icons.restaurant,
  Categories.transportation: Icons.pedal_bike,
  Categories.travel: Icons.mode_of_travel_outlined,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.categories,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.categories)
      : expenses = allExpenses
            .where((expense) => expense.category == categories)
            .toList();

  final Categories categories;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
