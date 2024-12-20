import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/widgets/confirmation/logout_confirmation.dart';
import 'package:flutter/material.dart';

class MenuScreen {
  static void showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.6,
          minChildSize: 0.4,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Scrollable section for menu items
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        children: [
                          _buildMenuButton(context, 'Vouchers & offers',
                              Icons.card_giftcard),
                          _buildMenuButton(
                              context, 'Invite friends', Icons.people),
                          _buildMenuButton(
                              context, 'Location', Icons.location_on),
                          _buildMenuButton(
                              context, 'Terms & Conditions', Icons.description),
                          _buildMenuButton(
                              context, 'Help Center', Icons.help_outline),
                          _buildMenuButton(
                              context, 'Switch account', Icons.swap_horiz),
                          Divider(thickness: 1, color: Colors.grey[300]),
                        ],
                      ),
                    ),
                    // Non-scrollable section for the logout button
                    _buildLogoutButton(context, 'Log out'),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Widget _buildMenuButton(
      BuildContext context, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor: AppColors.BLUE,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          // Handle the menu item actions here
        },
        icon: Icon(icon, color: Colors.white),
        label: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  static Widget _buildLogoutButton(BuildContext context, String title) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              AppColors.RED,
              AppColors.RED
            ],
          ),
        ),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 100.0),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            LogoutConfirmation.showLogOutConfirmation(context);
          },
          icon: Icon(
            Icons.logout, // Using the logout icon
            color: Colors.white,
          ),
          label: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.05,
            ),
          ),
        ),
      ),
    );
  }
}
