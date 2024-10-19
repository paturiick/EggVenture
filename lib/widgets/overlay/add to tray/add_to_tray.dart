import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eggventure/constants/colors.dart';
import 'package:eggventure/controller/add_to_tray_controller.dart';
import 'package:eggventure/models/tray_item.dart';
import 'package:eggventure/providers/add_to_tray_provider.dart';
import 'package:eggventure/widgets/overlay/add%20to%20tray/error_to_add_widget.dart';

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
                scrollController: scrollController, screenId: screenId);
          },
        );
      },
    );
  }
}

class AddToTrayContent extends StatefulWidget {
  final ScrollController scrollController;
  final String screenId;

  const AddToTrayContent(
      {Key? key, required this.scrollController, required this.screenId})
      : super(key: key);

  @override
  _AddToTrayContentState createState() => _AddToTrayContentState();
}

class _AddToTrayContentState extends State<AddToTrayContent> {
  // Track the checkbox and counter states for each egg tray
  List<bool> _isChecked = List.filled(4, false);
  List<int> _counters = List.filled(4, 0);
  late List<TrayItem> trayItems;

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
          imagePath: "assets/browse store/small_eggs.jpg"),
      TrayItem(
          id: 1,
          screenId: widget.screenId,
          name: "Medium Egg Tray",
          price: 180,
          amount: 0,
          imagePath: "assets/browse store/medium_eggs.jpg"),
      TrayItem(
          id: 2,
          screenId: widget.screenId,
          name: "Large Egg Tray",
          price: 220,
          amount: 0,
          imagePath: "assets/browse store/large_eggs.jpeg"),
      TrayItem(
          id: 3,
          screenId: widget.screenId,
          name: "XL Egg Tray",
          price: 250,
          amount: 0,
          imagePath: "assets/browse store/xl_eggs.jpg"),
    ];
  }

  List<TrayItem> checkedItems = [];

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
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              controller: widget.scrollController,
              children: trayItems.map((item) => _buildTrayItem(item)).toList(),
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
                  foregroundColor: Colors.red,
                  side: BorderSide(color: Colors.red),
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.red,
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
                      trayItems[index].price *= _counters[index];
                      trayItems[index].amount = _counters[index];
                      checkedItems.add(trayItems[index]);
                      hasValidSelection = true;
                    }
                  });

                  if (hasValidSelection) {
                    checkedItems.forEach((item) {
                      trayProvider.trayItems.add(item);
                    });
                    Navigator.of(context).pop();
                  } else {
                    // Show error if no valid selection
                    showErrorOverlay(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFB612),
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
                    color: Color(0xFF353E55),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrayItem(TrayItem item) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Checkbox(
            value: _isChecked[item.id],
            onChanged: (value) {
              setState(() {
                _isChecked[item.id] = value!;
              });
            },
            activeColor: AppColors.YELLOW,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.YELLOW,
                    ),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Image.asset(
                  item.imagePath,
                  width: screenWidth * 0.12,
                  height: screenHeight * 0.06,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              SizedBox(width: screenWidth * 0.02,)
            ],
          ),
          SizedBox(width: screenWidth * 0.001),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.03,
                  color: Color(0xFF353E55),
                ),
              ),
              Text(
                'P ${item.price.toString()}',
                style: TextStyle(
                  fontSize: screenWidth * 0.03,
                  color: Color(0xFFFFB612),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
          _buildCounter(item.id),
        ],
      ),
    );
  }

  Widget _buildCounter(int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Row(
          children: [
            Container(
                width: screenWidth * 0.05,
                height: screenHeight * 0.03,
                decoration: BoxDecoration(
                  color: AppColors.BLUE,
                  borderRadius: BorderRadius.circular(3.0)
                ),
              child: Center(
                child: IconButton(
              icon: Icon(
                Icons.remove,
                size: screenWidth * 0.05,
              ),
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(),
              color: AppColors.YELLOW,
              onPressed: () {
                if (_counters[index] > 0) {
                  setState(() {
                    _counters[index]--;
                  });
                }
              },
            ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.02,),
            Text(
              '${_counters[index]}',
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.bold,
                color: AppColors.BLUE,
              ),
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
            Container(
                width: screenWidth * 0.05,
                height: screenHeight * 0.03,
                decoration: BoxDecoration(
                  color: AppColors.YELLOW,
                  borderRadius: BorderRadius.circular(3.0)
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      size: screenWidth * 0.05,
                    ),
                    padding: EdgeInsets.all(0),
                    constraints: BoxConstraints(),
                    color: AppColors.BLUE,
                    onPressed: () {
                      setState(() {
                        _counters[index]++;
                      });
                    },
                  ),
                ))
          ],
        );
      },
    );
  }
}
