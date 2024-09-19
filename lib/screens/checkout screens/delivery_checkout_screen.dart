import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeliveryCheckoutScreen extends StatefulWidget {
  @override
  _DeliveryCheckoutScreenState createState() => _DeliveryCheckoutScreenState();
}

class _DeliveryCheckoutScreenState extends State<DeliveryCheckoutScreen> {
  String selectedPaymentMethod = "GCash";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Checkout",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color(0xFF353E55),
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Color(0xFF353E55)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          // Rest of the body content below the appbar
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Shipping Address",
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF353E55),
                    ),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Name: ",
                        style: TextStyle(color: Color(0xFF353E55))),
                    subtitle: Text("Address"),
                    trailing: TextButton(
                      onPressed: () {
                        // Implement change address functionality
                      },
                      child: Text(
                        "Change",
                        style: TextStyle(color: Color(0xFFF9B514)),
                      ),
                    ),
                  ),
                  _buildFullWidthDivider(), // Full width divider
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Approximate Delivery Time",
                        style: TextStyle(
                          color: Color(0xFF353E55),
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "30 MINS",
                        style: TextStyle(
                          color: Color(0xFFF9B514),
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Payment Methods",
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF353E55),
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildPaymentMethod(
                      "GCash", Icons.mobile_friendly, screenWidth),
                  _buildPaymentMethod(
                      "PayMaya", Icons.credit_card, screenWidth),
                  _buildPaymentMethod(
                      "Credit or Debit Card", Icons.credit_card, screenWidth),
                  _buildPaymentMethod("Cash on Delivery",
                      Icons.delivery_dining_rounded, screenWidth),
                  _buildFullWidthDivider(),
                  _buildTotalPriceSection(screenWidth),
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "By completing this order, I agree to all ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: screenWidth * 0.04,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: () {
                            // Handle Terms and Conditions link
                          },
                          child: Text(
                            "Terms and Conditions",
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: Color(0xFF353E55),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(screenWidth),
    );
  }

  Widget _buildPaymentMethod(String method, IconData icon, double screenWidth) {
    return RadioListTile<String>(
      activeColor: Color(0xFFF9B514),
      value: method,
      groupValue: selectedPaymentMethod,
      onChanged: (value) {
        setState(() {
          selectedPaymentMethod = value!;
        });
      },
      title: Text(
        method,
        style: TextStyle(color: Color(0xFF353E55)),
      ),
      secondary: Icon(icon, color: Color(0xFF353E55)),
    );
  }

  Widget _buildFullWidthDivider() {
    return Container(
      width: double.infinity,
      child: Divider(
        color: Colors.grey.shade400,
        thickness: 1,
      ),
    );
  }

  Widget _buildTotalPriceSection(double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Color(0xFF353E55),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Price",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF9B514)),
              ),
              Text(
                "P 190.00",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF9B514)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFF9B514),
          padding: EdgeInsets.symmetric(vertical: 15),
          elevation: 0, // Set to 0 because the container already has shadow
        ),
        onPressed: () {
          // Handle place order action
        },
        child: SizedBox(
          width: screenWidth,
          child: Text(
            "Place Order Now",
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
