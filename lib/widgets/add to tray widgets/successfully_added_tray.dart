import 'package:eggventure/controller/custom_transition.dart';
import 'package:flutter/material.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/providers/add_to_tray_provider.dart';
import 'package:provider/provider.dart';

class SuccessfullyAddedTray {
  static void showSuccessAddedTray(
    BuildContext context, {
    required VoidCallback onContinueBrowsing,
    required VoidCallback onViewTray,
  }) {
    final trayProvider = Provider.of<AddToTrayProvider>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;

    // Call the custom transition dialog
    showCustomTransitionDialog(
      context: context,
      dialogContent: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 80.0,
                width: 80.0,
                child: Image.asset(
                  "assets/icons/successfully_added.png",
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                "Successfully Added!",
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: AppColors.BLUE,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onContinueBrowsing();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.YELLOW,
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 15.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  "Continue Browsing",
                  style: TextStyle(
                    color: AppColors.BLUE,
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onViewTray();
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 15.0,
                  ),
                  side: BorderSide(
                    color: AppColors.YELLOW,
                    width: 2.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  "View Tray",
                  style: TextStyle(
                    color: AppColors.YELLOW,
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
