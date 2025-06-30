import 'package:expense_app/data/local/helper/db_helper.dart';
import 'package:expense_app/data/local/repository/user_repository.dart';
import 'package:expense_app/ui/sign_up/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'utils/routes/app_routes.dart';

void main() {
  runApp(
    BlocProvider(
      create:
          (_) => UserBloc(
            userRepository: UserRepository(dbHelper: DBHelper.getInstance()),
          ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            minimumSize: Size(280, 50),
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
        ),
      ),
      initialRoute: AppRoutes.splashPage,
      routes: AppRoutes.routes,
    );
  }
}
