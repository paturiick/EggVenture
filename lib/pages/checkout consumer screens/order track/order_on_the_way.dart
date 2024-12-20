import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:flutter/material.dart';

class OrderOnTheWay extends StatefulWidget {
  @override
  _OrderOnTheWayState createState() => _OrderOnTheWayState();
}

class _OrderOnTheWayState extends State<OrderOnTheWay> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1), // Dynamic padding
          child: Column(
            mainAxisSize: MainAxisSize.min, // Minimize vertical space usage
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Your order is on its way!",
                style: TextStyle(
                  fontSize: screenWidth * 0.06, // Dynamic font size
                  fontWeight: FontWeight.bold,
                  color: AppColors.BLUE,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenWidth * 0.05), // Dynamic spacing
              Text(
                "Delivery Time: 30 min",
                style: TextStyle(
                  fontSize: screenWidth * 0.04, // Dynamic font size
                  color: AppColors.BLUE,
                ),
              ),
              SizedBox(height: screenWidth * 0.1), // Dynamic spacing
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: screenWidth * 0.3, // Dynamic circle size
                    width: screenWidth * 0.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.YELLOW,
                        width: screenWidth * 0.03, // Dynamic border width
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "30",
                        style: TextStyle(
                          fontSize: screenWidth * 0.08, // Dynamic font size
                          fontWeight: FontWeight.bold,
                          color: AppColors.BLUE,
                        ),
                      ),
                      Text(
                        "mins left",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04, // Dynamic font size
                          color: AppColors.BLUE,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.1), // Dynamic spacing
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.HOMESCREEN);
                },
                child: Text(
                  "Close",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045, // Dynamic font size
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.BLUE,
                  padding: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.03, // Dynamic vertical padding
                    horizontal:
                        screenWidth * 0.08, // Dynamic horizontal padding
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        screenWidth * 0.05), // Dynamic border radius
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
