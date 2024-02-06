import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wish/src/constants.dart';

class UserRepository {
  final dio = Dio();
  //login
  Future<dynamic> signUp(
      String name, String password, String email, String phone) async {
    try {
      final Response response = await dio.post("${baseUrl}user/", data: {
        'name': name,
        'password': password,
        'email': email,
        'phone': phone
      });
      if (response.statusCode == 201) {
        print("in the repo ${response.data}");
        return response.data;
      } else {
        throw response.data;
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          throw ('Server is not reachable.');
        } else {
          print('Dio error: ${e.message}');
          throw 'Dio error: ${e.message}';
        }
      } else {
        print('Error: $e');
        throw '$e';
      }
    }
  }

  Future<dynamic> signIn(String email, String password) async {
    final Response response = await dio.post("${baseUrl}user/signin", data: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 201) {
      return response.data;
    } else {
      throw response.data;
    }
  }

  Future<dynamic> getUserById(String id) async {
    final Response response = await dio.get("${baseUrl}user/$id");
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return "Something went wrong";
    }
  }

  Future<dynamic> getUserByEmail(String email) async {
    final Response response = await dio.get("${baseUrl}user/${email}");
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return "Something went wrong";
    }
  }

  Future<dynamic> googlesSignUp(
      String name, String email, String phone, String photo) async {
    try {
      final Response response = await dio.post("${baseUrl}user/google", data: {
        'name': name,
        'email': email,
        'phone': phone,
        'profile_pic': photo
      });
      if (response.statusCode == 201) {
        print("in the repo ${response.data}");
        return response.data;
      } else {
        throw response.data;
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          throw ('Server is not reachable.');
        } else {
          print('Dio error: ${e.message}');
          throw 'Dio error: ${e.message}';
        }
      } else {
        print('Error: $e');
        throw '$e';
      }
    }
  }
}
