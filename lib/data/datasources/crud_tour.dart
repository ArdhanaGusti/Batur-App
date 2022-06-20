import 'dart:io';
import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/utils/exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class CrudTour {
  Future<String> sendTour(
    BuildContext context,
    String imageName,
    String name,
    String type,
    String desc,
    File image,
    double latitude,
    double longitude,
  );
  Future<String> editTour(
    BuildContext context,
    File? image,
    String coverUrlNow,
    String? imageName,
    String nameNow,
    String typeNow,
    String descNow,
    double latitude,
    double longitude,
    DocumentReference index,
  );
  Future<String> removeTour(DocumentReference index, String urlName);
}

class CrudTourImpl implements CrudTour {
  final ApiService apiService;

  CrudTourImpl({required this.apiService});

  @override
  Future<String> sendTour(
    BuildContext context,
    String imageName,
    String name,
    String type,
    String desc,
    File image,
    double latitude,
    double longitude,
  ) async {
    try {
      apiService.sendTour(
        context,
        imageName,
        name,
        type,
        desc,
        image,
        latitude,
        longitude,
      );
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
    String nameNow,
    String typeNow,
    String descNow,
    double latitude,
    double longitude,
    DocumentReference index,
  ) async {
    try {
      apiService.editTour(context, image, coverUrlNow, imageName, nameNow,
          typeNow, descNow, latitude, longitude, index);
      return 'Wisata sudah di edit';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTour(
      DocumentReference<Object?> index, String urlName) async {
    try {
      apiService.deleteTour(index, urlName);
      return "Tempat wisata sudah dihapus";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
