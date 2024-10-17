import 'package:eggventure/constants/colors.dart';
import 'package:flutter/material.dart';

class ErrorToAddWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.RED,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), 
          topRight: Radius.circular(10))
      ),
      child: Text(
        'No items to add',
      ),
    );
  }
}
