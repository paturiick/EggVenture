import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:eggventure/screens_farmer/start_selling_screens/shop_information_screen.dart'; // Import your ShopInformationScreen
import 'package:eggventure/screens_farmer/profile_screen_farmer.dart'; // Import your HomeScreenFarmer

class BusinessInformationScreen extends StatefulWidget {
  @override
  _BusinessInformationScreenState createState() => _BusinessInformationScreenState();
}

class _BusinessInformationScreenState extends State<BusinessInformationScreen> {
  String _sellerType = 'Sole Proprietorship'; // Default seller type
  String? _fileName; // Selected file name

  final _formKey = GlobalKey<FormState>();
  final _registeredNameController = TextEditingController();
  final _businessNameController = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Business Information", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Handle Save action
            },
            child: Text("Save", style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stepper Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _stepCircle(true),
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
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(width: 60), // Adjust the space between text
                  Text(
                    '     Business Information',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Seller Type Selection
              _buildSellerTypeOptions(),

              SizedBox(height: 20),

              // Registered Name Field
              TextFormField(
                controller: _registeredNameController,
                decoration: InputDecoration(
                  labelText: 'Registered Name',
                  hintText: 'Last Name, First Name (e.g. Sabuero, Joel)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the registered name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // BIR Certificate Upload
              Text("BIR Certificate of Registration", style: TextStyle(fontSize: 16)),
              GestureDetector(
                onTap: _pickFile,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: _fileName == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload_file, size: 40, color: Colors.grey),
                              SizedBox(height: 10),
                              Text("+Upload (0/1)", style: TextStyle(color: Colors.grey)),
                            ],
                          )
                        : Text(_fileName!),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Business Name / Trade Name Field
              TextFormField(
                controller: _businessNameController,
                decoration: InputDecoration(
                  labelText: 'Business Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the business name or trade name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShopInformationScreen(), // Navigate to ShopInformationScreen
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.orange),
                      padding: EdgeInsets.symmetric(horizontal: 90),
                    ),
                    child: Text(
                      'Back',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreenFarmer(), // Navigate to HomeScreenFarmer
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 90),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
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

  Widget _buildSellerTypeOptions() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          RadioListTile(
            title: Text("Sole Proprietorship"),
            value: 'Sole Proprietorship',
            groupValue: _sellerType,
            onChanged: (String? value) {
              setState(() {
                _sellerType = value!;
              });
            },
          ),
          RadioListTile(
            title: Text("Partnership / Corporation"),
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

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(120, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }

  Widget _stepCircle(bool isActive) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: isActive ? Colors.orange : Colors.grey[300],
      child: Icon(Icons.check, color: Colors.white, size: 16),
    );
  }

  Widget _stepLine() {
    return Container(
      height: 2,
      width: 50,
      color: Colors.orange,
    );
  }
}
