import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_app/consts.dart';
import 'package:rest_api_app/models/article.dart';

class NewsRepository {
  //future function to fetch news belonging to a required category as passed in the params
  Future<ArticleModel> fetchCategoryHeadlines(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=${category}&apiKey=${Consts.apiKey}";
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      //print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return ArticleModel.fromJson(body);
    }
    throw Exception("Error");
  }
}
