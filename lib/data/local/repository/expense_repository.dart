import 'package:expense_app/data/local/helper/db_helper.dart';
import 'package:expense_app/data/local/model/expense_model.dart';
import 'package:expense_app/data/local/model/filtered_expense_model.dart';
import 'package:expense_app/utils/app_constants.dart';
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
    required String filter,
  }) async {
    List<Map<String, dynamic>> list = await dbHelper.fetchUsersExpenses(
      userId: userId,
    );

    if (list.isEmpty) {
      return [];
    }

    List<ExpenseModel> expenseList = [];
    for (var expense in list) {
      expenseList.add(ExpenseModel.fromMap(expense));
    }
    if (filter == "Daily") {
      return filterByDaily(expenseList);
    } else if (filter == "Monthly") {
      return filterByMonthly(expenseList);
    } else if (filter == "Yearly") {
      return filterByYearly(expenseList);
    } else if (filter == "Category Wise") {
      return filterByCategory(expenseList);
    }
    return filterByMonthly(expenseList);
  }

  List<FilteredExpenseModel> filterByDaily(List<ExpenseModel> expenseList) {
    List<FilteredExpenseModel> filteredExpenseList = [];
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

  List<FilteredExpenseModel> filterByMonthly(List<ExpenseModel> expenseList) {
    List<FilteredExpenseModel> filteredExpenseList = [];
    DateFormat df = DateFormat('MMMM, yyyy');

    List<String> months = [];
    for (ExpenseModel expense in expenseList) {
      String month = df.format(
        DateTime.fromMillisecondsSinceEpoch(int.parse(expense.createdAt)),
      );
      if (!months.contains(month)) {
        months.add(month);
      }
    }

    for (String month in months) {
      num total = 0.0;
      List<ExpenseModel> expenses = [];
      for (ExpenseModel expense in expenseList) {
        String eMonth = df.format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(expense.createdAt)),
        );
        if (eMonth == month) {
          if (expense.type == 1) {
            total -= double.parse(expense.amt);
          } else {
            total += double.parse(expense.amt);
          }
          expenses.add(expense);
        }
      }
      filteredExpenseList.add(
        FilteredExpenseModel(title: month, bal: total, expenses: expenses),
      );
    }
    return filteredExpenseList;
  }

  List<FilteredExpenseModel> filterByYearly(List<ExpenseModel> expenseList) {
    List<FilteredExpenseModel> filteredExpenseList = [];
    DateFormat df = DateFormat('yyyy');

    List<String> years = [];
    for (ExpenseModel expense in expenseList) {
      String year = df.format(
        DateTime.fromMillisecondsSinceEpoch(int.parse(expense.createdAt)),
      );
      if (!years.contains(year)) {
        years.add(year);
      }
    }

    for (String year in years) {
      num total = 0.0;
      List<ExpenseModel> expenses = [];
      for (ExpenseModel expense in expenseList) {
        String eYear = df.format(
          DateTime.fromMillisecondsSinceEpoch(int.parse(expense.createdAt)),
        );
        if (eYear == year) {
          if (expense.type == 1) {
            total -= double.parse(expense.amt);
          } else {
            total += double.parse(expense.amt);
          }
          expenses.add(expense);
        }
      }
      filteredExpenseList.add(
        FilteredExpenseModel(title: year, bal: total, expenses: expenses),
      );
    }
    return filteredExpenseList;
  }

  List<FilteredExpenseModel> filterByCategory(List<ExpenseModel> expenseList) {
    List<FilteredExpenseModel> filteredExpenseList = [];

    List<String> categories = [];
    for (ExpenseModel expense in expenseList) {
      String category =
          AppConstants.categories
              .where((cat) => expense.catId == cat.catId)
              .toList()[0]
              .catName;
      if (!categories.contains(category)) {
        categories.add(category);
      }
    }

    for (String category in categories) {
      num total = 0.0;
      List<ExpenseModel> expenses = [];
      for (ExpenseModel expense in expenseList) {
        String eCat =
            AppConstants.categories
                .where((cat) => expense.catId == cat.catId)
                .toList()[0]
                .catName;
        if (eCat == category) {
          if (expense.type == 1) {
            total -= double.parse(expense.amt);
          } else {
            total += double.parse(expense.amt);
          }
          expenses.add(expense);
        }
      }
      filteredExpenseList.add(
        FilteredExpenseModel(title: category, bal: total, expenses: expenses),
      );
    }
    return filteredExpenseList;
  }
}
