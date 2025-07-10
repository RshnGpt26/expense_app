import '../helper/db_helper.dart';
import '../model/user_model.dart';

class UserRepository {
  DBHelper dbHelper;
  UserRepository({required this.dbHelper});

  Future<String> signUpUser({required UserModel user}) async {
    if (await dbHelper.checkIfEmailExist(user.email)) {
      return "User already Exist!!";
    }
    bool check = await dbHelper.registerUser(user: user);
    return check ? "Registration Successful!!" : "Registration Failed!!";
  }

  Future<int> authenticateUser({
    required String email,
    required String password,
  }) async {
    if (await dbHelper.checkIfEmailExist(email)) {
      if (await dbHelper.authenticateUser(email: email, password: password)) {
        return 1;
      }
      return 3;
    }
    return 2;
  }
}
