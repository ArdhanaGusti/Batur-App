import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:latlong2/latlong.dart';

abstract class UmkmEvent extends Equatable {
  const UmkmEvent();

  @override
  List<Object> get props => [];
}

class OnCreateUmkm extends UmkmEvent {
  final BuildContext context;
  final String imageName, name, type, desc;
  final String address, phone, shopee, tokped, website;
  final File image;
  final double latitude, longitude;
  const OnCreateUmkm(
      this.context,
      this.imageName,
      this.address,
      this.phone,
      this.shopee,
      this.tokped,
      this.website,
      this.name,
      this.type,
      this.desc,
      this.image,
      this.latitude,
      this.longitude);
  @override
  List<Object> get props => [];
}

class OnUpdateUmkm extends UmkmEvent {
  final BuildContext context;
  final String? imageName;
  final String name, type, coverUrlNow, desc;
  final String address;
  final String? phone, shopee, tokped, website;
  final File? image;
  final double latitude, longitude;
  final DocumentReference index;
  const OnUpdateUmkm(
      this.context,
      this.imageName,
      this.name,
      this.type,
      this.desc,
      this.coverUrlNow,
      this.image,
      this.latitude,
      this.longitude,
      this.address,
      this.phone,
      this.shopee,
      this.tokped,
      this.website,
      this.index);
  @override
  List<Object> get props => [];
}

class OnRemoveUmkm extends UmkmEvent {
  final DocumentReference index;
  final String coverUrl;

  const OnRemoveUmkm(this.coverUrl, this.index);
  @override
  List<Object> get props => [];
}

class OnVerifUmkm extends UmkmEvent {
  final DocumentReference index;
  final bool value;

  const OnVerifUmkm(this.value, this.index);
  @override
  List<Object> get props => [];
}
