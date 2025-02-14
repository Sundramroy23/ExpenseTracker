import 'package:uuid/uuid.dart';

final uuid = Uuid();
enum Category{food, leisure, work, travel}

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
    required this.category
  }) :id = uuid.v4();

}