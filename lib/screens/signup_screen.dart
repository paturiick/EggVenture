import 'package:eggventure/screens/signin_screen.dart';
import 'package:eggventure/welcome_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _agreeToTerms = false;
  bool _attemptedSignUp = false;
  final double _textFieldFontSize = 12.0; // Adjustable font size
  final double _textButtonFontSize = 12.0; // Fixed text button font size

  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _addClearErrorListener(_lastNameController);
    _addClearErrorListener(_firstNameController);
    _addClearErrorListener(_emailController);
    _addClearErrorListener(_phoneController);
    _addClearErrorListener(_passwordController);
    _addClearErrorListener(_confirmPasswordController);

    // Also listen to password changes for confirm password validation
    _passwordController.addListener(() {
      if (_attemptedSignUp) {
        setState(() {
          _formKey.currentState?.validate();
        });
      }
    });
    _confirmPasswordController.addListener(() {
      if (_attemptedSignUp) {
        setState(() {
          _formKey.currentState?.validate();
        });
      }
    });
  }

  void _addClearErrorListener(TextEditingController controller) {
    controller.addListener(() {
      if (_attemptedSignUp) {
        setState(() {
          _formKey.currentState?.validate(); // Manually trigger validation
        });
      }
    });
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() {
    setState(() {
      _attemptedSignUp = true;
    });

    if (_formKey.currentState!.validate() && _agreeToTerms) {
      // Proceed with the sign-up process
    } else if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You must agree to the terms and conditions.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFFF9B514)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Create your account',
                        style: TextStyle(
                          fontFamily: 'AvenirNextCyr',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color(0xFF353E55),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          labelStyle: TextStyle(fontSize: _textFieldFontSize),
                          border: OutlineInputBorder(),
                        ),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          labelStyle: TextStyle(fontSize: _textFieldFontSize),
                          border: OutlineInputBorder(),
                        ),
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle(fontSize: _textFieldFontSize),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(fontSize: _textFieldFontSize),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: _textFieldFontSize),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
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
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: !_confirmPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(fontSize: _textFieldFontSize),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _confirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _confirmPasswordVisible =
                                    !_confirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            value: _agreeToTerms,
                            onChanged: (bool? value) {
                              setState(() {
                                _agreeToTerms = value ?? false;
                              });
                            },
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                // Handle terms and conditions click
                              },
                              child: Text(
                                'Agree with Terms and Conditions',
                                style: TextStyle(
                                  fontFamily: 'AvenirNextCyr',
                                  fontWeight: FontWeight.bold,
                                  fontSize: _textButtonFontSize,
                                  color: Color(0xFF353E55),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      if (!_agreeToTerms && _attemptedSignUp)
                        Text(
                          'You must agree to the terms and conditions.',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: _textButtonFontSize,
                          ),
                        ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _signUp,
                        child: Text('Sign up'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFFF9B514),
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                          textStyle: TextStyle(
                            fontFamily: 'AvenirNextCyr',
                            fontWeight: FontWeight.bold,
                            fontSize: _textFieldFontSize,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontFamily: 'AvenirNextCyr',
                              fontSize: _textButtonFontSize,
                              color: Color(0xFF353E55),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SigninScreen();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontFamily: 'AvenirNextCyr',
                                fontSize: _textButtonFontSize,
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
    );
  }
}
