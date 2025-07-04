import '../../../data/local/model/filtered_expense_model.dart';

abstract class ExpenseState {}

class ExpenseInitialState extends ExpenseState {}

class ExpenseAddingState extends ExpenseState {}

class ExpenseAddedState extends ExpenseState {}

class ExpenseAddFailedState extends ExpenseState {
  String errMsg;
  ExpenseAddFailedState({required this.errMsg});
}

class ExpenseLoadingState extends ExpenseState {}

class ExpenseLoadedState extends ExpenseState {
  List<FilteredExpenseModel> expenses;
  ExpenseLoadedState({required this.expenses});
}
