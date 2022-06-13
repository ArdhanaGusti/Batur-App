import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class OnCreateProfile extends ProfileEvent {
  final BuildContext context;
  final String username, fullname, imageName, email;
  final File image;
  final User user;
  const OnCreateProfile(this.context, this.username, this.fullname,
      this.imageName, this.email, this.image, this.user);
  @override
  List<Object> get props => [];
}

class OnUpdateProfile extends ProfileEvent {
  final BuildContext context;
  final String username, fullname, imageName, urlName, email;
  final File image;
  final User user;
  final DocumentReference index;
  const OnUpdateProfile(
      this.context,
      this.username,
      this.fullname,
      this.imageName,
      this.email,
      this.image,
      this.user,
      this.urlName,
      this.index);
  @override
  List<Object> get props => [];
}
