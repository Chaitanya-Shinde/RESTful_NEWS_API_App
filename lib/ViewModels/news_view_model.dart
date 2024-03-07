import 'package:rest_api_app/models/NewsRepository/news_repository.dart';
import 'package:rest_api_app/models/article.dart';

class NewsViewModel {
  //fetch news from news_repository model
  final _resp = NewsRepository();
  Future<ArticleModel> fetchCategoryHeadlines(String category) async {
    final response = await _resp.fetchCategoryHeadlines(category);
    return response;
  }
}
