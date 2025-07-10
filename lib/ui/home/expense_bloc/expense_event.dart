import '../../../data/local/model/expense_model.dart';

abstract class ExpenseEvent {}

class ExpenseFetchEvent extends ExpenseEvent {
  String filter;
  ExpenseFetchEvent({required this.filter});
}

class ExpenseAddEvent extends ExpenseEvent {
  ExpenseModel expense;
  ExpenseAddEvent({required this.expense});
}
