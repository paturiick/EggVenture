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
  if (_isOverlayVisible) return; // Prevent multiple overlays

  final overlayState = Overlay.of(context);

  _currentLockoutOverlay = OverlayEntry(
    builder: (context) => Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SlideTransitionOverlay(
          message: message,
          textStyle: textStyle,
        ),
      ),
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
      begin: const Offset(0.0, 1.0),
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
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.RED,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_outlined,
                color: Colors.white,
                size: screenWidth * 0.05,
              ),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                child: Text(
                  widget.message,
                  style: widget.textStyle ??
                      TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.035,
                        decoration: TextDecoration.none,
                      ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
