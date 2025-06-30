import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';
import '../../utils/routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateTo() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      int id = pref.getInt(AppConstants.prefUserIdKey) ?? 0;

      String navigateToName = AppRoutes.loginPage;

      if (id > 0) {
        navigateToName = AppRoutes.mainPage;
      }

      Navigator.pushReplacementNamed(context, navigateToName);
    }

    Timer(Duration(seconds: 4), () {
      navigateTo();
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
