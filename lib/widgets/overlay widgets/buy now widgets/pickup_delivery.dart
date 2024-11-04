import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/pages/checkout%20consumer%20screens/delivery_checkout_screen.dart';
import 'package:eggventure/pages/checkout%20consumer%20screens/pickup_checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PickupDeliveryScreen {
  static void showPickupDeliveryScreen(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark));
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          // Adjusting the child size limits
          maxChildSize:
              0.5, // The maximum height the sheet can reach (50% of the screen height)
          minChildSize:
              0.4, // The minimum height of the sheet (40% of the screen height)
          initialChildSize: 0.4, // Initial height when the sheet is shown
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                controller:
                    scrollController, // Attach the scrollController to the sheet
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.DELIVERYCHECKOUT);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.BLUE,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.all(30),
                              ),
                              child: Text(
                                "For Delivery",
                                style: TextStyle(
                                  color: AppColors.YELLOW,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.PICKUPCHECKOUT);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.BLUE,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.all(30),
                              ),
                              child: Text(
                                "For Pick Up",
                                style: TextStyle(
                                  color: AppColors.YELLOW,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
