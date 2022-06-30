import 'dart:io';

import 'package:account/data/service/api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AccountRemoteDataSource {
  Future<User> getUser();
  Future<String> emailSignIn(String email, String password);
  Future<String> emailSignUp(String email, String password);
  Future<String> emailSignOut();
  Future<String> deleteAuth();
  Future<String> googleSignIn();
  Future<String> facebookSignIn();
  Future<String> googleSignUp();
  Future<String> facebookSignUp();
  Future<String> googleSignOut();
  Future<String> facebookSignOut();
  Future<String> registerProfile(
    String username,
    String fullname,
    String imageName,
    String email,
    File image,
  );
  Future<String> editProfile(
    String username,
    String fullname,
    String? imageName,
    String urlNameNow,
    File? image,
    DocumentReference index,
  );
  Future<bool> isHaveProfile(String email);
  Future<bool> isAdmin(String email);
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final ServiceApiAccount api;

  AccountRemoteDataSourceImpl({required this.api});

  @override
  Future<User> getUser() async {
    return await api.getUser();
  }

  @override
  Future<String> emailSignIn(String email, String password) async {
    return await api.emailSignIn(email, password);
  }

  @override
  Future<String> emailSignOut() async {
    return await api.emailSignOut();
  }

  @override
  Future<String> deleteAuth() async {
    return await api.deleteAuth();
  }

  @override
  Future<String> emailSignUp(String email, String password) async {
    return await api.emailSignUp(email, password);
  }

  @override
  Future<String> googleSignIn() async {
    return await api.googleSignIn();
  }

  @override
  Future<String> facebookSignIn() async {
    return await api.facebookSignIn();
  }

  @override
  Future<String> googleSignUp() async {
    return await api.googleSignUp();
  }

  @override
  Future<String> facebookSignUp() async {
    return await api.facebookSignUp();
  }

  @override
  Future<String> googleSignOut() async {
    return await api.googleSignOut();
  }

  @override
  Future<String> facebookSignOut() async {
    return await api.facebookSignOut();
  }

  @override
  Future<String> registerProfile(
    String username,
    String fullname,
    String imageName,
    String email,
    File image,
  ) async {
    return await api.registerProfile(
      username,
      fullname,
      imageName,
      email,
      image,
    );
  }

  @override
  Future<String> editProfile(
    String username,
    String fullname,
    String? imageName,
    String urlNameNow,
    File? image,
    DocumentReference index,
  ) async {
    return await api.editProfile(
      username,
      fullname,
      imageName,
      urlNameNow,
      image,
      index,
    );
  }

  @override
  Future<bool> isHaveProfile(String email) async {
    return await api.isHaveProfile(email);
  }

  @override
  Future<bool> isAdmin(String email) async {
    return await api.isAdmin(email);
  }
}
