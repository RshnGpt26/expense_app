import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/expense_bloc/expense_bloc.dart';
import '../home/expense_bloc/expense_event.dart';
import '../home/expense_bloc/expense_state.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  final List<Map<String, dynamic>> expenseList = [
    {"type": "shop", "title": "Shop", "expense": 1190},
    {"type": "transportation", "title": "Transportation", "expense": 867},
    {"type": "electronic", "title": "Electronic", "expense": 867},
  ];

  // final List<FilteredExpenseModel> allExp = [
  //   FilteredExpenseModel(title: "Grocery", bal: 1000, expenses: []),
  //   FilteredExpenseModel(title: "Petrol", bal: 7000, expenses: []),
  //   FilteredExpenseModel(title: "Shopping", bal: 10000, expenses: []),
  //   FilteredExpenseModel(title: "Recharge", bal: 2400, expenses: []),
  //   FilteredExpenseModel(title: "Coffee", bal: 2700, expenses: []),
  //   FilteredExpenseModel(title: "Restaurant", bal: 7700, expenses: []),
  // ];

  bool isLoading = false;
  String selectedFilter = "Daily";
  List<String> filters = ["Daily", "Monthly", "Yearly", "Category Wise"];

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(ExpenseFetchEvent(filter: selectedFilter));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Statistic",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: Icon(Icons.keyboard_arrow_down),
                        value: "This Month",
                        items:
                            ["This Month"]
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 25,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Expense total",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "\$3,734",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "/ \$4000 per month",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  LinearProgressIndicator(
                                    value: 0.7,
                                    backgroundColor: Colors.white24,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.amberAccent.shade100,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white24,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.more_horiz,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Expense Breakdown",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: Icon(Icons.keyboard_arrow_down),
                                value: selectedFilter,
                                items:
                                    filters
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedFilter = value!;
                                  });
                                  context.read<ExpenseBloc>().add(
                                    ExpenseFetchEvent(filter: selectedFilter),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Limit \$900 / week",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        child: BlocBuilder<ExpenseBloc, ExpenseState>(
                          builder: (context, state) {
                            if (state is ExpenseLoadingState) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (state is ExpenseLoadedState) {
                              if (state.expenses.isEmpty) {
                                return Center(
                                  child: Text("Expenses not added Yet!!"),
                                );
                              }
                              List<BarChartGroupData> mBar = [];

                              for (int i = 0; i < state.expenses.length; i++) {
                                mBar.add(
                                  BarChartGroupData(
                                    x: i,
                                    barRods: [
                                      _barUI(
                                        toY: state.expenses[i].bal.toDouble(),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return BarChart(
                                BarChartData(
                                  titlesData: FlTitlesData(
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) {
                                          return Text(
                                            state.expenses[value.toInt()].title,
                                            style: TextStyle(fontSize: 9),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  barGroups: mBar,
                                  maxY: 1000,
                                  baselineY: 500,
                                  minY: -9500,
                                ),
                              );
                            }
                            return Center(child: Text("Expenses not Found!!"));
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Spending Details",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Your expenses are divided into 6 categories",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 20),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: expenseList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 25 / 11,
                        ),
                        itemBuilder: (_, index) {
                          Map<String, dynamic> expenseDetails =
                              expenseList[index];
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:
                                        expenseDetails["type"] == "shop"
                                            ? Colors.deepPurple.shade200
                                            : expenseDetails["type"] ==
                                                "electronic"
                                            ? Colors.orange.shade200
                                            : expenseDetails["type"] ==
                                                "transportation"
                                            ? Colors.red.shade200
                                            : null,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      expenseDetails["type"] == "shop"
                                          ? Icons.shopping_cart
                                          : expenseDetails["type"] ==
                                              "electronic"
                                          ? Icons.phone_android
                                          : expenseDetails["type"] ==
                                              "transportation"
                                          ? Icons.car_rental
                                          : null,
                                      color:
                                          expenseDetails["type"] == "shop"
                                              ? Colors.deepPurple
                                              : expenseDetails["type"] ==
                                                  "electronic"
                                              ? Colors.orange
                                              : expenseDetails["type"] ==
                                                  "transportation"
                                              ? Colors.red
                                              : null,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        expenseDetails["title"] ?? "",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "-\$${expenseDetails["expense"] ?? "0"}",
                                        style: TextStyle(
                                          color: Colors.pink,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartRodData _barUI({required double toY}) {
    return BarChartRodData(
      toY: toY,
      color: Colors.blue,
      width: 35,
      borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
    );
  }
}
