import 'package:expense_app/data/local/model/category_model.dart';
import 'package:expense_app/data/local/model/expense_model.dart';
import 'package:expense_app/ui/home/expense_bloc/expense_bloc.dart';
import 'package:expense_app/ui/home/expense_bloc/expense_event.dart';
import 'package:expense_app/ui/home/expense_bloc/expense_state.dart';
import 'package:expense_app/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddExpenseScreen extends StatelessWidget {
  AddExpenseScreen({super.key});

  final TextEditingController _title = TextEditingController();

  final TextEditingController _desc = TextEditingController();

  final TextEditingController _amount = TextEditingController();

  final List<String> typeList = ["Debit", "Credit"];

  final DateFormat dateFormat = DateFormat.yMMMEd();

  bool isAdding = false;

  @override
  Widget build(BuildContext context) {
    String selectedType = "Debit";
    DateTime? selectedDate;
    // int expenseType = 0;
    int selectedCatIndex = -1;
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 10),
            TextField(
              controller: _title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                labelText: "Title",
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                hintText: "Enter title",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _desc,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                hintText: "Enter description",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _amount,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                labelText: "Amount",
                labelStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                hintText: "Enter amount",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 20),
            // StatefulBuilder(
            //   builder: (context, ss) {
            //     return Row(
            //       children: [
            //         Text(
            //           "Type: ",
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 18,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //         RadioMenuButton(
            //           value: 0,
            //           groupValue: expenseType,
            //           onChanged: (value) {
            //             ss(() {
            //               expenseType = value!;
            //             });
            //           },
            //           child: Text("Credit"),
            //         ),
            //         RadioMenuButton(
            //           value: 1,
            //           groupValue: expenseType,
            //           onChanged: (value) {
            //             ss(() {
            //               expenseType = value!;
            //             });
            //           },
            //           child: Text("Debit"),
            //         ),
            //       ],
            //     );
            //   },
            // ),
            DropdownMenu(
              initialSelection: selectedType,
              width: MediaQuery.of(context).size.width - 40,
              onSelected: (value) {
                selectedType = value!;
              },
              textStyle: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              menuStyle: MenuStyle(
                alignment: Alignment.bottomLeft,

                minimumSize: WidgetStatePropertyAll(
                  Size(MediaQuery.of(context).size.width, 120),
                ),
                maximumSize: WidgetStatePropertyAll(
                  Size(MediaQuery.of(context).size.width, 120),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              dropdownMenuEntries:
                  typeList
                      .map((v) => DropdownMenuEntry(value: v, label: v))
                      .toList(),
            ),
            SizedBox(height: 20),
            StatefulBuilder(
              builder: (__, ss) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            dateFormat.format(selectedDate ?? DateTime.now()),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    FloatingActionButton(
                      elevation: 0,
                      backgroundColor: Colors.deepPurple,
                      child: Icon(Icons.calendar_month, color: Colors.white),
                      onPressed: () async {
                        selectedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now().subtract(
                            Duration(days: 730),
                          ),
                          lastDate: DateTime.now(),
                        );
                        ss(() {});
                      },
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
            StatefulBuilder(
              builder: (_, ss) {
                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Padding(
                          padding: EdgeInsets.all(20),
                          child: GridView.builder(
                            itemCount: AppConstants.categories.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                ),
                            itemBuilder: (_, index) {
                              CategoryModel category =
                                  AppConstants.categories[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  ss(() {
                                    selectedCatIndex = category.catId;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      category.catImg,
                                      height: 50,
                                      width: 50,
                                    ),
                                    SizedBox(height: 10),
                                    Text(category.catName),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:
                          selectedCatIndex >= 0
                              ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppConstants
                                        .categories[selectedCatIndex]
                                        .catImg,
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    AppConstants
                                        .categories[selectedCatIndex]
                                        .catName,
                                  ),
                                ],
                              )
                              : Text(
                                "Select Category",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            BlocConsumer<ExpenseBloc, ExpenseState>(
              listener: (context, state) {
                if (state is ExpenseInitialState) {
                  isAdding = false;
                } else if (state is ExpenseAddingState) {
                  isAdding = true;
                } else if (state is ExpenseAddedState) {
                  isAdding = false;
                  context.read<ExpenseBloc>().add(
                    ExpenseFetchEvent(filter: "Daily"),
                  );
                  Navigator.pop(context);
                } else if (state is ExpenseAddFailedState) {
                  isAdding = false;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errMsg)));
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () async {
                    if (_title.text.trim().isNotEmpty &&
                        _desc.text.trim().isNotEmpty &&
                        _amount.text.trim().isNotEmpty) {
                      if (selectedCatIndex >= 0) {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        int userId =
                            (pref.getInt(AppConstants.prefUserIdKey)) ?? -1;
                        String createdAt =
                            (selectedDate ?? DateTime.now())
                                .millisecondsSinceEpoch
                                .toString();
                        ExpenseModel expense = ExpenseModel(
                          userId: userId,
                          title: _title.text.trim(),
                          desc: _desc.text.trim(),
                          amt: _amount.text.trim(),
                          bal: "0",
                          catId:
                              AppConstants.categories[selectedCatIndex].catId,
                          createdAt: createdAt,
                          type: selectedType == "Debit" ? 1 : 0,
                        );
                        context.read<ExpenseBloc>().add(
                          ExpenseAddEvent(expense: expense),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please select the Category!"),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please fill all the fields!")),
                      );
                    }
                  },
                  child:
                      isAdding
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(color: Colors.white),
                              SizedBox(width: 5),
                              Text("Adding..."),
                            ],
                          )
                          : Text("Add"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
