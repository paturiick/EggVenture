import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/controller/image_picker_controller.dart';
import 'package:eggventure/firebase/firebase%20storage/firebase_shopinfo_profile.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/screens/farmer_screens/start_selling_farmer/business_information_screen.dart';
import 'package:eggventure/widgets/image%20picker%20widget/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ShopInformationScreen extends StatefulWidget {
  @override
  _ShopInformationScreenState createState() => _ShopInformationScreenState();
}

class _ShopInformationScreenState extends State<ShopInformationScreen> {
  final _shopNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _pickupAddressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseShopinfoProfile _firebaseShopinfoProfile =
      FirebaseShopinfoProfile();

  String? _phoneNumber;
  String? _phoneError; // Variable to store phone number validation error
  String? _uploadImageUrl;

  final ImagePickerController _imagePickerController = ImagePickerController();
  XFile? imageFile;

  void imageSelection(ImageSource source) async {
    final XFile? pickedFile = await _imagePickerController.pickImage(source);
    setState(() {
      imageFile = pickedFile;
    });
  }

  @override
  void dispose() {
    _shopNameController.dispose();
    _emailController.dispose();
    _pickupAddressController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType? keyboardType, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        cursorColor: AppColors.YELLOW,
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.BLUE,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.RED),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.YELLOW),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.BLUE),
          ),
        ),
        style: TextStyle(
          color: AppColors.BLUE,
        ),
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
        onChanged: (value) {
          setState(() {
            // Trigger UI update on every change to clear the error message
          });
        },
      ),
    );
  }

  Widget _buildProfilePicturePicker() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
        image: _uploadImageUrl != null && _uploadImageUrl!.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(_uploadImageUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: _uploadImageUrl == null || _uploadImageUrl!.isEmpty
          ? Center(
              child: IconButton(
                icon: Icon(Icons.add, color: AppColors.BLUE),
                onPressed: () async {
                  await _firebaseShopinfoProfile.changeProfilePicture(context);
                  setState(() {
                    _uploadImageUrl = _firebaseShopinfoProfile.uploadedImageUrl;
                  });
                },
              ),
            )
          : null,
    );
  }


  Widget _stepCircle(bool isActive) {
    return CircleAvatar(
      radius: MediaQuery.of(context).size.width * 0.03,
      backgroundColor: isActive ? AppColors.YELLOW : Colors.grey[300],
      child: Icon(Icons.circle,
          color: Colors.white, size: MediaQuery.of(context).size.width * 0.04),
    );
  }

  Widget _stepLine() {
    return Container(
      height: 2,
      width: MediaQuery.of(context).size.width * 0.1,
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Shop Information',
          style: TextStyle(
            color: AppColors.BLUE,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
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
                  color: AppColors.YELLOW,
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.045,
                ),
              ),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: AppColors.BLUE),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Form(
            key: _formKey,
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
                        fontSize: screenWidth * 0.03,
                        color: AppColors.BLUE,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.15),
                    Text(
                      'Business Information',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: AppColors.BLUE,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

                // Shop Information Input Fields
                _buildTextField('Shop Name', _shopNameController),
                _buildTextField('Email', _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail),
                _buildTextField('Pickup Address', _pickupAddressController),

                // Phone Number Field with Error Handling
                // Phone Number Field with Error Handling
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: IntlPhoneField(
                    cursorColor: AppColors.YELLOW,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact Number',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.BLUE,
                      ),
                      errorText: _phoneError, // Display error if exists
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.RED),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.YELLOW),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.BLUE),
                      ),
                    ),
                    initialCountryCode: 'PH',
                    onChanged: (phone) {
                      setState(() {
                        _phoneNumber = phone.completeNumber;
                        _phoneError =
                            null; // Clear error when valid input is provided
                      });
                    },
                    onSaved: (phone) {
                      _phoneNumber = phone?.completeNumber;
                    },
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),
                Center(
                  child: Column(
                    children: [
                      _buildProfilePicturePicker(),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Insert Profile Picture',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.PROFILESCREEN);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(color: AppColors.YELLOW),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.15),
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: AppColors.BLUE,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_phoneNumber == null || _phoneNumber!.isEmpty) {
                            _phoneError = 'Please enter contact number';
                          } else {
                            _phoneError = null;
                          }
                        });

                        if (_formKey.currentState!.validate() &&
                            _phoneError == null) {
                          String shopName = _shopNameController.text.trim();
                          String email = _emailController.text.trim();
                          String address = _pickupAddressController.text.trim();
                          String phoneNumber = _phoneNumber ?? '';

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BusinessInformationScreen(
                                address: address,
                                email: email,
                                phoneNumber: int.tryParse(phoneNumber) ?? 0,
                                shopName: shopName,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.YELLOW,
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.15),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'AvenirNextCyr',
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04,
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
