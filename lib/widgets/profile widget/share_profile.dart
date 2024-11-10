import 'package:eggventure/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

class ShareProfile {
  void showShareProfileDialog(BuildContext context, String profileLink,
      VoidCallback getUserNameCallback) {
    final screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Share your profile on:",
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: AppColors.BLUE,
                  ),
                ),
                SizedBox(height: 20),
                // Social media icons in a grid format
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  children: [
                    _buildPlatformIcon(Icons.facebook, "Facebook", Colors.blue,
                        context, profileLink),
                    _buildPlatformIcon(Icons.email, "Email", AppColors.YELLOW,
                        context, profileLink),
                  ],
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 10),
                // Copy link section
                Text(
                  "Or copy link",
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Text(
                              profileLink,
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: screenWidth * 0.025),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: profileLink));
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Profile link copied to clipboard!'),
                          ),
                        );
                      },
                      child: Text(
                        "Copy Link",
                        style: TextStyle(color: AppColors.BLUE),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Close button
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text(
                      "Close",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlatformIcon(IconData icon, String platformName, Color color,
      BuildContext context, String profileLink) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(); // Close the dialog before sharing
        Share.share("Check out my profile on $platformName! $profileLink");
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 15,
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          SizedBox(height: 5),
          Text(
            platformName,
            style: TextStyle(fontSize: 10,
            color: AppColors.BLUE),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
