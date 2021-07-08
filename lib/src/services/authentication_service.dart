import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthenticationService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(
      {required String email,
      required String password,
      required String fullName,
      required String phone,
      required File image,
      required Function onSuccess,
      required Function error}) async {
    _auth
        .createUserWithEmailAndPassword(
            email: email.toLowerCase().trim(), password: password.trim())
        .then((value) async {
      //Connect to FirebaseStorage
      final ref = FirebaseStorage.instance
          .ref()
          .child('usersImages')
          .child(fullName + '.jpg');
      //Upload File to FirebaseStorage
      await ref.putFile(image);
      //Get url Image after upload
      String url = await ref.getDownloadURL();
      //Create user in FirebaseFirestore
      final User user = _auth.currentUser!;
      final _uid = user.uid;
      var date = DateFormat('dd/MM/yyyy', 'en_US').format(DateTime.now());
      await FirebaseFirestore.instance.collection('users').doc(_uid).set({
        'id': _uid,
        'name': fullName,
        'email': email,
        'phone': phone,
        'ImageUrl': url,
        'joinedAt': date,
        'createdAt': Timestamp.now(),
      });
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

  Future<void> logOut({required Function onSuccess}) async {
    _auth.signOut().then((value) {
      onSuccess();
    });
  }

  Future<void> signInWithGoogle({required Function onError}) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _auth
            .signInWithCredential(GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken))
            .catchError((err) {
          onError('${err.message}');
        });
        var date = DateFormat('dd/MM/yyyy', 'en_US').format(DateTime.now());
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'id': authResult.user!.uid,
          'name': authResult.user!.displayName,
          'email': authResult.user!.email,
          'phone': authResult.user!.phoneNumber,
          'ImageUrl': authResult.user!.photoURL,
          'joinedAt': date,
          'createdAt': Timestamp.now(),
        });
      }
    }
  }

  Future<void> signInGuest() async {
    await _auth.signInAnonymously();
  }
}
