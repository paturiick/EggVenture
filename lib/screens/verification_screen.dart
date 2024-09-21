import 'package:eggventure/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Getting the width and height of the screen
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/Eggventure.png",
                        width: screenWidth * 0.25,
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'E',
                              style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                fontWeight: FontWeight.w700,
                                fontSize: screenWidth * 0.09,
                                color: Color(0xFFF9B514),
                              ),
                            ),
                            TextSpan(
                              text: 'GG',
                              style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                fontWeight: FontWeight.w700,
                                fontSize: screenWidth * 0.07,
                                color: Color(0xFF353E55),
                              ),
                            ),
                            TextSpan(
                              text: 'V',
                              style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                fontWeight: FontWeight.w700,
                                fontSize: screenWidth * 0.09,
                                color: Color(0xFFF9B514),
                              ),
                            ),
                            TextSpan(
                              text: 'ENTURE',
                              style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                fontWeight: FontWeight.w700,
                                fontSize: screenWidth * 0.07,
                                color: Color(0xFF353E55),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Container with border and padding
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.03,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Color(0xFFF9B514)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Verification code',
                          style: TextStyle(
                            fontFamily: 'AvenirNextCyr',
                            fontSize:
                                screenWidth * 0.06, // Responsive text size
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF353E55),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Text(
                          'Please enter the verification code sent to \n "phone number"',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF353E55),
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),

                        // Verification Code Input
                        PinCodeTextField(
                          keyboardType: TextInputType.number,
                          appContext: context,
                          length: 4,
                          obscureText: false,
                          controller: _pinController,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: screenWidth * 0.16,
                            fieldWidth: screenWidth * 0.16,
                            activeColor: Color(0xFF353E55),
                            inactiveColor: Colors.grey[300],
                            selectedColor: Color(0xFFFFB612),
                          ),
                          onChanged: (value) {
                            print(value);
                          },
                        ),

                        SizedBox(height: screenHeight * 0.01),
                        TextButton(
                          onPressed: () {
                            // Add resend logic
                          },
                          child: Text(
                            'Resend code',
                            style: TextStyle(
                              color: Color(0xFF353E55),
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.05,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SigninScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFB612),
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.25,
                              vertical: screenHeight * 0.02,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              color: Color(0xFF353E55),
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.08,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        TextButton(
                          onPressed: () {
                            // Add change email logic
                          },
                          child: Text(
                            'Change Email',
                            style: TextStyle(
                              color: Color(0xFF353E55),
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.05,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
