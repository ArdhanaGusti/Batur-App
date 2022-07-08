import 'dart:convert';

import 'package:core/utils/config.dart';
import 'package:http/http.dart' as http;

import '../../utils/exception.dart';
import '../model/news.dart';

class NewsRemoteDataSource {
  final apiKey = Config().newsKey;
  static const baseUrl = 'https://newsapi.org/v2';
  static const query = 'kota bandung';
  static const sort = 'publishedAt';
  static const language = 'en';

  Future<ArticlesResult> bandungNewsId() async {
    final response = await http.get(
        Uri.parse("$baseUrl/everything?q=$query&sortBy=$sort&apiKey=$apiKey"));
    if (response.statusCode == 200) {
      return ArticlesResult.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<ArticlesResult> bandungNewsEn() async {
    final response = await http.get(Uri.parse(
        "$baseUrl/everything?language=$language&q=$query&sortBy=$sort&apiKey=$apiKey"));
    if (response.statusCode == 200) {
      return ArticlesResult.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
