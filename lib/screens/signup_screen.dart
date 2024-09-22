import 'package:eggventure/screens/signin_screen.dart';
import 'package:eggventure/screens/verification_screen.dart';
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

  void _signUp() {
    setState(() {
      _attemptedSignUp = true;
    });

    // Trigger validation on form fields
    if (_formKey.currentState!.validate()) {
      if (_agreeToTerms) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerificationScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You must agree to the terms and conditions.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
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
                  border: Border.all(color: const Color(0xFFF9B514)),
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
                        prefixIcon: const Icon(Icons.email),
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        'Phone Number',
                        _phoneController,
                        false,
                        TextInputType.phone,
                        _phoneFocusNode,
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        'Password',
                        _passwordController,
                        !_passwordVisible,
                        TextInputType.text,
                        _passwordFocusNode,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: _toggleVisibilityButton(),
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        'Confirm Password',
                        _confirmPasswordController,
                        !_confirmPasswordVisible,
                        TextInputType.text,
                        _confirmPasswordFocusNode,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: _toggleVisibilityButton(isConfirm: true),
                      ),
                      SizedBox(height: 20),
                      _buildTermsCheckbox(),
                      if (!_agreeToTerms && _attemptedSignUp)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'You must agree to the terms and conditions.',
                            style: TextStyle(
                              color: Colors.red,
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
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'E',
                style: TextStyle(
                  fontFamily: 'AvenirNextCyr',
                  fontWeight: FontWeight.w700,
                  fontSize: size.width * 0.09,
                  color: const Color(0xFFF9B514),
                ),
              ),
              TextSpan(
                text: 'GG',
                style: TextStyle(
                  fontFamily: 'AvenirNextCyr',
                  fontWeight: FontWeight.w700,
                  fontSize: size.width * 0.06,
                  color: const Color(0xFF353E55),
                ),
              ),
              TextSpan(
                text: 'V',
                style: TextStyle(
                  fontFamily: 'AvenirNextCyr',
                  fontWeight: FontWeight.w700,
                  fontSize: size.width * 0.09,
                  color: const Color(0xFFF9B514),
                ),
              ),
              TextSpan(
                text: 'ENTURE',
                style: TextStyle(
                  fontFamily: 'AvenirNextCyr',
                  fontWeight: FontWeight.w700,
                  fontSize: size.width * 0.06,
                  color: const Color(0xFF353E55),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(Size size) {
    return Text(
      'Create your account',
      style: TextStyle(
        fontFamily: 'AvenirNextCyr',
        fontWeight: FontWeight.bold,
        fontSize: size.width * 0.06,
        color: const Color(0xFF353E55),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool obscureText,
    TextInputType keyboardType,
    FocusNode focusNode, {
    Icon? prefixIcon,
    IconButton? suffixIcon,
    double textSize = 12,
    Color textColor = const Color(0xFF353E55),
    Color labelColor = const Color(0xFF353E55),
  }) {
    Size size = MediaQuery.of(context).size;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      focusNode: focusNode,
      style: TextStyle(
        fontSize: textSize,
        color: textColor,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: size.width * 0.03,
          color: labelColor,
        ),
        border: OutlineInputBorder(),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFF9B514)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (label == 'Email Address' && !value.contains('@')) {
          return 'Please enter a valid email';
        }
        if (label == 'Password' && value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        if (label == 'Confirm Password' && value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _agreeToTerms,
          onChanged: (value) {
            setState(() {
              _agreeToTerms = value!;
            });
          },
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                "I agree with",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.normal,
                  fontSize: 13,
                ),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  // Handle the Terms and Conditions tap
                },
                child: Text(
                  "Terms and Conditions",
                  style: TextStyle(
                    color: const Color(0xFF353E55),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton(Size size) {
    return ElevatedButton(
      onPressed: _signUp,
      child: const Text('Sign up'),
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF353E55),
        backgroundColor: const Color(0xFFF9B514),
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.2,
          vertical: size.height * 0.02,
        ),
        textStyle: TextStyle(
          fontFamily: 'AvenirNextCyr',
          fontWeight: FontWeight.bold,
          fontSize: size.width * 0.045,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget _buildSignInPrompt() {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SigninScreen()),
          );
        },
        child: Column(
          children: [
            Text(
              "Already have an account?",
              style: TextStyle(
                  color: Color(0xFF353E55), fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Sign In",
              style: TextStyle(
                  color: Color(0xFFF9B514), fontWeight: FontWeight.bold),
            )
          ],
        ));
  }

  IconButton _toggleVisibilityButton({bool isConfirm = false}) {
    return IconButton(
      icon: Icon(
        isConfirm
            ? (_confirmPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off)
            : (_passwordVisible ? Icons.visibility : Icons.visibility_off),
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
}
