import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/local/repository/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitialState()) {
    on<SignupEvent>((event, emit) async {
      emit(UserLoadingState());
      String msg = await userRepository.signUpUser(user: event.user);
      if (msg == "Registration Successful!!") {
        emit(UserSuccessState());
      } else {
        emit(UserFailureState(errorMsg: msg));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(UserLoadingState());
      int status = await userRepository.authenticateUser(
        email: event.email,
        password: event.password,
      );
      if (status == 1) {
        emit(UserSuccessState());
      } else if (status == 2) {
        emit(UserFailureState(errorMsg: "User not found. Please Register!!"));
      } else {
        emit(UserFailureState(errorMsg: "Incorrect Password!!"));
      }
    });
  }
}
