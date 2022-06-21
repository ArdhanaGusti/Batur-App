import 'dart:io';
import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/utils/exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class CrudProfile {
  Future<String> sendProfile(BuildContext context, String username, fullname,
      imageName, email, File image, User user);
  Future<String> editProfile(BuildContext context, String usernameNow,
      fullnameNow, imageName, urlNameNow, File? image, DocumentReference index);
}

class CrudProfileImpl implements CrudProfile {
  final ApiService apiService;

  CrudProfileImpl({required this.apiService});
  @override
  Future<String> editProfile(
      BuildContext context,
      String usernameNow,
      fullnameNow,
      imageName,
      urlNameNow,
      File? image,
      DocumentReference<Object?> index) async {
    try {
      apiService.editProfile(context, usernameNow, fullnameNow, imageName,
          urlNameNow, image, index);
      return "Profile berhasil diedit";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> sendProfile(BuildContext context, String username, fullname,
      imageName, email, File image, User user) async {
    try {
      apiService.sendProfile(
          context, username, fullname, imageName, email, image, user);
      return "Profile sudah dibuat";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
