import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomerService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool isGuest() {
    User user = _auth.currentUser!;
    if (user.isAnonymous)
      return true;
    else
      return false;
  }

  Future<DocumentSnapshot> getUserInfo() async {
    User user = _auth.currentUser!;
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    return userDoc;
  }
}
