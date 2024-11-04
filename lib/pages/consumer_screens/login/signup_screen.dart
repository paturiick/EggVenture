import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/controller/signup_controller.dart';
import 'package:eggventure/services/firebase/firebase%20auth/firebase_auth_service.dart';
import 'package:eggventure/pages/consumer_screens/main_consumer/home_screen.dart';
import 'package:eggventure/pages/consumer_screens/login/signin_screen.dart';
import 'package:eggventure/pages/consumer_screens/login/welcome_screen.dart';
import 'package:eggventure/widgets/terms%20&%20conditions/terms_conditions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _agreeToTerms = false;
  bool _attemptedSignUp = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _isLoading = false;

  final SignupController _signupController = SignupController();
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _signupController.addClearErrorListeners(() {
      if (_attemptedSignUp) {
        setState(() {
          _formKey.currentState?.validate();
        });
      }
    });
  }

  @override
  void dispose() {
    _signupController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return true;
  }

  Future<void> _showLoadingScreen() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.YELLOW),
            ),
          );
        });
  }

  Future<void> _hideLoadingScreen() async {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

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
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
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
                    child: _buildLogo(size, isPortrait),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.04,
                        vertical: size.height * 0.03),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.YELLOW),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildTitle(size),
                          SizedBox(height: 20),
                          _buildTextField(
                            'Last Name',
                            _signupController.lastNameController,
                            false,
                            TextInputType.name,
                            _signupController.lastNameFocusNode,
                          ),
                          SizedBox(height: 20),
                          _buildTextField(
                            'First Name',
                            _signupController.firstNameController,
                            false,
                            TextInputType.name,
                            _signupController.firstNameFocusNode,
                          ),
                          SizedBox(height: 20),
                          _buildTextField(
                            'Email Address',
                            _signupController.emailController,
                            false,
                            TextInputType.emailAddress,
                            _signupController.emailFocusNode,
                            prefixIcon: Icon(Icons.email),
                          ),
                          SizedBox(height: 20),
                          // Modify the phone field without the validator
                          IntlPhoneField(
                            controller: _signupController.phoneController,
                            focusNode: _signupController.phoneFocusNode,
                            cursorColor: AppColors.YELLOW,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(
                                color: AppColors.BLUE,
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.YELLOW,
                                ),
                              ),
                            ),
                            initialCountryCode: 'PH',
                            onChanged: (phone) {
                              print(phone.completeNumber);
                            },
                            onCountryChanged: (country) {
                              print('Country changed to: ${country.name}');
                            },
                            dropdownTextStyle: TextStyle(
                              color: AppColors.BLUE,
                              fontSize: 12,
                            ),
                            dropdownIcon: Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.BLUE,
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.BLUE,
                            ),
                          ),
                          SizedBox(height: 20),
                          _buildTextField(
                            'Password',
                            _signupController.passwordController,
                            !_passwordVisible,
                            TextInputType.text,
                            _signupController.passwordFocusNode,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: _toggleVisibilityButton(),
                          ),
                          SizedBox(height: 20),
                          _buildTextField(
                            'Confirm Password',
                            _signupController.confirmPasswordController,
                            !_confirmPasswordVisible,
                            TextInputType.text,
                            _signupController.confirmPasswordFocusNode,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon:
                                _toggleVisibilityButton(isConfirm: true),
                            isConfirmPassword:
                                true, // Custom validation for confirm password
                          ),
                          SizedBox(height: 20),
                          _buildTermsCheckbox(),
                          if (!_agreeToTerms && _attemptedSignUp)
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                'You must agree to the terms and conditions.',
                                style: TextStyle(
                                  color: AppColors.RED,
                                  fontSize: size.width * 0.03,
                                ),
                              ),
                            ),
                          SizedBox(height: 20),
                          _buildSignUpButton(size),
                          SizedBox(height: 20),
                          _buildSignInPrompt(),
                        ],
                      ),
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

  Widget _buildLogo(Size size, bool isPortrait) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/Eggventure.png',
          width: size.width * (isPortrait ? 0.25 : 0.2),
        ),
        SizedBox(width: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
    );
  }

  Widget _buildTitle(Size size) {
    return Text(
      'Create your account',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: size.width * 0.05,
        color: AppColors.BLUE,
      ),
    );
  }

  Widget _buildTextField(
    String labelText,
    TextEditingController controller,
    bool obscureText,
    TextInputType keyboardType,
    FocusNode focusNode, {
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool isConfirmPassword = false, // Flag for confirm password validation
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          focusNode: focusNode,
          cursorColor: AppColors.YELLOW,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              color: AppColors.BLUE,
              fontSize: 12,
            ),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.YELLOW),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.RED),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.RED),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
          style: TextStyle(fontSize: 12, color: AppColors.BLUE),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your $labelText';
            }
            // Email validation logic
            if (labelText == 'Email Address') {
              String pattern =
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
              RegExp regex = RegExp(pattern);
              if (!regex.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
            }
            // Password validation logic
            if (labelText == 'Password' && value.length < 8) {
              return 'Password must be at least 8 characters long';
            }
            // Confirm password logic
            if (isConfirmPassword &&
                value != _signupController.passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _toggleVisibilityButton({bool isConfirm = false}) {
    return IconButton(
      icon: Icon(
        isConfirm
            ? (_confirmPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off)
            : (_passwordVisible ? Icons.visibility : Icons.visibility_off),
        color: AppColors.BLUE,
      ),
      onPressed: () {
        setState(() {
          if (isConfirm) {
            _confirmPasswordVisible = !_confirmPasswordVisible;
          } else {
            _passwordVisible = !_passwordVisible;
          }
        });
      },
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _agreeToTerms,
          activeColor: AppColors.YELLOW,
          onChanged: (value) {
            setState(() {
              _agreeToTerms = value ?? false;
            });
          },
        ),
        Flexible(
            child: GestureDetector(
          onTap: () {
            TermsConditions.showTermsConditionsDialog(context);
          },
          child: Text(
            'I agree to the Terms and Conditions',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.BLUE,
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildSignUpButton(Size size) {
    return Container(
      width: size.width,
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            _attemptedSignUp = true;
            _isLoading = true; // Start loading indicator
          });

          if (_formKey.currentState!.validate()) {
            try {
              final emailString = _signupController.emailController.text.trim();
              final passwordString =
                  _signupController.passwordController.text.trim();
              final lastNameString =
                  _signupController.lastNameController.text.trim();
              final firstNameString =
                  _signupController.firstNameController.text.trim();
              final userPhoneNumberString =
                  _signupController.phoneController.text.trim();

              User? user = await _auth.signupUser(
                lastNameString,
                firstNameString,
                int.parse(userPhoneNumberString),
                emailString,
                passwordString,
              );

              debugPrint('Signup clicked');

              if (user != null) {
                setState(() => _isLoading = false); // Stop loading on success
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SigninScreen()),
                  (Route<dynamic> route) => false,
                );
              } else {
                setState(() => _isLoading = false); // Stop loading on error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('Sign up failed. Please check your credentials.'),
                  ),
                );
              }
            } catch (e) {
              setState(() => _isLoading = false); // Stop loading on exception
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('An error occurred. Please try again.'),
                ),
              );
            }
          } else {
            setState(
                () => _isLoading = false); // Stop loading if validation fails
          }
        },
        child: _isLoading
            ? SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(
                  color: AppColors.BLUE,
                  strokeWidth: 3.0,
                ),
              )
            : Text(
                'Sign Up',
                style: TextStyle(
                  color: AppColors.BLUE,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.YELLOW,
          minimumSize: Size(150, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInPrompt() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(
            fontSize: 15,
            color: AppColors.BLUE,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SigninScreen(),
              ),
            );
          },
          child: Text(
            'Sign In',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.YELLOW,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
