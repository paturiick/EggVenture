import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/constants/dropdown_list_province.dart';
import 'package:eggventure/providers/buy_now_provider.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickupEditInfoScreen extends StatefulWidget {
  @override
  _PickupEditInfoScreenState createState() => _PickupEditInfoScreenState();
}

class _PickupEditInfoScreenState extends State<PickupEditInfoScreen> {
  final _form = GlobalKey<FormState>();
  final DropdownListProvince _province = DropdownListProvince();
  String? _selectedProvince;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.BLUE.withOpacity(0.2),
                      offset: Offset(0, 2),
                      blurRadius: 5,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  title: Text(
                    "Edit Info",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.BLUE,
                    ),
                  ),
                  centerTitle: true,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        maxLines: null,
                        minLines: 1,
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: AppColors.BLUE,
                        ),
                        decoration: InputDecoration(
                          labelText: "Street/House No.",
                          labelStyle: TextStyle(
                            fontSize: screenWidth * 0.03,
                            color: AppColors.BLUE,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.YELLOW),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        maxLength: 40,
                        style: TextStyle(
                          fontSize: screenWidth * 0.025,
                          color: AppColors.BLUE,
                        ),
                        decoration: InputDecoration(
                          labelText: "Barangay",
                          labelStyle: TextStyle(
                            fontSize: screenWidth * 0.03,
                            color: AppColors.BLUE,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.YELLOW),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        maxLength: 40,
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: AppColors.BLUE,
                        ),
                        decoration: InputDecoration(
                          labelText: "City",
                          labelStyle: TextStyle(
                            fontSize: screenWidth * 0.03,
                            color: AppColors.BLUE,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.YELLOW),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      DropdownButtonFormField<String>(
                        dropdownColor: Colors.white,
                        value: _selectedProvince,
                        icon:
                            Icon(Icons.arrow_drop_down, color: AppColors.BLUE),
                        decoration: InputDecoration(
                          labelText: "Province",
                          labelStyle: TextStyle(
                            color: AppColors.BLUE,
                            fontSize: screenWidth * 0.03,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.YELLOW),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: _province.province.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: AppColors.BLUE),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedProvince = newValue;
                          });
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        minLines: 1,
                        maxLines: null,
                        style: TextStyle(
                          fontSize: screenWidth * 0.025,
                          color: AppColors.BLUE,
                        ),
                        decoration: InputDecoration(
                          labelText: "Additional Information",
                          labelStyle: TextStyle(
                            fontSize: screenWidth * 0.03,
                            color: AppColors.BLUE,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.YELLOW),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.2),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRoutes.PICKUPCHECKOUT);
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
                        child: Text("Cancel",
                            style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: AppColors.RED)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_form.currentState!.validate()) {
                          // Save button action
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
                        child: Text("Save",
                            style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: AppColors.BLUE)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
