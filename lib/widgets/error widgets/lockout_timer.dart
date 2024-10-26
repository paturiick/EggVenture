import 'dart:async';
import 'package:flutter/material.dart';
import 'package:eggventure/constants/colors.dart';

OverlayEntry? _currentLockoutOverlay;
bool _isOverlayVisible = false;
int loginAttempts = 7;
bool isLockedOut = false;

void startLockoutTimer(BuildContext context, [VoidCallback? onTimerEnd]) {
  isLockedOut = true;
  loginAttempts = 7;

  Timer(const Duration(minutes: 1), () {
    isLockedOut = false;
    onTimerEnd?.call();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'You can now log in again.',
          style: TextStyle(color: AppColors.BLUE),
        ),
        backgroundColor: AppColors.YELLOW,
      ),
    );
  });
}

void showLockoutOverlay(BuildContext context, String message,
    {TextStyle? textStyle}) {
  if (_isOverlayVisible)
    return; // If an overlay is already being shown, do nothing

  final overlayState = Overlay.of(context);
  if (overlayState == null) return;

  _currentLockoutOverlay = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).size.height * 0.05,
      left: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
      child: SlideTransitionOverlay(message: message, textStyle: textStyle),
    ),
  );

  overlayState.insert(_currentLockoutOverlay!);
  _isOverlayVisible = true;

  // Remove overlay after a delay
  Future.delayed(const Duration(seconds: 3), () {
    _currentLockoutOverlay?.remove();
    _currentLockoutOverlay = null;
    _isOverlayVisible = false;
  });
}

class SlideTransitionOverlay extends StatefulWidget {
  final String message;
  final TextStyle? textStyle;

  const SlideTransitionOverlay({
    required this.message,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  @override
  _SlideTransitionOverlayState createState() => _SlideTransitionOverlayState();
}

class _SlideTransitionOverlayState extends State<SlideTransitionOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

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
      position: _offsetAnimation,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.RED,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.error_outline_outlined,
              color: Colors.white,
              size: screenWidth * 0.04,
            ),
            Text(
              widget.message,
              style: widget.textStyle ??
                  TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.03,
                    decoration: TextDecoration.none,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
