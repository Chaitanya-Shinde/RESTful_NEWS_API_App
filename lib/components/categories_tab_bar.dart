import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_app/providers/categories_provider.dart';

class CategoriesTabBar extends StatefulWidget {
  const CategoriesTabBar({super.key});

  @override
  State<CategoriesTabBar> createState() => _CategoriesTabBarState();
}

class _CategoriesTabBarState extends State<CategoriesTabBar> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Consumer<CategoryProvider>(
      builder: (context, categoryProviderModel, child) => SizedBox(
        width: width,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.06,
              width: width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryProviderModel.categoryList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      String selectedCategory =
                          categoryProviderModel.categoryList[index];
                      categoryProviderModel.selectCategory(selectedCategory);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      width: width * 0.25,
                      height: height * 0.03,
                      decoration: const BoxDecoration(color: Colors.white),
                      alignment: Alignment.center,
                      child: Text(
                        categoryProviderModel.categoryList[index],
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
