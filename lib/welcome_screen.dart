import 'dart:ui';
import 'package:eggventure/screens/signin_screen.dart';
import 'package:eggventure/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background image with drop shadow (top)
            Positioned(
              top: 0.07, // Adjusted relative to screen height
              child: Container(
                width: screenWidth * 0.9, // 90% of the screen width
                height: screenHeight * 0.5, // 50% of the screen height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 189, 188, 188).withOpacity(0.5),
                      spreadRadius: 12,
                      blurRadius: 20,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/BG Home - EggVenture.png',
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.5,
                        fit: BoxFit.cover,
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.5,
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom image with blur effect
            Positioned(
              bottom: screenHeight * 0.02, // Positioned relative to bottom
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/Bottom BG.jpeg',
                      width: screenWidth * 0.9, // Responsive width
                      height: screenHeight * 0.3, // Responsive height
                      fit: BoxFit.fill,
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.3,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Foreground logo and text
            Align(
              alignment: Alignment(0.0, -0.2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/Eggventure.png',
                    width: screenWidth * 0.4, // Scaled relative to screen width
                    height: screenWidth *
                        0.4, // Make the height proportional to width
                    fit: BoxFit.contain,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'E',
                          style: TextStyle(
                            fontFamily: 'AvenirNextCyr',
                            fontWeight: FontWeight.w700,
                            fontSize:
                                screenWidth * 0.12, // Responsive font size
                            color: Color(0xFFF9B514),
                          ),
                        ),
                        TextSpan(
                          text: 'GG',
                          style: TextStyle(
                            fontFamily: 'AvenirNextCyr',
                            fontWeight: FontWeight.w700,
                            fontSize: screenWidth * 0.09,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        TextSpan(
                          text: 'V',
                          style: TextStyle(
                            fontFamily: 'AvenirNextCyr',
                            fontWeight: FontWeight.w700,
                            fontSize: screenWidth * 0.12,
                            color: Color(0xFFF9B514),
                          ),
                        ),
                        TextSpan(
                          text: 'ENTURE',
                          style: TextStyle(
                            fontFamily: 'AvenirNextCyr',
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.09,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01), // Responsive spacing
                  Column(
                    children: [
                      Text(
                        'Get Your Fresh Eggs',
                        style: TextStyle(
                          fontFamily: 'AvenirNextCyr',
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.06,
                          color: Color(0xFF353E55),
                        ),
                      ),
                      Text(
                        'Delivered at your Doorstep',
                        style: TextStyle(
                          fontFamily: 'AvenirNextCyr',
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.06,
                          color: Color(0xFF353E55),
                        ),
                      ),
                      Text(
                        '“From egg farms to your home: Fresh eggs just a few clicks away.”',
                        style: TextStyle(
                          fontFamily: 'AvenirNextCyr',
                          fontStyle: FontStyle.italic,
                          fontSize: screenWidth * 0.04,
                          color: Color(0xFF353E55),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Sign In and Sign Up buttons
            Positioned(
              bottom: screenHeight * 0.08, // Adjusted for responsiveness
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SigninScreen();
                          },
                        ),
                      );
                    },
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: screenWidth * 0.6,
                        decoration: BoxDecoration(
                          color: Color(0xFFF9B514),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.07,
                            vertical: screenHeight * 0.02),
                        child: Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontFamily: 'AvenirNextCyr',
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.05,
                              color: Color(0xFF353E55),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignupScreen();
                          },
                        ),
                      );
                    },
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: screenWidth * 0.6,
                        decoration: BoxDecoration(
                          color: Color(0xFF353E55),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Color(0xFF353E55)),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.07,
                            vertical: screenHeight * 0.02),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontFamily: 'AvenirNextCyr',
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.05,
                              color: Color(0xFFF9B514),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
