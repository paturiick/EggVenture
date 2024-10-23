import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthService {
  AccessToken? _accessToken;
  Map<String, dynamic>? _userData;

  // Facebook login function
  Future<Map<String, dynamic>?> loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      _userData = await FacebookAuth.instance.getUserData();
      return _userData; // Return the user data on successful login
    } else {
      print("Facebook login failed: ${result.message}");
      return null;
    }
  }

  // Facebook logout function
  Future<void> logoutFromFacebook() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
  }
}
