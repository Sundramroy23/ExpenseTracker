// This file contains the AddExpense widget which is a modal overlay that allows the user to add an expense to the list of expenses.
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

DateFormat dateConverter = DateFormat("dd/MM/yyyy");

class AddExpense extends StatefulWidget {
  const AddExpense({
    required this.expenses,
    required this.onAddExpense,
    super.key,
  });
  
  final List<Expense> expenses;
  final void Function(Expense expense) onAddExpense;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedDate;
  String? _selectedCategory = Category.leisure.name.toString();

  void _expenseSubmit() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);
    final date = _selectedDate;
    
    if (title.isEmpty || amount == null || date == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("Please enter valid input"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Okay")
            )
          ],
        ),
      );
    } else {
      final expense = Expense(
        title: title,
        amount: amount,
        date: dateConverter.parse(date),
        category: Category.values.firstWhere(
          (element) => element.name.toString() == _selectedCategory
        ),
      );
      widget.onAddExpense(expense);
      Navigator.of(context).pop();
    }
  }

  void _datePicker() async {
    final currentDate = DateTime.now();
    final firstDate = DateTime(currentDate.year - 1);

    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: currentDate,
      currentDate: currentDate
    );

    if (picked != null) {
      setState(() {
        _selectedDate = dateConverter.format(picked).toString();
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          const Text("Add Expense"),
          TextField(
            controller: _titleController,
            maxLength: 50,
            // onChanged: _onAmountChaned,
            decoration: const InputDecoration(labelText: "Description"),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  // onChanged: _onAmountChaned,
                  decoration: const InputDecoration(
                    labelText: "Amount",
                    prefixText: "\$ ",
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null
                        ? "Empty"
                        : _selectedDate.toString()),
                    // const Spacer(),
                    IconButton(
                        onPressed: _datePicker,
                        icon: Icon(Icons.calendar_month)),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              DropdownButton(
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toString())),
                    )
                    .toList(),
                onChanged: (value) {
                  print(value);
                  setState(() {
                    _selectedCategory = value?.name.toString();
                  });
                },
                hint: Text(_selectedCategory!),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _expenseSubmit,
                child: Text("Add"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
