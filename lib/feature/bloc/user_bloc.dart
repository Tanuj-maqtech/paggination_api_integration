import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_api_integration/feature/bloc/user_event.dart';
import 'package:pagination_api_integration/feature/bloc/user_state.dart';
import '../../domain/usecase/get_users.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsers;

  UserBloc({required this.getUsers}) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<ResetUsers>(_onResetUsers); // Register ResetUsers event handler
  }

  void _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    try {
      if (state is UserInitial) {
        final users = await getUsers(event.page, event.size);
        emit(UserLoaded(users: users, hasReachedMax: users.isEmpty, page: event.page, size: event.size));
      } else if (state is UserLoaded) {
        final currentState = state as UserLoaded;
        final users = await getUsers(event.page, event.size);

        // Update state only if page or size changes
        if (currentState.page != event.page || currentState.size != event.size) {
          emit(UserLoaded(
            users: users,
            hasReachedMax: users.isEmpty,
            page: event.page,
            size: event.size,
          ));
        } else {
          emit(UserLoaded(
            users: currentState.users + users,
            hasReachedMax: users.isEmpty,
            page: event.page,
            size: event.size,
          ));
        }
      }
    } catch (e) {
      emit(UserError(error: e.toString()));
    }
  }
  void _onResetUsers(ResetUsers event, Emitter<UserState> emit) {
    emit(UserInitial());
  }
}
