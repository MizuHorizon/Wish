import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wish/src/constants.dart';
import 'package:wish/src/wish/models/user_model.dart';
import 'package:wish/src/wish/services/firebase_auth_service.dart';

final userControllerProvider =
    StateNotifierProvider.autoDispose<UserController, AsyncValue<void>>(
        (ref) => UserController(firebase: ref.read(authFireBaseRepoProvider)));

class UserController extends StateNotifier<AsyncValue<void>> {
  UserController({required this.firebase}) : super(const AsyncData(null));

  final FirebaseAuthService firebase;

  Future<void> logout() async {
    try {
      state = const AsyncLoading();
      final newState =
          await AsyncValue.guard(() async => await firebase.signOut());
      if (mounted) {
        state = newState;
      }
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
      throw Exception(error);
    }
  }

  Future<MyAppUser?> currentUser() async {
    MyAppUser? userData = await firebase.currentUser();
    return userData;
  }

  Future<MyAppUser?> updateFCM(String fcmToken) async {
    try {
      MyAppUser? userData = await firebase.updateFcm(fcmToken);
      return userData;
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<MyAppUser?> doSignUp(
      String name, String email, String phone, String password) async {
    try {
      state = const AsyncLoading();
      MyAppUser? userData;
      final newState = await AsyncValue.guard(() async {
        userData = await firebase.createUserWithEmailAndPassword(
            name, password, email, phone);
      });
      if (mounted) {
        state = newState;
      }
      print(userData);
      if (userData == null) throw Exception("Something went wrong");
      return userData;
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
      throw Exception(error);
    }
  }

  Future<MyAppUser?> signIn(String email, String password) async {
    try {
      state = const AsyncLoading();
      MyAppUser? userData;
      final newState = await AsyncValue.guard(() async {
        userData = await firebase.signInWithEmailAndPassword(email, password);
      });
      if (mounted) {
        state = newState;
      }
      print(userData);

      if (userData == null) {
        throw Exception("Wrong Email and Password!!");
      }

      return userData;
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
      print(error);
      throw Exception(error);
    }
  }

  Future googleSigin() async {
    try {
      state = const AsyncLoading();

      MyAppUser? user;

      final newState = await AsyncValue.guard(() async {
        user = await firebase.signInWithGoogle();
      });
      if (mounted) {
        state = newState;
      }
      print(user);
      return user;
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      throw Exception(e);
    }
  }
}
