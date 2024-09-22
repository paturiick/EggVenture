import 'package:eggventure/screens/signin_screen.dart';
import 'package:eggventure/screens/verification_screen.dart';
import 'package:eggventure/welcome_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

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

  Future<bool> _onWillPop() async {
    return true;
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
          SnackBar(
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
                      border: Border.all(color: Color(0xFFF9B514)),
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
                          _buildTextField(
                            'Phone Number',
                            _phoneController,
                            false,
                            TextInputType.phone,
                            _phoneFocusNode,
                            prefixIcon: Icon(Icons.phone),
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
                          ),
                          SizedBox(height: 20),
                          _buildTermsCheckbox(),
                          if (!_agreeToTerms && _attemptedSignUp)
                            Padding(
                              padding: EdgeInsets.only(top: 10),
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
    );
  }

  Widget _buildTitle(Size size) {
    return Text(
      'Create your account',
      style: TextStyle(
        fontFamily: 'AvenirNextCyr',
        fontWeight: FontWeight.w700,
        fontSize: size.width * 0.05,
        color: Color(0xFF353E55),
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
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      focusNode: focusNode,
      cursorColor: Color(0xFFF9B514),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Color(0xFF353E55),
          fontSize: 12,
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFF9B514)),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      style: TextStyle(fontSize: 12, color: Color(0xFF353E55)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelText';
        }
        return null;
      },
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
        color: Color(0xFFF9B514),
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
          activeColor: Color(0xFF353E55),
          onChanged: (bool? value) {
            setState(() {
              _agreeToTerms = value ?? false;
            });
          },
        ),
        Text(
          'I agree with',
          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
        ),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            // Handle terms and conditions
          },
          child: Text(
            'Terms and Conditions',
            style: TextStyle(
              color: Color(0xFF353E55),
              fontSize: 13,
              decoration: TextDecoration.underline,
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
        onPressed: _signUp,
        child: Text(
          'Sign Up',
          style: TextStyle(
              color: Color(0xFF353E55),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFF9B514),
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
      children: <Widget>[
        Text('Already have an account?'),
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
            'Sign in',
            style: TextStyle(color: Color(0xFFF9B514), fontSize: 15),
          ),
        ),
      ],
    );
  }
}
