import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar_farmer.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeScreenFarmer extends StatefulWidget {
  const HomeScreenFarmer({Key? key}) : super(key: key);

  @override
  _HomeScreenFarmerState createState() => _HomeScreenFarmerState();
}

class _HomeScreenFarmerState extends State<HomeScreenFarmer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 6, vsync: this); // 6 tabs: All, 1-5 stars
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.05),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/Eggventure.png',
                    width: size.width * 0.15,
                  ),
                  SizedBox(width: size.width * 0.02),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'E',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: size.width * 0.09,
                          color: AppColors.YELLOW,
                        ),
                      ),
                      Text(
                        'GG',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: size.width * 0.06,
                          color: AppColors.BLUE,
                        ),
                      ),
                      Text(
                        'V',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: size.width * 0.09,
                          color: AppColors.YELLOW,
                        ),
                      ),
                      Text(
                        'ENTURE',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: size.width * 0.06,
                          color: AppColors.BLUE,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.02,
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: AppColors.YELLOW,
            unselectedLabelColor: Color(0xFF353E55),
            indicatorColor: AppColors.YELLOW,
            tabs: [
              Tab(text: 'All'),
              _buildTabWithStar('1', size),
              _buildTabWithStar('2', size),
              _buildTabWithStar('3', size),
              _buildTabWithStar('4', size),
              _buildTabWithStar('5', size),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildContentForRating(0, size), // Content for "All"
                _buildContentForRating(1, size), // Content for 1 star
                _buildContentForRating(2, size), // Content for 2 stars
                _buildContentForRating(3, size), // Content for 3 stars
                _buildContentForRating(4, size), // Content for 4 stars
                _buildContentForRating(5, size), // Content for 5 stars
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBarWidgetFarmer(currentIndex: 0),
    );
  }

  // Helper method to generate a tab with rating number and star
  Tab _buildTabWithStar(String rating, Size size) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rating,
            style:
                TextStyle(fontSize: size.width * 0.035), // Responsive font size
          ),
          SizedBox(
              width: size.width * 0.01), // Small space between number and star
          Icon(
            Icons.star,
            color: AppColors.YELLOW,
            size: size.width * 0.033, // Responsive icon size
          ),
        ],
      ),
    );
  }

  // Helper method to generate content based on the selected rating
  Widget _buildContentForRating(int rating, Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Container(
        height: size.height * 0.2,
        child: Center(
          child: Text(
            rating == 0
                ? 'All Ratings Content'
                : 'Content for $rating Star Rating',
            style: TextStyle(
              color: Colors.grey,
              fontSize: size.width * 0.04,
            ),
          ),
        ),
      ),
    );
  }
}
