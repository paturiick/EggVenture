import 'package:flutter/material.dart';
import 'package:eggventure/constants/colors.dart';

class ErrorToBuyWidget extends StatefulWidget {
  @override
  _ErrorToBuyWidgetState createState() => _ErrorToBuyWidgetState();
}

class _ErrorToBuyWidgetState extends State<ErrorToBuyWidget>
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
            EdgeInsets.symmetric(vertical: 8, horizontal: screenWidth * 0.02),
        decoration: BoxDecoration(
          color: AppColors.RED,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_outlined,
              size: screenWidth * 0.06,
              color: Colors.white,
            ),
            SizedBox(width: screenWidth * 0.02),
            Text(
              "No Item(s) to Buy",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.04,
                decoration: TextDecoration.none,
              ),
            )
          ],
        ),
      ),
    );
  }
}

OverlayEntry? _currentErrorOverlay;

void showErrortoBuyOverlay(BuildContext context) {
  if (_currentErrorOverlay != null) {
    return; // If an overlay is already being shown, do nothing
  }

  OverlayState overlayState = Overlay.of(context);
  _currentErrorOverlay = OverlayEntry(
    builder: (context) => Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.05,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          child: Center(
            child: ErrorToBuyWidget(),
          ),
        ),
      ],
    ),
  );

  // Insert the overlay entry
  overlayState.insert(_currentErrorOverlay!);

  Future.delayed(Duration(milliseconds: 900), () {
    _currentErrorOverlay?.remove();
    _currentErrorOverlay = null;
  });
}
