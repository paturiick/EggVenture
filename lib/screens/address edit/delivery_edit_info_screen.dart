import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/constants/dropdown_list_delivery_checkout.dart';
import 'package:eggventure/models/user_info.dart';
import 'package:eggventure/providers/buy_now_provider.dart';
import 'package:eggventure/providers/user_info_provider.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryEditInfoScreen extends StatefulWidget {
  @override
  _DeliveryEditInfoScreenState createState() => _DeliveryEditInfoScreenState();
}

class _DeliveryEditInfoScreenState extends State<DeliveryEditInfoScreen> {
  final _form = GlobalKey<FormState>();
  final DropdownListDeliveryCheckout _province = DropdownListDeliveryCheckout();
  String? _selectedProvince;
  String _firstName = '';
  String _lastName = '';
  String _streetAddress = '';
  String _barangayAddress = '';
  String _cityAddress = '';
  String _provinceAddress = '';
  String _additionalInfo = '';

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
                      color: Colors.black.withOpacity(0.2),
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
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onSaved: (value) => _firstName = value ?? '',
                              keyboardType: TextInputType.name,
                              maxLength: 30,
                              cursorColor: AppColors.YELLOW,
                              style: TextStyle(
                                color: AppColors.BLUE,
                                fontSize: screenWidth * 0.025,
                              ),
                              decoration: InputDecoration(
                                labelText: "First Name",
                                labelStyle: TextStyle(
                                  color: AppColors.BLUE,
                                  fontSize: screenWidth * 0.03,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.YELLOW),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          Expanded(
                            child: TextFormField(
                              onSaved: (value) => _lastName = value ?? '',
                              keyboardType: TextInputType.name,
                              maxLength: 30,
                              cursorColor: AppColors.YELLOW,
                              style: TextStyle(
                                fontSize: screenWidth * 0.025,
                                color: AppColors.BLUE,
                              ),
                              decoration: InputDecoration(
                                labelText: "Last Name",
                                labelStyle: TextStyle(
                                  color: AppColors.BLUE,
                                  fontSize: screenWidth * 0.03,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.YELLOW),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextFormField(
                        onSaved: (value) => _streetAddress = value ?? '',
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
                        onSaved: (value) => _barangayAddress = value?? '',
                        keyboardType: TextInputType.text,
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
                        onSaved: (value) => _cityAddress = value?? '',
                        keyboardType: TextInputType.text,
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
                        onSaved: (value) => _provinceAddress = value?? '', 
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
                        onSaved: (value) => _additionalInfo = value?? '',
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
                            context, AppRoutes.DELIVERYCHECKOUT);
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
                        if (_form.currentState!.validate()) {
                          _form.currentState!.save();
                          final newUserInfo = UserInfo(
                              firstName: _firstName,
                              lastName: _lastName,
                              streetAddress: _streetAddress,
                              barangayAddress: _barangayAddress,
                              cityAddress: _cityAddress,
                              provinceAddress: _provinceAddress,
                              additionalInfo: _additionalInfo);
                          Provider.of<UserInfoProvider>(context, listen: false)
                              .updateUserInfo(newUserInfo);
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
