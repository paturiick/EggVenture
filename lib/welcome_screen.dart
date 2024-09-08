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
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background image with drop shadow (top)
            Positioned(
              top: 59,
              child: Container(
                width: 400, // Fixed width
                height: 500, // Fixed height
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
                  child: Image.asset(
                    'assets/BG Home - EggVenture.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Background image with layer blur (top)
            Positioned(
              top: 0,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(20.0), // Adjust the radius as needed
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/BG Home - EggVenture.png',
                      width: 400, // Fixed width
                      height: 500, // Fixed height
                      fit: BoxFit.cover,
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: 5.0,
                          sigmaY: 5.0), // Adjust the blur radius as needed
                      child: Container(
                        width: 400,
                        height: 500,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(20.0), // Adjust the radius as needed
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/Bottom BG.jpeg',
                      width: 400, // Fixed width
                      height: 360, // Fixed height
                      fit: BoxFit.cover,
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: 5.0,
                          sigmaY: 5.0), // Adjust the blur radius as needed
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Foreground image
            Align(
              alignment: Alignment(
                  0.0, -0.2), // Adjust the vertical alignment to move it up
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/Eggventure.png',
                    width: 200, // Fixed width
                    height: 200, // Fixed height
                    fit: BoxFit.contain,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'E',
                          style: TextStyle(
                            fontFamily: 'AvenirNextCyr',
                            fontWeight: FontWeight.w700, // Semibold weight
                            fontSize: 44,
                            color: Color(0xFFF9B514), // Color from the palette
                          ),
                        ),
                        TextSpan(
                          text: 'GG',
                          style: TextStyle(
                            fontFamily: 'AvenirNextCyr',
                            fontWeight: FontWeight.w700, // Semibold weight
                            fontSize: 32,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                        TextSpan(
                          text: 'V',
                          style: TextStyle(
                            fontFamily: 'AvenirNextCyr',
                            fontWeight: FontWeight.w700, // Semibold weight
                            fontSize: 44,
                            color: Color(0xFFF9B514), // Color from the palette
                          ),
                        ),
                        TextSpan(
                          text: 'ENTURE',
                          style: TextStyle(
                            fontFamily: 'AvenirNextCyr',
                            fontWeight: FontWeight.bold, // Semibold weight
                            fontSize: 32,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height:
                          10), // Increased space between "EggVenture" and the new text
                  Column(
                    children: [
                      Text(
                        'Get Your Fresh Eggs',
                        style: TextStyle(
                          fontFamily: 'AvenirNextCyr',
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Color(0xFF353E55),
                        ),
                      ),
                      Text(
                        'Delivered at your Doorstep',
                        style: TextStyle(
                          fontFamily: 'AvenirNextCyr',
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Color(0xFF353E55),
                        ),
                      ),
                      Text(
                        '“From egg farms to your home: Fresh eggs just a few clicks away.”',
                        style: TextStyle(
                          fontFamily: 'AvenirNextCyr',
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
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
              bottom: 50,
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
                        width: 250,
                        decoration: BoxDecoration(
                          color: Color(0xFFF9B514),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        child: Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontFamily: 'AvenirNextCyr',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFF353E55),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
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
                        width: 250,
                        decoration: BoxDecoration(
                          color: Color(0xFF353E55),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Color(0xFF353E55)),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontFamily: 'AvenirNextCyr',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
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
