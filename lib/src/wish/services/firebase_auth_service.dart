import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/services.dart";
import 'dart:math';
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:wish/src/wish/models/user_model.dart";
import "package:wish/src/wish/services/auth_service.dart";
import 'package:wish/src/wish/data/user_repository.dart';

final authFireBaseRepoProvider = Provider((ref) => FirebaseAuthService());

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserRepository userRepository = UserRepository();

  MyAppUser? _userFromFirebase(User user) {
    // here we will our Database
    return null;
  }

  @override
  Future<dynamic> createUserWithEmailAndPassword(
      String name, String password, String email, String phone) async {
    return await userRepository.signUp(name, password, email, phone);
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
    final userData = await userRepository.signIn(email, password);

    //save this token to local
    var jwtToken = userData.token;

    MyAppUser user = MyAppUser.fromJson(userData.data);
    return user;
  }

  @override
  Future<MyAppUser> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final UserCredential userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        var userdata = userCredential.user;
        var userFromBackend =
            await userRepository.getUserByEmail(userdata!.email as String);

        if (userFromBackend == null) {
          final dynamic newUser = await userRepository.signUp(
              userdata.displayName as String,
              randomHexString(16),
              userdata.email as String,
              "12");
          //

          //save the token to the local storage;

          return MyAppUser.fromJson(newUser);
        } else {
          final dynamic newUser = await userRepository.signIn(
              userFromBackend.email as String,
              userFromBackend.password as String);

          var jwtToken = newUser.token;

          MyAppUser user = MyAppUser.fromJson(newUser);
          return user;
        }
      } else {
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    return _firebaseAuth.signOut();
  }
}
