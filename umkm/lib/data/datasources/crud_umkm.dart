import 'dart:io';
import '../../data/service/api_service.dart';
import '../../utils/exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class CrudUmkm {
  Future<String> sendUmkm(
    BuildContext context,
    String imageName,
    String address,
    String phone,
    String shopee,
    String tokped,
    String website,
    String name,
    String type,
    String desc,
    File image,
    double latitude,
    double longitude,
  );
  Future<String> editUmkm(
      BuildContext context,
      File? image,
      String coverUrlNow,
      String? imageName,
      String nameNow,
      String typeNow,
      String descNow,
      double latitude,
      double longitude,
      DocumentReference index);
  Future<String> removeUmkm(DocumentReference index, String urlName);
}

class CrudUmkmImpl implements CrudUmkm {
  final ApiServiceUMKM apiService;

  CrudUmkmImpl({required this.apiService});

  @override
  Future<String> editUmkm(
      BuildContext context,
      File? image,
      String coverUrlNow,
      String? imageName,
      String nameNow,
      String typeNow,
      String descNow,
      double latitude,
      double longitude,
      DocumentReference<Object?> index) async {
    try {
      apiService.editUmkm(context, image, coverUrlNow, imageName, nameNow,
          typeNow, descNow, latitude, longitude, index);
      return "UMKM sudah di Update";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> sendUmkm(
    BuildContext context,
    String imageName,
    String address,
    String phone,
    String shopee,
    String tokped,
    String website,
    String name,
    String type,
    String desc,
    File image,
    double latitude,
    double longitude,
  ) async {
    try {
      apiService.sendUmkm(context, imageName, name, type, desc, address, phone,
          shopee, tokped, website, image, latitude, longitude);
      return "UMKM sudah jadi :)";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeUmkm(
      DocumentReference<Object?> index, String urlName) async {
    try {
      apiService.deleteUmkm(index, urlName);
      return "Umkm sudah dihapus";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
