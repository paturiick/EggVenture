import 'package:eggventure/firebase/firebase_auth_service.dart';
import 'package:eggventure/screens/home_screen.dart';
import 'package:eggventure/screens/signup_screen.dart';
// Add this import
import 'package:eggventure/welcome_screen.dart';
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
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;
  bool _autoValidate = false;

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

  void _signIn() {
    setState(() {
      _autoValidate = true;
    });

    if (_formKey.currentState!.validate()) {
      // Proceed with the sign-in process
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      print("Form is not valid. Display error messages.");
    }
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
        MaterialPageRoute(
            builder: (context) =>
                HomeScreen()), // Navigate to HomeScreen after login
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
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'E',
                                  style: TextStyle(
                                    fontFamily: 'AvenirNextCyr',
                                    fontWeight: FontWeight.w700,
                                    fontSize: size.width * 0.09,
                                    color: Color(0xFFF9B514),
                                  ),
                                ),
                                TextSpan(
                                  text: 'GG',
                                  style: TextStyle(
                                    fontFamily: 'AvenirNextCyr',
                                    fontWeight: FontWeight.w700,
                                    fontSize: size.width * 0.06,
                                    color: Color(0xFF353E55),
                                  ),
                                ),
                                TextSpan(
                                  text: 'V',
                                  style: TextStyle(
                                    fontFamily: 'AvenirNextCyr',
                                    fontWeight: FontWeight.w700,
                                    fontSize: size.width * 0.09,
                                    color: Color(0xFFF9B514),
                                  ),
                                ),
                                TextSpan(
                                  text: 'ENTURE',
                                  style: TextStyle(
                                    fontFamily: 'AvenirNextCyr',
                                    fontWeight: FontWeight.w700,
                                    fontSize: size.width * 0.06,
                                    color: Color(0xFF353E55),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Color(0xFFF9B514)),
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
                                fontFamily: 'AvenirNextCyr',
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Color(0xFF353E55),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Log-In to your account',
                              style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                fontSize: 15,
                                color: Color(0xFF353E55),
                              ),
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () => _toggleFocus(_emailFocusNode),
                              child: TextFormField(
                                controller: _emailController,
                                focusNode: _emailFocusNode,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  labelText: 'Email Address or Phone Number',
                                  labelStyle: TextStyle(
                                      fontSize: 10, color: Color(0xFF353E55)),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: _isEmailFocused
                                          ? Color(0xFFF9B514)
                                          : Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF9B514),
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
                                controller: _passwordController,
                                focusNode: _passwordFocusNode,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                obscureText: !_isPasswordVisible,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      fontSize: 10, color: Color(0xFF353E55)),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: _isPasswordFocused
                                          ? Color(0xFFF9B514)
                                          : Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF9B514),
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
                                      activeColor: Color(0xFFF9B514),
                                    ),
                                    Text(
                                      'Remember me',
                                      style: TextStyle(
                                          fontFamily: 'AvenirNextCyr',
                                          fontSize: 10,
                                          color: Color(0xFF353E55)),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                        fontFamily: 'AvenirNextCyr',
                                        fontSize: 10,
                                        color: Color(0xFF353E55)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            GestureDetector(
                              onTap: _signIn,
                              child: Container(
                                width: size.width,
                                height: size.height * 0.06,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF9B514),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontFamily: 'AvenirNextCyr',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
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
                            ElevatedButton(
                              onPressed: () =>
                                  FirebaseAuthService().signInWithGoogle,
                              child: Container(
                                width: size.width,
                                height: size.height * 0.06,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
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
                                        fontFamily: 'AvenirNextCyr',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xFF353E55),
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
                                        color: Colors.black.withOpacity(0.1),
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
                                          fontFamily: 'AvenirNextCyr',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color(0xFF353E55),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            if (_accessToken != null)
                              GestureDetector(
                                onTap: _logoutFromFacebook,
                                child: Container(
                                  width: size.width,
                                  height: size.height * 0.06,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Log Out from Facebook',
                                      style: TextStyle(
                                        fontFamily: 'AvenirNextCyr',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
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
                                    fontFamily: 'AvenirNextCyr',
                                    fontSize: 12,
                                    color: Color(0xFF353E55),
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
                                      fontFamily: 'AvenirNextCyr',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color(0xFFF9B514),
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
