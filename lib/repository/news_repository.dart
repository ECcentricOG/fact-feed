import 'dart:convert';

import 'package:news_apk/models/categories_news_model.dart';
import 'package:news_apk/models/indian_news_model.dart';
import 'package:news_apk/models/news_channel_headlines_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_apk/screens/home_screen.dart';

class NewsRepository {
  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi() async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?sources=$name&apiKey=b6e519e0078e4284a2fe5f4e59bec1a5");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }
    throw Exception("Does not get Headlines");
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$category&apiKey=b6e519e0078e4284a2fe5f4e59bec1a5");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception("Does not get Headlines");
  }

  Future<IndianNewsModel> fetchIndianNewsApi() async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=b6e519e0078e4284a2fe5f4e59bec1a5");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return IndianNewsModel.fromJson(body);
    }
    throw Exception("Fail to fetch Indian News");
  }
}
