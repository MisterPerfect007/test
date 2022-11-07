part of 'user_list_bloc.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object> get props => [];
}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final List<UserModel> userList;

  const UserListLoaded(this.userList);

  @override
  List<Object> get props => [userList];
}

class UserListFailed extends UserListState {
  final UserListErrors error;

  const UserListFailed(this.error);

  @override
  List<Object> get props => [error];
}
