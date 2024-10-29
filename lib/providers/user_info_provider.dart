import 'package:eggventure/models/user_info.dart';
import 'package:flutter/material.dart';

class UserInfoProvider with ChangeNotifier {
  UserInfo _userInfo = UserInfo(
      firstName: '',
      lastName: '',
      streetAddress: '',
      barangayAddress: '',
      cityAddress: '',
      provinceAddress: '',
      additionalInfo: '');

  UserInfo get userInfo => _userInfo;

  void updateUserInfo(UserInfo newInfo) {
    _userInfo = newInfo;
    notifyListeners();
  }

  void updateNameInfo({String? firstName, String? lastName}) {
    if (firstName != null) _userInfo.firstName = firstName;
    if (lastName != null) _userInfo.lastName = lastName;
    notifyListeners();
  }
}
