import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/routes/routes.dart';
import 'package:eggventure/widgets/add%20to%20tray%20widgets/successfully_added_tray.dart';
import 'package:eggventure/widgets/error%20widgets/error_to_add_widget.dart';
import 'package:eggventure/widgets/add%20to%20tray%20widgets/checkbox_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eggventure/models/tray_item.dart';
import 'package:eggventure/providers/add_to_tray_provider.dart';

class AddToTrayScreen {
  static void showAddToTrayScreen(BuildContext context, String screenId) {
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
            return AddToTrayContent(
              scrollController: scrollController,
              screenId: screenId,
            );
          },
        );
      },
    );
  }
}

class AddToTrayContent extends StatefulWidget {
  final ScrollController scrollController;
  final String screenId;

  const AddToTrayContent({
    Key? key,
    required this.scrollController,
    required this.screenId,
  }) : super(key: key);

  @override
  _AddToTrayContentState createState() => _AddToTrayContentState();
}

class _AddToTrayContentState extends State<AddToTrayContent> {
  List<bool> _isChecked = List.filled(4, false);
  List<int> _counters = List.filled(4, 0);
  late List<TrayItem> trayItems;
  List<TrayItem> checkedItems = [];

  @override
  void initState() {
    super.initState();
    trayItems = [
      TrayItem(
        id: 0,
        screenId: widget.screenId,
        name: "Small Egg Tray",
        price: 140,
        amount: 0,
        imagePath: "assets/browse store/small_eggs.jpg",
      ),
      TrayItem(
        id: 1,
        screenId: widget.screenId,
        name: "Medium Egg Tray",
        price: 180,
        amount: 0,
        imagePath: "assets/browse store/medium_eggs.jpg",
      ),
      TrayItem(
        id: 2,
        screenId: widget.screenId,
        name: "Large Egg Tray",
        price: 220,
        amount: 0,
        imagePath: "assets/browse store/large_eggs.jpeg",
      ),
      TrayItem(
        id: 3,
        screenId: widget.screenId,
        name: "XL Egg Tray",
        price: 250,
        amount: 0,
        imagePath: "assets/browse store/xl_eggs.jpg",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final trayProvider = Provider.of<AddToTrayProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Item(s)",
                style: TextStyle(
                  fontSize: screenWidth * 0.03,
                  color: AppColors.BLUE
                ),
              ),
              SizedBox(
                width: screenWidth * 0.5,
              ),
              Text(
                "Quantity",
                style: TextStyle(
                    fontSize: screenWidth * 0.03, 
                    color: AppColors.BLUE),
              )
            ],
          ),
          Expanded(
            child: ListView(
              controller: widget.scrollController,
              children: trayItems.map((item) {
                return CheckboxItemWidget(
                  item: item,
                  isChecked: _isChecked[item.id],
                  counter: _counters[item.id],
                  onCheckboxChanged: (value) {
                    setState(() {
                      _isChecked[item.id] = value!;
                    });
                  },
                  onIncrement: (index) {
                    setState(() {
                      _counters[index]++;
                    });
                  },
                  onDecrement: (index) {
                    setState(() {
                      if (_counters[index] > 0) {
                        _counters[index]--;
                      }
                    });
                  },
                );
              }).toList(),
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
                  foregroundColor: AppColors.RED,
                  side: BorderSide(color: AppColors.RED),
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: AppColors.RED,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  bool hasValidSelection = false;

                  _isChecked.asMap().entries.forEach((entry) {
                    int index = entry.key;
                    bool isChecked = entry.value;

                    if (isChecked && _counters[index] > 0) {
                      trayItems[index].amount = _counters[index];
                      checkedItems.add(trayItems[index]);
                      hasValidSelection = true;
                    }
                  });
                  if (hasValidSelection) {
                    checkedItems.forEach((item) {
                      trayProvider.trayItems.add(item);
                    });
                    SuccessfullyAddedTray.showSuccessAddedTray(context,
                        onContinueBrowsing: () {
                      Navigator.pop(context);
                    }, 
                    onViewTray: () {
                      Navigator.pushNamed(context, AppRoutes.TRAYSCREEN);
                    });
                  } else {
                    // Show error if no valid selection
                    showErrorOverlay(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.YELLOW,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Add To Tray',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                    color: AppColors.BLUE,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
