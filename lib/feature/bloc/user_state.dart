import 'package:equatable/equatable.dart';

import '../../data/model/user.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  final bool hasReachedMax;
  final int page;
  final int size;

  UserLoaded({
    required this.users,
    required this.hasReachedMax,
    required this.page,
    required this.size,
  });

// Optional: Override == and hashCode for equality checks
}

class UserError extends UserState {
  final String error;

  UserError({required this.error});

  @override
  List<Object> get props => [error];
}