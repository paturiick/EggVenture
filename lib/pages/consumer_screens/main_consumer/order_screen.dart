import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the device's dimensions
    final size = MediaQuery.of(context).size;

    // Adjust font sizes and paddings based on screen width
    double baseFontSize = size.width * 0.04; // Dynamic font size
    double tabFontSize = size.width * 0.035;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Order History',
            style: TextStyle(
              fontFamily: 'AvenirNextCyr',
              fontWeight: FontWeight.bold,
              fontSize: baseFontSize * 1.5, // Scales based on screen size
              color: AppColors.BLUE,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.BLUE.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      labelColor: AppColors.YELLOW,
                      unselectedLabelColor: Colors.grey[600],
                      indicatorColor: AppColors.YELLOW,
                      indicatorWeight: 4,
                      labelPadding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      isScrollable: true,
                      tabs: [
                        Tab(
                          child: Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: Text(
                              "All",
                              style: TextStyle(fontSize: tabFontSize),
                            ),
                          ),
                        ),
                        Tab(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 1),
                            child: Text(
                              "Received",
                              style: TextStyle(fontSize: tabFontSize),
                            ),
                          ),
                        ),
                        Tab(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.9),
                            child: Text(
                              "Pending",
                              style: TextStyle(fontSize: tabFontSize),
                            ),
                          ),
                        ),
                        Tab(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.9),
                            child: Text(
                              "Cancelled",
                              style: TextStyle(fontSize: tabFontSize),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Adjust font size based on the available height
            double contentFontSize = constraints.maxHeight * 0.02;
            return TabBarView(
              controller: _tabController,
              children: [
                _buildTabContent('No Transaction', contentFontSize),
                _buildTabContent('No Order Received Yet', contentFontSize),
                _buildTabContent('No Pending Orders', contentFontSize),
                _buildTabContent('No Cancelled Orders', contentFontSize),
              ],
            );
          },
        ),
        bottomNavigationBar: NavigationBarWidget(currentIndex: 1),
      ),
    );
  }

  Widget _buildTabContent(String message, double fontSize) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: fontSize, color: Color(0xFF353E55)),
      ),
    );
  }
}
