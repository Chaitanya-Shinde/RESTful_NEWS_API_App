import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rest_api_app/components/categories_tab_bar.dart';
import 'package:rest_api_app/components/large_news_highlights.dart';
import 'package:rest_api_app/components/small_news_highlights.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text(
          "home page",
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey[300],
              child: Column(
                children: [
                  const CategoriesTabBar(),
                  const LargeNewsHighlights(),
                  SizedBox(
                    height: height * 0.04,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  const SmallNewsHighlights(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const mySpinKit = SpinKitFadingCircle(
  color: Colors.grey,
  size: 50,
);
