import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

abstract class TrainEvent extends Equatable {
  const TrainEvent();

  @override
  List<Object> get props => [];
}

class OnCreateTrain extends TrainEvent {
  final BuildContext context;
  final String trainName;
  final String station;
  final DateTime time;
  const OnCreateTrain(this.context, this.trainName, this.station, this.time);
  @override
  List<Object> get props => [];
}

class OnUpdateTrain extends TrainEvent {
  final BuildContext context;
  final String trainName;
  final String station;
  final DateTime time;
  final DocumentReference<Object?> index;
  const OnUpdateTrain(
      this.context, this.trainName, this.station, this.time, this.index);
  @override
  List<Object> get props => [];
}

class OnRemoveTrain extends TrainEvent {
  final DocumentReference index;

  const OnRemoveTrain(this.index);
  @override
  List<Object> get props => [];
}
