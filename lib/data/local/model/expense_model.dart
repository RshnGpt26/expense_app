import '../helper/db_helper.dart';

class ExpenseModel {
  int? id;
  int userId;
  String title;
  String desc;
  String amt;
  String bal;
  int catId;
  String createdAt;
  int type;

  ExpenseModel({
    this.id,
    required this.userId,
    required this.title,
    required this.desc,
    required this.amt,
    required this.bal,
    required this.catId,
    required this.createdAt,
    required this.type,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map[DBHelper.columnExpenseID],
      userId: map[DBHelper.columnUserID],
      title: map[DBHelper.columnExpenseTitle],
      desc: map[DBHelper.columnExpenseDesc],
      amt: map[DBHelper.columnExpenseAmount],
      bal: map[DBHelper.columnExpenseBalance],
      catId: map[DBHelper.columnExpenseCatID],
      createdAt: map[DBHelper.columnExpenseCreatedAt],
      type: map[DBHelper.columnExpenseType],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DBHelper.columnUserID: userId,
      DBHelper.columnExpenseTitle: title,
      DBHelper.columnExpenseDesc: desc,
      DBHelper.columnExpenseAmount: amt,
      DBHelper.columnExpenseBalance: bal,
      DBHelper.columnExpenseCatID: catId,
      DBHelper.columnExpenseCreatedAt: createdAt,
      DBHelper.columnExpenseType: type,
    };
  }
}
