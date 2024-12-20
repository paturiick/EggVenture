import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/constants/dropdown_list_province.dart';
import 'package:eggventure/providers/edit_profile_provider.dart';
import 'package:eggventure/providers/user_info_provider.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/services/firebase/firebase%20storage/firebase_profile_picture.dart';
import 'package:eggventure/services/profile/edit_profile_service.dart';
import 'package:eggventure/widgets/confirmation/save_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eggventure/models/user_info.dart' as user_info;

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final profileService = EditProfileService();
  final changeProfilePicture = ChangeProfilePicture();

  final DropdownListProvince _province = DropdownListProvince();

  @override
  void initState() {
    super.initState();
    profileService.init(context);
  }

  @override
  void dispose() {
    profileService.dispose();
    super.dispose();
  }
  
  void saveChanges(){
    profileService.saveUserName(context);
  }

   Widget buildProfilePicture(double screenWidth) {
    return Consumer<EditProfileProvider>(
      builder: (context, userImageProvider, child) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: screenWidth * 0.15,
              backgroundImage: userImageProvider.imageUrl.isNotEmpty
                  ? NetworkImage(userImageProvider.imageUrl)
                  : null,
              backgroundColor: Colors.grey[200],
              child: userImageProvider.imageUrl.isEmpty
                  ? Icon(
                      Icons.person,
                      color: AppColors.BLUE,
                      size: screenWidth * 0.1,
                    )
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () async {
                  await changeProfilePicture.changeProfilePicture(context);
                  final newImageUrl = changeProfilePicture.uploadedImageUrl;

                  if (newImageUrl != null) {
                    await profileService.saveProfilePicture(newImageUrl);
                    userImageProvider.updateImageUrl(newImageUrl);
                    setState(() {});
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.YELLOW,
                        content: Text(
                          "Failed to retrieve the new Profile Picture",
                          style: TextStyle(color: AppColors.BLUE),
                        ),
                      ),
                    );
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: screenWidth * 0.05,
                  child: Icon(
                    Icons.edit,
                    color: AppColors.BLUE,
                    size: screenWidth * 0.04,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Scaffold(
              body: StreamBuilder<DocumentSnapshot>(
                  stream: profileService.userProfileStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.YELLOW,
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error loading profile data."),
                      );
                    }
                    final userProfileData =
                        snapshot.data?.data() as Map<String, dynamic>?;
                    String? uploadImageUrl =
                        userProfileData?['profilePictureUrl'];
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          // AppBar and Profile Picture
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
                              automaticallyImplyLeading: false,
                              backgroundColor: Colors.white,
                              elevation: 0,
                              title: Text(
                                "Edit Profile",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.BLUE,
                                ),
                              ),
                              centerTitle: true,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          buildProfilePicture(screenWidth),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Text(
                            profileService.userName ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.05,
                              color: AppColors.BLUE,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Text(
                            profileService.userEmail ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.03,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.04,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: TextField(
                                      controller: profileService.firstNameController,
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.035,
                                          color: AppColors.BLUE),
                                      decoration: InputDecoration(
                                          label: Text(
                                            "First Name",
                                            style: TextStyle(
                                                color: AppColors.BLUE,
                                                fontSize: screenWidth * 0.03),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.YELLOW))),
                                    )),
                                    SizedBox(
                                      width: screenWidth * 0.01,
                                    ),
                                    Expanded(
                                        child: TextField(
                                      controller: profileService.lastNameController,
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.035,
                                          color: AppColors.BLUE),
                                      decoration: InputDecoration(
                                          label: Text(
                                            "Last Name",
                                            style: TextStyle(
                                                color: AppColors.BLUE,
                                                fontSize: screenWidth * 0.03),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.YELLOW))),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                                TextFormField(
                                  controller: profileService.streetAddressController,
                                  keyboardType: TextInputType.streetAddress,
                                  maxLines: null,
                                  minLines: 1,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    color: AppColors.BLUE,
                                  ),
                                  decoration: InputDecoration(
                                    label: Text(
                                      "Street/House No.",
                                      style: TextStyle(
                                        color: AppColors.BLUE,
                                        fontSize: screenWidth * 0.03,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.YELLOW),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your street/house number';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                                TextFormField(
                                  controller: profileService.barangayAddressController,
                                  keyboardType: TextInputType.text,
                                  maxLength: 40,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    color: AppColors.BLUE,
                                  ),
                                  decoration: InputDecoration(
                                    label: Text(
                                      "Barangay",
                                      style: TextStyle(
                                        color: AppColors.BLUE,
                                        fontSize: screenWidth * 0.03,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.YELLOW),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your barangay';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                                TextFormField(
                                  controller: profileService.cityAddressController,
                                  keyboardType: TextInputType.text,
                                  maxLength: 40,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    color: AppColors.BLUE,
                                  ),
                                  decoration: InputDecoration(
                                    label: Text(
                                      "City",
                                      style: TextStyle(
                                        color: AppColors.BLUE,
                                        fontSize: screenWidth * 0.03,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.YELLOW),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your city';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                                DropdownButtonFormField<String>(
                                  dropdownColor: Colors.white,
                                  value: profileService.selectedProvince,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      profileService.selectedProvince = newValue;
                                    });
                                  },
                                  icon: Icon(Icons.arrow_drop_down,
                                      color: AppColors.BLUE),
                                  decoration: InputDecoration(
                                    labelText: "Province",
                                    labelStyle: TextStyle(
                                      color: AppColors.BLUE,
                                      fontSize: screenWidth * 0.03,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.YELLOW),
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
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.05,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.PROFILESCREEN);
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
                                    if (profileService.form.currentState!.validate()) {
                                      profileService.form.currentState!.save();
                                      final newUserInfo = user_info.UserInfo(
                                          streetAddress: profileService.streetAddressController.text,
                                          barangayAddress:
                                              profileService
                                              .barangayAddressController.text,
                                          cityAddress: profileService.cityAddressController.text,
                                          provinceAddress:
                                              profileService.selectedProvince ?? '',
                                          additionalInfo: profileService.additionalInfoController.text);
                                      Provider.of<UserInfoProvider>(context,
                                              listen: false)
                                          .updateUserInfo(newUserInfo);

                                      showSaveConfirmation(context);

                                      Navigator.pushNamed(
                                          context, AppRoutes.PROFILESCREEN);
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
                        ],
                      ),
                    );
                  })),
        ));
  }
}
