import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/utils/exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class CrudTrain {
  Future<String> sendTrain(
      BuildContext context, String trainName, String station, DateTime time);
  Future<String> editTrain(BuildContext context, String trainName,
      String station, DateTime time, DocumentReference index);
  Future<String> removeTrain(DocumentReference index);
}

class CrudTrainImpl implements CrudTrain {
  final ApiService apiService;

  CrudTrainImpl({required this.apiService});

  @override
  Future<String> sendTrain(BuildContext context, String trainName,
      String station, DateTime time) async {
    try {
      apiService.sendTrain(context, trainName, station, time);
      return 'Jadwal kereta berhasil dibuat';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> editTrain(BuildContext context, String trainName,
      String station, DateTime time, DocumentReference<Object?> index) async {
    try {
      apiService.editTrain(context, trainName, station, time, index);
      return 'Jadwal kereta berhasil diedit';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTrain(DocumentReference<Object?> index) async {
    try {
      apiService.deleteTrain(index);
      return "Kereta sudah dihapus";
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
