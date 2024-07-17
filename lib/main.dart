import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/resources/user_service.dart';
import 'domain/repository/user_repository.dart';
import 'domain/usecase/get_users.dart';
import 'feature/bloc/user_bloc.dart';
import 'feature/pages/user_page.dart';
import 'initializeDependencies.dart';

void main() async {
 /* final userService = UserService();
  final userRepository = UserRepository(userService);
  final getUsers = GetUsers(userRepository);*/
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Details',
      home: BlocProvider(
        create: (context) => sl<UserBloc>(),
        child: UserPage(),
      ),
    );
  }
}






