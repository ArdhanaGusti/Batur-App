import 'dart:io';
import 'package:capstone_design/presentation/page/news/news.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class OnCreateNews extends NewsEvent {
  final BuildContext context;
  final File image;
  final String imageName;
  final String judul;
  final String konten;

  const OnCreateNews(
      this.context, this.image, this.imageName, this.judul, this.konten);
  @override
  List<Object> get props => [];
}

class OnUpdateNews extends NewsEvent {
  final BuildContext context;
  final File? image;
  final String? imageName;
  final String konten, judul, urlName;
  final DocumentReference index;

  const OnUpdateNews(this.context, this.image, this.imageName, this.konten,
      this.judul, this.urlName, this.index);
  @override
  List<Object> get props => [];
}

class OnRemoveNews extends NewsEvent {
  final DocumentReference index;
  final String coverUrl;

  const OnRemoveNews(this.coverUrl, this.index);
  @override
  List<Object> get props => [];
}
