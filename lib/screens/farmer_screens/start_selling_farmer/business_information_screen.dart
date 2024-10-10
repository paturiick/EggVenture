import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/firebase/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:eggventure/screens/farmer_screens/start_selling_farmer/shop_information_screen.dart';
import 'package:eggventure/screens/farmer_screens/main_farmer/profile_screen_farmer.dart';

class BusinessInformationScreen extends StatefulWidget {
  final String shopName, email, address;
  final int phoneNumber;
  BusinessInformationScreen(
      {required this.address,
      required this.email,
      required this.phoneNumber,
      required this.shopName});

  @override
  _BusinessInformationScreenState createState() =>
      _BusinessInformationScreenState();
}

class _BusinessInformationScreenState extends State<BusinessInformationScreen> {
  String _sellerType = 'Sole Proprietorship';
  String? _fileName;

  final _formKey = GlobalKey<FormState>();
  final _registeredNameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final FirestoreService _service = FirestoreService();

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Business Information",
            style: TextStyle(
                color: AppColors.BLUE, fontSize: screenWidth * 0.05)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Handle Save action
            },
            child: Text("Save",
                style: TextStyle(
                    color: AppColors.YELLOW, fontSize: screenWidth * 0.04)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _stepCircle(true, screenWidth),
                  _stepLine(screenWidth),
                  _stepLine(screenWidth),
                  _stepLine(screenWidth),
                  _stepLine(screenWidth),
                  _stepCircle(false, screenWidth),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Shop Information',
                    style: TextStyle(
                        fontSize: screenWidth * 0.03, color: AppColors.BLUE),
                  ),
                  SizedBox(width: screenWidth * 0.15),
                  Text(
                    'Business Information',
                    style: TextStyle(
                        fontSize: screenWidth * 0.03, color: AppColors.BLUE),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              _buildSellerTypeOptions(screenWidth),
              SizedBox(height: screenHeight * 0.03),
              TextFormField(
                controller: _registeredNameController,
                decoration: InputDecoration(
                  labelText: 'Registered Name',
                  hintText: 'Last Name, First Name (e.g. Sabuero, Joel)',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    fontFamily: 'AvenirNextCyr',
                    fontWeight: FontWeight.bold,
                    color: AppColors.BLUE,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the registered name';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                "BIR Certificate of Registration",
                style: TextStyle(
                    fontSize: screenWidth * 0.04, color: AppColors.BLUE),
              ),
              GestureDetector(
                onTap: _pickFile,
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.2,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: _fileName == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload_file,
                                  size: screenWidth * 0.1, color: Colors.grey),
                              SizedBox(height: screenHeight * 0.01),
                              Text("+Upload (0/1)",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          )
                        : Text(_fileName!,
                            style: TextStyle(color: AppColors.BLUE)),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              TextFormField(
                controller: _businessNameController,
                decoration: InputDecoration(
                  labelText: 'Business Name',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    fontFamily: 'AvenirNextCyr',
                    fontWeight: FontWeight.bold,
                    color: AppColors.BLUE,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the business name or trade name';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShopInformationScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: AppColors.YELLOW),
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
                    ),
                    child: Text(
                      'Back',
                      style: TextStyle(
                          color: Color(0xFF353E55),
                          fontSize: screenWidth * 0.04),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                          // Submit business data to Firestore
                          await _service.submitBusiness(widget.shopName,
                              widget.email, widget.address, widget.shopName);
                          debugPrint('Button clicked');
                          // Navigate to the ProfileScreenFarmer
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreenFarmer(),
                            ),
                          );
                        } catch (e) {
                          // Handle any errors here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Failed to submit business: $e')),
                          );
                        }
                      // if (_formKey.currentState!.validate()) {
                        
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.YELLOW,
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white, fontSize: screenWidth * 0.04),
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

  Widget _buildSellerTypeOptions(double screenWidth) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.YELLOW),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          RadioListTile(
            title: Text("Sole Proprietorship",
                style: TextStyle(
                    color: AppColors.BLUE, fontSize: screenWidth * 0.04)),
            value: 'Sole Proprietorship',
            groupValue: _sellerType,
            onChanged: (String? value) {
              setState(() {
                _sellerType = value!;
              });
            },
          ),
          RadioListTile(
            title: Text("Partnership / Corporation",
                style: TextStyle(
                    color: AppColors.BLUE, fontSize: screenWidth * 0.04)),
            value: 'Partnership / Corporation',
            groupValue: _sellerType,
            onChanged: (String? value) {
              setState(() {
                _sellerType = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _stepCircle(bool isActive, double screenWidth) {
    return CircleAvatar(
      radius: screenWidth * 0.03,
      backgroundColor: isActive ? AppColors.YELLOW : Colors.grey[300],
      child: Icon(Icons.check, color: Colors.white, size: screenWidth * 0.04),
    );
  }

  Widget _stepLine(double screenWidth) {
    return Container(
      height: 2,
      width: screenWidth * 0.12,
      color: Colors.grey,
    );
  }
}
