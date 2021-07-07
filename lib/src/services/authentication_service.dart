import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(
      String email, String password, Function onSuccess, Function error) async {
    _auth
        .createUserWithEmailAndPassword(
            email: email.toLowerCase().trim(), password: password.trim())
        .then((value) {
      onSuccess();
    }).catchError((err) {
      error('${err.message}');
    });
  }

  Future<void> signIn(
      {required String email,
      required String password,
      required Function onSuccess,
      required Function onError}) async {
    _auth
        .signInWithEmailAndPassword(
            email: email.toLowerCase().trim(), password: password.trim())
        .then((value) {
      onSuccess();
    }).catchError((err) {
      onError('${err.message}');
    });
  }
}
