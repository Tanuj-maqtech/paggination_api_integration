import '../../core/resources/user_service.dart';
import '../../data/model/user.dart';

class UserRepository {
  final UserService userService;

  UserRepository(this.userService);

  Future<List<User>> getUsers(int page, int size) {
    return userService.fetchUsers(page, size);
  }
}