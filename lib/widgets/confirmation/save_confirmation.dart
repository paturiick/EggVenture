import 'package:eggventure/constants/colors.dart';
import 'package:flutter/material.dart';

void showSaveConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Information Saved",
        style: TextStyle(
          color: AppColors.BLUE
        ),),
        content: Text("Your information has been successfully saved!",
        style: TextStyle(
          color: AppColors.BLUE
        ),),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}