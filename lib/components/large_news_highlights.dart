import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_app/ViewModels/news_view_model.dart';
import 'package:rest_api_app/models/article.dart';
import 'package:rest_api_app/providers/categories_provider.dart';
import 'package:rest_api_app/view/view_article_screen.dart';

import '../providers/view_article_provider.dart';

class LargeNewsHighlights extends StatefulWidget {
  const LargeNewsHighlights({
    super.key,
  });

  @override
  State<LargeNewsHighlights> createState() => _LargeNewsHighlightsState();
}

class _LargeNewsHighlightsState extends State<LargeNewsHighlights> {
  NewsViewModel newsViewModel = NewsViewModel();
  late List<Articles> topSevenHighlights = [];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final viewArticleProvider = Provider.of<ViewArticleProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Column(
      children: [
        Container(
          height: height * 0.3,
          width: width,
          color: Colors.white,
          child: FutureBuilder<ArticleModel>(
            future: newsViewModel
                .fetchCategoryHeadlines(categoryProvider.currentCategory),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitCircle(
                    color: Colors.red,
                    size: 40,
                  ),
                );
              } else {
                String? titleString;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    final article = snapshot.data!.articles![index];
                    // Check if any essential field is null, and exclude such articles
                    if (article.title == null ||
                        article.source == null ||
                        article.source!.name == null ||
                        article.author == null ||
                        article.description == null ||
                        article.content == null ||
                        article.url == null) {
                      return Container(); // Skip rendering for articles with missing values
                    }

                    final imageUrl =
                        snapshot.data!.articles![index].urlToImage?.toString();
                    if (imageUrl != null && imageUrl.isNotEmpty) {
                      titleString = snapshot.data!.articles![index].title;
                      return GestureDetector(
                        onTap: () {
                          viewArticleProvider.viewArticle(article);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ViewArticle(),
                            ),
                          );
                        },
                        child: SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                //container containing image and card widget
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.01,
                                ),
                                height: height * 0.4,
                                width: width,
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    child: mySpinKit,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Positioned(
                                //card widget
                                bottom: width * 0.0,
                                child: Card(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          //text container
                                          color: Colors.black12,
                                          width: width * 0.98,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.02,
                                          ),
                                          child: Text(
                                            titleString!.toString(),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                height: 1.4,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white,
                                                shadows: [
                                                  Shadow(
                                                      color: Colors.black,
                                                      offset: Offset(-0.1, 2),
                                                      blurRadius: 2)
                                                ]),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      debugPrint('Image URL is null or empty at index $index');
                      return Container();
                    }
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

const mySpinKit = SpinKitFadingCircle(
  color: Colors.grey,
  size: 50,
);
