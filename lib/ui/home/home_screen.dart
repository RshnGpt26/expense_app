import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Map<String, dynamic>> expenseList = [
    {
      "date_time": "Tuesday, 14",
      "expense": 1380,
      "list": [
        {
          "type": "shop",
          "title": "Shop",
          "subtitle": "Buy new clothes",
          "expense": 90,
        },
        {
          "type": "electronic",
          "title": "Electronic",
          "subtitle": "Buy new iPhone 14",
          "expense": 1290,
        },
      ],
    },
    {
      "date_time": "Monday, 13",
      "expense": 60,
      "list": [
        {
          "type": "transportation",
          "title": "Transportation",
          "subtitle": "Trip to malang",
          "expense": 60,
        },
      ],
    },
  ];

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
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                    color: Colors.black,
                    iconSize: 28,
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
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          Map<String, dynamic> expense = expenseList[index];
                          return Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        expense["date_time"] ?? "",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "-\$${expense["expense"] ?? "0"}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(height: 20),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (_, index) {
                                    Map<String, dynamic> expenseDetails =
                                        (expense["list"] as List)[index];
                                    return ListTile(
                                      leading: Container(
                                        height: 45,
                                        width: 45,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
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
                                      title: Text(
                                        expenseDetails["title"] ?? "",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Text(
                                        expenseDetails["subtitle"] ?? "",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      trailing: Text(
                                        "-\$${expenseDetails["expense"] ?? "0"}",
                                        style: TextStyle(
                                          color: Colors.pink,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(0),
                                    );
                                  },
                                  separatorBuilder:
                                      (_, __) => SizedBox(height: 0),
                                  itemCount: (expense["list"] as List).length,
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => SizedBox(height: 15),
                        itemCount: expenseList.length,
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
