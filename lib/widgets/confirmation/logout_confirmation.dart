import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/firebase/firebase_auth_service.dart';
import 'package:eggventure/screens/consumer_screens/login/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LogoutConfirmation {
  static Future<void> showLogOutConfirmation(BuildContext context) async {
    final screenWidth = MediaQuery.of(context).size.width;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Are you sure you want to log out your account?',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: AppColors.BLUE,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: AppColors.RED,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                'Log out',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  color: AppColors.BLUE,
                ),
              ),
              onPressed: () {
                FirebaseAuthService().signOut();
                FacebookAuth.instance.logOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SigninScreen()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
