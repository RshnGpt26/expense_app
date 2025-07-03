import 'expense_model.dart';

class FilteredExpenseModel {
  String title;
  num bal;
  List<ExpenseModel> expenses;
  FilteredExpenseModel({
    required this.title,
    required this.bal,
    required this.expenses,
  });

  factory FilteredExpenseModel.fromMap(Map<String, dynamic> map) {
    return FilteredExpenseModel(
      title: map["title"],
      bal: map["bal"],
      expenses: map["expenses"],
    );
  }

  Map<String, dynamic> toMap() {
    return {"title": title, "bal": bal, "expenses": expenses};
  }
}
