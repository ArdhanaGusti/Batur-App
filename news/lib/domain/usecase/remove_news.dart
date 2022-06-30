import 'package:flutter/material.dart';

import '../../domain/repositories/data_repository.dart';
import '../../utils/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class RemoveNews {
  final DataRepositoryNews repository;

  RemoveNews(this.repository);

  Future<Either<Failure, String>> execute(
      BuildContext context, DocumentReference<Object?> index, String coverUrl) {
    return repository.removeNews(context, index, coverUrl);
  }
}
