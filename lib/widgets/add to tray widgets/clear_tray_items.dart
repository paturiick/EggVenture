import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/providers/add_to_tray_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClearTrayItemsDialog {
  static Future<void> showClearTrayDialog(BuildContext context) async {
    final trayProvider = Provider.of<AddToTrayProvider>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Clear Tray Items',
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: AppColors.RED,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Are you sure you want to clear all items?',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: AppColors.BLUE,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: AppColors.RED,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(
                'Clear All',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: AppColors.BLUE,
                ),
              ),
              onPressed: () {
                trayProvider.clearTray(); // Clear the tray items
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
