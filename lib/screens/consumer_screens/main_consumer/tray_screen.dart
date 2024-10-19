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
                          return Row(
                            children: [
                              Image.asset(
                                trayProvider.trayItems[index].imagePath,
                                width: 50,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                  trayProvider.trayItems[index].name
                                ),
                                Text(
                                  trayProvider.trayItems[index].screenId,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey
                                  ),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Text(
                                'Amount: ${trayProvider.trayItems[index].amount.toString()}'
                              ),
                              const SizedBox(width: 5),
                              const Text('|'),
                              const SizedBox(width: 5),
                              Text(
                                'P ${trayProvider.trayItems[index].price.toString()}'
                              ),
                              IconButton(
                              icon: Icon(Icons.remove_circle_outline,
                                  color: AppColors.RED),
                              onPressed: () {
                                // Remove the item from the tray
                                trayProvider.removeFromTray(trayProvider.trayItems[index]);
                              },
                            ),
                            ],
                          );
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
