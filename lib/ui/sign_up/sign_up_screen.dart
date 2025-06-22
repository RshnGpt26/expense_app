import 'package:expense_app/data/local/model/user_model.dart';
import 'package:expense_app/ui/sign_up/bloc/user_bloc.dart';
import 'package:expense_app/ui/sign_up/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobNo = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
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
              controller: _name,
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                hintText: "Enter your name",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 15),
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
              controller: _mobNo,
              decoration: InputDecoration(
                prefixText: "+91",
                prefixStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                labelText: "Mobile No.",
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                hintText: "Enter your mobile number",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                counterText: "",
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10,
            ),
            SizedBox(height: 15),
            TextField(
              controller: _pass,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                hintText: "Enter password",
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
                    !obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _confPass,
              obscureText: obscureConfirmPassword,
              decoration: InputDecoration(
                labelText: "Confirm Password",
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                hintText: "Re-enter password",
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
                    !obscureConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    });
                  },
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Register"),
              onPressed: () {
                if (_name.text.isNotEmpty &&
                    _email.text.isNotEmpty &&
                    _mobNo.text.isNotEmpty &&
                    _pass.text.isNotEmpty &&
                    _confPass.text.isNotEmpty) {
                  if (_pass.text == _confPass.text) {
                    UserModel user = UserModel(
                      name: _name.text,
                      email: _email.text,
                      mobNo: _mobNo.text,
                      pass: _pass.text,
                    );
                    context.read<UserBloc>().add(SignupEvent(user: user));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Passwords does not match!!")),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please enter values in all fields!!"),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an Account ? ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Login Now",
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
