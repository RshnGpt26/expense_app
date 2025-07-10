import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../../utils/app_constants.dart';
import '../model/expense_model.dart';
import '../model/user_model.dart';

class DBHelper {
  DBHelper._();

  static DBHelper getInstance() => DBHelper._();

  Database? mDB;

  // User Table
  static const String tableUser = "table_user";
  static const String columnUserID = "u_id";
  static const String columnUserName = "u_name";
  static const String columnUserEmail = "u_email";
  static const String columnUserMobNo = "u_mob_no";
  static const String columnUserPassword = "u_password";

  // Expense table
  static const String tableExpense = "table_expense";
  static const String columnExpenseID = "e_id";
  static const String columnExpenseTitle = "e_title";
  static const String columnExpenseDesc = "e_desc";
  static const String columnExpenseAmount = "e_amount";
  static const String columnExpenseBalance = "e_balance";
  static const String columnExpenseCreatedAt = "e_created_at";
  static const String columnExpenseCatID = "e_cat_id";
  static const String columnExpenseType = "e_type"; // 1 => Debit && 2 => Credit

  Future<Database> initDB() async {
    mDB ??= await openDB();
    return mDB!;
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();

    String dbPath = join(appDir.path, "expenseDB.db");

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "create table $tableUser ( $columnUserID integer primary key, $columnUserEmail text, $columnUserName text, $columnUserMobNo text, $columnUserPassword text)",
        );
        db.execute(
          "create table $tableExpense ( $columnExpenseID integer primary key, $columnUserID integer, $columnExpenseTitle text, $columnExpenseDesc text, $columnExpenseAmount text, $columnExpenseBalance text, $columnExpenseCreatedAt text, $columnExpenseCatID integer, $columnExpenseType integer)",
        );
      },
    );
  }

  Future<bool> registerUser({required UserModel user}) async {
    var db = await initDB();
    int rowsAffected = await db.insert(tableUser, user.toMap());
    return rowsAffected > 0;
  }

  Future<bool> authenticateUser({
    required String email,
    required String password,
  }) async {
    var db = await initDB();
    List<Map<String, dynamic>> responseUsers = await db.query(
      tableUser,
      where: "$columnUserEmail = ? AND $columnUserPassword = ?",
      whereArgs: [email, password],
    );
    if (responseUsers.isNotEmpty) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setInt(
        AppConstants.prefUserIdKey,
        responseUsers[0][columnUserID] ?? 0,
      );
    }

    return responseUsers.isNotEmpty;
  }

  fetchUsers() async {
    var db = await initDB();
    List<Map<String, dynamic>> users = await db.query(tableUser);
    List<UserModel> mUsers = [];
    for (var user in users) {
      mUsers.add(UserModel.fromMap(user));
    }
  }

  Future<bool> checkIfEmailExist(String email) async {
    var db = await initDB();
    List<Map<String, dynamic>> users = await db.query(
      tableUser,
      where: "$columnUserEmail = ?",
      whereArgs: [email],
    );
    return users.isNotEmpty;
  }

  Future<bool> addExpense({required ExpenseModel expense}) async {
    var db = await initDB();

    int rowsAffected = await db.insert(tableExpense, expense.toMap());

    return rowsAffected > 0;
  }

  Future<List<Map<String, dynamic>>> fetchUsersExpenses({
    required int userId,
  }) async {
    var db = await initDB();

    List<Map<String, dynamic>> list = await db.query(
      tableExpense,
      where: "$columnUserID = ?",
      whereArgs: [userId],
    );

    return list;
  }
}
