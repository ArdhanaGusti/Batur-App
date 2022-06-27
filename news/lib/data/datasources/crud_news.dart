import 'dart:io';
import '../../data/service/api_service.dart';
import '../../utils/exception.dart';
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
  Future<String> removeNews(
      BuildContext context, DocumentReference index, String coverUrl);
}

class CrudNewsImpl implements CrudNews {
  final ApiServiceNews apiServiceNews;

  CrudNewsImpl({required this.apiServiceNews});
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
      apiServiceNews.editNews(context, imageNow, imageNameNow, judulNow,
          kontenNow, urlNameNow, index);
      return "Berita sudah di edit";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> sendNews(BuildContext context, File image, String imageName,
      String judul, String konten) async {
    try {
      apiServiceNews.sendNews(context, image, imageName, judul, konten);
      return "Berita sudah di buat";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeNews(
      BuildContext context, DocumentReference index, String coverUrl) async {
    try {
      apiServiceNews.deleteNews(context, index, coverUrl);
      return "Berita sudah dihapus";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
