import 'dart:async';

import 'package:flutter/material.dart';

import '../../utils/routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
    });
    return Scaffold(
      backgroundColor: Colors.purpleAccent.shade400,
      body: Center(
        child: Text(
          "Monety",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
