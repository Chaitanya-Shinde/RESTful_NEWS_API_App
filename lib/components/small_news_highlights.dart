import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_app/ViewModels/news_view_model.dart';
import 'package:rest_api_app/models/article.dart';
import 'package:rest_api_app/providers/categories_provider.dart';
import 'package:rest_api_app/providers/view_article_provider.dart';
import 'package:rest_api_app/view/view_article_screen.dart';

class SmallNewsHighlights extends StatefulWidget {
  const SmallNewsHighlights({super.key});

  @override
  State<SmallNewsHighlights> createState() => _SmallNewsHighlightsState();
}

class _SmallNewsHighlightsState extends State<SmallNewsHighlights> {
  NewsViewModel newsViewModel = NewsViewModel();
  late List<Articles> validArticles;
  late Articles selectedArticle;
  String? imageUrl = "";
  late String? titleString;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final viewArticleProvider = Provider.of<ViewArticleProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Container(
      child: FutureBuilder(
        future: newsViewModel
            .fetchCategoryHeadlines(categoryProvider.currentCategory),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              alignment: Alignment.center,
              height: height * 0.4,
              width: width,
              color: Colors.white,
              child: const Center(
                child: SpinKitCircle(
                  color: Colors.red,
                  size: 40,
                ),
              ),
            );
          } else {
            if (snapshot.hasData &&
                snapshot.data!.articles != null &&
                snapshot.data!.articles!.isNotEmpty) {
              // Filter out articles with null properties
              validArticles = snapshot.data!.articles!
                  .where((article) =>
                      article.title != null &&
                      article.source != null &&
                      article.source!.name != null &&
                      article.author != null &&
                      article.description != null &&
                      article.content != null &&
                      article.url != null &&
                      article.urlToImage != null)
                  .toList();

              if (validArticles.isNotEmpty) {
                // Select a random article
                Articles randomArticle =
                    validArticles[Random().nextInt(validArticles.length)];
                selectedArticle =
                    randomArticle; //assign random article to global variable
                titleString = randomArticle.title
                    .toString(); //assign title to global variable
                imageUrl = randomArticle
                    .urlToImage; //assign img url to global variable
              } else {
                // Handle the case where there are no valid articles
                return const Text('No valid articles found.');
              }
            }
            if (imageUrl != null) {
              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      viewArticleProvider.viewArticle(selectedArticle);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ViewArticle(),
                        ),
                      );
                    },
                    child: Container(
                      //small_news_highlights displays only 1 news
                      alignment: Alignment.center,
                      height: height * 0.4,
                      width: width * 0.5,

                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: height,
                            width: width,
                            child: CachedNetworkImage(
                              imageUrl: imageUrl.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  selectedArticle.title!.toString(),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      height: 1.4,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black,
                                            offset: Offset(-0.1, 2),
                                            blurRadius: 2)
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      //small news highlights text only, displays a column of text only news
                      alignment: Alignment.center,
                      color: const Color.fromRGBO(240, 236, 229, 100),
                      width: width * 0.5,
                      height: height * 0.4,
                      child: Container(
                        child: ListView(
                          children: validArticles.take(3).map((value) {
                            return Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  color:
                                      const Color.fromRGBO(240, 236, 229, 100),
                                  width: width,
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(
                                      left: width * 0.02,
                                      right: width * 0.02,
                                      top: width * 0.009,
                                      bottom: width * 0.02,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        viewArticleProvider.viewArticle(value);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ViewArticle(),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            value.source!.name.toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                height: 1),
                                          ),
                                          Text(
                                            value.title!,
                                            maxLines: 3,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  color: Color.fromRGBO(22, 26, 48, 100),
                                  thickness: 2,
                                  indent: 10,
                                  endIndent: 10,
                                )
                              ],
                            );
                          }).toList(),
                        ),
                      ))
                ],
              );
            } else {
              debugPrint('Image URL is null or empty');
              return Container();
            }
          }
        },
      ),
    );
  }
}
