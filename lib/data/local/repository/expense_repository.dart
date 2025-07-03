import 'package:expense_app/data/local/helper/db_helper.dart';
import 'package:expense_app/data/local/model/expense_model.dart';
import 'package:expense_app/data/local/model/filtered_expense_model.dart';
import 'package:intl/intl.dart';

class ExpenseRepository {
  DBHelper dbHelper;
  ExpenseRepository({required this.dbHelper});

  Future<bool> addExpense({required ExpenseModel expense}) async {
    bool check = await dbHelper.addExpense(expense: expense);
    return check;
  }

  Future<List<FilteredExpenseModel>> fetchUsersExpenses({
    required int userId,
  }) async {
    List<Map<String, dynamic>> list = await dbHelper.fetchUsersExpenses(
      userId: userId,
    );

    if (list.isEmpty) {
      return [];
    }

    List<ExpenseModel> expenseList = [];
    List<FilteredExpenseModel> filteredExpenseList = [];

    for (var expense in list) {
      expenseList.add(ExpenseModel.fromMap(expense));
    }

    DateFormat df = DateFormat.yMMMEd();
    List<String> dates = [];
    for (ExpenseModel expense in expenseList) {
      String date = df.format(
        DateTime.fromMillisecondsSinceEpoch(int.parse(expense.createdAt)),
      );
      if (!dates.contains(date)) {
        dates.add(date);
      }
    }

    for (String date in dates) {
      num total = 0.0;
      List<ExpenseModel> expenses = [];
      for (ExpenseModel expense in expenseList) {
        String eDate = df.format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(expense.createdAt)),
        );
        if (eDate == date) {
          if (expense.type == 1) {
            total -= double.parse(expense.amt);
          } else {
            total += double.parse(expense.amt);
          }
          expenses.add(expense);
        }
      }
      filteredExpenseList.add(
        FilteredExpenseModel(title: date, bal: total, expenses: expenses),
      );
    }

    return filteredExpenseList;
  }
}
