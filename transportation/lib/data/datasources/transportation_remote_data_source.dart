import 'dart:convert';

import 'package:core/utils/config.dart';
import 'package:http/http.dart' as http;
import 'package:transportation/data/models/station.dart';
import 'package:transportation/data/models/station_detail.dart';

class TransportationRemoteDataSource {
  final apiKey = Config().mapsKey;
  final placeUrl = Config().placeUrl;
  final placeDetailUrl = Config().placeDetailUrl;
  static const language = 'id';
  static const location = '-6.9249264,107.6462874';
  static const radius = 22000;
  static const type = 'train_station';

  Future<StationResult> getStation() async {
    String url = '${placeUrl}language=$language&location=$location&radius=$radius&type=$type&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return StationResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load tourist attraction');
    }
  }

  Future<StationDetailResult> getStationDetail(String id) async {
    String detailUrl =
        '${placeDetailUrl}language=id&place_id=$id&key=$apiKey';
    final response = await http.get(Uri.parse(detailUrl));
    if (response.statusCode == 200) {
      return StationDetailResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load tourist attraction');
    }
  }
}
