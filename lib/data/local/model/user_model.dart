import '../helper/db_helper.dart';

class UserModel {
  int? id;
  String name;
  String email;
  String mobNo;
  String pass;
  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.mobNo,
    required this.pass,
  });

  // Convert Map into Model
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[DBHelper.columnUserID],
      name: map[DBHelper.columnUserName],
      email: map[DBHelper.columnUserEmail],
      mobNo: map[DBHelper.columnUserMobNo],
      pass: map[DBHelper.columnUserPassword],
    );
  }

  // Convert Model into Map
  Map<String, dynamic> toMap() {
    return {
      DBHelper.columnUserName: name,
      DBHelper.columnUserEmail: email,
      DBHelper.columnUserMobNo: mobNo,
      DBHelper.columnUserPassword: pass,
    };
  }
}
