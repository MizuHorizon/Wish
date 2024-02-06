import 'package:flutter/material.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/models/user_model.dart';
import 'package:wish/src/wish/services/firebase_auth_service.dart';

class UserController {
  final FirebaseAuthService _firebase = FirebaseAuthService();
  Future<MyAppUser?> doSignUp(String name, String email, String phone,
      String password, BuildContext context) async {
    try {
      MyAppUser userData = await _firebase.createUserWithEmailAndPassword(
          name, password, email, phone);
      print(userData);
      return userData;
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppColors.dividerColor,
        content: Text('Something Went Wrong! Please try again later!!! ${e}'),
        duration: Duration(seconds: 5),
      ));
    }
  }

  Future<MyAppUser?> signIn(
      String email, String password, BuildContext context) async {
    try {
      MyAppUser userData =
          await _firebase.signInWithEmailAndPassword(email, password);
      print(userData);
      return userData;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppColors.dividerColor,
        content: Text('Something Went Wrong! Please try again later!!! ${e}'),
        duration: Duration(seconds: 5),
      ));
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await _firebase.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppColors.dividerColor,
        content: Text('Something Went Wrong! Please try again later!!! ${e}'),
        duration: Duration(seconds: 5),
      ));
    }
  }

  Future googleSigin(BuildContext context) async {
    try {
      MyAppUser? user = await _firebase.signInWithGoogle();
      print(user);
      return user;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppColors.dividerColor,
        content: Text('Something Went Wrong! Please try again later!!! ${e}'),
        duration: Duration(seconds: 5),
      ));
    }
  }
}
