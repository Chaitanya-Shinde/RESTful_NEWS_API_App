import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_app/providers/view_article_provider.dart';
import 'package:rest_api_app/view/web_view_screen.dart';

class ViewArticle extends StatefulWidget {
  const ViewArticle({
    super.key,
  });

  @override
  State<ViewArticle> createState() => _ViewArticleState();
}

class _ViewArticleState extends State<ViewArticle> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final viewArticleProvider = Provider.of<ViewArticleProvider>(context);
    final selectedArticle = viewArticleProvider.selectedArticle;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text(
          "view article page",
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          color: Color.fromRGBO(240, 236, 229, 100),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  //text container
                  width: width * 0.98,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                  ),
                  child: Text(
                    selectedArticle.title.toString(),
                    style: const TextStyle(
                      height: 1.2,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color.fromRGBO(22, 26, 48, 1),
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                //container containing image and card widget
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.01,
                  vertical: height * 0.004,
                ),
                height: height * 0.3,
                width: width,
                child: CachedNetworkImage(
                  imageUrl: selectedArticle.urlToImage.toString(),
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    child: mySpinKit,
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              SingleChildScrollView(
                child: Container(
                  //text container
                  width: width * 0.98,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                  ),
                  child: Text(
                    selectedArticle.content
                        .toString()
                        .substring(0, selectedArticle.content!.length - 12),
                    style: const TextStyle(
                      height: 1.2,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(22, 26, 48, 1),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const WebViewScreen(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(height * 0.01),
                  width: width * 0.9,
                  height: height * 0.05,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Color.fromRGBO(22, 26, 48, 1),
                  ),
                  child: const Text(
                    "Click here to read entire article",
                    style: TextStyle(
                      height: 1.2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

const mySpinKit = SpinKitFadingCircle(
  //spinning loading image
  color: Colors.grey,
  size: 50,
);
