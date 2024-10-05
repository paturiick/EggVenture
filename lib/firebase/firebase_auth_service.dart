import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<dynamic> signupUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } catch (e) {
      return e;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
// Use signInWithEmailAndPassword to log in an existing user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user; // Return the logged-in user
    } catch (e) {
      print("Sign in failed: $e"); // Log the error for debugging
      return null; // Return null in case of an error
    }
  }

  //google sign in
  Future<dynamic> signInWithGoogle() async {
    //proceeds to sign in
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //if user cancels the sign in of google
    if (gUser == null) return;

    //auth details
    final GoogleSignInAuthentication? gAuth = await gUser.authentication;

    //create new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth?.accessToken,
      idToken: gAuth?.idToken,
    );
    //sign in
    return await _auth.signInWithCredential(credential);
  }
}
