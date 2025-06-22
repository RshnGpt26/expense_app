import 'package:flutter/material.dart';

import '../statistic/statistic_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _selectedIndex == 0
              ? HomeScreen()
              : _selectedIndex == 1
              ? StatisticScreen()
              : Center(
                child: Text(
                  "Screen not found!!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlue.shade100,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.blueGrey,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Statistic",
          ),
        ],
      ),
    );
  }
}
