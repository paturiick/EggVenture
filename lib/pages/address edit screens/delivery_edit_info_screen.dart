import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/constants/dropdown_list_province.dart';
import 'package:eggventure/models/user_info.dart';
import 'package:eggventure/providers/user_info_provider.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/widgets/confirmation/save_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryEditInfoScreen extends StatefulWidget {
  @override
  _DeliveryEditInfoScreenState createState() => _DeliveryEditInfoScreenState();
}

class _DeliveryEditInfoScreenState extends State<DeliveryEditInfoScreen> {
  final _form = GlobalKey<FormState>();
  final DropdownListProvince _province = DropdownListProvince();
  String? _selectedProvince;
  late TextEditingController _streetAddress;
  late TextEditingController _barangayAddress;
  late TextEditingController _cityAddress;
  late TextEditingController _additionalInfo;

  @override
  void initState() {
    super.initState();

    final userProvider = Provider.of<UserInfoProvider>(context, listen: false);

    final storedUserInfo = userProvider.getUserInfo();

    _streetAddress = TextEditingController(text: storedUserInfo.streetAddress);
    _barangayAddress = TextEditingController(text: storedUserInfo.barangayAddress);
    _cityAddress = TextEditingController(text: storedUserInfo.cityAddress);
    _additionalInfo = TextEditingController(text: storedUserInfo.additionalInfo);
    _selectedProvince = storedUserInfo.provinceAddress.isNotEmpty
    ? storedUserInfo.provinceAddress
    : null;
  }

  @override
  void dispose() {
    _streetAddress.dispose();
    _barangayAddress.dispose();
    _cityAddress.dispose();
    _additionalInfo.dispose();
    super.dispose();
  }

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
                        controller: _streetAddress,
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
                        controller: _barangayAddress,
                        keyboardType: TextInputType.text,
                        maxLength: 40,
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
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
                        controller: _cityAddress,
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
                        value: _selectedProvince,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedProvince = newValue;
                          });
                        },
                        items: _province.province.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: AppColors.BLUE),
                            ),
                          );
                        }).toList(),
                        dropdownColor: Colors.white,
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
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextFormField(
                        controller: _additionalInfo,
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
                      onPressed: () async{
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
                              streetAddress: _streetAddress.text,
                              barangayAddress: _barangayAddress.text,
                              cityAddress: _cityAddress.text,
                              provinceAddress: _selectedProvince ?? '',
                              additionalInfo: _additionalInfo.text);
                          Provider.of<UserInfoProvider>(context, listen: false)
                              .updateUserInfo(newUserInfo);

                          showSaveConfirmation(context);

                          Navigator.pushNamed(
                              context, AppRoutes.DELIVERYCHECKOUT);
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