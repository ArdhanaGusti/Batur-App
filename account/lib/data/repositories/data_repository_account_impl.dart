import 'dart:io';
import 'package:account/data/sources/local_data_source.dart';
import 'package:account/data/sources/remote_data_source.dart';
import 'package:account/domain/repository/data_repository.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataRepositoryAccountImpl implements DataAccountRepository {
  final AccountLocalDataSource localDataSource;
  final AccountRemoteDataSource remoteDataSource;

  DataRepositoryAccountImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<bool> isLogIn() async {
    final result = await localDataSource.isLogIn();

    return result;
  }

  @override
  Future<bool> saveIsLogIn(bool value) async {
    final result = await localDataSource.saveIsLogIn(value);

    return result;
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final result = await remoteDataSource.getUser();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.stackTrace.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> emailSignUp(
    String email,
    String password,
  ) async {
    try {
      final result = await remoteDataSource.emailSignUp(email, password);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.stackTrace.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> emailSignIn(
    String email,
    String password,
  ) async {
    try {
      final result = await remoteDataSource.emailSignIn(email, password);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.plugin));
    } on FirebaseDataException catch (e) {
      return Left(FirebaseFailure(e.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> emailSignOut() async {
    try {
      final result = await remoteDataSource.emailSignOut();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.plugin));
    } on FirebaseDataException catch (e) {
      return Left(FirebaseFailure(e.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAuth() async {
    try {
      final result = await remoteDataSource.deleteAuth();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.plugin));
    } on FirebaseDataException catch (e) {
      return Left(FirebaseFailure(e.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> googleSignUp() async {
    try {
      final result = await remoteDataSource.googleSignUp();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.plugin));
    } on FirebaseDataException catch (e) {
      return Left(FirebaseFailure(e.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> facebookSignUp() async {
    try {
      final result = await remoteDataSource.facebookSignUp();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.plugin));
    } on FirebaseDataException catch (e) {
      return Left(FirebaseFailure(e.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> googleSignIn() async {
    try {
      final result = await remoteDataSource.googleSignIn();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.plugin));
    } on FirebaseDataException catch (e) {
      return Left(FirebaseFailure(e.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> facebookSignIn() async {
    try {
      final result = await remoteDataSource.facebookSignIn();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.plugin));
    } on FirebaseDataException catch (e) {
      return Left(FirebaseFailure(e.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> googleSignOut() async {
    try {
      final result = await remoteDataSource.googleSignOut();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.plugin));
    } on FirebaseDataException catch (e) {
      return Left(FirebaseFailure(e.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> facebookSignOut() async {
    try {
      final result = await remoteDataSource.facebookSignOut();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.plugin));
    } on FirebaseDataException catch (e) {
      return Left(FirebaseFailure(e.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> registerProfile(
    String username,
    String fullname,
    String imageName,
    String email,
    File image,
  ) async {
    try {
      final result = await remoteDataSource.registerProfile(
        username,
        fullname,
        imageName,
        email,
        image,
      );
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.plugin));
    } on FirebaseDataException catch (e) {
      return Left(FirebaseFailure(e.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> editProfile(
    String username,
    String fullname,
    String? imageName,
    String urlNameNow,
    File? image,
    DocumentReference index,
  ) async {
    try {
      final result = await remoteDataSource.editProfile(
        username,
        fullname,
        imageName,
        urlNameNow,
        image,
        index,
      );
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure(e.plugin));
    } on FirebaseDataException catch (e) {
      return Left(FirebaseFailure(e.toString()));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<bool> isHaveProfile(String email) async {
    final result = await remoteDataSource.isHaveProfile(email);

    return result;
  }

  @override
  Future<bool> isAdmin(String email) async {
    final result = await remoteDataSource.isAdmin(email);

    return result;
  }
}
