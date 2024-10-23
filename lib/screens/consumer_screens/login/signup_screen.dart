import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/firebase/firebase_auth_service.dart';
import 'package:eggventure/screens/consumer_screens/main_consumer/home_screen.dart';
import 'package:eggventure/screens/consumer_screens/login/signin_screen.dart';
import 'package:eggventure/screens/consumer_screens/login/welcome_screen.dart';
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

  final FirebaseAuthService _auth = FirebaseAuthService();

  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _lastNameFocusNode = FocusNode();
  final _firstNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

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
  }

  void _addClearErrorListener(TextEditingController controller) {
    controller.addListener(() {
      if (_attemptedSignUp) {
        setState(() {
          _formKey.currentState?.validate();
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

    _lastNameFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return true;
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
                            _lastNameController,
                            false,
                            TextInputType.name,
                            _lastNameFocusNode,
                          ),
                          SizedBox(height: 20),
                          _buildTextField(
                            'First Name',
                            _firstNameController,
                            false,
                            TextInputType.name,
                            _firstNameFocusNode,
                          ),
                          SizedBox(height: 20),
                          _buildTextField(
                            'Email Address',
                            _emailController,
                            false,
                            TextInputType.emailAddress,
                            _emailFocusNode,
                            prefixIcon: Icon(Icons.email),
                          ),
                          SizedBox(height: 20),
                          IntlPhoneField(
                            controller: _phoneController,
                            focusNode: _phoneFocusNode,
                            cursorColor: AppColors.YELLOW,
                              decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  labelStyle: TextStyle(
                                    color: AppColors.BLUE,
                                    fontSize: 12
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.YELLOW,
                                    )
                                  )
                              ),
                              initialCountryCode: 'PH',
                              onChanged: (phone) {
                                  print(phone.completeNumber);  
                              },
                              onCountryChanged: (country) {
                              print('Country changed to: ${country.name}');
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.completeNumber.isEmpty) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                            dropdownTextStyle: TextStyle(
                              color: AppColors.BLUE,
                              fontSize: 12
                            ),
                            dropdownIcon: Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.BLUE,
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.BLUE
                            ),
                          ),
                          SizedBox(height: 20),
                          _buildTextField(
                            'Password',
                            _passwordController,
                            !_passwordVisible,
                            TextInputType.text,
                            _passwordFocusNode,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: _toggleVisibilityButton(),
                          ),
                          SizedBox(height: 20),
                          _buildTextField(
                            'Confirm Password',
                            _confirmPasswordController,
                            !_confirmPasswordVisible,
                            TextInputType.text,
                            _confirmPasswordFocusNode,
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
            if (isConfirmPassword && value != _passwordController.text) {
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
          child: Text(
            'I agree to the Terms and Conditions',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.BLUE,
            ),
          ),
        ),
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
          });
          if (_formKey.currentState!.validate()) {
            final emailString = _emailController.text.trim();
            final passwordString = _passwordController.text.trim();
            final lastNameString = _lastNameController.text.trim();
            final firstNameString = _firstNameController.text.trim();
            final userPhoneNumberString = _phoneController.text.trim();

            User? user = await _auth.signupUser(lastNameString, firstNameString,
                int.parse(userPhoneNumberString), emailString, passwordString);

            debugPrint('signup clicked');

            if (user != null) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SigninScreen()),
                (Route<dynamic> route) => false,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('Sign up failed. Please check your credentials.'),
                ),
              );
            }
          }
        },
        child: Text(
          'Sign Up',
          style: TextStyle(
              color: AppColors.BLUE, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.YELLOW,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(
            fontSize: 12,
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
              fontSize: 12,
              color: AppColors.YELLOW,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
