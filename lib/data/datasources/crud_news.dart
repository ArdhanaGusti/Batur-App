import 'dart:io';
import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/utils/exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class CrudNews {
  Future<String> sendNews(BuildContext context, File image, String imageName,
      String judul, String konten);
  Future<String> editNews(
      BuildContext context,
      File? imageNow,
      String? imageNameNow,
      String judulNow,
      String kontenNow,
      String urlNameNow,
      DocumentReference index);
  Future<String> removeNews(DocumentReference index, String coverUrl);
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
      String kontenNow,
      String urlNameNow,
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
  Future<String> sendNews(BuildContext context, File image, String imageName,
      String judul, String konten) async {
    try {
      apiService.sendNews(context, image, imageName, judul, konten);
      return "Berita sudah di buat";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeNews(DocumentReference index, String coverUrl) async {
    try {
      apiService.deleteNews(index, coverUrl);
      return "Berita sudah dihapus";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
