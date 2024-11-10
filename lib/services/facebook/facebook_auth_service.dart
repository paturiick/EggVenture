import 'package:eggventure/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:path/path.dart';

class FacebookAuthService {
  AccessToken? _accessToken;
  Map<String, dynamic>? _userData;
  bool _isDataFetched = false; // Add this flag

  // Facebook login function
  Future<Map<String, dynamic>?> loginWithFacebook(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login();
    try {
      if (result.status == LoginStatus.success) {
        _accessToken = result.accessToken;
        _userData = await FacebookAuth.instance.getUserData();
        _isDataFetched = true; // Set flag to true after fetching
        return _userData;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.YELLOW,
            content: Text(
              "Facebook log-in failed: ${result.message}",
              style: TextStyle(color: AppColors.BLUE),
            )));
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColors.YELLOW,
          content: Text(
            "An error occurred: ${result.status}",
            style: TextStyle(color: AppColors.BLUE),
          )));
    }
  }

  Future<Map<String, dynamic>?> fetchUserFacebook(BuildContext context) async {
    // Check if data has already been fetched
    if (_isDataFetched && _userData != null) {
      return _userData;
    }

    try {
      if (_accessToken != null) {
        _userData = await FacebookAuth.instance.getUserData();
        _isDataFetched = true; // Set flag after successful fetch
        return _userData;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColors.YELLOW,
            content: Text(
              "User not logged in with Facebook",
              style: TextStyle(color: AppColors.BLUE),
            )));
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Reset flag on logout
  Future<void> logoutFromFacebook() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    _isDataFetched = false;
  }

  Future<bool> isFacebookLoggedIn() async {
    _accessToken = await FacebookAuth.instance.accessToken;
    return _accessToken != null;
  }
}
