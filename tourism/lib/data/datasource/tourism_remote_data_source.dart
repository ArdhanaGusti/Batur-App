import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tourism/data/models/tourist_attraction_detail.dart';

import '../models/tourist_attraction.dart';

class TourismRemoteDataSource {
  static const apiKey = 'AIzaSyAO1b9CLWFz6Y9NG14g2gpYP7TQWPRsPG0';
  static const baseUrl =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
  static const language = 'id';
  static const location = '-6.905977,107.613144';
  static const radius = 50000;
  static const type = 'torist_attraction';
  static const String _url =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json?language=id&location=-6.905977%2C107.613144&radius=50000&type=tourist_attraction&key=YOUR KEY HERE";

  Future<TouristAttractionResult> getTouristAttraction() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      return TouristAttractionResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load tourist attraction');
    }
  }

  Future<TouristAttractionDetailResult> getTouristAttractionDetail(String id) async {
    String detailUrl = 'https://maps.googleapis.com/maps/api/place/details/json?language=id&place_id=$id&key=YOUR KEY HERE';
    final response = await http.get(Uri.parse(detailUrl));
    if (response.statusCode == 200) {
      return TouristAttractionDetailResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load tourist attraction');
    }
  }
}
