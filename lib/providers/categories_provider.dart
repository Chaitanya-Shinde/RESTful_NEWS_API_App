import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  List<String> categoryList = [
    "General",
    "Business",
    "Sports",
    "Health",
    "Science"
  ];
  String currentCategory = "general"; //default value

  void selectCategory(String selectedCategory) {
    if (currentCategory == selectedCategory) {
      return;
    } else {
      currentCategory = selectedCategory;
      debugPrint("Selected Category is: " + currentCategory);
      notifyListeners();
    }
  }
}
