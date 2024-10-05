import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/widgets/navigation_bar.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Order History',
            style: TextStyle(
              fontFamily: 'AvenirNextCyr',
              fontWeight: FontWeight.bold,
              fontSize: 30,
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
                    color: Colors.black.withOpacity(0.1),
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
                          EdgeInsetsDirectional.only(start: 20, end: 20.0),
                      isScrollable: true,
                      tabs: [
                        Tab(
                          child: Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: Text("All"),
                          ),
                        ),
                        Tab(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 1),
                            child: Text("Received"),
                          ),
                        ),
                        Tab(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.9),
                            child: Text("Pending"),
                          ),
                        ),
                        Tab(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.9),
                            child: Text("Cancelled"),
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
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildTabContent('No Transaction'),
            _buildTabContent('No Order Received Yet'),
            _buildTabContent('No Pending Orders'),
            _buildTabContent('No Cancelled Orders'),
          ],
        ),
        bottomNavigationBar: NavigationBarWidget(currentIndex: 1),
      ),
    );
  }

  Widget _buildTabContent(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 14, color: Color(0xFF353E55)),
      ),
    );
  }
}
