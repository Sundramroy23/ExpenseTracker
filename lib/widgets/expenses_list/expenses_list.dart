import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:expense_tracker/widgets/modal_overlay/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  List<Expense> expenses = [];

  void _addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void _onpressed() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        child: AddExpense(
          expenses: expenses,
          onAddExpense: _addExpense,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: _onpressed, icon: const Icon(Icons.add_circle_outline))
        ],
      ),
      body: Column(
        children: [
          const Text("Graph Placeholder"),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) => ExpenseItem(expenses[index]),
            ),
          )
        ],
      ),
    );
  }
}
