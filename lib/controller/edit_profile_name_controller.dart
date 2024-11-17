import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/services/firebase/firebase%20auth/firestore_service.dart';
import 'package:flutter/material.dart';

class EditProfileNameController {
  final FirestoreService _service;

  EditProfileNameController(this._service);

  Future<void> updateUserName(
      {required String uid,
      required String firstName,
      required String lastName,
      required BuildContext context,
      required Function(String) updatedUserName}) async {
    try {
      await _service.updateUserField(uid, 'firstName', firstName);
      await _service.updateUserField(uid, 'lastName', lastName);

      updatedUserName('$firstName $lastName');

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
