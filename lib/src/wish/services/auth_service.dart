
abstract class AuthService {
  //Future<MyAppUser> currentUser();
  Future signInWithGoogle();
  Future signInWithEmailAndPassword(String email, String password);
  Future<dynamic> createUserWithEmailAndPassword(
      String email, String name, String password, String phone);
  Future<void> signOut();
  //Stream<MyAppUser> get onAuthStateChanged;
  void dispose();
}
