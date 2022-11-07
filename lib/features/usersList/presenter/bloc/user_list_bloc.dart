import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder/features/usersList/data/datasource/user_list_data_source.dart';
import 'package:json_placeholder/features/usersList/data/models/user_model.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(UserListInitial()) {
    on<UserListEvent>((event, emit) async {
      if (event is GetUserList) {
        emit(UserListLoading());
        final userListOrError = await getUserList();
        userListOrError.fold(
          (error) => emit(UserListFailed(error)),
          (userList) => emit(UserListLoaded(userList)),
        );
      }
    });
  }
}
