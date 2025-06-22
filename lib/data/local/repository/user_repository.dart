import 'package:expense_app/data/local/helper/db_helper.dart';

import '../model/user_model.dart';

class UserRepository {
  DBHelper dbHelper;
  UserRepository({required this.dbHelper});

  Future<String> signUpUser({required UserModel user}) async {
    if (!await dbHelper.checkIfEmailExist(user.email)) {
      return "User already Exist!!";
    }
    bool check = await dbHelper.registerUser(user: user);
    return check ? "Registration Successful!!" : "Registration Failed!!";
  }
}
