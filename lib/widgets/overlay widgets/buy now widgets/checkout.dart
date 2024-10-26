import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/providers/buy_now_provider.dart';
import 'package:eggventure/widgets/overlay%20widgets/buy%20now%20widgets/buy_now.dart';
import 'package:eggventure/widgets/overlay%20widgets/buy%20now%20widgets/pickup_delivery.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  static void showCheckOutScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CheckoutScreen(); // Show the stateful widget here
      },
    );
  }

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  @override
  Widget build(BuildContext context) {
    final buynowProvider = Provider.of<BuyNowProvider>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(screenWidth * 0.05),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                height: screenHeight * 0.005,
                width: screenWidth * 0.1,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quantity:",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${buynowProvider.buyItems.fold<int>(0, (totalQuantity, item) => item.amount)}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: AppColors.BLUE,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Subtotal:",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  // fix the price 
                  'P ${buynowProvider.subtotal}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.045,
                    color: AppColors.BLUE,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shipping Fee:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.045,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "P 10.00",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,  
                    fontWeight: FontWeight.bold,
                    color: AppColors.BLUE,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Price:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.045,
                    color: AppColors.BLUE,
                  ),
                ),
                Text(
                  'P ${(buynowProvider.subtotal + 10.0).toStringAsFixed(2)}', // Updating total price dynamically
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: AppColors.BLUE,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      buynowProvider.clearTray();
                      buynowProvider.buyItems.clear();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.RED,
                      side: BorderSide(color: AppColors.RED),
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        color: AppColors.RED,
                      ),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      PickupDeliveryScreen.showPickupDeliveryScreen(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.BLUE,
                      side: BorderSide(color: AppColors.BLUE),
                      backgroundColor: AppColors.BLUE,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.045,
                        color: AppColors.YELLOW,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
