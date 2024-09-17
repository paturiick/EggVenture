import 'package:eggventure/overlay_screens/checkout_screen.dart';
import 'package:flutter/material.dart';

class BuyNowScreen {
  static void showBuyNowScreen(BuildContext context) {
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
                  children: [
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        children: [
                          _buildTrayItem(context, "Small Egg Tray", "P 140",
                              "assets/browse store/small_eggs.jpg"),
                          _buildTrayItem(context, "Medium Egg Tray", "P 180",
                              "assets/browse store/medium_eggs.jpg"),
                          _buildTrayItem(context, "Large Egg Tray", "P 220",
                              "assets/browse store/large_eggs.jpeg"),
                          _buildTrayItem(context, "XL Egg Tray", "P 250",
                              "assets/browse store/xl_eggs.jpg"),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: BorderSide(color: Colors.red),
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            CheckoutScreen.showCheckOutScreen(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFB612),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Proceed',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF353E55),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Widget _buildTrayItem(
      BuildContext context, String title, String price, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Checkbox(
            value: false, // You can manage this state
            onChanged: (bool? value) {
              // Handle change
            },
          ),
          Column(
            children: [
              Image.asset(
                imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 5),
              Text(
                price,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFFFB612),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF353E55),
              ),
            ),
          ),
          _buildCounter(),
        ],
      ),
    );
  }

  // Widget to build the increment/decrement counter
  static Widget _buildCounter() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        int _count = 1;

        return Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              color: Color(0xFF353E55),
              onPressed: () {
                if (_count > 1) {
                  setState(() {
                    _count--;
                  });
                }
              },
            ),
            Text(
              '$_count',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF353E55),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              color: Color(0xFFFFB612),
              onPressed: () {
                setState(() {
                  _count++;
                });
              },
            ),
          ],
        );
      },
    );
  }
}
