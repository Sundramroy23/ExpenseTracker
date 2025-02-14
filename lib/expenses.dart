import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  List<Expense> expenses = [
    Expense(
      title: "Flutter Course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Cinema",
      amount: 15.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Graph Placeholder"),
        Expanded(
          child: ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) => Text(expenses[index].title),
          ),
        )
      ],
    );
  }
}
