import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/routes/app_routes.dart';
import '../sign_up/bloc/user_bloc.dart';
import '../sign_up/bloc/user_event.dart';
import '../sign_up/bloc/user_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscurePassword = true;
  bool? isLoading;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isPasswordStrong(String password) {
    final strongPasswordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
    );

    return strongPasswordRegex.hasMatch(password);
  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login your Account",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 25),
            TextField(
              controller: _email,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                hintText: "Enter your email",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 15),
            TextField(
              controller: _password,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                hintText: "Enter your password",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
            // SizedBox(height: 20),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Forget Your Password ?",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            BlocConsumer<UserBloc, UserState>(
              listenWhen: (previous, current) {
                return isLoading != null;
              },
              buildWhen: (previous, current) {
                return isLoading != null;
              },
              listener: (context, state) {
                if (state is UserInitialState) {
                  isLoading = false;
                } else if (state is UserLoadingState) {
                  isLoading = true;
                } else if (state is UserSuccessState) {
                  isLoading = false;
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(AppRoutes.mainPage);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Login successfully!!")),
                  );
                } else if (state is UserFailureState) {
                  isLoading = false;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  child:
                      isLoading != null && isLoading!
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: Colors.white),
                              SizedBox(width: 20),
                              Text("Logging In..."),
                            ],
                          )
                          : Text("Login"),
                  onPressed: () {
                    String email = _email.text.trim();
                    String password = _password.text.trim();
                    isLoading = false;
                    context.read<UserBloc>().add(
                      LoginEvent(email: email, password: password),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an Account ? ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    isLoading = null;
                    Navigator.pushNamed(context, AppRoutes.registerPage);
                  },
                  child: Text(
                    "Register Now",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
