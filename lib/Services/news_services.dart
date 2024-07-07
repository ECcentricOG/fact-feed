import 'package:news_apk/models/categories_news_model.dart';
import 'package:news_apk/models/indian_news_model.dart';
import 'package:news_apk/models/news_channel_headlines_model.dart';
import 'package:news_apk/repository/news_repository.dart';

class NewsServices {
  final _repo = NewsRepository();

  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi() async {
    final response = await _repo.fetchNewsChannelHeadlinesApi();
    return response;
  }

  Future<CategoriesNewsModel> fetCategoriesNewsApi(String category) async {
    final response = await _repo.fetchCategoriesNewsApi(category);
    return response;
  }

  Future<IndianNewsModel> fetchIndianNewsApi() async {
    final response = await _repo.fetchIndianNewsApi();
    return response;
  }
}
