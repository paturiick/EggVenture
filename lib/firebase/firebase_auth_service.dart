import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //google sign in
  signInWithGoogle() async {
    //proceeds to sign in
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //if user cancels the sign in of google
    if (gUser == null) return;

    //auth details
    final GoogleSignInAuthentication? gAuth = await gUser!.authentication;

    //create new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth?.accessToken,
      idToken: gAuth?.idToken,
    );
    //sign in
    return await _firebaseAuth.signInWithCredential(credential);
  }
}
