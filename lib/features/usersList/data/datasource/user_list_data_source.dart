import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:json_placeholder/features/usersList/data/models/user_model.dart';

Future<Either<UserListErrors, List<UserModel>>> getUserList() async {
  Uri uri = Uri.https('jsonplaceholder.typicode.com', '/users');

  final Response response;

  try {
    response = await http.get(uri, headers: {
      'Content-type': 'application/json'
    }).timeout(const Duration(seconds: 60));

    if (response.statusCode == 200) {
      final responseBody =
          List<Map<String, dynamic>>.from(jsonDecode(response.body));
      final userList = responseBody.map((e) {
        return UserModel.fromJson(e);
      },).toList();

      // print(response.body);

      return Right(userList);
    }
    return const  Left(UserListErrors.failedRequest);

  } catch (e) {
    return const Left(UserListErrors.networkError);
  }
}

enum UserListErrors {
  networkError,
  failedRequest,
}
