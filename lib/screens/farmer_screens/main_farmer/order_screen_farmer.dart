import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar_farmer.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class OrderScreenFarmer extends StatefulWidget {
  @override
  _OrderScreenFarmerState createState() => _OrderScreenFarmerState();
}

class _OrderScreenFarmerState extends State<OrderScreenFarmer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTimeRange? selectedDateRange;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Function to select a date range
  Future<void> _selectDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
      initialDateRange: selectedDateRange,
    );

    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Getting screen dimensions using MediaQuery
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // Remove shadow
          centerTitle: true,
          title: Text(
            'Orders',
            style: TextStyle(
              fontFamily: 'AvenirNextCyr',
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.07, // Responsive font size
              color: Color(0xFF353E55),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1), // Height of the bottom border
            child: Container(
              color: Colors.grey[300], // Bottom border color
              height: 1, // Border thickness
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, // Responsive padding
            vertical: screenHeight * 0.02, // Responsive vertical padding
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  //search orders here
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenHeight * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.BLUE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        AntDesign.search_outline,
                        color: AppColors.BLUE,
                      ),
                      SizedBox(
                        width: screenWidth * 0.01,
                      ),
                      Text(
                        "Search Orders",
                        style: TextStyle(color: AppColors.BLUE),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01), // Responsive spacing

              // Date range picker button under the search bar
              // Date range picker button under the search bar
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap:
                      _selectDateRange, // Opens the date range picker when tapped
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_today, color: Colors.grey),
                        SizedBox(
                            width: 8), // Spacing between icon and date text
                        Text(
                          selectedDateRange == null
                              ? 'Select Date' // Placeholder when no date is selected
                              : '${DateFormat('yyyy/MM/dd').format(selectedDateRange!.start)} - ${DateFormat('yyyy/MM/dd').format(selectedDateRange!.end)}',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.02), // Responsive spacing

              // TabBar for different order statuses
              TabBar(
                controller: _tabController,
                labelColor: Color(0xFF353E55),
                unselectedLabelColor: Colors.grey,
                indicatorColor: Color(0xFF353E55),
                tabs: [
                  Tab(text: 'All'),
                  Tab(text: 'To Process'),
                  Tab(text: 'Processed'),
                ],
              ),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing

              // Order List
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildOrderList(screenWidth, screenHeight),
                    _buildOrderList(screenWidth, screenHeight),
                    _buildOrderList(screenWidth, screenHeight),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBarWidgetFarmer(currentIndex: 1),
      ),
    );
  }

  Widget _buildOrderList(double screenWidth, double screenHeight) {
    // Dummy order data (replace with your actual data logic)
    List<Map<String, String>> orders = [
      {
        'product': 'Medium Egg Tray',
        'size': 'Medium',
        'quantity': '1',
        'price': '₱160',
        'status': 'To Deliver',
        'user': 'User1',
        'productImage': 'assets/browse store/medium_eggs.jpg',
      },
    ];

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.amberAccent, width: 1.5),
          ),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(screenHeight * 0.015),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User row with profile picture and name
                Row(
                  children: [
                    // Placeholder for profile picture
                    CircleAvatar(
                      radius: screenWidth * 0.04, // Responsive size
                      backgroundColor: Colors.grey[300], // Placeholder color
                      child: Icon(
                        Icons.person,
                        size: screenWidth * 0.03, // Responsive icon size
                        color: Colors.grey[600], // Icon color
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),

                    // User name and label
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          orders[index]['user']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.04,
                            color: AppColors.BLUE,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        IconButton(
                          icon: Icon(AntDesign.message_outline),
                          color: AppColors.BLUE,
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, AppRoutes.FARMERCHATMESSAGES);
                          },
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Divider(
                  color: AppColors.YELLOW,
                ),
                
                // Product row details (as shown in the image)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Product(s)",
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: AppColors.BLUE
                      ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.39),

                    Text("Total Price",
                    style: TextStyle(
                      color: AppColors.BLUE,
                      fontSize: screenWidth * 0.03
                    ),),
                    SizedBox(width: screenWidth * 0.04,),
                    
                    Text("Actions",
                    style: TextStyle(
                      color: AppColors.BLUE,
                      fontSize: screenWidth * 0.03
                    ),)
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Product image
                    Image.asset(
                      orders[index]['productImage']!,
                      width: screenWidth * 0.15, // Adjusted width
                      height: screenHeight * 0.08, // Adjusted height
                    ),
                    SizedBox(width: screenWidth * 0.03),

                    // Product info
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                orders[index]['product']!,
                                style: TextStyle(
                                  color: AppColors.BLUE,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.03,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              Text(
                                '${orders[index]['quantity']}x',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: screenWidth * 0.03,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Size: " + orders[index]['size']!,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: screenWidth * 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Price info
                    Expanded(
                      flex: 3,
                      child: Text(
                        orders[index]['price']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.BLUE,
                          fontSize: screenWidth * 0.03,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // Status (Actions)
                    Expanded(
                      flex: 3,
                      child: Text(
                        orders[index]['status']!,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                        textAlign: TextAlign.end,
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
  }
}
