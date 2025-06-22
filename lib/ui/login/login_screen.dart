import 'package:flutter/material.dart';

import '../../utils/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscurePassword = true;
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
            ElevatedButton(
              child: Text("Login"),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.mainPage);
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
