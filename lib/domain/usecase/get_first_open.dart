import 'package:capstone_design/domain/repositories/repository.dart';

class GetIsFirstOpen {
  final Repository repository;

  GetIsFirstOpen(this.repository);

  Future<bool> execute() async {
    return repository.isFirstOpen();
  }
}
