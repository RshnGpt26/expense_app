import 'package:expense_app/data/local/model/expense_model.dart';
import 'package:expense_app/ui/home/expense_bloc/expense_bloc.dart';
import 'package:expense_app/ui/home/expense_bloc/expense_event.dart';
import 'package:expense_app/ui/home/expense_bloc/expense_state.dart';
import 'package:expense_app/utils/app_constants.dart';
import 'package:expense_app/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local/model/filtered_expense_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final List<Map<String, dynamic>> expenseList = [
  //   {
  //     "date_time": "Tuesday, 14",
  //     "expense": 1380,
  //     "list": [
  //       {
  //         "type": "shop",
  //         "title": "Shop",
  //         "subtitle": "Buy new clothes",
  //         "expense": 90,
  //       },
  //       {
  //         "type": "electronic",
  //         "title": "Electronic",
  //         "subtitle": "Buy new iPhone 14",
  //         "expense": 1290,
  //       },
  //     ],
  //   },
  //   {
  //     "date_time": "Monday, 13",
  //     "expense": 60,
  //     "list": [
  //       {
  //         "type": "transportation",
  //         "title": "Transportation",
  //         "subtitle": "Trip to malang",
  //         "expense": 60,
  //       },
  //     ],
  //   },
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
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Monety",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                        color: Colors.black,
                        iconSize: 28,
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder:
                                (_) => Container(
                                  height: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Logout",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "Are you sure. Do you want to logout?",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                              ),
                                              onPressed: () async {
                                                SharedPreferences prefs =
                                                    await SharedPreferences.getInstance();
                                                bool status = await prefs
                                                    .setInt(
                                                      AppConstants
                                                          .prefUserIdKey,
                                                      0,
                                                    );
                                                if (status) {
                                                  Navigator.pop(context);
                                                  Navigator.of(
                                                    context,
                                                  ).pushReplacementNamed(
                                                    AppRoutes.loginPage,
                                                  );
                                                }
                                              },
                                              child: Text("YES"),
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("NO"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                          );
                        },
                        icon: Icon(Icons.logout),
                        color: Colors.black,
                        iconSize: 28,
                      ),
                    ],
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
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                              "assets/images/profile.png",
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Morning",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "Roshan Gupta",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
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
                      SizedBox(height: 25),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
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
                                SizedBox(height: 10),
                                Text(
                                  "\$3,734",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      child: Text(
                                        "+\$240",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "than last month",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: -30,
                            child: Image.asset(
                              "assets/images/graph.png",
                              height: 180,
                              width: 180,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Expense List",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20),

                      BlocBuilder<ExpenseBloc, ExpenseState>(
                        // listener: (context, state) {
                        //   if (state is ExpenseInitialState) {
                        //     isLoading = false;
                        //   } else if (state is ExpenseLoadingState) {
                        //     isLoading = true;
                        //   } else if (state is ExpenseLoadedState) {
                        //     isLoading = false;
                        //     state.expenses;
                        //   }
                        // },
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
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (_, index) {
                                FilteredExpenseModel filteredExpense =
                                    state.expenses[index];
                                return Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              filteredExpense.title,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "\$${filteredExpense.bal}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(height: 20),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            filteredExpense.expenses.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          ExpenseModel expenseDetails =
                                              filteredExpense.expenses[index];
                                          return ListTile(
                                            leading: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                // color:
                                                //     expenseDetails["type"] ==
                                                //             "shop"
                                                //         ? Colors
                                                //             .deepPurple
                                                //             .shade200
                                                //         : expenseDetails["type"] ==
                                                //             "electronic"
                                                //         ? Colors.orange.shade200
                                                //         : expenseDetails["type"] ==
                                                //             "transportation"
                                                //         ? Colors.red.shade200
                                                //         : null,
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  AppConstants.categories
                                                      .where(
                                                        (cat) =>
                                                            expenseDetails
                                                                .catId ==
                                                            cat.catId,
                                                      )
                                                      .toList()[0]
                                                      .catImg,

                                                  // color:
                                                  //     expenseDetails["type"] ==
                                                  //             "shop"
                                                  //         ? Colors.deepPurple
                                                  //         : expenseDetails["type"] ==
                                                  //             "electronic"
                                                  //         ? Colors.orange
                                                  //         : expenseDetails["type"] ==
                                                  //             "transportation"
                                                  //         ? Colors.red
                                                  //         : null,
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              expenseDetails.title,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            subtitle: Text(
                                              expenseDetails.desc,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            trailing: Text(
                                              "\$${expenseDetails.amt}",
                                              style: TextStyle(
                                                color:
                                                    expenseDetails.type == 0
                                                        ? Colors.green
                                                        : Colors.pink,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.all(0),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (_, __) => SizedBox(height: 20),
                              itemCount: state.expenses.length,
                            );
                          }
                          return Center(child: Text("Expenses not Found!!"));
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
}
