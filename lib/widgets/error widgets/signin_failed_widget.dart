import 'package:flutter/material.dart';
import 'package:eggventure/constants/colors.dart';

class SigninFailedWidget extends StatefulWidget {
  final String message;
  final Duration duration;

  const SigninFailedWidget({
    Key? key,
    required this.message,
    this.duration = const Duration(seconds: 3),
  }) : super(key: key);

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
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the slide-in animation
    _controller.forward();

    // Auto-dismiss after the specified duration
    Future.delayed(widget.duration, () {
      if (mounted)
        _controller.reverse().then((_) => Navigator.of(context).pop());
    });
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
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
              size: screenWidth * 0.05,
              color: Colors.white,
            ),
            SizedBox(width: screenWidth * 0.02),
            Expanded(
              child: Text(
                widget.message,
                style: TextStyle(
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
    );
  }
}

// Function to show the FloatingSnackbar
void showFloatingSnackbar(BuildContext context, String message) {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) => Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SigninFailedWidget(message: message),
        ),
      ),
    ),
  );
}
