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

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
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
  }
}
