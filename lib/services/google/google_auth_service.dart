import 'package:eggventure/pages/consumer_screens/main_consumer/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> signInwithGoogle(BuildContext context) async {
  try {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return null; // Sign-in was canceled by the user.
    }

    GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Attempt sign-in with Firebase
    UserCredential userCredential = 
        await FirebaseAuth.instance.signInWithCredential(credential);

    print("Signed in as ${userCredential.user?.displayName}");

    // Navigate to HomeScreen if sign-in is successful
    if (userCredential.user != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
    }

    return userCredential;
  } catch (e) {
    print("Error signing in with Google: $e");
    return null;
  }
}
