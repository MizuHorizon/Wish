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
        } else if (e.response!.statusCode == 404) {
          throw e.response!.data['message'];
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
    try {
      final Response response = await dio.post("${baseUrl}user/signin", data: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 201) {
        return response.data;
      } else if (response.statusCode == 404) {
        print("hellloo");
        print(response.data);
        throw response.data;
      }
    } catch (e) {
      print("hellloo1");
      if (e is DioException) {
        if (e.response!.data['message'] ==
                "Account with Email Doesn't Exists!" &&
            e.response!.statusCode == 404) {
          throw "Account with Email Doesn't Exists!";
        } else if (e.response!.statusCode == 501) {
          throw "Wrong Password or Email!!";
        }
        if (e.response != null) {
          print(e.response!.data); // Server error response data
          print(e.response!.statusCode); // Server error status code
          print(e.response!.statusMessage); // Server error status message
        } else {
          print(e.message); // Error message when no response is received
        }
      } else {
        print(e.toString()); // Other types of errors
      }
      throw '$e';
    }
  }

  Future<dynamic> getUserById(String id) async {
    final Response response = await dio.get("${baseUrl}user/$id");
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw "Something went wrong";
    }
  }

  Future<dynamic> updateFCM(String id, String token) async {
    final Response response = await dio
        .post("${baseUrl}user/updatefcm/$id", data: {'fcmtoken': token});
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw "Something went wrong ${response.data}";
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
