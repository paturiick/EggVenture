import 'dart:async';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/services/firebase/firebase%20auth/firebase_auth_service.dart';
import 'package:eggventure/services/firebase/firebase%20auth/firestore_service.dart';
import 'package:eggventure/services/google/google_auth_service.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/pages/consumer_screens/main_consumer/home_screen.dart';
import 'package:eggventure/pages/consumer_screens/login/signup_screen.dart';
import 'package:eggventure/pages/consumer_screens/login/welcome_screen.dart';
import 'package:eggventure/widgets/error%20widgets/lockout_timer.dart'
    as lockout;
import 'package:eggventure/widgets/error%20widgets/signin_failed_widget.dart'
    as signin;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _isChecked = false;
  bool _isPasswordVisible = false;
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;
  bool _autoValidate = false;
  bool isLockedOut = false;
  int loginAttempts = 7;

  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirestoreService _firestoreService = FirestoreService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  Map<String, dynamic>? _userData; // Store user data from Facebook login
  AccessToken? _accessToken;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_handleFocusChange);
    _passwordFocusNode.addListener(_handleFocusChange);
    _checkIfIsLoggedIn(); // Check if the user is already logged in
  }

  void _handleFocusChange() {
    setState(() {
      _isEmailFocused = _emailFocusNode.hasFocus;
      _isPasswordFocused = _passwordFocusNode.hasFocus;
    });
  }

  void _toggleFocus(FocusNode focusNode) {
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    } else {
      focusNode.requestFocus();
    }
  }

  Future<bool> _onWillPop() async {
    if (_emailFocusNode.hasFocus || _passwordFocusNode.hasFocus) {
      _emailFocusNode.unfocus();
      _passwordFocusNode.unfocus();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Check if the user is logged in via Facebook
  Future<void> _checkIfIsLoggedIn() async {
    final accessToken = await FacebookAuth.instance.accessToken;

    if (accessToken != null) {
      final userData = await FacebookAuth.instance.getUserData();
      setState(() {
        _accessToken = accessToken;
        _userData = userData;
      });
    }
  }

  // Facebook login function
  Future<void> _loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      final userData = await FacebookAuth.instance.getUserData();
      setState(() {
        _userData = userData;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      print("Facebook login failed: ${result.message}");
    }
  }

  // Facebook logout function
  Future<void> _logoutFromFacebook() async {
    await FacebookAuth.instance.logOut();
    setState(() {
      _accessToken = null;
      _userData = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Size size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: _onWillPop,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: Container(
              width: double.infinity,
              height: size.height,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.1),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return WelcomeScreen();
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/Eggventure.png',
                            width: size.width * 0.25,
                          ),
                          SizedBox(width: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'E',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.width * 0.09,
                                  color: AppColors.YELLOW,
                                ),
                              ),
                              Text(
                                'GG',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.width * 0.06,
                                  color: AppColors.BLUE,
                                ),
                              ),
                              Text(
                                'V',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.width * 0.09,
                                  color: AppColors.YELLOW,
                                ),
                              ),
                              Text(
                                'ENTURE',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.width * 0.06,
                                  color: AppColors.BLUE,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: AppColors.YELLOW),
                      ),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: _autoValidate
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        child: Column(
                          children: [
                            Text(
                              'Welcome Back!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: AppColors.BLUE,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Log-In to your account',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.BLUE,
                              ),
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () => _toggleFocus(_emailFocusNode),
                              child: TextFormField(
                                cursorColor: AppColors.YELLOW,
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  labelStyle: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.BLUE,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.YELLOW)),
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.email),
                                ),
                                style: TextStyle(
                                    fontSize: 12, color: AppColors.BLUE),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () => _toggleFocus(_passwordFocusNode),
                              child: TextFormField(
                                cursorColor: AppColors.YELLOW,
                                controller: _passwordController,
                                obscureText: !_isPasswordVisible,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.BLUE,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.YELLOW)),
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                    child: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                    fontSize: 12, color: AppColors.BLUE),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    User? user = await _auth.signIn(
                                      context,
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                    );
                                    if (user != null) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()),
                                        (Route<dynamic> route) => false,
                                      );
                                    } else {
                                      if (isLockedOut) {
                                        lockout.showLockoutOverlay(context,
                                            'Locked out, please wait for 1 minute');
                                        return;
                                      }
                                      if (loginAttempts == 1) {
                                        lockout.showLockoutOverlay(context,
                                            'Login attempts expired, please wait 1 minute');
                                        lockout.startLockoutTimer(context, () {
                                          setState(() {
                                            isLockedOut = false;
                                            loginAttempts = 7;
                                          });
                                        });
                                      } else {
                                        loginAttempts--;
                                        String errorMessage = _auth.errorMessage;
                                        signin.showFloatingSnackbar(context, errorMessage);
                                      }
                                    }
                                  }
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                          value: _isChecked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              _isChecked = value ?? false;
                                            });
                                          },
                                          activeColor: AppColors.YELLOW,
                                          checkColor: AppColors.BLUE,
                                        ),
                                        Text(
                                          "Remember me",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.BLUE),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                AppRoutes.FORGOTPASSWORD);
                                          },
                                          child: Text(
                                            "Forgot Password?",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.BLUE),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.02,
                                    ),
                                    Container(
                                      width: size.width,
                                      height: size.height * 0.06,
                                      decoration: BoxDecoration(
                                        color: AppColors.YELLOW,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Sign In',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: AppColors.BLUE,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
// OR Line Separator
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.shade400,
                                    thickness: 1,
                                    endIndent: 10,
                                  ),
                                ),
                                Text(
                                  "or",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.shade400,
                                    thickness: 1,
                                    indent: 10,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            // Google Sign-In Button
                            GestureDetector(
                              onTap: () async {
                                UserCredential? userCredential =
                                    await signInwithGoogle(context);

                                if (userCredential != null) {
                                  print(
                                      'Signed in as: ${userCredential.user?.displayName}');
                                } else {
                                  print('Sign in failed');
                                }
                              },
                              child: Container(
                                width: size.width,
                                height: size.height * 0.06,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.BLUE.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1.0, // Border width
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/google_icon.svg', // Google icon SVG
                                      height: 16,
                                      width: 16,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Continue with Google',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.BLUE,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
// Facebook Sign-In Button with Decoration
                            if (_accessToken == null)
                              GestureDetector(
                                onTap: _loginWithFacebook,
                                child: Container(
                                  width: size.width,
                                  height: size.height * 0.06,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.BLUE.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset:
                                            Offset(0, 4), // Shadow positioning
                                      ),
                                    ],
                                    border: Border.all(
                                      color:
                                          Colors.grey.shade300, // Border color
                                      width: 1.0, // Border width
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/fb_icon.svg',
                                        height: 16,
                                        width: 16,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Continue with Facebook',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: AppColors.BLUE,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.BLUE,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignupScreen()),
                                    );
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: AppColors.YELLOW,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
