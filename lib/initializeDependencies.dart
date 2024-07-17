import 'package:get_it/get_it.dart';
import 'package:pagination_api_integration/domain/repository/user_repository.dart';


import 'core/resources/user_service.dart';
import 'domain/usecase/get_users.dart';
import 'feature/bloc/user_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {


  // Api client sources
  sl.registerSingleton<UserService>(UserService());




  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepository(sl()));



  // Use cases
  sl.registerLazySingleton<GetUsers>(() => GetUsers(sl()));

  // Register blocs
  sl.registerFactory<UserBloc>(() => UserBloc(getUsers: sl()));


}
