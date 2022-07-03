import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:transportation/data/models/station.dart';
import 'package:transportation/data/models/station_detail.dart';

class TransportationRemoteDataSource {
  static const apiKey = 'YOUR KEY HERE';
  static const baseUrl = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?&';
  static const location = '-6.905977%2C107.613144';
  static const radius = 5000;
  static const type = 'torist_attraction';
  static const String _url =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json?language=id&location=-6.9249264%2C107.6462874&radius=22000&type=train_station&key=YOUR KEY HERE";

  Future<StationResult> getStation() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      return StationResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load tourist attraction');
    }
  }

  Future<StationDetailResult> getStationDetail(
      String id) async {
    String detailUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?language=id&place_id=$id&key=YOUR KEY HERE';
    final response = await http.get(Uri.parse(detailUrl));
    if (response.statusCode == 200) {
      return StationDetailResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load tourist attraction');
    }
  }

}