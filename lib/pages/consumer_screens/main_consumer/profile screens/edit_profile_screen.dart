import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/constants/dropdown_list_province.dart';
import 'package:eggventure/services/firebase/firebase%20auth/firestore_service.dart';
import 'package:eggventure/services/firebase/firebase%20storage/firebase_profile_picture.dart';
import 'package:eggventure/widgets/loading_screen.dart/shimmer_effect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ChangeProfilePicture changeProfilePicture = ChangeProfilePicture();
  final FirestoreService _service = FirestoreService();
  final DropdownListProvince _province = DropdownListProvince();
  final _formKey = GlobalKey<FormState>();

  String? userName;
  String? userEmail;
  String? _selectedProvince;

  bool _isLoading = true;
  bool _hasFetchedData = false;

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late Stream<DocumentSnapshot> userProfileStream;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();

    if (!_hasFetchedData) {
      getUserName();
      
      // Fetch user ID and pass it to the stream method
      final userId = _service.getCurrentUserId();
      userProfileStream = _service.getUserProfileStream(userId);

      getUserEmail().then((email) {
        setState(() {
          userEmail = email;
        });
      });
      _hasFetchedData = true;
    }
  }

  Future<void> saveProfilePicture(String newImageUrl) async {
    final uid = _service.getCurrentUserId();
    await _service.updateUserField(uid, 'profilePictureUrl', newImageUrl);
  }

  Future<void> getUserName() async {
    try {
      final uid = _service.getCurrentUserId();
      final userDetails = await _service.getBasedOnId('userDetails', uid);
      final data = userDetails.data() as Map<String, dynamic>?;
      final firstName = data?["firstName"];
      final lastName = data?["lastName"];

      setState(() {
        userName = '$firstName $lastName';
        _firstNameController.text = firstName ?? '';
        _lastNameController.text = lastName ?? '';
        _hasFetchedData = true;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String?> getUserEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      return user?.email;
    } catch (e) {
      print(e);
      return null;
    }
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
            stream: userProfileStream,
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
              final userProfileData = snapshot.data?.data() as Map<String, dynamic>?;
              String? uploadImageUrl = userProfileData?['profilePictureUrl'];
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
                        backgroundColor: Colors.white,
                        elevation: 0,
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.BLUE,
                            size: screenWidth * 0.05,
                          ),
                        ),
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
                    // Profile Picture
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              uploadImageUrl == null
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        await changeProfilePicture.changeProfilePicture(context);
                                        final newImageUrl = changeProfilePicture.uploadedImageUrl;
                                        if (newImageUrl != null) {
                                          await saveProfilePicture(newImageUrl);
                                          setState(() {
                                            uploadImageUrl = newImageUrl;
                                          });
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
                                      style: ElevatedButton.styleFrom(
                                        shape: CircleBorder(),
                                        backgroundColor: Colors.grey[200],
                                        padding: EdgeInsets.all(screenWidth * 0.1),
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: AppColors.BLUE,
                                        size: screenWidth * 0.1,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: screenWidth * 0.15,
                                      backgroundImage: NetworkImage(uploadImageUrl),
                                    ),
                              if (uploadImageUrl != null)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () async {
                                      await changeProfilePicture.changeProfilePicture(context);
                                      final newImageUrl = changeProfilePicture.uploadedImageUrl;
                                      if (newImageUrl != null) {
                                        await saveProfilePicture(newImageUrl);
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.15),
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                      padding: EdgeInsets.all(screenWidth * 0.02),
                                      child: Icon(
                                        Icons.edit,
                                        color: AppColors.BLUE,
                                        size: screenWidth * 0.05,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Text(
                      userName ?? '',
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
                      userEmail ?? '',
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
                                controller: _firstNameController,
                                style: TextStyle(
                                    fontSize: screenWidth * 0.025,
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
                                controller: _lastNameController,
                                style: TextStyle(
                                    fontSize: screenWidth * 0.025,
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
                            style: TextStyle(
                              fontSize: screenWidth * 0.025,
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
                                borderSide: BorderSide(color: AppColors.YELLOW),
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
                            style: TextStyle(
                              fontSize: screenWidth * 0.025,
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
                                borderSide: BorderSide(color: AppColors.YELLOW),
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
                            style: TextStyle(
                              fontSize: screenWidth * 0.025,
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
                                borderSide: BorderSide(color: AppColors.YELLOW),
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
                            value: _selectedProvince,
                            icon: Icon(Icons.arrow_drop_down,
                                color: AppColors.BLUE),
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
      )),
      )
    );
  }
}
