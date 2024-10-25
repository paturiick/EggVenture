import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Future<String?> uploadFile(File file, String filePath) async {
  try {
    final ref = FirebaseStorage.instance.ref().child(filePath);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  } catch (exception) {
    debugPrint('Failed to upload file: $exception');
    return null;
  }
}

Future<String?> uploadBytes(Uint8List bytes, String filepath) async {
  try {
    final ref = FirebaseStorage.instance.ref().child(filepath);
    await ref.putData(bytes);
    return await ref.getDownloadURL();
  } catch (exception) {
    debugPrint('Failed to upload bytes: $exception');
    return null;
  }
}

Future<String?> getFileURL(String uid, String fileName) async {
  try {
    final String filePath = 'images/$uid/$fileName';
    final ref = FirebaseStorage.instance.ref().child(filePath);
    return await ref.getDownloadURL();
  } catch (exception) {
    debugPrint('Failed to get file URL: $exception');
    return null;
  }
}

Future<void> onProfileTapped() async {
  final ImagePicker picker = ImagePicker();

  // Pick an image from the gallery
  final XFile? pickedImage =
      await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage == null) return;

  // Convert XFile to File
  final File imageFile = File(pickedImage.path);

  // Upload the file using uploadFile method
  final String filePath = 'images/user_1.jpg'; // Example path
  final String? downloadUrlFile = await uploadFile(imageFile, filePath);

  if (downloadUrlFile != null) {
    debugPrint(
        'File uploaded successfully (File). Download URL: $downloadUrlFile');
  } else {
    debugPrint('Failed to upload image (File).');
  }

  // Convert the image to bytes
  final Uint8List imageBytes = await pickedImage.readAsBytes();

  // Upload the file using uploadBytes method
  final String? downloadUrlBytes = await uploadBytes(imageBytes, filePath);

  if (downloadUrlBytes != null) {
    debugPrint(
        'File uploaded successfully (Bytes). Download URL: $downloadUrlBytes');
  } else {
    debugPrint('Failed to upload image (Bytes).');
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Assuming the user ID can be fetched from some authentication method
  String getCurrentUserId() {
    // Example function to get the current user's ID
    return FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void> updateUserProfile(
      String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('userDetails').doc(userId).update(data);
      print("Profile updated successfully.");
    } catch (e) {
      print("Error updating profile: $e");
    }
  }
}
