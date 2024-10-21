import 'package:flutter/material.dart';

// Define controllers here
class AddProductControllers {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDescriptionController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController eggTypeController = TextEditingController();

  void dispose() {
    productNameController.dispose();
    productDescriptionController.dispose();
    sizeController.dispose();
    eggTypeController.dispose();
  }
}