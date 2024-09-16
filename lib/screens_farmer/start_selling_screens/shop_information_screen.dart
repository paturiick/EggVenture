import 'package:eggventure/screens/profile_screen.dart';
import 'package:eggventure/screens_farmer/start_selling_screens/business_information_screen.dart';
import 'package:flutter/material.dart';

class ShopInformationScreen extends StatefulWidget {
  @override
  _ShopInformationScreenState createState() => _ShopInformationScreenState();
}

class _ShopInformationScreenState extends State<ShopInformationScreen> {
  final _shopNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _pickupAddressController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Added formKey

  @override
  void dispose() {
    _shopNameController.dispose();
    _emailController.dispose();
    _pickupAddressController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          labelStyle: TextStyle(
            fontFamily: 'AvenirNextCyr',
            fontWeight: FontWeight.bold,
            color: Color(0xFF353E55),
          ),
        ),
        style: TextStyle(
          fontFamily: 'AvenirNextCyr',
          color: Color(0xFF353E55),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildProfilePicturePicker() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: IconButton(
          icon: Icon(Icons.add, color: Color(0xFF353E55)),
          onPressed: () {
            // Logic to add a profile picture
          },
        ),
      ),
    );
  }

  Widget _stepCircle(bool isActive) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: isActive ? Color(0xFFF9B514) : Colors.grey[300],
      child: Icon(Icons.circle, color: Colors.white, size: 16),
    );
  }

  Widget _stepLine() {
    return Container(
      height: 2,
      width: 50,
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Shop Information',
          style: TextStyle(color: Color(0xFF353E55), fontFamily: 'AvenirNextCyr', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Logic for saving
                }
              },
              child: Text(
                'Save',
                style: TextStyle(color: Color(0xFFF9B514), fontFamily: 'AvenirNextCyr', fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Color(0xFF353E55)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Form(
          key: _formKey, // Added formKey
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _stepCircle(false),
                  _stepLine(),
                  _stepLine(),
                  _stepLine(),
                  _stepLine(),
                  _stepCircle(false),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Shop Information',
                    style: TextStyle(fontSize: 16, color: Color(0xFF353E55), fontFamily: 'AvenirNextCyr', fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 60), // Adjust the space between text
                  Text(
                    'Business Information',
                    style: TextStyle(fontSize: 16, color: Color(0xFF353E55), fontFamily: 'AvenirNextCyr', fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Shop Information Input Fields
              _buildTextField('Shop Name', _shopNameController),
              _buildTextField('Email', _emailController),
              _buildTextField('Pickup Address', _pickupAddressController),
              _buildTextField('Contact Number', _contactNumberController),

              SizedBox(height: 20),

              // Profile Picture Picker
              Center(
                child: Column(
                  children: [
                    _buildProfilePicturePicker(),
                    SizedBox(height: 10),
                    Text(
                      'Insert Profile Picture',
                      style: TextStyle(color: Colors.grey, fontFamily: 'AvenirNextCyr', fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Buttons for Back and Next
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(), // Navigate to ProfileScreen
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Color(0xFFF9B514)),
                      padding: EdgeInsets.symmetric(horizontal: 95),
                    ),
                    child: Text(
                      'Back',
                      style: TextStyle(color: Color(0xFF353E55), fontFamily: 'AvenirNextCyr', fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusinessInformationScreen(), // Navigate to BusinessInformationScreen
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF9B514),
                      padding: EdgeInsets.symmetric(horizontal: 95),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontFamily: 'AvenirNextCyr', fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
