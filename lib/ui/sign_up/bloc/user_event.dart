import '../../../data/local/model/user_model.dart';

abstract class UserEvent {}

class SignupEvent extends UserEvent {
  UserModel user;
  SignupEvent({required this.user});
}

class LoginEvent extends UserEvent {
  String email;
  String password;
  LoginEvent({required this.email, required this.password});
}
