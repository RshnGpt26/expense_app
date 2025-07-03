import 'package:expense_app/data/local/model/expense_model.dart';

abstract class ExpenseEvent {}

class ExpenseFetchEvent extends ExpenseEvent {
  ExpenseFetchEvent();
}

class ExpenseAddEvent extends ExpenseEvent {
  ExpenseModel expense;
  ExpenseAddEvent({required this.expense});
}
