import 'dart:io';

import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/utils/exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

abstract class CrudTour {
  Future<String> sendTour(BuildContext context, String imageName, String name,
      String type, String desc, File image, Position currentLocation);
  Future<String> editTour(
    BuildContext context,
    File? image,
    String coverUrlNow,
    String? imageName,
    nameNow,
    typeNow,
    String descNow,
    LatLng center,
    DocumentReference index,
  );
}

class CrudTourImpl implements CrudTour {
  final ApiService apiService;

  CrudTourImpl({required this.apiService});

  @override
  Future<String> sendTour(BuildContext context, String imageName, String name,
      String type, String desc, File image, Position currentLocation) async {
    try {
      apiService.sendTour(
          context, imageName, name, type, desc, image, currentLocation);
      return "Wisata sudah dibuat";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> editTour(
    BuildContext context,
    File? image,
    String coverUrlNow,
    String? imageName,
    nameNow,
    typeNow,
    String descNow,
    LatLng center,
    DocumentReference index,
  ) async {
    try {
      apiService.editTour(context, image, coverUrlNow, imageName, nameNow,
          typeNow, descNow, center, index);
      return 'Wisata sudah di edit';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
