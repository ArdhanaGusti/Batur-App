import 'dart:convert';

import '../model/place.dart';
import 'package:http/http.dart' as http;


class TourismRemoteDataSource {
  static const apiKey = 'YOUR KEY HERE';
  static const baseUrl = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?&';
  static const location = '-6.905977%2C107.613144';
  static const radius = 1500;
  static const type = 'torist_attraction';
  static const String _url =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json?&location=-6.905977%2C107.613144&radius=50000&type=tourist_attraction&key=AIzaSyAO1b9CLWFz6Y9NG14g2gpYP7TQWPRsPG0";

  Future<PlaceResult> getTouristAttraction() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      return PlaceResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load tourist attraction');
    }
  }

}