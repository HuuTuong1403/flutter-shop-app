import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopappfirebase/src/screens/authentication/widgets/landing_page.dart';
import 'package:shopappfirebase/src/screens/home/home_screen.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LandingPage();
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error occured'),
          );
        }
        return Container();
      },
    );
  }
}
