import 'package:eggventure/models/tray_item.dart';
import 'package:eggventure/providers/add_to_tray_provider.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/widgets/add%20to%20tray%20widgets/counter_widget.dart';
import 'package:eggventure/widgets/add%20to%20tray%20widgets/clear_tray_items.dart';
import 'package:eggventure/widgets/overlay%20widgets/buy%20now%20widgets/pickup_delivery.dart';
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
              // Search bar and filter row
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.TRAYSEARCH);
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
              SizedBox(height: screenHeight * 0.02),
              trayProvider.trayItems.isNotEmpty
                  ? Row(
                      children: [
                        Expanded(
                          flex:
                              3, // Adjust flex value to match product column width
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Product',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.04,
                                color: AppColors.BLUE,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex:
                              1, // Adjust flex value to match price column width
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Quantity',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.04,
                                color: AppColors.BLUE,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ClearTrayItemsDialog.showClearTrayDialog(context)
                                .then((_) {
                              setState(() {});
                            });
                          },
                          icon: Icon(Icons.delete_forever),
                        ),
                      ],
                    )
                  : Container(),
              Expanded(
                child: trayProvider.trayItems.isNotEmpty
                    ? ListView.builder(
                        itemCount: trayProvider.trayItems.length,
                        itemBuilder: (context, index) {
                          TrayItem item = trayProvider.trayItems[index];
                          bool _isChecked =
                              trayProvider.selectedItems.contains(item);

                          return Padding(
                            padding: EdgeInsets.all(2),
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.YELLOW, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: _isChecked,
                                    onChanged: (value) {
                                      trayProvider.toggleSelection(item);
                                      setState(() {});
                                    },
                                    activeColor: AppColors.YELLOW,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Image.asset(
                                      trayProvider.trayItems[index].imagePath,
                                      width: screenWidth * 0.1,
                                      height: screenHeight * 0.1,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    flex:
                                        2, // Adjust flex value to match product column width
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          trayProvider.trayItems[index].name,
                                          style: TextStyle(
                                            color: AppColors.BLUE,
                                            fontSize: screenWidth * 0.035,
                                          ),
                                        ),
                                        Text(
                                          trayProvider
                                              .trayItems[index].screenId,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: screenWidth * 0.03,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'P ${(trayProvider.calculateTotalPrice(trayProvider.trayItems[index]))}',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: screenWidth * 0.03,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  IntrinsicHeight(
                                    child: Expanded(
                                      flex:
                                          1, // Adjust flex value to match price column width
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: screenWidth * 0.01),
                                            child: CounterWidget(
                                                index: index,
                                                counter: trayProvider
                                                    .trayItems[index].amount,
                                                onIncrement: (int index) {
                                                  trayProvider
                                                      .incrementAmount(index);
                                                  setState(() {});
                                                },
                                                onDecrement: (int index) {
                                                  if (trayProvider
                                                          .trayItems[index]
                                                          .amount >
                                                      1) {
                                                    trayProvider
                                                        .decrementAmount(index);
                                                    setState(() {});
                                                  }
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove_circle_outline_outlined,
                                      color: AppColors.RED,
                                      size: screenWidth * 0.05,
                                    ),
                                    onPressed: () {
                                      trayProvider.removeFromTray(
                                          trayProvider.trayItems[index]);
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'No Added Items in the Tray',
                          style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Colors.grey[600]),
                        ),
                      ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              if (trayProvider.trayItems.isNotEmpty && trayProvider.selectedItems.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        Spacer(), // This pushes the button to the right
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.YELLOW,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          onPressed: () {
                            PickupDeliveryScreen.showPickupDeliveryScreen(
                                context);
                          },
                          child: Text(
                            "Confirm Order",
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: AppColors.BLUE,
                            ),
                          ),
                        ),
                      ],
                    ),
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
