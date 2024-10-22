import 'package:flutter/material.dart';

void showCustomTransitionDialog({
  required BuildContext context,
  required Widget dialogContent,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return dialogContent;
    },
    transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      // Using Fade transition
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
          child: child,
        ),
      );
    },
    transitionDuration: Duration(milliseconds: 200),
  );
}
