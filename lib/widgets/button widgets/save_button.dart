import 'package:flutter/material.dart';
import 'package:eggventure/constants/colors.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return TextButton(
      onPressed: onPressed,
      child: Text(
        "Save",
        style: TextStyle(
          color: AppColors.YELLOW,
          fontSize: screenWidth * 0.04,
        ),
      ),
    );
  }
}
