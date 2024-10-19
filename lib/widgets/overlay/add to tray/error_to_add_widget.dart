import 'package:flutter/material.dart';
import 'package:eggventure/constants/colors.dart';

class ErrorToAddWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(8),
      color: Colors.transparent,
      child: Text(
        "No Item(s) to Add",
        style: TextStyle(
          color: AppColors.RED,
          fontSize: screenWidth * 0.03,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}

// This will hold the currently displayed overlay entry (if any)
OverlayEntry? _currentErrorOverlay;

// Method to show the error overlay when no items are selected
void showErrorOverlay(BuildContext context) {
  // Check if there is already an error overlay being displayed
  if (_currentErrorOverlay != null) {
    return; // If an overlay is already present, do nothing
  }

  OverlayState overlayState = Overlay.of(context);
  _currentErrorOverlay = OverlayEntry(
    builder: (context) => Stack(
      children: [
        Positioned(
          // Position the error message slightly above the button
          bottom: 53, // Button's bottom position
          left: MediaQuery.of(context).size.width * 0.50,
          right: MediaQuery.of(context).size.width * 0.1,
          child: ErrorToAddWidget(), // Show the error widget without animation
        ),
      ],
    ),
  );

  // Insert the overlay entry
  overlayState.insert(_currentErrorOverlay!);

  // Remove the overlay after 900 milliseconds and reset the reference
  Future.delayed(Duration(milliseconds: 900), () {
    _currentErrorOverlay?.remove();
    _currentErrorOverlay = null; // Reset so another error can be shown later
  });
}
