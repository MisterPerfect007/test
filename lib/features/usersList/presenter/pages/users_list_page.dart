import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_placeholder/features/usersList/data/models/user_model.dart';

import '../bloc/user_list_bloc.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // getUserList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Users List"),
      ),
      body: Body(size: size),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    context.read<UserListBloc>().add(GetUserList());
    return SizedBox(
        width: double.infinity,
        height: size.height,
        child:
            BlocBuilder<UserListBloc, UserListState>(builder: (context, state) {
          if (state is UserListLoading || state is UserListInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserListFailed) {
            return Center(
              child: Text(
                "${state.error}",
                style: const  TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          } else if (state is UserListLoaded) {
            return ListView.builder(
                itemCount: state.userList.length,
                itemBuilder: (context, index) {
                  final user = state.userList[index];
                  return User(
                    user: user,
                  );
                });
          }
          return Container();
        }));
  }
}

class User extends StatelessWidget {
  final UserModel user;
  const User({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Center(
                child: Text(
              user.name[0],
              style: const TextStyle(color: Colors.white, fontSize: 20),
            )),
          ),
          const SizedBox(width: 10),
          SizedBox(
              width: 150,
              child: Text(
                user.name,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              )),
          Expanded(
            child: Column(
              children: [
                Text(
                  user.username,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  user.email,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
