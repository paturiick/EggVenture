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
      width: MediaQuery.of(context).size.width * 0.4, // 40% of the screen width
      height: MediaQuery.of(context).size.width * 0.4, // 40% of the screen width
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
      radius: MediaQuery.of(context).size.width * 0.03, // Adjust radius based on screen width
      backgroundColor: isActive ? Color(0xFFF9B514) : Colors.grey[300],
      child: Icon(Icons.circle, color: Colors.white, size: MediaQuery.of(context).size.width * 0.04),
    );
  }

  Widget _stepLine() {
    return Container(
      height: 2,
      width: MediaQuery.of(context).size.width * 0.1, // Adjust width dynamically
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to get the screen height and width
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Shop Information',
          style: TextStyle(
            color: Color(0xFF353E55),
            fontFamily: 'AvenirNextCyr',
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05, // Adjust text size based on screen width
          ),
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
                style: TextStyle(
                  color: Color(0xFFF9B514),
                  fontFamily: 'AvenirNextCyr',
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.045, // Adjust text size based on screen width
                ),
              ),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Color(0xFF353E55)),
      ),
      body: SingleChildScrollView( // To avoid overflow issues on small screens
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, // 5% of screen width
            vertical: screenHeight * 0.02,  // 2% of screen height
          ),
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
                SizedBox(height: screenHeight * 0.02),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Shop Information',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // Responsive text size
                        color: Color(0xFF353E55),
                        fontFamily: 'AvenirNextCyr',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.15), // Adjust spacing dynamically
                    Text(
                      'Business Information',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // Responsive text size
                        color: Color(0xFF353E55),
                        fontFamily: 'AvenirNextCyr',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

                // Shop Information Input Fields
                _buildTextField('Shop Name', _shopNameController),
                _buildTextField('Email', _emailController),
                _buildTextField('Pickup Address', _pickupAddressController),
                _buildTextField('Contact Number', _contactNumberController),

                SizedBox(height: screenHeight * 0.02),

                // Profile Picture Picker
                Center(
                  child: Column(
                    children: [
                      _buildProfilePicturePicker(),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Insert Profile Picture',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'AvenirNextCyr',
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.035, // Responsive text size
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

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
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15), // Adjust button padding
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: Color(0xFF353E55),
                          fontFamily: 'AvenirNextCyr',
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04, // Responsive text size
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                             String shopName = _shopNameController.text.trim();
                            String email = _emailController.text.trim();
                            String address = _pickupAddressController.text.trim();
                            int phoneNumber = int.parse(_contactNumberController.text.trim()); 

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BusinessInformationScreen(
                                address: address, 
                                email: email, 
                                phoneNumber: phoneNumber, 
                                shopName: shopName), // Navigate to BusinessInformationScreen
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF9B514),
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15), // Adjust button padding
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'AvenirNextCyr',
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04, // Responsive text size
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
