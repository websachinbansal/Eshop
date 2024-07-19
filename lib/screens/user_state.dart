import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/screens/first_screen.dart';
import 'package:flutter_shop_app/screens/landing_page.dart';

class UserState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (userSnapshot.connectionState == ConnectionState.active) {
          if (userSnapshot.hasData) {
            print('user already loggoin');
            return FirstScreen();
          } else {
               print('user did not loggin yet');
            return LandingPage();
          }
        } else if (userSnapshot.hasError) {
          return Center(
            child: Text('Error occurred'),
          );
        } else {
          return Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }
}
