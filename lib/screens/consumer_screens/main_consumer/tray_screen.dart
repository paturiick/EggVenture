import 'package:eggventure/models/tray_item.dart';
import 'package:eggventure/providers/add_to_tray_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/widgets/navigation%20bars/navigation_bar.dart';

class TrayScreen extends StatefulWidget {
  @override
  _TrayScreenState createState() => _TrayScreenState();
}

class _TrayScreenState extends State<TrayScreen> {
  @override
  Widget build(BuildContext context) {
    // Access the tray provider
    final trayProvider = Provider.of<AddToTrayProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.YELLOW,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Text(
                  'My Tray',
                  style: TextStyle(
                    fontFamily: 'AvenirNextCyr',
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color(0xFF353E55),
                  ),
                ),
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // search product here
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.BLUE),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              AntDesign.search_outline,
                              color: AppColors.BLUE,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Search",
                              style: TextStyle(
                                  color: AppColors.BLUE, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(
                      AntDesign.filter_outline,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      // Filter functionality here
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Display tray items using the provider
              trayProvider.trayItems.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(
                          'No items were added to the tray.',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: trayProvider.trayItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                              child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.YELLOW,
                                width: 1.5),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Image.asset(
                                  trayProvider.trayItems[index].imagePath,
                                  width: screenWidth * 0.1,
                                  height: screenHeight * 0.1,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      trayProvider.trayItems[index].name,
                                      style: TextStyle(
                                          color: AppColors.BLUE,
                                          fontSize: screenWidth * 0.04),
                                    ),
                                    Text(
                                      trayProvider.trayItems[index].screenId,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: screenWidth * 0.03),
                                    ),
                                    Text(
                                      'Quantity: ${trayProvider.trayItems[index].amount.toString()}',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: screenWidth * 0.03),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      const VerticalDivider(
                                        color: AppColors.BLUE,
                                        thickness: 2,
                                      ),
                                      SizedBox(width: screenWidth * 0.01),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Total: ",
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.04,
                                                color: Colors.grey[600]),
                                          ),
                                          Text(
                                            'P ${trayProvider.trayItems[index].price.toString()}',
                                            style: TextStyle(
                                                color: AppColors.BLUE,
                                                fontSize: screenWidth * 0.04),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete_outline_outlined,
                                          color: AppColors.RED,
                                          size: screenWidth * 0.06,
                                        ),
                                        onPressed: () {
                                          // Remove the item from the tray
                                          trayProvider.removeFromTray(
                                              trayProvider.trayItems[index]);
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),);
                        },
                      ),
                    ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBarWidget(currentIndex: 3),
      ),
    );
  }
}
