import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:theme/common/failure.dart';

abstract class DataRepositoryTrans {
  Future<Either<Failure, String>> sendTrain(
      BuildContext context, String trainName, String station, DateTime time);
  Future<Either<Failure, String>> editTrain(
      BuildContext context,
      String trainName,
      String station,
      DateTime time,
      DocumentReference<Object?> index);
  Future<Either<Failure, String>> removeTrain(DocumentReference index);
}
