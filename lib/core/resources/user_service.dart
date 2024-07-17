import 'package:dio/dio.dart';
import 'package:pagination_api_integration/constant/Constant.dart';

import '../../data/model/user.dart';

class UserService {
  final Dio _dio = Dio();

  Future<List<User>> fetchUsers(int page, int size) async {
    print("Request page ${page} size ${size}");
    final response = await _dio.get(
      Constant.baseURL,
      queryParameters: {'page': page, 'size': size},
    );

    if (response.statusCode == 200) {
      print("Responce ${response.data.toString()}");
      // Access the 'users' key from the response data
      final users = response.data['users'] as List;

      // Map the JSON data to User objects
      return users.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}