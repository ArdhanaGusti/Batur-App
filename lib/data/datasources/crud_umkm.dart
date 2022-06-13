import 'dart:io';
import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/utils/exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

abstract class CrudUmkm {
  Future<String> sendUmkm(BuildContext context, String imageName, name, type,
      File image, Position currentLocation);
  Future<String> editUmkm(BuildContext context, File? image, String coverUrlNow,
      imageName, nameNow, typeNow, LatLng center, DocumentReference index);
}

class CrudUmkmImpl implements CrudUmkm {
  final ApiService apiService;

  CrudUmkmImpl({required this.apiService});

  @override
  Future<String> editUmkm(
      BuildContext context,
      File? image,
      String coverUrlNow,
      imageName,
      nameNow,
      typeNow,
      LatLng center,
      DocumentReference<Object?> index) async {
    try {
      apiService.editUmkm(context, image, coverUrlNow, imageName, nameNow,
          typeNow, center, index);
      return "UMKM sudah di Update";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> sendUmkm(BuildContext context, String imageName, name, type,
      File image, Position currentLocation) async {
    try {
      apiService.sendUmkm(
          context, imageName, name, type, image, currentLocation);
      return "UMKM sudah jadi :)";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
