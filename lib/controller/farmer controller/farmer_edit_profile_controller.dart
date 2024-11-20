import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/services/firebase/firebase%20auth/firestore_service.dart';
import 'package:flutter/material.dart';

class FarmerEditProfileController {
  final FirestoreService _service;

  FarmerEditProfileController(this._service);

  Future<void> updateShopName(
      {required String uid,
      required String shopName,
      required BuildContext context,
      required Function(String) updatedShopName}) async {
    try {
      await _service.updateUserField(uid, 'shopName', shopName);

      updatedShopName('$shopName');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColors.YELLOW,
          content: Text(
            "Profile updated successfully!",
            style: TextStyle(color: AppColors.BLUE),
          )));
    } catch (e) {
      print("Error occured when updating profile ${e}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColors.YELLOW,
          content: Text(
            "Failed to update profile.Please try again",
            style: TextStyle(color: AppColors.BLUE),
          )));
    }
  }
}
