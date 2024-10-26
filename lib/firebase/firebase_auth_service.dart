import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/models/user_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<User?> signIn(
      BuildContext context, String email, String password) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.YELLOW,
            ),
          );
        });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pop(context);
      
      return userCredential.user;
    } catch (e) {
      print("Sign in failed: $e");
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

  registerWithEmailAndPassword(String text, String text2) {}
}
