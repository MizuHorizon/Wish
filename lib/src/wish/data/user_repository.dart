import 'package:dio/dio.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/models/user_model.dart';

class UserRepository {
  final dio = Dio();
  //login
  Future<dynamic> signUp(
      String name, String password, String email, bool googleUser) async {
    final Response response = await dio.post("${baseUrl}user/", data: {
      'name': name,
      'password': password,
      'email': email,
      'goole': googleUser
    });
    if (response.statusCode == 200) {
      return 200;
    }
  }

  Future<dynamic> signIn(String email, String password) async {
    final Response response = await dio.post("${baseUrl}user/signin", data: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return "Something Went wrong";
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

  // Future<MyAppUser> updateUserById(MyAppUser user) async{
  //     final Reponse reponse = await dio.patch("${baseUrl}user/",data:{

  //     })
  // }
}
