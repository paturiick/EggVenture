import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/controller/image_picker_controller.dart';
import 'package:eggventure/models/shop_info_details.dart';
import 'package:eggventure/services/firebase/firebase%20storage/firebase_shopinfo_profile.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/pages/farmer%20screens/start_selling_farmer/business_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ShopInformationScreen extends StatefulWidget {
  final String shopInformationId;

  ShopInformationScreen({required this.shopInformationId, Key? key})
      : super(key: key);

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
  final ImagePickerController _imagePickerController = ImagePickerController();

  String? _phoneNumber;
  String? _phoneError; // Variable to store phone number validation error
  String? _uploadImageUrl;
  XFile? imageFile;

  void imageSelection(ImageSource source) async {
    final XFile? pickedFile = await _imagePickerController.pickImage(source);
    setState(() {
      imageFile = pickedFile;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSavedDetails();
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

  void _loadSavedDetails() {
    final details = ShopInfoDetails.getDetails();
    _shopNameController.text = details['shopName'] ?? '';
    _emailController.text = details['email'] ?? '';
    _pickupAddressController.text = details['address'] ?? '';
    _phoneNumber = details['phoneNumber'];
    _uploadImageUrl = details['uploadImageUrl'];
  }

  void _clearDetails() {
    ShopInfoDetails.clearDetails();
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
        border: const OutlineInputBorder(),
        labelText: label,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.BLUE,
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.RED),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.YELLOW),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.BLUE),
        ),
      ),
      style: const TextStyle(
        color: AppColors.BLUE,
      ),
      validator: validator ?? (value) => value?.isEmpty ?? true ? 'Please enter $label' : null,
      onChanged: (value) => setState(() {}),
    ),
  );
}

  Widget _buildProfilePicturePicker() {
    final imageUrl = _firebaseShopinfoProfile.uploadedImageUrl;

    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
        image: imageUrl != null && imageUrl.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imageUrl == null || imageUrl.isEmpty
          ? Center(
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                  color: AppColors.BLUE,
                ),
                onPressed: () async {
                  await _firebaseShopinfoProfile.changeProfilePicture(context);
                  setState(() {});
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _clearDetails();
                        Navigator.pushNamed(context, AppRoutes.PROFILESCREEN);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24.0),
                        child: Text("Back",
                            style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: AppColors.BLUE)),
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
                          ShopInfoDetails.saveDetails(
                            shopNameInput: _shopNameController.text.trim(),
                            emailInput: _emailController.text.trim(),
                            addressInput: _pickupAddressController.text.trim(),
                            phoneNumberInput: _phoneNumber!,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BusinessInformationScreen(
                                address: _pickupAddressController.text.trim(),
                                email: _emailController.text.trim(),
                                phoneNumber: int.tryParse(_phoneNumber!) ?? 0,
                                shopName: _shopNameController.text.trim(),
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.YELLOW,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24.0),
                        child: Text("Next",
                            style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: AppColors.BLUE)),
                      ),
                    ),
                  ],
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
