import 'package:wish/src/wish/services/firebase_auth_service.dart';

class UserController {
  final FirebaseAuthService _firebase = FirebaseAuthService();
  Future<void> doSignUp(
      String name, String email, String phone, String password) async {
    try {
      var userData = await _firebase.createUserWithEmailAndPassword(
          name, password, email, phone);
      print(userData);
    } catch (e) {
      rethrow;
    }
  }

  void googleSigin() async {}
}
