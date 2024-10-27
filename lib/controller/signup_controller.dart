import 'package:flutter/material.dart';

class SignupController {
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final lastNameFocusNode = FocusNode();
  final firstNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  void addClearErrorListeners(VoidCallback onUpdate) {
    _addClearErrorListener(lastNameController, onUpdate);
    _addClearErrorListener(firstNameController, onUpdate);
    _addClearErrorListener(emailController, onUpdate);
    _addClearErrorListener(phoneController, onUpdate);
    _addClearErrorListener(passwordController, onUpdate);
    _addClearErrorListener(confirmPasswordController, onUpdate);
  }

  void _addClearErrorListener(
      TextEditingController controller, VoidCallback onUpdate) {
    controller.addListener(onUpdate);
  }

  void dispose() {
    lastNameController.dispose();
    firstNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    lastNameFocusNode.dispose();
    firstNameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
  }
}
