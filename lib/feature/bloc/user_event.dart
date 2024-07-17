import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUsers extends UserEvent {
  final int page;
  final int size;

  FetchUsers({required this.page, required this.size});

  @override
  List<Object> get props => [page, size];
}