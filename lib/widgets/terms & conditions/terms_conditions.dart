import 'package:flutter/material.dart';
import 'package:eggventure/constants/colors.dart';

class TermsConditions {
  static Future<void> showTermsConditionsDialog(BuildContext context) async {
    final screenWidth = MediaQuery.of(context).size.width;

    return showDialog<void>(
      context: context,
      barrierDismissible:
          true, // Prevents closing the dialog by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Terms and Conditions",
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: AppColors.BLUE,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Effective Date: [Insert Date Here]\n\n"
                    "Welcome to EggVenture! Please read these Terms and Conditions (\"Terms\") carefully before using the EggVenture application (\"Service\") operated by [Your Company Name] (\"us\", \"we\", or \"our\"). By using or accessing the Service, you agree to be bound by these Terms. If you do not agree to any part of these Terms, you may not access the Service.\n\n"
                    "1. Acceptance of Terms\n\n"
                    "By creating an account, accessing, or using EggVenture, you confirm that you have read, understood, and agreed to these Terms and Conditions, as well as our Privacy Policy.\n\n"
                    "2. Description of Service\n\n"
                    "EggVenture is an online application that offers [briefly describe your system's purpose, e.g., 'an interactive platform for users to track, manage, and learn about egg-related activities and nutrition.'] We reserve the right to update or change the Service and these Terms at any time, and your continued use of the Service constitutes acceptance of those changes.\n\n"
                    "3. Eligibility\n\n"
                    "To use EggVenture, you must be at least 13 years old. By agreeing to these Terms, you represent and warrant that you are of legal age to form a binding contract with EggVenture and meet all of the eligibility requirements.\n\n"
                    "4. Accounts and Security\n\n"
                    "You may need to create an account to access some features of the Service. You are responsible for maintaining the confidentiality of your account and password and for restricting access to your account. You agree to notify us immediately of any unauthorized use of your account. We will not be liable for any loss or damage arising from your failure to protect your account.\n\n"
                    "5. Use of the Service\n\n"
                    "By using the Service, you agree to:\n"
                    "- Comply with all applicable laws and regulations.\n"
                    "- Not use the Service for any illegal or unauthorized purpose.\n"
                    "- Not attempt to interfere with the Service, including but not limited to distributing viruses, malware, or any other harmful technology.\n\n"
                    // Continue adding more sections as needed...
                    "Thank you for using EggVenture!\n\n"
                    "If you have any questions regarding these Terms and Conditions, please contact us.",
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: AppColors.BLUE,
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.white
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Close',
                        style: TextStyle(color: AppColors.RED),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
