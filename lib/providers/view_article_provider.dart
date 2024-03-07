import 'package:flutter/material.dart';
import 'package:rest_api_app/models/article.dart';

class ViewArticleProvider extends ChangeNotifier {
  Articles selectedArticle = Articles(
      //initializing a default article
      source: Source(id: "1", name: "name"),
      author: '',
      title: '',
      description: '',
      url: '',
      urlToImage: '',
      publishedAt: '',
      content: ''); //default article

  void viewArticle(Articles article) {
    //function which sets the selected article to the article provided in the params
    if (selectedArticle == article) {
      return;
    } else {
      selectedArticle = article;
      debugPrint("Selected Category is: " + selectedArticle.title.toString());
    }
  }
}
