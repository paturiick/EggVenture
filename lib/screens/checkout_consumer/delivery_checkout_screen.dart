import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/firebase/firestore_service.dart';
import 'package:eggventure/providers/buy_now_provider.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/widgets/overlay%20widgets/buy%20now%20widgets/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DeliveryCheckoutScreen extends StatefulWidget {
  @override
  _DeliveryCheckoutScreenState createState() => _DeliveryCheckoutScreenState();
}

class _DeliveryCheckoutScreenState extends State<DeliveryCheckoutScreen> {
  String? userName;
  final FirestoreService _service = FirestoreService();
  String selectedPaymentMethod = "GCash";
  bool isLoading = true; // Add loading state

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    getUserName(); // Call getUserName on initialization
  }

  Future<void> getUserName() async {
    try {
      final uid = _service.getCurrentUserId();
      final userDetails = await _service.getBasedOnId('userDetails', uid);

      final firstName = userDetails['firstName'];
      final lastName = userDetails['lastName'];

      setState(() {
        userName = '$firstName $lastName';
        isLoading = false; // Stop loading after data is fetched
      });
    } catch (e) {
      print('Error fetching user name: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: isLoading // Display loading indicator until name is fetched
          ? Center(
              child: CircularProgressIndicator(
              color: AppColors.YELLOW,
            ))
          : Column(
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
                        color: AppColors.BLUE,
                      ),
                    ),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: AppColors.BLUE),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.HOMESCREEN);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Shipping Address",
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                            color: AppColors.BLUE,
                          ),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            "Name: ${userName ?? 'Loading...'}",
                            style: TextStyle(color: AppColors.BLUE),
                          ),
                          subtitle: Text("Address:"),
                          trailing: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.DELIVERYEDITINFO);
                            },
                            child: Text(
                              "Change",
                              style: TextStyle(color: AppColors.YELLOW),
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
                                color: AppColors.BLUE,
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "30 MINS",
                              style: TextStyle(
                                color: AppColors.YELLOW,
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
                            color: AppColors.BLUE,
                          ),
                        ),
                        SizedBox(height: 10),
                        _buildPaymentMethod(
                          "GCash",
                          Image.asset(
                            "assets/icons/gcash.png",
                            height: 24,
                            width: 24,
                          ),
                          screenWidth,
                        ),
                        _buildPaymentMethod(
                          "PayMaya",
                          Image.asset(
                            "assets/icons/paymaya.png",
                            height: 24,
                            width: 24,
                          ),
                          screenWidth,
                        ),
                        _buildPaymentMethod(
                          "Credit or Debit Card",
                          Icon(Icons.credit_card,
                              color: AppColors.BLUE, size: 24),
                          screenWidth,
                        ),
                        _buildPaymentMethod(
                          "Cash on Delivery",
                          Icon(Icons.delivery_dining_rounded,
                              color: AppColors.BLUE, size: 24),
                          screenWidth,
                        ),
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
                                    color: AppColors.BLUE,
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

  Widget _buildPaymentMethod(String method, Widget icon, double screenWidth) {
    return RadioListTile<String>(
      activeColor: AppColors.YELLOW,
      value: method,
      groupValue: selectedPaymentMethod,
      onChanged: (value) {
        setState(() {
          selectedPaymentMethod = value!;
        });
      },
      title: Text(
        method,
        style: TextStyle(
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.w500,
          color: AppColors.BLUE,
        ),
      ),
      secondary: SizedBox(
        height: 24,
        width: 24,
        child: Center(child: icon),
      ),
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
    final buyNowProvider = Provider.of<BuyNowProvider>(context, listen: false);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: AppColors.BLUE,
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
                    color: AppColors.YELLOW),
              ),
              Text(
                "P ${(buyNowProvider.subtotal + 10.0).toStringAsFixed(2)}",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.YELLOW),
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
          backgroundColor: AppColors.YELLOW,
          padding: EdgeInsets.symmetric(vertical: 15),
          elevation: 0,
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
              color: AppColors.BLUE,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
