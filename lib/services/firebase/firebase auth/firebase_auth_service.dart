import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/models/user_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String errorMessage;


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
          userEmail: userEmail,
          isSeller: false
      );

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

      // Check if the email is registered
      List<String> signInMethods =
          await _auth.fetchSignInMethodsForEmail(email);
      if (signInMethods.isEmpty) {
        Navigator.pop(context);
        errorMessage = 'User does not exist with these credentials.';
        return null;
      }

      // Proceed with sign-in if email exists
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pop(context); // Dismiss the loading indicator on success
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Dismiss the loading indicator on error

      // Handle specific errors
      if (e.code == 'wrong-password') {
        errorMessage =
            'The password you entered is incorrect. Please try again.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Email address format is invalid.';
      } else if (e.code == 'user-disabled') {
        errorMessage = 'This account has been disabled.';
      } else {
        errorMessage = 'An unexpected error occurred. Please try again.';
      }
      return null;
    } catch (e) {
      Navigator.pop(
          context); // Dismiss the loading indicator on unexpected error
      errorMessage = 'An error occurred. Please try again later.';
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
