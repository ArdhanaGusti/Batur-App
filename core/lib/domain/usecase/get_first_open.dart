import 'package:core/domain/repositories/repositories.dart';

class GetIsFirstOpen {
  final CoreRepository repository;

  GetIsFirstOpen(this.repository);

  Future<bool> execute() async {
    return repository.isFirstOpen();
  }
}
