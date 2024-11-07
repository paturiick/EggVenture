import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ChangeProfilePicture {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? uploadedImageUrl;

  Future<void> changeProfilePicture(BuildContext context) async {
    try {
      // Use ImagePicker to select an image
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'No image selected',
              style: TextStyle(color: AppColors.BLUE),
            ),
            backgroundColor: AppColors.YELLOW,
          ),
        );
        return;
      }

      // Get the current user ID
      User? user = _auth.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'No user is signed in',
              style: TextStyle(color: AppColors.BLUE),
            ),
            backgroundColor: AppColors.YELLOW,
          ),
        );
        return;
      }

      String fileName = basename(image.path);
      Reference storageRef =
          _storage.ref().child('profile_pictures/${user.uid}/$fileName');

      // Upload the file to Firebase Storage
      File file = File(image.path);
      UploadTask uploadTask = storageRef.putFile(file);

      // Show a loading dialog while uploading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        },
      );

      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL
      uploadedImageUrl = await snapshot.ref.getDownloadURL();

      // Check if the document exists in Firestore
      DocumentReference userDocRef =
          _firestore.collection('users').doc(user.uid);
      DocumentSnapshot userDocSnapshot = await userDocRef.get();

      if (userDocSnapshot.exists) {
        // If the document exists, update the profile picture URL
        await userDocRef.update({
          'profile_picture': uploadedImageUrl,
        });
      } else {
        // If the document doesn't exist, create it with the profile picture URL
        await userDocRef.set({
          'profile_picture': uploadedImageUrl,
        });
      }

      // Close the loading dialog
      Navigator.of(context).pop();

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profile picture updated successfully',
            style: TextStyle(color: AppColors.BLUE),
          ),
          backgroundColor: AppColors.YELLOW,
        ),
      );
    } catch (e) {
      // Close the loading dialog if there is an error
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile picture: $e')),
      );
    }
  }
}
