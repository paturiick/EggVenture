import 'package:flutter/material.dart';
import 'package:eggventure/constants/colors.dart';

class SigninFailedWidget extends StatefulWidget {
  @override
  _SigninFailedWidgetState createState() => _SigninFailedWidgetState();
}

class _SigninFailedWidgetState extends State<SigninFailedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SlideTransition(
      position: _offsetAnimation, // Slide animation
      child: Container(
        margin: EdgeInsets.only(top: 5),
        padding:
            EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.RED,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_outlined,
              size: screenWidth * 0.05,
              color: Colors.white,
            ),
            SizedBox(width: screenWidth * 0.01),
            Text(
              "Sign-in Failed. Please try again.",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.03,
                decoration: TextDecoration.none,
              ),
            )
          ],
        ),
      ),
    );
  }
}

OverlayEntry? _currentSignInFailedOverlay;

void showSignInFailedOverlay(BuildContext context) {
  if (_currentSignInFailedOverlay != null) {
    return; // If an overlay is already being shown, do nothing
  }

  OverlayState overlayState = Overlay.of(context)!;
  _currentSignInFailedOverlay = OverlayEntry(
    builder: (context) => Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.05,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          child: Center(
            child: SigninFailedWidget(),
          ),
        ),
      ],
    ),
  );

  // Insert the overlay entry
  overlayState.insert(_currentSignInFailedOverlay!);

  Future.delayed(Duration(milliseconds: 900), () {
    _currentSignInFailedOverlay?.remove();
    _currentSignInFailedOverlay = null;
  });
}
