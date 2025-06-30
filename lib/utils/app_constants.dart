import 'package:expense_app/data/local/model/category_model.dart';

class AppConstants {
  static const String prefUserIdKey = "uid";

  static List<CategoryModel> categories = [
    CategoryModel(
      catId: 0,
      catName: "Coffee",
      catImg: "assets/icons/coffee.png",
    ),
    CategoryModel(
      catId: 1,
      catName: "Fast Food",
      catImg: "assets/icons/fast-food.png",
    ),
    CategoryModel(
      catId: 2,
      catName: "Recharge",
      catImg: "assets/icons/smartphone.png",
    ),
    CategoryModel(
      catId: 3,
      catName: "Snacks",
      catImg: "assets/icons/snack.png",
    ),
    CategoryModel(
      catId: 4,
      catName: "Travel",
      catImg: "assets/icons/travel.png",
    ),
    CategoryModel(
      catId: 5,
      catName: "Petrol",
      catImg: "assets/icons/vehicles.png",
    ),
    CategoryModel(
      catId: 6,
      catName: "Groceries",
      catImg: "assets/icons/shopping-bag.png",
    ),
  ];
}
