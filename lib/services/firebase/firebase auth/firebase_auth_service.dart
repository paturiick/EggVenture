import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/models/user_auth.dart';
import 'package:eggventure/widgets/error%20widgets/signin_failed_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.YELLOW,
          ),
        );
      },
    );
  }

  Future<dynamic> signupUser(String lastName, String firstName,
      int userPhoneNumber, String userEmail, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: password,
      );

      UserAuthModel userAuthModel = UserAuthModel(
          lastName: lastName,
          firstName: firstName,
          userPhoneNumber: userPhoneNumber,
          userEmail: userEmail);

      final uid = getCurrentUserId();

      if (userCredential.user != null) {
        await _firestore
            .collection('userDetails')
            .doc(uid)
            .set(userAuthModel.toMap());
      }

      return userCredential.user;
    } catch (e) {
      return e;
    }
  }

  Future<void> sendEmailVerificationLink() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendPasswordResetLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  Future<User?> signIn(
      BuildContext context, String email, String password) async {
    try {
      _showLoadingDialog(context); // Show loading indicator

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pop(context); // Dismiss the loading indicator on success
      return userCredential.user;
    } catch (e) {
      Navigator.pop(context); // Dismiss the loading indicator on error
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  String getCurrentUserId() {
    User? user = _auth.currentUser;
    return user?.uid ?? '';
  }

  // Helper function to handle Firebase Auth errors
  String handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No user found for that email.';
        case 'wrong-password':
          return 'Incorrect password provided.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'user-disabled':
          return 'This user account has been disabled.';
        case 'too-many-requests':
          return 'Too many attempts. Please try again later.';
        default:
          return 'An unknown error occurred. Please try again.';
      }
    }
    return 'An error occurred. Please check your credentials and try again.';
  }

  registerWithEmailAndPassword(String text, String text2) {}
}