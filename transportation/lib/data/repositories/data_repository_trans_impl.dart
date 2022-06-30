import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:theme/common/exception.dart';
import 'package:theme/common/failure.dart';
import 'package:transportation/data/datasources/crud_train.dart';
import 'package:transportation/domain/repository/data_repository_trans.dart';

class DataRepositoryTransImpl implements DataRepositoryTrans {
  final CrudTrain crudTrain;

  DataRepositoryTransImpl({required this.crudTrain});

  @override
  Future<Either<Failure, String>> sendTrain(BuildContext context,
      String trainName, String station, DateTime time) async {
    try {
      final res = await crudTrain.sendTrain(context, trainName, station, time);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> editTrain(
      BuildContext context,
      String trainName,
      String station,
      DateTime time,
      DocumentReference<Object?> index) async {
    try {
      final res =
          await crudTrain.editTrain(context, trainName, station, time, index);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeTrain(
      DocumentReference<Object?> index) async {
    try {
      final res = await crudTrain.removeTrain(index);
      return Right(res);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
