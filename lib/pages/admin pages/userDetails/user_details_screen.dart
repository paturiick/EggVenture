import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eggventure/constants/colors.dart';

class UserDetailsDialog {
  static Future<void> show(BuildContext context, String userId) async {
    Future<Map<String, dynamic>> _fetchUserDetails() async {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('userDetails')
            .doc(userId)
            .get();
        return doc.data() ?? {};
      } catch (e) {
        throw 'Failed to fetch user details: $e';
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text('User Details',
            style: TextStyle(
              color: AppColors.BLUE
            ),)
          ),
          content: FutureBuilder<Map<String, dynamic>>(
            future: _fetchUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              final userDetails = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'First Name: ${userDetails['firstName'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 16, color: AppColors.BLUE),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Last Name: ${userDetails['lastName'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 16, color: AppColors.BLUE),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Email: ${userDetails['userEmail'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 16, color: AppColors.BLUE),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Phone Number: ${userDetails['userPhoneNumber'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 16, color: AppColors.BLUE),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Farmer: ${userDetails['isSeller'] ?? false ? 'Yes' : 'No'}',
                      style: TextStyle(fontSize: 16, color: AppColors.BLUE),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close', style: TextStyle(color: AppColors.RED)),
            ),
          ],
        );
      },
    );
  }
}
