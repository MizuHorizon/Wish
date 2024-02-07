import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/services.dart";
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:wish/src/wish/models/user_model.dart";
import "package:wish/src/wish/services/auth_service.dart";
import 'package:wish/src/wish/data/user_repository.dart';

final authFireBaseRepoProvider = Provider((ref) => FirebaseAuthService());

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserRepository userRepository = UserRepository();

  static Future<void> saveTokenAndId(String token, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwtToken', token);
    await prefs.setString('userId', userId);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwtToken');
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  @override
  Future<dynamic> createUserWithEmailAndPassword(
      String name, String password, String email, String phone) async {
    try {
      final userData =
          await userRepository.signUp(name, password, email, phone);
      print(userData);
      MyAppUser user = MyAppUser.fromMap(userData['data']);
      return user;
    } catch (e) {
      print(e.toString());
      throw '$e';
    }
  }

  @override
  void dispose() {}

  // @override
  // Stream<MyAppUser> get onAuthStateChanged {
  //   return _firebaseAuth
  //       .authStateChanges()
  //       .map((user) => MyAppUser(, name: name, username: username, profilePic: profilePic, email: email));
  // }

  String randomHexString(int length) {
    Random random = Random();
    StringBuffer sb = StringBuffer();
    for (var i = 0; i < length; i++) {
      sb.write(random.nextInt(16).toRadixString(16));
    }
    return sb.toString();
  }

  @override
  Future<MyAppUser> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userData = await userRepository.signIn(email, password);
      print(userData);
      String token = userData['data']['token'];
      String userId = userData['data']['userId'];
      print("$token, $userId");
      await saveTokenAndId(token, userId);
      MyAppUser user = MyAppUser.fromMap(userData['data']['userData']);
      print("Serialized $user");
      return user;
    } catch (e) {
      print(e);
      throw '$e';
    }
  }

  @override
  Future<MyAppUser?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final UserCredential userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        var userdata = userCredential.user;
        print("  ${userdata!.displayName}");
        print("  ${userdata!.email}");
        print("  ${userdata!.phoneNumber}");
        print("  ${userdata!.photoURL}");

        final userDataFromBackend = await userRepository.googlesSignUp(
            userdata!.displayName as String,
            userdata.email as String,
            userdata.phoneNumber ?? "null",
            userdata.photoURL as String);

        // print("user from back $userDataFromBackend");
        String token = userDataFromBackend['data']['token'];
        String userId = userDataFromBackend['data']['userId'];
        // print("$token, $userId");
        await saveTokenAndId(token, userId);
        MyAppUser user =
            MyAppUser.fromMap(userDataFromBackend['data']['userData']);
        //print("Serialized $user");
        return user;
      }
    } catch (e) {
      print(e);
      throw "$e";
    }
  }

  @override
  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    return _firebaseAuth.signOut();
  }
}
