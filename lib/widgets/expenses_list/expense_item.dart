import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;
 
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(expense.id),
          Text(expense.title),
          Row(
            children: [
              Text('\$${expense.amount.toStringAsFixed(2)}'),
              const Spacer(
                flex: 10,
              ),
              Icon(categoryIcons[expense.category]), // IconData used directly
              const Spacer(
                flex: 1,
              ),
              // const SizedBox(
              //   width: 8,
              // ),
              // const Spacer(),
              Text(expense.formatDate)
            ],
          )
        ],
      ),
    ));
  }
}
