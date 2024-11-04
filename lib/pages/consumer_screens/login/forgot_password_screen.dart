import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/services/firebase/firebase%20auth/firebase_auth_service.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _form = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final _emailAddress = TextEditingController();
  final _auth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: AppColors.BLUE.withOpacity(0.2),
                      offset: Offset(0, 2),
                      blurRadius: 5,
                      spreadRadius: 5,
                    )
                  ]),
                  child: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.BLUE,
                      ),
                    ),
                    centerTitle: true,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
                          controller: _emailAddress,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            color: AppColors.BLUE,
                            fontSize: screenWidth * 0.03,
                          ),
                          decoration: InputDecoration(
                            labelText:
                                "Enter your email address to reset password",
                            labelStyle: TextStyle(
                              color: AppColors.BLUE,
                              fontSize: screenWidth * 0.03,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.YELLOW),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Back",
                                  style: TextStyle(
                                      color: AppColors.BLUE,
                                      fontSize: screenWidth * 0.03),
                                )),
                            Spacer(),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.YELLOW,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () async {
                                  if (_emailAddress.text.isEmpty) {
                                    Future.delayed(Duration(seconds: 2));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            backgroundColor: AppColors.RED,
                                            content: Text(
                                              "Please fill out your email address",
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.03,
                                                  color: Colors.white),
                                            )));
                                  } else {
                                    await _auth.sendPasswordResetLink(
                                        _emailAddress.text);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            backgroundColor: AppColors.YELLOW,
                                            content: Text(
                                              "An email for password reset has been sent",
                                              style: TextStyle(
                                                  color: AppColors.BLUE,
                                                  fontSize: screenWidth * 0.03),
                                            )));
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  "Send Email",
                                  style: TextStyle(
                                      color: AppColors.BLUE,
                                      fontSize: screenWidth * 0.03),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
