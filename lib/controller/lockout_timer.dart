import 'dart:async';
import 'dart:ui';

import 'package:eggventure/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class LockoutTimer {
  
  int loginAttempts = 3;
  bool isLockedOut = false;

  void startLockoutTimer() {
    isLockedOut = true;
    loginAttempts = 3;

    Timer(const Duration(minutes: 1), () {
      isLockedOut = false;
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(
          content: Text(
            'You can now Log in again.',
            style: TextStyle(color: AppColors.BLUE),
          ),
          backgroundColor: AppColors.YELLOW,
        ),
      );
    });
  }
}