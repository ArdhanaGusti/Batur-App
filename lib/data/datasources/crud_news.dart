import 'dart:io';
import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/utils/exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class CrudNews {
  Future<String> sendNews(
      BuildContext context, File image, String imageName, judul, konten);
  Future<String> editNews(
      BuildContext context,
      File? imageNow,
      String? imageNameNow,
      String judulNow,
      kontenNow,
      urlNameNow,
      DocumentReference index);
}

class CrudNewsImpl implements CrudNews {
  final ApiService apiService;

  CrudNewsImpl({required this.apiService});
  @override
  Future<String> editNews(
      BuildContext context,
      File? imageNow,
      String? imageNameNow,
      String judulNow,
      kontenNow,
      urlNameNow,
      DocumentReference<Object?> index) async {
    try {
      apiService.editNews(context, imageNow, imageNameNow, judulNow, kontenNow,
          urlNameNow, index);
      return "Berita sudah di edit";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> sendNews(
      BuildContext context, File image, String imageName, judul, konten) async {
    try {
      apiService.sendNews(context, image, imageName, judul, konten);
      return "Berita sudah di buat";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
