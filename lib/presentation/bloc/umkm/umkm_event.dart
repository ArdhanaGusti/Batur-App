import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

abstract class UmkmEvent extends Equatable {
  const UmkmEvent();

  @override
  List<Object> get props => [];
}

class OnCreateUmkm extends UmkmEvent {
  final BuildContext context;
  final String imageName, name, type;
  final File image;
  final Position currentLocation;
  const OnCreateUmkm(this.context, this.imageName, this.name, this.type,
      this.image, this.currentLocation);
  @override
  List<Object> get props => [];
}

class OnUpdateUmkm extends UmkmEvent {
  final BuildContext context;
  final String imageName, name, type, coverUrlNow;
  final File image;
  final LatLng center;
  final DocumentReference index;
  const OnUpdateUmkm(this.context, this.imageName, this.name, this.type,
      this.coverUrlNow, this.image, this.center, this.index);
  @override
  List<Object> get props => [];
}
