import 'package:azlistview/azlistview.dart';

class Food extends ISuspensionBean {
  final String name;
  final String imagePath;
  final String category;
  bool isSelected = false;

  Food(this.name, this.imagePath, this.category);

  @override
  String getSuspensionTag() => name[0].toUpperCase();
}

class FoodList {

  /* static void insertFoodItem(String name) {
    Food newItem = Food(name, 'assets/icons/logo/Logo_withoutTitle_alpha_small.png', 'All');
    all_items.add(newItem);
  } */

  static List<Food> all_items = [
    Food("Apple", 'assets/ingredients/Apple_Icon.png', 'Fruits'),
    //Food("Ananas", 'assets/ingredients/Apple_Icon.png', 'Fruits'),
    //Food("Ananas", 'assets/ingredients/Apple_Icon.png', 'Fruits'),
   // Food("Ananas", 'assets/ingredients/Apple_Icon.png', 'Fruits'),
    Food("Ananas", 'assets/ingredients/Apple_Icon.png', 'Fruits'),
    Food("Avocado", 'assets/ingredients/Apple_Icon.png', 'Vegetables'),
    Food("Aprikose", 'assets/ingredients/Apple_Icon.png', 'Fruits'),
    Food("Apfelsine", "assets/ingredients/Apple_Icon.png", 'Fruits'),
    Food("Banana", "assets/ingredients/Apple_Icon.png", 'Fruits'),
    Food("Cheese", "assets/ingredients/Apple_Icon.png", 'Proteins'),
    //Food("Cheese", "assets/ingredients/Apple_Icon.png", 'Proteins'),
    //Food("Cheese", "assets/ingredients/Apple_Icon.png", 'Proteins'),
   // Food("Cheese", "assets/ingredients/Apple_Icon.png", 'Proteins'),
    Food("Donut", "assets/ingredients/Apple_Icon.png", 'Baking Essentials'),
    Food("Eggplant", "assets/ingredients/Apple_Icon.png", 'Vegetables'),
    //Food("Eggplant", "assets/ingredients/Apple_Icon.png", 'Vegetables'),
    //Food("Eggplant", "assets/ingredients/Apple_Icon.png", 'Vegetables'),
    //Food("Eggplant", "assets/ingredients/Apple_Icon.png", 'Vegetables'),
    Food("Fries", "assets/ingredients/Apple_Icon.png", 'Grilling and BBQ'),
    Food("Grapes", "assets/ingredients/Apple_Icon.png", 'Fruits'),
    Food("Hamburger", "assets/ingredients/Apple_Icon.png", 'Grilling and BBQ'),
    Food("Ice Cream", "assets/ingredients/Apple_Icon.png", 'Frozen Foods'),
    Food("Jelly", "assets/ingredients/Apple_Icon.png",
        'Canned and Jarred Goods'),
   /* Food("Jelly", "assets/ingredients/Apple_Icon.png",
        'Canned and Jarred Goods'),
    Food("Jelly", "assets/ingredients/Apple_Icon.png",
        'Canned and Jarred Goods'),*/
    Food("Kiwi", "assets/ingredients/Apple_Icon.png", 'Fruits'),
    Food("Lemon", "assets/ingredients/Apple_Icon.png", 'Fruits'),
    Food("Mango", "assets/ingredients/Apple_Icon.png", 'Fruits'),
    Food("Noodles", "assets/ingredients/Apple_Icon.png", 'Herbs and Spices'),
    Food("Orange", "assets/ingredients/Apple_Icon.png", 'Fruits'),
   // Food("Orange", "assets/ingredients/Apple_Icon.png", 'Fruits'),
  //  Food("Orange", "assets/ingredients/Apple_Icon.png", 'Fruits'),
   // Food("Orange", "assets/ingredients/Apple_Icon.png", 'Fruits'),
    //Food("Other", "assets/ingredients/Apple_Icon.png", 'All'),
    Food("Pizza", "assets/ingredients/Apple_Icon.png", 'Baking Essentials'),
    Food("Quiche", "assets/ingredients/Apple_Icon.png", 'Baking Essentials'),
    Food("Rice", "assets/ingredients/Apple_Icon.png", 'Diary and Alternatives'),
    Food("Strawberry", "assets/ingredients/Apple_Icon.png", 'Fruits'),
    Food("Tomato", "assets/ingredients/Apple_Icon.png", 'Vegetables'),
    //Food("Tomato", "assets/ingredients/Apple_Icon.png", 'Vegetables'),
    //Food("Tomato", "assets/ingredients/Apple_Icon.png", 'Vegetables'),
    //Food("Tomato", "assets/ingredients/Apple_Icon.png", 'Vegetables'),
    //Food("Tomato", "assets/ingredients/Apple_Icon.png", 'Vegetables'),
    Food("Toast", "assets/ingredients/Apple_Icon.png", 'Baking Essentials'),
    //Food("Tomato", "assets/ingredients/Apple_Icon.png", 'Vegetables'),
    //Food("Tomato", "assets/ingredients/Apple_Icon.png", 'Vegetables'),
   // Food("Tomato", "assets/ingredients/Apple_Icon.png", 'Vegetables'),
    Food("Tomato", "assets/ingredients/Apple_Icon.png", 'Vegetables'),
    Food("Udon", "assets/ingredients/Apple_Icon.png", 'Herbs and Spices'),
    Food("Vanilla", "assets/ingredients/Apple_Icon.png", 'Herbs and Spices'),
    Food("Watermelon", "assets/ingredients/Apple_Icon.png", 'Fruits'),
    Food("Xacuti", "assets/ingredients/Apple_Icon.png", 'Proteins'),
    Food("Yogurt", "assets/ingredients/Apple_Icon.png", 'Proteins'),
   // Food("Zucchini", "assets/ingredients/Apple_Icon.png", 'Vegetables'),
   // Food("Zucchini", "assets/ingredients/Apple_Icon.png", 'Vegetables'),
  //  Food("Zucchini", "assets/ingredients/Apple_Icon.png", 'Vegetables'),
    Food("Zucchini", "assets/ingredients/Apple_Icon.png", 'Vegetables'),
  ];
}
