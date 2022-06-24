import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/utils/exception.dart';
import 'package:flutter/material.dart';

abstract class CrudLogin {
  Future<String> signInbyGoogle(BuildContext context);
  Future<String> signInWithFacebook(BuildContext context);
  Future<String> loginWithEmail(
      BuildContext context, String email, String pass);
  Future<String> signInWithEmail(
      BuildContext context, String email, String pass);
}

class CrudLoginImpl implements CrudLogin {
  final ApiService apiService;

  CrudLoginImpl({required this.apiService});

  @override
  Future<String> loginWithEmail(
      BuildContext context, String email, String pass) async {
    try {
      apiService.loginWithEmail(context, email, pass);
      return 'Login Email berhasil';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> signInWithEmail(
      BuildContext context, String email, String pass) async {
    try {
      apiService.signInWithEmail(context, email, pass);
      return 'Register email berhasil';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> signInWithFacebook(BuildContext context) async {
    try {
      apiService.signInWithFacebook(context);
      return 'Login Facebook berhasil';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> signInbyGoogle(BuildContext context) async {
    try {
      apiService.signInbyGoogle(context);
      return 'Login Google berhasil';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
