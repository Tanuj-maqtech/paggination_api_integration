import '../../data/model/user.dart';
import '../repository/user_repository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<List<User>> call(int page, int size) {
    return repository.getUsers(page, size);
  }
}