import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class DataAccountRepository {
  // Remote
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, String>> emailSignUp(
    String email,
    String password,
  );
  Future<Either<Failure, String>> emailSignIn(
    String email,
    String password,
  );
  Future<Either<Failure, String>> emailSignOut();
  Future<Either<Failure, String>> deleteAuth();
  Future<Either<Failure, String>> googleSignIn();
  Future<Either<Failure, String>> facebookSignIn();
  Future<Either<Failure, String>> googleSignUp();
  Future<Either<Failure, String>> facebookSignUp();
  Future<Either<Failure, String>> googleSignOut();
  Future<Either<Failure, String>> facebookSignOut();
  Future<Either<Failure, String>> registerProfile(
    String username,
    String fullname,
    String imageName,
    String email,
    File image,
  );
  Future<Either<Failure, String>> editProfile(
    String username,
    String fullname,
    String? imageName,
    String urlNameNow,
    File? image,
    DocumentReference index,
  );
  Future<bool> isHaveProfile(String email);
  Future<bool> isAdmin(String email);

  // Local
  Future<bool> isLogIn();
  Future<bool> saveIsLogIn(bool value);
}
