import 'package:eggventure/screens/signup_screen.dart';
import 'package:eggventure/user interface/dashboard_screen.dart'; // Add this import
import 'package:eggventure/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

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

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_handleFocusChange);
    _passwordFocusNode.addListener(_handleFocusChange);
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
          builder: (context) => DashboardScreen(),
        ),
      );
    } else {
      print("Form is not valid. Display error messages.");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
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
                        width: size.width * 0.2,
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
                                fontSize: 32,
                                color: Color(0xFFF9B514),
                              ),
                            ),
                            TextSpan(
                              text: 'GG',
                              style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Color(0xFF353E55),
                              ),
                            ),
                            TextSpan(
                              text: 'V',
                              style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                fontWeight: FontWeight.w700,
                                fontSize: 32,
                                color: Color(0xFFF9B514),
                              ),
                            ),
                            TextSpan(
                              text: 'ENTURE',
                              style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              labelText: 'Email Address or Phone Number',
                              labelStyle: TextStyle(fontSize: 11),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: _isEmailFocused
                                      ? Color(0xFF353E55)
                                      : Colors.grey,
                                ),
                              ),
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email or phone number';
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
                            textCapitalization: TextCapitalization.sentences,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(fontSize: 11),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: _isPasswordFocused
                                      ? Color(0xFF353E55)
                                      : Colors.grey,
                                ),
                              ),
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
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
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isChecked = value ?? false;
                                    });
                                  },
                                ),
                                SizedBox(width: 0),
                                Text(
                                  'Save Password',
                                  style: TextStyle(
                                    fontFamily: 'AvenirNextCyr',
                                    fontSize: 12,
                                    color: Color(0xFF353E55),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                fontSize: 12,
                                color: Color.fromARGB(255, 116, 116, 116),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _signIn,
                          child: Text('Sign In'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color(0xFF353E55),
                            backgroundColor: Color(0xFFF9B514),
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 15),
                            textStyle: TextStyle(
                              fontFamily: 'AvenirNextCyr',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: Divider(color: Color(0xFF353E55))),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'or',
                                style: TextStyle(
                                  fontFamily: 'AvenirNextCyr',
                                  fontSize: 14,
                                  color: Color(0xFF353E55),
                                ),
                              ),
                            ),
                            Expanded(child: Divider(color: Color(0xFF353E55))),
                          ],
                        ),
                        SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(AntDesign.google_outline),
                          label: Text('Continue with Google'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color(0xFF353E55),
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            textStyle: TextStyle(
                              fontFamily: 'AvenirNextCyr',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Color(0xFF353E55)),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(BoxIcons.bxl_facebook_circle),
                          label: Text('Continue with Facebook'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color(0xFF353E55),
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            textStyle: TextStyle(
                              fontFamily: 'AvenirNextCyr',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color: Color(0xFF353E55)),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                fontSize: 14,
                                color: Color(0xFF353E55),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SignupScreen();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontFamily: 'AvenirNextCyr',
                                  fontSize: 14,
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
    );
  }
}
