import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/firebase/firebase_auth_service.dart';
import 'package:eggventure/screens/home_screen.dart';
import 'package:eggventure/screens/login%20screens/signup_screen.dart';
import 'package:eggventure/screens/login%20screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _isChecked = false;
  bool _isPasswordVisible = false;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;
  bool _autoValidate = false;

  final FirebaseAuthService _auth = FirebaseAuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

  // void _signIn() {
  //  setState(() {
//      _autoValidate = true;
  // });
//
//    if (_formKey.currentState!.validate()) {
  // Proceed with the sign-in process
  //     Navigator.pushReplacement(
  //       context,
//MaterialPageRoute(
  ///        builder: (context) => HomeScreen(),
  //     ),
////);
  //   } else {
  //     print("Form is not valid. Display error messages.");
//}
  // }

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
    final emailString = _emailController.text.trim();
    final passwordString = _passwordController.text.trim();

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
                                color: Color(0xFF353E55),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Log-In to your account',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF353E55),
                              ),
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () => _toggleFocus(_emailFocusNode),
                              child: TextFormField(
                                cursorColor: AppColors.YELLOW,
                                controller: _emailController,
                                focusNode: _emailFocusNode,
                                decoration: InputDecoration(
                                  labelText: 'Email Address or Phone Number',
                                  labelStyle: TextStyle(
                                      fontSize: 10, color: AppColors.BLUE),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: _isEmailFocused
                                          ? AppColors.YELLOW
                                          : Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.YELLOW,
                                      width: 2.0,
                                    ),
                                  ),
                                  prefixIcon: Icon(Icons.email),
                                ),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF353E55),
                                    fontWeight: FontWeight.normal),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email or number';
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
                                focusNode: _passwordFocusNode,
                                obscureText: !_isPasswordVisible,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      fontSize: 10, color: AppColors.BLUE),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: _isPasswordFocused
                                          ? AppColors.YELLOW
                                          : Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.YELLOW,
                                      width: 2.0,
                                    ),
                                  ),
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
                                    fontSize: 12,
                                    color: Color(0xFF353E55),
                                    fontWeight: FontWeight.normal),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _isChecked,
                                      onChanged: (value) {
                                        setState(() {
                                          _isChecked = value!;
                                        });
                                      },
                                      activeColor: AppColors.YELLOW,
                                    ),
                                    Text(
                                      'Remember me',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: AppColors.BLUE),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                        fontFamily: 'AvenirNextCyr',
                                        fontSize: 11,
                                        color: AppColors.BLUE),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            GestureDetector(
                              onTap: () async {
                                User? user = await _auth.signIn(
                                    emailString, passwordString);
                                debugPrint('signup clicked');
                                user != null
                                    ? Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()),
                                        (Route<dynamic> route) => false,
                                      )
                                    : ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Sign In failed. Please check your credentials.'),
                                        ),
                                      );
                              },
                              child: Container(
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
                                      fontFamily: 'AvenirNextCyr',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF353E55),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                                    fontFamily: 'AvenirNextCyr',
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
                                    await _auth.signInwithGoogle();

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

  // void _login() async {
  //   String email = _emailController.text.trim();
  //   String password = _passwordController.text.trim();

  //   User? user = await _auth.signIn(email, password);

  //   if (user != null) {
  //     print("User is successfully created");
  //     Navigator.pushNamed(context, "_signUp");
  //   } else {
  //     print("Error!");
  //   }
  // }
}
