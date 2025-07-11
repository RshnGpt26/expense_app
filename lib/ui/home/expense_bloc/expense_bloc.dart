import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/local/model/filtered_expense_model.dart';
import '../../../data/local/repository/expense_repository.dart';
import '../../../utils/app_constants.dart';
import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseRepository expenseRepository;
  ExpenseBloc({required this.expenseRepository})
    : super(ExpenseInitialState()) {
    on<ExpenseAddEvent>((event, emit) async {
      emit(ExpenseAddingState());
      bool check = await expenseRepository.addExpense(expense: event.expense);
      if (check) {
        emit(ExpenseAddedState());
      } else {
        emit(ExpenseAddFailedState(errMsg: "Expenses not added yet!!"));
      }
    });

    on<ExpenseFetchEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      SharedPreferences pref = await SharedPreferences.getInstance();
      int userId = pref.getInt(AppConstants.prefUserIdKey) ?? -1;
      List<FilteredExpenseModel> expenseList = await expenseRepository
          .fetchUsersExpenses(userId: userId, filter: event.filter);
      num totalExpenses = 0;
      for (FilteredExpenseModel expense in expenseList) {
        totalExpenses += expense.bal;
      }
      emit(
        ExpenseLoadedState(
          totalExpenses: totalExpenses.toInt(),
          expenses: expenseList,
        ),
      );
    });
  }
}
