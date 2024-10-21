import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/models/user_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;  

  Future<dynamic> signupUser(
    String lastName,
    String firstName,
    int userPhoneNumber,
    String userEmail, 
    String password
    ) async {
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
        userEmail: userEmail
      );

      final uid = getCurrentUserId();

      if (userCredential.user != null) {
        await _firestore.collection('userDetails').doc(uid).set(userAuthModel.toMap());
      }

      return userCredential.user;
    } catch (e) {
      return e;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user; 
    } catch (e) {
      print("Sign in failed: $e"); 
      return null; 
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  //[Google Authentication] - Google Signin
  Future <UserCredential?> signInwithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = await GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    print(userCredential.user?.displayName);
    return null;
  }

  String getCurrentUserId(){
    User? user = _auth.currentUser;
    return user?.uid ?? '';
  }
}
