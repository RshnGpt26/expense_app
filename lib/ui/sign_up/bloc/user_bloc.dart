// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:expense_app/data/local/repository/user_repository.dart';
import 'package:expense_app/ui/sign_up/bloc/user_event.dart';
import 'package:expense_app/ui/sign_up/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitialState()) {
    on<SignupEvent>((event, emit) async {
      String msg = await userRepository.signUpUser(user: event.user);
      if (msg == "Registration Successful!!") {
        emit(UserSuccessState());
      } else {
        emit(UserFailureState(errorMsg: msg));
      }
    });
  }
}
