import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:eggventure/screens_farmer/start_selling_screens/shop_information_screen.dart';
import 'package:eggventure/screens_farmer/profile_screen_farmer.dart';

class BusinessInformationScreen extends StatefulWidget {
  @override
  _BusinessInformationScreenState createState() => _BusinessInformationScreenState();
}

class _BusinessInformationScreenState extends State<BusinessInformationScreen> {
  String _sellerType = 'Sole Proprietorship';
  String? _fileName;

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
        title: Text("Business Information", style: TextStyle(color: Color(0xFF353E55))),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Handle Save action
            },
            child: Text("Save", style: TextStyle(color: Color(0xFFF9B514))),
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
                    style: TextStyle(fontSize: 16, color: Color(0xFF353E55)),
                  ),
                  SizedBox(width: 60),
                  Text(
                    '     Business Information',
                    style: TextStyle(fontSize: 16, color: Color(0xFF353E55)),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildSellerTypeOptions(),
              SizedBox(height: 20),
              TextFormField(
                controller: _registeredNameController,
                decoration: InputDecoration(
                  labelText: 'Registered Name',
                  hintText: 'Last Name, First Name (e.g. Sabuero, Joel)',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    fontFamily: 'AvenirNextCyr',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF353E55),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the registered name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text("BIR Certificate of Registration", style: TextStyle(fontSize: 16, color: Color(0xFF353E55))),
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
                        : Text(_fileName!, style: TextStyle(color: Color(0xFF353E55))),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _businessNameController,
                decoration: InputDecoration(
                  labelText: 'Business Name',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    fontFamily: 'AvenirNextCyr',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF353E55),
                  ),
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
                          builder: (context) => ShopInformationScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Color(0xFFF9B514)),
                      padding: EdgeInsets.symmetric(horizontal: 90),
                    ),
                    child: Text(
                      'Back',
                      style: TextStyle(color: Color(0xFF353E55)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreenFarmer(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF9B514),
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
        border: Border.all(color: Color(0xFFF9B514)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          RadioListTile(
            title: Text("Sole Proprietorship", style: TextStyle(color: Color(0xFF353E55))),
            value: 'Sole Proprietorship',
            groupValue: _sellerType,
            onChanged: (String? value) {
              setState(() {
                _sellerType = value!;
              });
            },
          ),
          RadioListTile(
            title: Text("Partnership / Corporation", style: TextStyle(color: Color(0xFF353E55))),
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

  Widget _stepCircle(bool isActive) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: isActive ? Color(0xFFF9B514) : Colors.grey[300],
      child: Icon(Icons.check, color: Colors.white, size: 16),
    );
  }

  Widget _stepLine() {
    return Container(
      height: 2,
      width: 50,
      color: Colors.grey,
    );
  }
}
