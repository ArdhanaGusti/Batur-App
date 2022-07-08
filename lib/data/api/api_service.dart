import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/article.dart';

class ApiService {
  static const String _baseUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = '9a9d9288c8af4e4aa7abf2b7b913247a';
  static const String _query = 'kota bandung';

  Future<ArticlesResult> topHeadlines() async {
    final response = await http.get(Uri.parse(_baseUrl +
        "everything?q=$_query&sortBy=publishedAt&apiKey=$_apiKey"));
    if (response.statusCode == 200) {
      return ArticlesResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
