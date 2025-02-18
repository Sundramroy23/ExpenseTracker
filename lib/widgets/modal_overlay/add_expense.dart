import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

DateFormat dateConverter = DateFormat("dd/MM/yyyy");

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedDate;
  String? _selectedCategory = Category.leisure.name.toString();

  void _datePicker() async {
    final currentDate = DateTime.now();
    final firstDate = DateTime(currentDate.year - 1);

    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: currentDate,
        currentDate: currentDate);

    setState(() {
      _selectedDate = dateConverter.format(picked!).toString();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
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
                onPressed: () {
                  print(_titleController.text.isEmpty
                      ? "Empty"
                      : _titleController.text);
                  print(_amountController.text.isEmpty
                      ? "Empty"
                      : _amountController.text);
                  print(_selectedDate ?? "Empty");
                },
                child: Text("Add"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
