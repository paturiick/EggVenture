import 'package:eggventure/screens/checkout%20screens/delivery_checkout_screen.dart';
import 'package:eggventure/screens/checkout%20screens/pickup_checkout_screen.dart';
import 'package:flutter/material.dart';

class PickupDeliveryScreen {
  static void showPickupDeliveryScreen(BuildContext context) {
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
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
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
                      height: 75,
                    ),
                    Center(
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DeliveryCheckoutScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF353E55),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: EdgeInsets.all(30)),
                              child: Text(
                                "For Delivery",
                                style: TextStyle(
                                    color: Color(0xFFFFB612),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PickupCheckoutScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF353E55),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: EdgeInsets.all(30)),
                              child: Text(
                                "For Pick Up",
                                style: TextStyle(
                                    color: Color(0xFFFFB612),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
