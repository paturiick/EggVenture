import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:eggventure/models/user_info.dart';

class UserInfoProvider with ChangeNotifier {
  UserInfo _userInfo = UserInfo(
      streetAddress: '',
      barangayAddress: '',
      cityAddress: '',
      provinceAddress: '',
      additionalInfo: '');

  static var userProfileStream;

  UserInfo get userInfo => _userInfo;

  Future<void> fetchUserInfoFromFirebase(String userId) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (doc.exists) {
      final data = doc.data();
      _userInfo = UserInfo(
        streetAddress: data?['streetAddress'] ?? '',
        barangayAddress: data?['barangayAddress'] ?? '',
        cityAddress: data?['cityAddress'] ?? '',
        provinceAddress: data?['provinceAddress'] ?? '',
        additionalInfo: data?['additionalInfo'] ?? '',
      );
      notifyListeners();
    }
  }

  void updateUserInfo(UserInfo newInfo) {
    _userInfo = newInfo;
    notifyListeners();
  }
  UserInfo getUserInfo() {
    return _userInfo;
  }
}
