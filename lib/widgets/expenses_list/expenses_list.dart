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

  void _removeExpense(Expense expense) {
    final expenseIndex = expenses.indexOf(expense);
    setState(
      () {
        expenses.remove(expense);
      },
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Expense Deleted!"),
        duration: const Duration(seconds: 3),
        backgroundColor: const Color.fromARGB(255, 234, 86, 75),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(
              () {
                expenses.insert(expenseIndex, expense);
              },
            );
          },
        ),
      ),
    );
  }

  void _onpressed() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SizedBox(
        // height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        child: AddExpense(
          expenses: expenses,
          onAddExpense: _addExpense,
        ),
      ),
    );
  }

  Widget mainWidget() {
    if (expenses.isNotEmpty) {
      return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(expenses[index].id),
          onDismissed: (direction) {
            _removeExpense(expenses[index]);
          },
          child: ExpenseItem(expenses[index]),
        ),
      );
    } else {
      return const Center(
        child: Text("No expenses added yet"),
      );
    }
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
            child: mainWidget(),
          ),
        ],
      ),
    );
  }
}
