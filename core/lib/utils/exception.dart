class ServerException implements Exception {}

class FirebaseServerException implements Exception {}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

class FirebaseDataException implements Exception {
  final String message;

  FirebaseDataException(this.message);
}

class UIException implements Exception {
  final String message;

  UIException(this.message);
}
