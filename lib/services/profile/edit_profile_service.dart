import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/controller/edit_profile_name_controller.dart';
import 'package:eggventure/providers/user_info_provider.dart';
import 'package:eggventure/services/firebase/firebase%20auth/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class EditProfileService {
  final FirestoreService _service = FirestoreService();
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  late TextEditingController streetAddressController;
  late TextEditingController barangayAddressController;
  late TextEditingController cityAddressController;
  late TextEditingController additionalInfoController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late Stream<DocumentSnapshot> userProfileStream;
  late EditProfileNameController userEditProfileName;

  String? userName;
  String? userEmail;
  String? selectedProvince;

  bool isLoading = true;
  bool hasFetchedData = false;

  void init(BuildContext context) {
    final userProvider = Provider.of<UserInfoProvider>(context, listen: false);
    final storedUserInfo = userProvider.getUserInfo();

    streetAddressController =
        TextEditingController(text: storedUserInfo.streetAddress);
    barangayAddressController =
        TextEditingController(text: storedUserInfo.barangayAddress);
    cityAddressController =
        TextEditingController(text: storedUserInfo.cityAddress);
    additionalInfoController =
        TextEditingController(text: storedUserInfo.additionalInfo);
    selectedProvince = storedUserInfo.provinceAddress.isNotEmpty
        ? storedUserInfo.provinceAddress
        : null;

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    userEditProfileName = EditProfileNameController(_service);

     if (!hasFetchedData) {
      getUserName();
      final userId = _service.getCurrentUserId();
      if (userId.isNotEmpty) {
        userProfileStream = _service.getUserProfileStream(userId);
      } else {
        print("User ID not found");
      }

      getUserEmail().then((email) {
        userEmail = email;
      });
      hasFetchedData = true;
    }
  }

  void dispose() {
    streetAddressController.dispose();
    barangayAddressController.dispose();
    cityAddressController.dispose();
    additionalInfoController.dispose();
  }

  Future<void> saveUserName(BuildContext context) async {
    if (form.currentState?.validate() ?? false) {
      final newFirstName = firstNameController.text.trim();
      final newLastName = lastNameController.text.trim();
      final uid = _service.getCurrentUserId();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar( 
          content: Text(
            'Saving changes...',
            style: TextStyle(color: AppColors.BLUE),
          ),
          backgroundColor: AppColors.YELLOW,
        ),
      );

      try {
        await userEditProfileName.updateUserName(
          uid: uid,
          firstName: newFirstName,
          lastName: newLastName,
          context: context,
          updatedUserName: (updatedName) {
            userName = updatedName;
          },
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Profile updated successfully!',
              style: TextStyle(color: AppColors.BLUE),
            ),
            backgroundColor: Colors.green,
          ),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to update profile: $error',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all required fields correctly.',
            style: TextStyle(color: AppColors.BLUE),
          ),
          backgroundColor: AppColors.YELLOW,
        ),
      );
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

      userName = '$firstName $lastName';
      firstNameController.text = firstName ?? '';
      lastNameController.text = lastName ?? '';
      hasFetchedData = true;
      isLoading = false;
    } catch (e) {
      print(e);
      isLoading = false;
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
}
